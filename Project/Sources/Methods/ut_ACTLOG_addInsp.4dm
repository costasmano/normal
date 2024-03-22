//%attributes = {"invisible":true}
//Method: ut_ACTLOG_addInsp
//Description
// Add Act log records for current selection of [inspection] records
// Parameters
// $1 : $SetToAddTo
// $2 ; $TableDesc
// $3 ; $LastRefID_L

If (False:C215)
	//----------------------------------------------------
	//User name (OS): Costas Manousakis
	//Date and time: 09/11/11, 21:28:39
	//----------------------------------------------------
	// ----------------------------------------------------
	//Ugrade to v11
	//Modified by: Costas Manousakis (9/11/11 21:28:41)
	// Modified by: Costas Manousakis-(Designer)-(9/9/15 16:03:07)
	Mods_2015_09_bug
	//  `Under The "INSPECTIONS" task add  [TunnelInspection] and [PON_ELEM_INSP]
	// Modified by: Costas Manousakis-(Designer)-(10/8/15 16:37:55)
	Mods_2015_10_bug
	//  `for speed improvement search for [ElementsSafety],[Standard Photos],[TunnelInspection],[PON_ELEM_INSP] in one querry
	//  `then do a query selection with array.
	// Modified by: Costas Manousakis-(Designer)-(11/2/18 16:33:44)
	Mods_2018_11
	//  `added table [NTI_ELEM_BIN_INSP] in the search by parent inspectionID and moved [Field Trip] in it too.
	//  `added task "TININSPECTIONS" for TIN inspections
	// Modified by: Costas Manousakis-(Designer)-(2022-01-18T00:00:00 19:59:52)
	Mods_2022_01
	//  `added third parameter for last RefID
