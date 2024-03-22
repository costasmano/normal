//%attributes = {"invisible":true}
//G_Insp_SaveInspection 
//Method to save an inspection.
//Called from the 'Accept' button of the Inspection input form.
If (False:C215)
	
	//Prompt user if Inspection report is completed, and ready to be reviewed.
	Mods_2005_CM04
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(11/15/05 17:56:05)
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(11/17/05 15:01:06)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/16/2005 11:12:17)
	Mods_2005_CM20
	Mods_2009_03  //CJM  r001   `03/06/09, 14:16:25`Upgrade from open form window to open window
	// Modified by: Costas Manousakis-(Designer)-(1/15/15 17:27:22)
	Mods_2015_01
	//  `added check for INSP_FieldWorkComplCheck, and autofill [Inspections]InspCompleteDate
	// Modified by: Costas Manousakis-(Designer)-(4/14/15 16:15:35)
	Mods_2015_04
	//  `added call to INSP_HICalcControl ("ALL") when inspection is marked as complete
	// Modified by: Costas Manousakis-(Designer)-(12/9/16 11:14:13)
	Mods_2016_12
	//  `added Check of image types to avoid PICTs and PDFs ; change message to use  ut_BigAlert
	// Modified by: Costas Manousakis-(Designer)-(1/19/17 15:00:55)
	Mods_2017_01
	//  `remove ImageCheck call
	// Modified by: Costas Manousakis-(Designer)-(9/20/17 15:46:38)
	Mods_2017_09
	//  `modifications to save insp data to SIA upon first completion.
	// Modified by: Costas Manousakis-(Designer)-(10/13/17 12:48:19)
	Mods_2017_10
	//  `do a INSP_SaveRecords right after the first confirm in case things get locked up
	// Modified by: Costas Manousakis-(Designer)-(10/25/19 16:23:33)
	Mods_2019_10_bug
	//  `add check for inspection date in the future -related to FldWorkComplete issue. CallReferences #663
	// Modified by: Costas Manousakis-(Designer)-(2021-10-25T00:00:00 14:17:45)
	Mods_2021_10
	//  `in the prompt for complete inspection add info about current user , OS user and workstation
	//  `Call INSP_QCSaveApprovalInfo when marking inspection complete
	
End if 

