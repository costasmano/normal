//%attributes = {"invisible":true}
// Method: ut_SQLReturnActLogRecords
// Description
// returns a blob that contains the RefIDs of records from activity Log that are due to go to the requestor.
// Based on which district the request is coming from and the username.
//
// Parameters
// $0 : $Return_blb 
// $1 : $Destination_txt
// $2 : $UserName_txt
// ----------------------------------------------------
If (False:C215)
	// Modified by: Charles Miller (6/18/10)
	// ----------------------------------------------------
	// User name (OS): Charles Miller
	// Date and time: 06/18/10, 15:24:07
	// ----------------------------------------------------
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:45:30)
	
	// Modified by: Costas Manousakis-()-(9/11/11 20:37:27)
	Mods_2011_09
	
	// Modified by: Costas Manousakis-()-(9/26/11 16:04:06)
	Mods_2011_09
	// Modified by: Costas Manousakis-(Designer)-(4/27/12 16:35:25)
	Mods_2012_04
	//  `added code to get deletions of  dive inspections.
	// Modified by: Costas Manousakis-(Designer)-(13/2/2015)
	Mods_2015_02
	//  `added code to get changes in Town address and Conslt Address tables for Dive and district users.
	// Modified by: Costas Manousakis-(Designer)-(9/9/15 16:05:04)
	Mods_2015_09_bug
	//  `When checking for deleted records add [TunnelInspection] and [PON_ELEM_INSP]
	//  `When checking for children of deleted Inspections use field [Activity Log]Parent ID NOT [Activity Log]Local ID
	// Modified by: Costas Manousakis-(Designer)-(10/8/15 16:37:55)
	Mods_2015_10_bug
	//  `for speed improvement search for [ElementsSafety],[Standard Photos],[TunnelInspection],[PON_ELEM_INSP] in one querry
	//  `then do a query selection with array.
	// Modified by: Costas Manousakis-(Designer)-(4/11/16 11:36:49)
	Mods_2016_04_bug
	//  `Removed  scanning for district 6 when doing District 4
	// Modified by: Costas Manousakis-(Designer)-(11/2/18 17:07:51)
	Mods_2018_11
	//  `added table [NTI_ELEM_BIN_INSP] in the search by parent inspectionID and moved [Field Trip] in it too.
	//  `added checking for inspection responsibility by district in addition to Item 2
	//  `added all tables related via the [BridgeInfoLink] table to the bridge table to the list of tables to full download
	//  `added [NTI_TunnelInfo] to the list of tables to full download
	//  `added searches for [TIN_Inspections] similar to bridge inspections, and search for [NTI_TunnelRatings]
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Added 3rd parameter which is last [Activity Log]RefID retrieved
	//Also adjusted how destination used - it is now an array
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	// Modified by: Costas Manousakis-(Designer)-(2022-01-18 20:00:48)
	Mods_2022_01
	//  `use third parameter $LastRefID_L to the calls to ut_ACTLOG_addInsp
	// Modified by: Costas Manousakis-(Designer)-(2022-03-21 17:55:50)
	Mods_2022_03
	//  `Don't search thru Act log for records related to  [Inventoryphotoinsp]. All inventory photo inspection related activity is downloaded
	// Modified by: Costas Manousakis-(Designer)-(2022-03-24 12:03:31)
	Mods_2022_03
	//  `don't search for [NTI_Tunnelinfo] records that are not in the forward list, search only for records in the forward list.
End if 

C_TEXT:C284($1; $2; $UserName_txt; $Destination_txt)
C_BLOB:C604($0; $Return_blb)
C_LONGINT:C283($3; $LastRefID_L; $DistrictLoop_l)
C_LONGINT:C283($tableNum_L)
$LastRefID_L:=$3

$Destination_txt:=$1
ARRAY TEXT:C222($Destination_atxt; 0)
ut_NewTextToArray($Destination_txt; ->$Destination_atxt; ",")

$UserName_txt:=$2
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
READ ONLY:C145(*)