End if 
C_TEXT:C284($1; $SetToAddTo)
$SetToAddTo:=$1
C_TEXT:C284($2; $TableDesc)
$TableDesc:=$2
C_LONGINT:C283($3; $LastRefID_L)
$LastRefID_L:=$3
C_LONGINT:C283($loop_L; $searchtbl_L)
Case of 
	: ($TableDesc="ADDSELECTION")
		QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]RefID:28>=$LastRefID_L)
		CREATE SET:C116([Activity Log:59]; "NewSet")
		UNION:C120("NewSet"; $SetToAddTo; $SetToAddTo)
		CLEAR SET:C117("NewSet")
		
	: ($TableDesc="INSPECTIONS")
		
		ARRAY LONGINT:C221($inspids_aL; Records in selection:C76([Inspections:27]))
		ARRAY TEXT:C222($inspids_atxt; Records in selection:C76([Inspections:27]))
		SELECTION TO ARRAY:C260([Inspections:27]InspID:2; $inspids_aL)
		For ($loop_L; 1; Size of array:C274($inspids_aL))
			$inspids_atxt{$loop_L}:=String:C10($inspids_aL{$loop_L})
		End for 
		
		$searchtbl_L:=Table:C252(->[Inspections:27])
		//find act log with for insp table with par id in curr distr
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Local ID:15; $inspids_atxt)
		
		ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		
		If (False:C215)
			$searchtbl_L:=Table:C252(->[Field Trip:43])
			//find act log for field trip with par id in inspids
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
			QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $InspIds_atxt)
			
			ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
			$searchtbl_L:=Table:C252(->[ElementsSafety:29])
			//find act log for elmtsfty with par id in inspids
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
			QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $InspIds_atxt)
			
			ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
			
			$searchtbl_L:=Table:C252(->[Standard Photos:36])
			//find act log for stdphoto with par id in inspids
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
			QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $InspIds_atxt)
			ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
			
			$searchtbl_L:=Table:C252(->[TunnelInspection:152])
			//find act log for TunnelInsp with par id in inspids
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
			QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $InspIds_atxt)
			ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
			
			$searchtbl_L:=Table:C252(->[PON_ELEM_INSP:179])
			//find act log for NBEs with par id in inspids
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
			QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $InspIds_atxt)
			ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		Else 
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[ElementsSafety:29]); *)
			QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[Field Trip:43]); *)
			QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[Standard Photos:36]); *)
			QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[TunnelInspection:152]); *)
			QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[NTI_ELEM_BIN_INSP:183]); *)
			QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[PON_ELEM_INSP:179]))
			QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $InspIds_atxt)
			ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		End if 
		
		
	: ($TableDesc="BMSINSPECTIONS")
		ARRAY LONGINT:C221($inspids_aL; Records in selection:C76([BMS Inspections:44]))
		ARRAY TEXT:C222($inspids_atxt; Records in selection:C76([BMS Inspections:44]))
		SELECTION TO ARRAY:C260([BMS Inspections:44]Inspection ID:1; $inspids_aL)
		For ($loop_L; 1; Size of array:C274($inspids_aL))
			$inspids_atxt{$loop_L}:=String:C10($inspids_aL{$loop_L})
		End for 
		
		$searchtbl_L:=Table:C252(->[BMS Inspections:44])
		//find act log with bms insp table with par id in curr dist
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Local ID:15; $inspids_atxt)
		
		ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		
		$searchtbl_L:=Table:C252(->[BMS Field Trip:56])
		//find act log for bmsfield trip with par id in bmsinspids
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $inspids_atxt)
		ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		
		$searchtbl_L:=Table:C252(->[Cond Units:45])
		//find act log for condunit with par id in bmsinspids
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $inspids_atxt)
		ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		
		
	: ($TableDesc="INVINSPECTIONS")
		ARRAY LONGINT:C221($inspids_aL; Records in selection:C76([InventoryPhotoInsp:112]))
		ARRAY TEXT:C222($inspids_atxt; Records in selection:C76([InventoryPhotoInsp:112]))
		SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]InvPhotoInspID_L:1; $inspids_aL)
		For ($loop_L; 1; Size of array:C274($inspids_aL))
			$inspids_atxt{$loop_L}:=String:C10($inspids_aL{$loop_L})
		End for 
		
		$searchtbl_L:=Table:C252(->[InventoryPhotoInsp:112])
		//find act log with for insp table with par id in curr distr
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Local ID:15; $inspids_atxt)
		
		ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		
		$searchtbl_L:=Table:C252(->[InventoryPhotos:113])
		//find act log for field trip with par id in inspids
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $InspIds_atxt)
		
		ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		
	: ($TableDesc="COMBINSPECTIONS")
		
		ARRAY LONGINT:C221($inspids_aL; Records in selection:C76([Combined Inspections:90]))
		ARRAY TEXT:C222($inspids_atxt; Records in selection:C76([Combined Inspections:90]))
		SELECTION TO ARRAY:C260([Combined Inspections:90]ID:6; $inspids_aL)
		For ($loop_L; 1; Size of array:C274($inspids_aL))
			$inspids_atxt{$loop_L}:=String:C10($inspids_aL{$loop_L})
		End for 
		$searchtbl_L:=Table:C252(->[Combined Inspections:90])
		//find act log with for insp table with par id in curr distr
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Local ID:15; $inspids_atxt)
		
		ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		
		SELECTION TO ARRAY:C260([Combined Inspections:90]NBISInspID:2; $inspids_aL)
		QUERY WITH ARRAY:C644([Inspections:27]InspID:2; $inspids_aL)
		ut_ACTLOG_addInsp($SetToAddTo; "INSPECTIONS"; $LastRefID_L)
		
		SELECTION TO ARRAY:C260([Combined Inspections:90]BMSInspID:3; $inspids_aL)
		QUERY WITH ARRAY:C644([BMS Inspections:44]Inspection ID:1; $inspids_aL)
		ut_ACTLOG_addInsp($SetToAddTo; "BMSINSPECTIONS"; $LastRefID_L)
		
	: ($TableDesc="TININSPECTIONS")
		//based on current selection ot records in [TIN_Inspections] - choose all related act log records
		ARRAY LONGINT:C221($inspids_aL; Records in selection:C76([TIN_Inspections:184]))
		ARRAY TEXT:C222($inspids_atxt; Records in selection:C76([TIN_Inspections:184]))
		SELECTION TO ARRAY:C260([TIN_Inspections:184]InspectionID:2; $inspids_aL)
		For ($loop_L; 1; Size of array:C274($inspids_aL))
			$inspids_atxt{$loop_L}:=String:C10($inspids_aL{$loop_L})
		End for 
		$searchtbl_L:=Table:C252(->[TIN_Inspections:184])
		
		//find act log with for insp table with par id in curr distr
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$searchtbl_L)
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Local ID:15; $inspids_atxt)
		ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		
		QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[NTI_ELEM_TIN_INSP:185]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[TIN_Insp_Comments:188]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[TIN_Insp_Images:186]); *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=Table:C252(->[TIN_Insp_TmMembers:187]))
		QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $InspIds_atxt)
		ut_ACTLOG_addInsp($SetToAddTo; "ADDSELECTION"; $LastRefID_L)
		
End case 


ARRAY LONGINT:C221($inspids_aL; 0)
ARRAY TEXT:C222($inspids_atxt; 0)

//End ut_ACTLOG_addInsp