//Object Method: [Inspections];"Dive Template".bzAccept 
//Accept Button
//Prompt user if Inspection report is completed, and ready to be reviewed.

If (False:C215)
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	// Modified by: Costas Manousakis-(Designer)-(1/16/15 12:06:36)
	Mods_2015_01
	//  `Addition of INSP_FieldWorkComplCheck
	// Modified by: Costas Manousakis-(Designer)-(12/9/16 12:04:34)
	Mods_2016_12
	//  `added Check of image types to avoid PICTs and PDFs ; change message to use  ut_BigAlert
	// Modified by: Costas Manousakis-(Designer)-(1/19/17 15:00:55)
	Mods_2017_01
	//  `remove ImageCheck call 
	// Modified by: Costas Manousakis-(Designer)-(9/15/17 12:48:48)
	Mods_2017_09
	//  `add the conditions to save insp data to SIA 
	// Modified by: Costas Manousakis-(Designer)-(5/4/20 14:30:36)
	Mods_2020_05
	//  `added resequence of images
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-10-25T00:00:00 15:18:24)
	Mods_2021_10
	//  `added current user, os user and machine to confirm message and call to INSP_QCSaveApprovalInfo
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 
//INSP_Check4DWriteChgs 
INSP_SaveInspCommts

C_BOOLEAN:C305($AllowMarkComplete_b)

//Save changes to sequences
If (NTI_ImageSortNeeded_b)
	EXECUTE METHOD IN SUBFORM:C1085("ListOfImages"; "NTI_ApplyImageSort")
End if 

If ([Bridge MHD NBIS:1]FHWARecord:174) & (([Inspections:27]Insp Type:6="DVE") | ([Inspections:27]Insp Type:6="DVL"))
	//for routine Dives allow only TL, UOE and designer
	$AllowMarkComplete_b:=(<>CurrentUser_PID=[Inspections:27]TeamLeader:4)
	$AllowMarkComplete_b:=$AllowMarkComplete_b | (<>CurrentUser_PID=<>UOEID)
	$AllowMarkComplete_b:=$AllowMarkComplete_b | User in group:C338(Current user:C182; "Design Access Group")
Else 
	//all others 
	$AllowMarkComplete_b:=True:C214
End if 

If ($AllowMarkComplete_b)
	
	G_MyConfirm(INSP_QCAddNoticeToMsg("Is this Inspection ready to be reviewed?"); "Not Yet"; "Ready")
	
	If (Ok#1)
		C_TEXT:C284($fldcheck_txt)
		$fldcheck_txt:=INSP_FieldWorkComplCheck
		C_TEXT:C284($ImageCheck_txt)
		$ImageCheck_txt:=""
		//$ImageCheck_txt:=INSP_CheckImages 
		If ($ImageCheck_txt#"")
			$ImageCheck_txt:="The following images are in incompatible/deprecated format. They have to be converted to a JPG, PNG or TIFF format!"+<>sCR+$ImageCheck_txt
			If ($fldcheck_txt="")
				$fldcheck_txt:=$ImageCheck_txt
			Else 
				$fldcheck_txt:=$fldcheck_txt+<>sCR+$ImageCheck_txt
			End if 
		End if 
		
		If ($fldcheck_txt="")
			//now save data to SIA
			C_BOOLEAN:C305($tranfertoInv_b)
			Case of 
				: ([Inspections:27]InspCompleteDate:221=!00-00-00!)  //first time it has been completed
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
					C_OBJECT:C1216($param_o)
					OB SET:C1220($param_o; "type"; "tl"; "fieldptr"; ->[Inspections:27]RatingFeedBack:203; "stack"; 1)
					INSP_QCSaveApprovalInfo($param_o)
					
				End if 
				
			Else 
				//error tranfering to inventory
				//don't allow to mark as complete
				ALERT:C41("Could not update Inventory record! Inspection is marked as incomplete!")
				If ([Inspections:27]InspComplete:168)
					[Inspections:27]InspComplete:168:=False:C215
					PushChange(1; ->[Inspections:27]InspComplete:168)
				End if 
			End if 
			
		Else 
			//ALERT($fldcheck_txt)
			$fldcheck_txt:=[Inspection Type:31]Description:2+" Inspection is incomplete!!!!"+<>sCR+$fldcheck_txt
			ut_BigAlert($fldcheck_txt; "Inspection Completion Checks")
			[Inspections:27]InspComplete:168:=False:C215
			PushChange(1; ->[Inspections:27]InspComplete:168)
		End if 
	Else 
		If ([Inspections:27]InspComplete:168)
			[Inspections:27]InspComplete:168:=False:C215
			PushChange(1; ->[Inspections:27]InspComplete:168)
		End if 
	End if 
End if 