C_TEXT:C284(msg)
CONFIRM:C162("Exit this Inspection and Save?"; "Exit and Save"; "Cancel")
If (OK=1)  //saving inspection
	// save inspection here and start a new transaction for any changes after this
	INSP_SaveRecords
	// - ptr_changes stacks are still in place but have been cleared in the Save
	START TRANSACTION:C239
	
	C_BOOLEAN:C305($InspCompCheck_b; $currentDBIE_b; $CurrentUOE_b; $InspTypeCheck_b)
	//Ask for completed inspection only from Inspection TL or DBIE listed or current DBIE or design user
	// for massdot NBI inspections
	$InspTypeCheck_b:=False:C215
	If (([Bridge MHD NBIS:1]InspResp:173="DIST@") & [Bridge MHD NBIS:1]FHWARecord:174)
		$InspTypeCheck_b:=([Inspections:27]Insp Type:6="RT@")  //typical routine
		$InspTypeCheck_b:=$InspTypeCheck_b | ([Inspections:27]Insp Type:6="CUL")  //routine culvert
		$InspTypeCheck_b:=$InspTypeCheck_b | ([Inspections:27]Insp Type:6="CMI")  //special member
		$InspTypeCheck_b:=$InspTypeCheck_b | ([Inspections:27]Insp Type:6="FCR")  //fract crit
		$InspTypeCheck_b:=$InspTypeCheck_b | ([Inspections:27]Insp Type:6="DVE")  //normal routine dive
		$InspTypeCheck_b:=$InspTypeCheck_b | ([Inspections:27]Insp Type:6="DVL")  //low clearance routine dive
		
		If ($InspTypeCheck_b)
			
			$InspCompCheck_b:=User in group:C338(Current user:C182; "Design Access Group")
			$InspCompCheck_b:=$InspCompCheck_b | (<>CURRENTUSER_PID=[Inspections:27]TeamLeader:4)
			$InspCompCheck_b:=$InspCompCheck_b | (<>CURRENTUSER_PID=[Inspections:27]DBrInspEngr:3)
			//check if current DBIE
			C_TEXT:C284($Dist_txt)
			$Dist_txt:=Substring:C12([Bridge MHD NBIS:1]InspResp:173; 5)
			READ ONLY:C145([Personnel:42])
			QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=<>CURRENTUSER_PID)
			$currentDBIE_b:=False:C215
			
			If (Records in selection:C76([Personnel:42])=1)
				$currentDBIE_b:=([Personnel:42]Job Code:8=1)
				$currentDBIE_b:=$currentDBIE_b & [Personnel:42]Active:11
				$currentDBIE_b:=$currentDBIE_b & ([Personnel:42]Division No:7=("044"+$Dist_txt))
			End if 
			
			$InspCompCheck_b:=$InspCompCheck_b | ($currentDBIE_b & Not:C34([Inspections:27]Insp Type:6="DV@"))  //for non-dive inspections
			
			//check if current UOE
			$currentDBIE_b:=False:C215
			
			If (Records in selection:C76([Personnel:42])=1)
				$currentDBIE_b:=([Personnel:42]Job Code:8=1)
				$currentDBIE_b:=$currentDBIE_b & [Personnel:42]Active:11
				$currentDBIE_b:=$currentDBIE_b & ([Personnel:42]Division No:7="0449")  //dive is 0449
			End if 
			$InspCompCheck_b:=$InspCompCheck_b | ($currentDBIE_b & ([Inspections:27]Insp Type:6="DV@"))  //for dive inspections
			
		Else 
			//allow anyone with write access to mark as complete
			$InspCompCheck_b:=True:C214
		End if 
		
	Else 
		$InspCompCheck_b:=True:C214
	End if 
	
	If ($InspCompCheck_b)  //allowed to mark inspection complete
		
		If ($InspTypeCheck_b) & ([Inspections:27]InspCompleteDate:221=!00-00-00!)  //one of inspection types for which data will be copied to SIA; first time completed
			// this will only be done first time complete id inspcompldate=00/00/00
			C_TEXT:C284($ItemsToUpdate_txt)
			$ItemsToUpdate_txt:=""
			Case of 
				: ([Inspections:27]Insp Type:6="RT@")
					$ItemsToUpdate_txt:="NBI Items 41, 58, 59, 60, 61, 36A, 36B, 36C, 36D, 90"
					If ([Inspections:27]InspRtnSpcMemFlag:209)
						$ItemsToUpdate_txt:=$ItemsToUpdate_txt+", 93C"
					End if 
				: ([Inspections:27]Insp Type:6="CUL")
					$ItemsToUpdate_txt:="NBI Items 41, 61, 62, 36A, 36B, 36C, 36D, 90"
					If ([Inspections:27]InspRtnSpcMemFlag:209)
						$ItemsToUpdate_txt:=$ItemsToUpdate_txt+", 93C"
					End if 
					
				: ([Inspections:27]Insp Type:6="FCR")
					$ItemsToUpdate_txt:="NBI Items 41, 59, 60, 93A"
					
				: ([Inspections:27]Insp Type:6="CMI")
					$ItemsToUpdate_txt:="NBI Items 41, 58, 59, 60, 62, 93C"
				: ([Inspections:27]Insp Type:6="DVE") | ([Inspections:27]Insp Type:6="DVL")
					$ItemsToUpdate_txt:="NBI Item 93B"
			End case 
			msg:="!!! CAUTION !!!"
			msg:=msg+Char:C90(13)+"Marking this Inspection Report as Completed will update the SI&A with "+$ItemsToUpdate_txt+" from this report!"
			msg:=msg+Char:C90(13)+"This automatic action will only be performed the first time this report is marked as complete!"
			msg:=msg+Char:C90(13)+"Is this Inspection ready to be reviewed?"
			
		Else   //other inspections or not the first completion
			If ([Inspections:27]InspComplete:168)
				msg:="Current Inspection status = Ready for Review"+<>sCR
			Else 
				msg:="Current Inspection status = Incomplete"+<>sCR
			End if 
			msg:=msg+"Is this Inspection ready to be reviewed?"
		End if 
		G_MyConfirm(INSP_QCAddNoticeToMsg(msg); "Not Yet"; "Ready")
		
		If (Ok=0)  // think its Ready
			//Do a data check
			msg:=""
			Case of 
				: ([Inspections:27]Insp Type:6="RT@")
					msg:=G_CheckRoutineInsp
				: ([Inspections:27]Insp Type:6="CUL")
					msg:=G_CheckCulvertInsp
			End case 
			
			//add check for inspection date not in the future
			If ([Inspections:27]Insp Date:78>Current date:C33(*))
				If (msg="")
					msg:="Inspection date "+String:C10([Inspections:27]Insp Date:78)+" is in the future !"
				Else 
					msg:="Inspection date "+String:C10([Inspections:27]Insp Date:78)+" is in the future !"+<>sCR+msg
				End if 
			End if 
			
			C_TEXT:C284($FldWorkMsg_txt)
			$FldWorkMsg_txt:=INSP_FieldWorkComplCheck
			
			If ($FldWorkMsg_txt#"")
				
				If (msg="")
					msg:=$FldWorkMsg_txt
				Else 
					msg:=$FldWorkMsg_txt+<>sCR+msg
				End if 
				
			End if 
			//check all images - this is skipped now
			C_TEXT:C284($ImageCheck_txt)
			$ImageCheck_txt:=""
			//$ImageCheck_txt:=INSP_CheckImages 
			If ($ImageCheck_txt#"")
				$ImageCheck_txt:="The following images are in incompatible/deprecated format. They have to be converted to a JPG, PNG or TIFF format!"+<>sCR+$ImageCheck_txt
				If (msg="")
					msg:=$ImageCheck_txt
				Else 
					msg:=$ImageCheck_txt+<>sCR+msg
				End if 
			End if 
			
			If (msg#"")
				//some errors - cannot mark as complete
				msg:=[Inspection Type:31]Description:2+" Inspection is incomplete. The reasons are : "+<>sCR+msg
				ut_BigAlert(msg; "Inspection Completion Checks")
				
				If ([Inspections:27]InspComplete:168)
					[Inspections:27]InspComplete:168:=False:C215
					PushChange(1; ->[Inspections:27]InspComplete:168)
				End if 
			Else 
				//no errors found
				C_BOOLEAN:C305($tranfertoInv_b)
				//save data to inventory record only for the first time the inspection has been completed
				// ie [Inspections]InspCompleteDate=!00-00-00!
				Case of 
					: ([Inspections:27]InspCompleteDate:221=!00-00-00!)
						$tranfertoInv_b:=INSP_Data2Inventory
					Else 
						$tranfertoInv_b:=True:C214  //allow to continue
				End case 
				
				If ($tranfertoInv_b)
					//data transfered Ok to inventory or bypassed
					If (Not:C34([Inspections:27]InspComplete:168))
						[Inspections:27]InspComplete:168:=True:C214
						PushChange(1; ->[Inspections:27]InspComplete:168)
						If ([Inspections:27]InspCompleteDate:221=!00-00-00!)
							[Inspections:27]InspCompleteDate:221:=Current date:C33(*)
							PushChange(1; ->[Inspections:27]InspCompleteDate:221)
						End if 
						If ([Inspections:27]Agency:156#"Mass. Highway Dept.@")
							//for consultants
							[Inspections:27]ConsAcceptanceDate:202:=Current date:C33(*)
							PushChange(1; ->[Inspections:27]ConsAcceptanceDate:202)
						End if 
						C_OBJECT:C1216($param_o)
						OB SET:C1220($param_o; "type"; "tl"; "fieldptr"; ->[Inspections:27]RatingFeedBack:203; "stack"; 1)
						INSP_QCSaveApprovalInfo($param_o)
					End if 
					//do HI calculation update here
					INSP_HICalcControl("ALL")
					
				Else 
					//error tranfering to inventory
					//don't allow to mark as complete
					ALERT:C41("Could not update Inventory record! Inspection is marked as incomplete!")
					If ([Inspections:27]InspComplete:168)
						[Inspections:27]InspComplete:168:=False:C215
						PushChange(1; ->[Inspections:27]InspComplete:168)
					End if 
				End if 
				
				
			End if 
			msg:=""
		Else 
			If ([Inspections:27]InspComplete:168)
				[Inspections:27]InspComplete:168:=False:C215
				PushChange(1; ->[Inspections:27]InspComplete:168)
			End if 
		End if 
		
	End if 
	
	INSP_SaveRecords
	
	//Make sure buttons and fields are left unlocked
	OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
	OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DE@")
	bDiveFormValid:=True:C214
	CANCEL:C270  //exit the form
End if 