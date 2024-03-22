//%attributes = {"invisible":true}
// Method: INSP_DWNLD_Task
// Description
// Preform various tasks during the download of inspections from remote server.
// 
// Parameters
// $0 : $Err_b
// $1 : $Task_txt
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/11/08, 10:25:03
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("INSPDWNLD")
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/27/10 11:08:50)
	
	// Modified by: Costas Manousakis-()-(12/2/11 18:14:29)
	Mods_2010_12
	//  `Add indicator of where we found the missing elements.
End if 

C_TEXT:C284($1; $Task_txt)
C_LONGINT:C283(RemoteID_l; $Count_l)

$Task_txt:=$1
C_BOOLEAN:C305($0)
$0:=True:C214
Case of 
	: ($Task_txt="FindBINinsp")
		ARRAY DATE:C224(aInspDates_ad; 0)
		ARRAY TEXT:C222(aInspTypes_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY LONGINT:C221(aRemoteInspIDs_al; 0)
		
		SQL_Select:="SELECT [Insp Date], [Insp Type], InspID FROM [Inspections] WHERE BIN = :vCurrBIN_s AND InspApproved = 2"
		ON ERR CALL:C155("SQL_ERROR")
		SQL EXECUTE:C820(SQL_Select; aInspDates_ad; aInspTypes_as; aRemoteInspIDs_al)
		While (Not:C34(SQL End selection:C821))
			SQL LOAD RECORD:C822(SQL all records:K49:10)
		End while 
		SQL CANCEL LOAD:C824
		ON ERR CALL:C155("4D_Errors")
		If (Size of array:C274(aInspDates_ad)>0)
			$0:=True:C214
		Else 
			$0:=False:C215
		End if 
		
	: ($Task_txt="CheckRemoteIsnps")
		
		C_LONGINT:C283($RecordsFound_l)
		$RecordsFound_l:=Size of array:C274(aInspDates_ad)
		C_TEXT:C284($MissingInfo_txt)
		C_LONGINT:C283($InspCount_L; $InspectionRecordNumber_l)
		READ ONLY:C145([Inspections:27])
		ut_Message("Found "+String:C10($RecordsFound_l)+" Approved Inspections in remote server"+<>sCR)
		SET QUERY DESTINATION:C396(Into set:K19:2; "InspectionSet")
		QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=vCurrBIN_s)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		C_BOOLEAN:C305($DowloadComplete_B; $UpdateLocal_B)
		For ($InspCount_L; 1; $RecordsFound_l)
			ut_Message("Checking remote insp type "+aInspTypes_as{$InspCount_L}+" BIN: "+[Bridge MHD NBIS:1]BIN:3+" Date:"+String:C10(aInspDates_ad{$InspCount_L})+<>sCR)
			USE SET:C118("InspectionSet")
			$DowloadComplete_B:=False:C215
			$UpdateLocal_B:=False:C215
			$MissingInfo_txt:=""
			If (aInspTypes_as{$InspCount_L}="PON")
				
			Else 
				QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6=aInspTypes_as{$InspCount_L}; *)
				QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Date:78=aInspDates_ad{$InspCount_L})
				$InspectionRecordNumber_l:=Record number:C243([Inspections:27])
				
				If (Records in selection:C76([Inspections:27])=0)
					$DowloadComplete_B:=True:C214  //Not here - download complete insp
				Else 
					LOAD RECORD:C52([Inspections:27])  //here
					If ([Inspections:27]InspApproved:167=BMS Approved)
						RemoteID_l:=aRemoteInspIDs_al{$InspCount_L}
						Case of 
							: (INSP_CheckCompleteness(Table:C252(->[ElementsSafety:29])))
								$UpdateLocal_B:=True:C214
								$MissingInfo_txt:="Bridge Elements"
							: (INSP_CheckCompleteness(Table:C252(->[Standard Photos:36])))
								$UpdateLocal_B:=True:C214
								$MissingInfo_txt:="Photos"
							: (INSP_CheckCompleteness(Table:C252(->[Cond Units:45])))
								$UpdateLocal_B:=True:C214
								$MissingInfo_txt:="Cond Units"
								
							Else 
								$UpdateLocal_B:=False:C215
						End case 
						
						
						If (Not:C34($UpdateLocal_B))
							ut_Message("   Approved Insp is here!"+<>sCR)  //here and approved - skip it
						End if 
					Else 
						$UpdateLocal_B:=True:C214  //here but not approved - needs replacing????
					End if 
					
				End if 
			End if 
			
			
			If (ut_fTestForSQLor4DError)
				Case of 
					: ($DowloadComplete_B)
						
						ut_Message("Trying Download of Insp"+<>sCR+"Type:"+aInspTypes_as{$InspCount_L}+" Date:"+String:C10(aInspDates_ad{$InspCount_L})+" ID:"+String:C10(aRemoteInspIDs_al{$InspCount_L})+<>sCR)
						START TRANSACTION:C239
						If (INSP_DownLoadInsp(aRemoteInspIDs_al{$InspCount_L}))
							
							InspDownLd_L:=InspDownLd_L+1
							VALIDATE TRANSACTION:C240
						Else 
							CANCEL TRANSACTION:C241
							$0:=False:C215
						End if 
						//FLUSH CACHE
						
					: ($UpdateLocal_B)
						
						If ($MissingInfo_txt="")
							$MissingInfo_txt:="Found Local Insp Not Approved or Incomplete "
						Else 
							$MissingInfo_txt:="Found Local Insp with Incomplete "+$MissingInfo_txt
						End if 
						
						ut_Message($MissingInfo_txt+<>sCR+"Type:"+aInspTypes_as{$InspCount_L}+" Date:"+String:C10(aInspDates_ad{$InspCount_L})+" ID:"+String:C10(aRemoteInspIDs_al{$InspCount_L})+<>sCR)
						If (ut_LoadRecordInteractive(->[Inspections:27]))
							
							ut_Message("Will Delete local Copy and reload from server."+<>sCR)
							C_BOOLEAN:C305($DeletedOK_b)
							START TRANSACTION:C239
							
							If (INSP_DeleteLocalInsp)
								ut_Message("Trying Download of Insp"+<>sCR+"Type:"+aInspTypes_as{$InspCount_L}+" Date :"+String:C10(aInspDates_ad{$InspCount_L})+" ID :"+String:C10(aRemoteInspIDs_al{$InspCount_L})+<>sCR)
								If (INSP_DownLoadInsp(aRemoteInspIDs_al{$InspCount_L}))
									
									InspDownLd_L:=InspDownLd_L+1
									VALIDATE TRANSACTION:C240
								Else 
									$0:=False:C215
									CANCEL TRANSACTION:C241
								End if 
							Else 
								$0:=False:C215
								CANCEL TRANSACTION:C241
							End if 
							
							//FLUSH CACHE
						End if 
						READ ONLY:C145([Inspections:27])
				End case 
			Else 
				ut_SQLWriteErrorsToLog("SQL or 4D error occurred.   -ID "+String:C10([Inspections:27]InspID:2)+<>sCR)
				$InspCount_L:=$RecordsFound_l+1
			End if 
			
		End for 
		READ WRITE:C146([Inspections:27])
		CLEAR SET:C117("InspectionSet")
End case 

Case of 
	: (4DError_b)
		$0:=False:C215
	: (SQLError_b)
		$0:=False:C215
End case 