//define tables that are not searched for changes through all records.
// these will be handled by the forward field
ARRAY POINTER:C280($TablesToSkip_aptr; 0)
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[Inspections:27])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[BMS Inspections:44])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[TIN_Inspections:184])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[Combined Inspections:90])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[ElementsSafety:29])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[ElmtRatingLoads:158])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[Standard Photos:36])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[Field Trip:43])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[BMS Field Trip:56])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[Cond Units:45])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[PON_ELEM_INSP:179])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[NTI_ELEM_BIN_INSP:183])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[TunnelInspection:152])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[TIN_Insp_Images:186])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[TIN_Insp_Comments:188])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[TIN_Insp_TmMembers:187])
APPEND TO ARRAY:C911($TablesToSkip_aptr; ->[NTI_ELEM_TIN_INSP:185])

SET QUERY DESTINATION:C396(Into set:K19:2; "Set1")
Case of 
	: ($Destination_txt="")
		//*****
		//*****  This case will not be used in the new server topology with only one server
		//*****  
		//*****
		//non district query - should be coming from DIVE users
		
		//search act log for changes in any table not in the tablestoskip array
		//start with the Bridge table
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[Bridge MHD NBIS:1]); *)
		For ($tableNum_L; 1; Get last table number:C254)
			If (Is table number valid:C999($tableNum_L))
				If ($tableNum_L#Table:C252(->[Bridge MHD NBIS:1]))  // already did Bridge table
					
					If (Find in array:C230($TablesToSkip_aptr; Table:C252($tableNum_L))>0)
					Else 
						QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=$tableNum_L; *)
					End if 
					
				End if 
				
			End if 
			
		End for 
		
		//QUERY([Activity Log];[Activity Log]Status=-1;*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[Bridge MHD NBIS]);*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[NTI_TunnelInfo]);*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[BridgeInfoLink]);*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[ScourPriorityRank]);*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[RAILBridgeInfo]);*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[TunnelInfo]);*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[ScourCriticalInfo]);*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[Town Address]);*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[Conslt Address]);*)
		//QUERY([Activity Log]; | ;[Activity Log]FileID Local=Table(->[BridgeStairs]);*)
		
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]InspType:5="DV@")
		
		ut_ACTLOG_addInsp("Set1"; "COMBINSPECTIONS"; $LastRefID_L)
		
		// GET DELETED DIVE INSPECTIONS
		ARRAY TEXT:C222($Insp_ids_atxt; 0)
		QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28>=$LastRefID_L; *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=Table:C252(->[Combined Inspections:90]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3="NRC")
		QUERY SELECTION:C341([Activity Log:59]; [Owners of Data:62]Owner Name:2=$UserName_txt)
		If (Records in selection:C76([Activity Log:59])>0)
			ARRAY TEXT:C222($Insp_ids_atxt; Records in selection:C76([Activity Log:59]))
			SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $Insp_ids_atxt)
			QUERY WITH ARRAY:C644([Activity Log:59]Local ID:15; $Insp_ids_atxt)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[Combined Inspections:90]))
			ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
			ARRAY TEXT:C222($Insp_ids_atxt; 0)
		End if 
		
		
		ARRAY TEXT:C222($Insp_ids_atxt; 0)
		QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28>=$LastRefID_L; *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=Table:C252(->[Inspections:27]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3="NRC")
		QUERY SELECTION:C341([Activity Log:59]; [Owners of Data:62]Owner Name:2=$UserName_txt)
		If (Records in selection:C76([Activity Log:59])>0)
			ARRAY TEXT:C222($Insp_ids_atxt; Records in selection:C76([Activity Log:59]))
			SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $Insp_ids_atxt)
			QUERY WITH ARRAY:C644([Activity Log:59]Local ID:15; $Insp_ids_atxt)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[Inspections:27]))
			ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
			ARRAY TEXT:C222($Insp_ids_atxt; 0)
		End if 
		
		ARRAY TEXT:C222($Insp_ids_atxt; 0)
		QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28>=$LastRefID_L; *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=Table:C252(->[BMS Inspections:44]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3="NRC")
		QUERY SELECTION:C341([Activity Log:59]; [Owners of Data:62]Owner Name:2=$UserName_txt)
		If (Records in selection:C76([Activity Log:59])>0)
			ARRAY TEXT:C222($Insp_ids_atxt; Records in selection:C76([Activity Log:59]))
			SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $Insp_ids_atxt)
			QUERY WITH ARRAY:C644([Activity Log:59]Local ID:15; $Insp_ids_atxt)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[BMS Inspections:44]))
			ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
			ARRAY TEXT:C222($Insp_ids_atxt; 0)
		End if 
		ARRAY TEXT:C222($Insp_ids_atxt; 0)
		
	: ($Destination_txt="ALL")  //
		//*****
		//*****  This case will not be used in the new server topology with only one server
		//*****  
		//*****
		//All records in server must match the database connecting to it
		//Case of users connecting to a district db or External server connecting to Boston server
		QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28>=$LastRefID_L)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
	Else 
		//*****  
		//*****   Everyone who does transfers to the main server will use this case
		//*****  
		//*****
		
		//case of district and Dive users connecting to Boston Server
		
		//search act log for changes in any table not in the tablestoskip array
		//start with the Bridge table
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[Bridge MHD NBIS:1]); *)
		For ($tableNum_L; 1; Get last table number:C254)
			If (Is table number valid:C999($tableNum_L))
				If ($tableNum_L#Table:C252(->[Bridge MHD NBIS:1]))  // already did Bridge table
					
					If (Find in array:C230($TablesToSkip_aptr; Table:C252($tableNum_L))>0)
					Else 
						QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=$tableNum_L; *)
					End if 
					
				End if 
				
			End if 
			
		End for 
		
		//now search for records that should be in my distribution list (list of destinations)
		//This will include Bridge and Tunnel Inspections
		For ($DistrictLoop_l; 1; Size of array:C274($Destination_atxt))
			QUERY:C277([Activity Log:59];  | ; [Activity Log:59]Forward:13="@"+$Destination_atxt{$DistrictLoop_l}+"@"; *)
		End for 
		
		//records that are after the last RefID that was downloaded
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)  // finish search
		
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		
		//get BINs belonging to user's district(s)
		C_TEXT:C284($Item2_txt; $InspResp_txt)
		
		For ($DistrictLoop_l; 1; Size of array:C274($Destination_atxt))
			$Item2_txt:=String:C10(Num:C11(Replace string:C233($Destination_atxt{$DistrictLoop_l}; "DIST"; ""); "00"))
			If ($DistrictLoop_l=1)
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item2:60=$Item2_txt; *)
			Else 
				QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item2:60=$Item2_txt; *)
			End if 
			QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]InspResp:173=$Destination_atxt{$DistrictLoop_l}; *)
		End for 
		QUERY:C277([Bridge MHD NBIS:1])
		
		
		ARRAY TEXT:C222($DistBINS_atxt; Records in selection:C76([Bridge MHD NBIS:1]))
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $DistBINS_atxt)
		
		//  `Existing Inspections
		QUERY WITH ARRAY:C644([Combined Inspections:90]BIN:1; $DistBINS_atxt)
		ut_ACTLOG_addInsp("Set1"; "COMBINSPECTIONS"; $LastRefID_L)
		
		If (False:C215)
			//Not needed in v18+ : All activity in inventory photo inspections are downloaded
			//  `Existing Inv inspections, 
			QUERY WITH ARRAY:C644([InventoryPhotoInsp:112]BIN:2; $DistBINS_atxt)
			ut_ACTLOG_addInsp("Set1"; "INVINSPECTIONS"; $LastRefID_L)
		End if 
		
		//  ` Search for act log records related to deleted bridge inspections.
		//  ` have to go by parent ID in the ActLog for BINs
		//  ` then find related records
		
		//  `  `[Combined Inspections]
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[Combined Inspections:90]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
		
		
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $DistBINS_atxt)
		
		ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
		
		//  `  `[Inspections]
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[Inspections:27]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $DistBINS_atxt)
		
		ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
		
		ARRAY TEXT:C222($inspIDsActLog_atxt; 0)
		ARRAY TEXT:C222($inspIDsActLog_atxt; Records in selection:C76([Activity Log:59]))
		SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $inspIDsActLog_atxt)
		
		//  `  ` build array with table numbers of tables related to [Inspections] with ParentID
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[ElementsSafety:29]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[Field Trip:43]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[Standard Photos:36]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[TunnelInspection:152]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[NTI_ELEM_BIN_INSP:183]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[PON_ELEM_INSP:179]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
		
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $inspIDsActLog_atxt)
		ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
		
		//  `  `[BMS Inspections]
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[BMS Inspections:44]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
		
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $DistBINS_atxt)
		ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
		
		ARRAY TEXT:C222($inspIDsActLog_atxt; 0)
		ARRAY TEXT:C222($inspIDsActLog_atxt; Records in selection:C76([Activity Log:59]))
		SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $inspIDsActLog_atxt)
		
		//  `  ` [BMS Field Trip] and [Cond Units] related to [BMS Inspections]
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[BMS Field Trip:56]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[Cond Units:45]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
		
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Local ID:15; $inspIDsActLog_atxt)
		ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
		
		If (False:C215)
			// not used in v18+ : all activity in InventoryPhoto inspections are downloaded
			//  `  `[InventoryPhotoInsp]
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[InventoryPhotoInsp:112]); *)
			QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
			
			QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $DistBINS_atxt)
			ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
			
			ARRAY TEXT:C222($inspIDsActLog_atxt; 0)
			ARRAY TEXT:C222($inspIDsActLog_atxt; Records in selection:C76([Activity Log:59]))
			SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $inspIDsActLog_atxt)
			
			//  `  ` [InventoryPhotos] related to [InventoryPhotoInsp]
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[InventoryPhotos:113]); *)
			QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
			
			QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $inspIDsActLog_atxt)
			ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
			
			ARRAY TEXT:C222($inspIDsActLog_atxt; 0)
			
		End if 
		//  ` END OF SEARCH FOR DELETED Bridge INSPECTIONS
		
		//Work on to make sure when multiple forward sent in code works
		//  `Look for changes to bridge inspections by Team leaders from my district
		//QUERY([Personnel];[Personnel]Division No=("044"+$1))
		ARRAY TEXT:C222($division_atxt; Size of array:C274($Destination_atxt))
		For ($DistrictLoop_l; 1; Size of array:C274($Destination_atxt))
			$division_atxt{$DistrictLoop_l}:=Replace string:C233($Destination_atxt{$DistrictLoop_l}; "DIST"; "044")
		End for 
		QUERY WITH ARRAY:C644([Personnel:42]Division No:7; $division_atxt)
		
		ARRAY INTEGER:C220($DistrInspectors_aL; Records in selection:C76([Personnel:42]))
		SELECTION TO ARRAY:C260([Personnel:42]Person ID:1; $DistrInspectors_aL)
		
		QUERY WITH ARRAY:C644([Inspections:27]TeamLeader:4; $DistrInspectors_aL)
		//only for BINS in other districts - already have my own district inspections
		For ($DistrictLoop_l; 1; Size of array:C274($Destination_atxt))
			$Item2_txt:=String:C10(Num:C11(Replace string:C233($Destination_atxt{$DistrictLoop_l}; "DIST"; ""); "00"))
			If ($DistrictLoop_l=1)
				QUERY SELECTION:C341([Inspections:27]; [Bridge MHD NBIS:1]Item2:60#$Item2_txt; *)
			Else 
				QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item2:60#$Item2_txt; *)
			End if 
			QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]InspResp:173#$Destination_atxt{$DistrictLoop_l}; *)
		End for 
		QUERY SELECTION:C341([Inspections:27])
		
		SELECTION TO ARRAY:C260([Inspections:27]InspID:2; $inspids_aL)
		QUERY WITH ARRAY:C644([Combined Inspections:90]NBISInspID:2; $inspids_aL)
		
		ut_ACTLOG_addInsp("Set1"; "COMBINSPECTIONS"; $LastRefID_L)
		
		If (False:C215)
			// not used in v18+ : all activity in InventoryPhoto inspections are downloaded
			
			//  `Inventory photos
			QUERY WITH ARRAY:C644([InventoryPhotoInsp:112]TeamLeader_I:5; $DistrInspectors_aL)
			
			For ($DistrictLoop_l; 1; Size of array:C274($Destination_atxt))
				$Item2_txt:=String:C10(Num:C11(Replace string:C233($Destination_atxt{$DistrictLoop_l}; "DIST"; ""); "00"))
				If ($DistrictLoop_l=1)
					QUERY SELECTION:C341([InventoryPhotoInsp:112]; [Bridge MHD NBIS:1]Item2:60#$Item2_txt; *)
				Else 
					QUERY SELECTION:C341([InventoryPhotoInsp:112];  & ; [Bridge MHD NBIS:1]Item2:60#$Item2_txt; *)
				End if 
				QUERY SELECTION:C341([InventoryPhotoInsp:112];  & ; [Bridge MHD NBIS:1]InspResp:173#$Destination_atxt{$DistrictLoop_l}; *)
			End for 
			
			QUERY SELECTION:C341([InventoryPhotoInsp:112])
			
			ut_ACTLOG_addInsp("Set1"; "INVINSPECTIONS"; $LastRefID_L)
			
		End if 
		
		//  ` END OF SEARCHES FOR BRIDGE related records
		// ************
		
		
		// ************
		// SEARCHES for TUNNEL related records
		//
		// tunnels belonging to district by I6 or inspection resp.
		For ($DistrictLoop_l; 1; Size of array:C274($Destination_atxt))
			$Item2_txt:=String:C10(Num:C11(Replace string:C233($Destination_atxt{$DistrictLoop_l}; "DIST"; ""); "00"))
			If ($DistrictLoop_l=1)
				QUERY:C277([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i6_s:11=$Item2_txt; *)
			Else 
				QUERY:C277([NTI_TunnelInfo:181];  & ; [NTI_TunnelInfo:181]NTI_i6_s:11=$Item2_txt; *)
			End if 
			QUERY:C277([NTI_TunnelInfo:181];  & ; [NTI_TunnelInfo:181]NTI_InspResp:73=$Destination_atxt{$DistrictLoop_l}; *)
		End for 
		
		QUERY:C277([NTI_TunnelInfo:181])
		
		ARRAY TEXT:C222($DistTINs_atxt; 0)
		ARRAY TEXT:C222($DistTINs_atxt; Records in selection:C76([NTI_TunnelInfo:181]))
		SELECTION TO ARRAY:C260([NTI_TunnelInfo:181]NTI_i1_s:6; $DistTINs_atxt)
		
		// add act log records related to existing TIN inspections
		QUERY WITH ARRAY:C644([TIN_Inspections:184]NTI_i1_S:1; $DistTINs_atxt)
		ut_ACTLOG_addInsp("Set1"; "TININSPECTIONS"; $LastRefID_L)
		
		//act log records for tunnel ratings related to the TINS
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[NTI_TunnelRatings:189]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $DistTINs_atxt)
		ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
		
		
		//  ` Search for act log records related to deleted TIN inspections.
		//  ` have to go by parent ID in the ActLog for TIN
		//  ` then find related records
		
		//  `  ` [TIN Inspections]
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[TIN_Inspections:184]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
		
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $DistTINs_atxt)
		ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
		ARRAY TEXT:C222($inspIDsActLog_atxt; 0)
		ARRAY TEXT:C222($inspIDsActLog_atxt; Records in selection:C76([Activity Log:59]))
		SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $inspIDsActLog_atxt)
		
		//  `  ` build array with table numbers of tables related to [Inspections] with ParentID
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[NTI_ELEM_TIN_INSP:185]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[TIN_Insp_Comments:188]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[TIN_Insp_Images:186]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[TIN_Insp_TmMembers:187]); *)
		QUERY:C277([Activity Log:59];  & ; [Activity Log:59]RefID:28>=$LastRefID_L)
		
		
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $inspIDsActLog_atxt)
		ut_ACTLOG_addInsp("Set1"; "ADDSELECTION"; $LastRefID_L)
		
		
		// ************
		//  `Look for changes to TIN inspections by Team leaders from my district
		// ************
		
		ARRAY TEXT:C222($division_atxt; Size of array:C274($Destination_atxt))
		For ($DistrictLoop_l; 1; Size of array:C274($Destination_atxt))
			$division_atxt{$DistrictLoop_l}:=Replace string:C233($Destination_atxt{$DistrictLoop_l}; "DIST"; "044")
		End for 
		QUERY WITH ARRAY:C644([Personnel:42]Division No:7; $division_atxt)
		//QUERY([Personnel];[Personnel]Division No=("044"+$1))
		ARRAY INTEGER:C220($DistrInspectors_aL; Records in selection:C76([Personnel:42]))
		SELECTION TO ARRAY:C260([Personnel:42]Person ID:1; $DistrInspectors_aL)
		
		QUERY WITH ARRAY:C644([TIN_Inspections:184]TeamLeader:11; $DistrInspectors_aL)
		
		//only for TINS in other districts - already have my own district inspections
		For ($DistrictLoop_l; 1; Size of array:C274($Destination_atxt))
			$Item2_txt:=String:C10(Num:C11(Replace string:C233($Destination_atxt{$DistrictLoop_l}; "DIST"; ""); "00"))
			If ($DistrictLoop_l=1)
				QUERY SELECTION:C341([TIN_Inspections:184]; [NTI_TunnelInfo:181]NTI_i6_s:11#$Item2_txt; *)
			Else 
				QUERY SELECTION:C341([TIN_Inspections:184];  & ; [NTI_TunnelInfo:181]NTI_i6_s:11#$Item2_txt; *)
			End if 
			QUERY SELECTION:C341([TIN_Inspections:184];  & ; [NTI_TunnelInfo:181]NTI_InspResp:73#$Destination_atxt{$DistrictLoop_l}; *)
		End for 
		
		QUERY SELECTION:C341([TIN_Inspections:184])
		ut_ACTLOG_addInsp("Set1"; "TININSPECTIONS"; $LastRefID_L)
		
		
		ARRAY INTEGER:C220($DistrInspectors_aL; 0)
		ARRAY TEXT:C222($DistBINS_atxt; 0)
		ARRAY TEXT:C222($DistTINs_atxt; 0)
		ARRAY LONGINT:C221($inspids_aL; 0)
		ARRAY TEXT:C222($inspIDsActLog_atxt; 0)
		
End case 
USE SET:C118("Set1")
SET QUERY DESTINATION:C396(Into set:K19:2; "Set1")
QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]RefID:28>=$LastRefID_L)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
USE SET:C118("Set1")
RELATE MANY SELECTION:C340([Owners of Data:62]RefID:1)
QUERY:C277([Owners of Data:62]; [Owners of Data:62]Owner Name:2=$UserName_txt)
//then query that selection for owners
If (Records in selection:C76([Owners of Data:62])>0)
	RELATE ONE SELECTION:C349([Owners of Data:62]; [Activity Log:59])
	CREATE SET:C116([Activity Log:59]; "Set2")
	CREATE EMPTY SET:C140([Activity Log:59]; "FinalSet")
	DIFFERENCE:C122("Set1"; "Set2"; "FinalSet")
	USE SET:C118("FinalSet")
	CLEAR SET:C117("FinalSet")
	CLEAR SET:C117("Set2")
Else 
	USE SET:C118("Set1")
End if 

CLEAR SET:C117("Set1")

ARRAY LONGINT:C221($ActivityKeys_al; 0)
C_LONGINT:C283($Size_l)
$Size_l:=Records in selection:C76([Activity Log:59])

ARRAY LONGINT:C221($ActivityKeys_al; $Size_l)
SELECTION RANGE TO ARRAY:C368(1; $Size_l; [Activity Log:59]RefID:28; $ActivityKeys_al)

SET BLOB SIZE:C606($Return_blb; 0)

VARIABLE TO BLOB:C532($ActivityKeys_al; $Return_blb)
ARRAY LONGINT:C221($ActivityKeys_al; 0)
$0:=$Return_blb