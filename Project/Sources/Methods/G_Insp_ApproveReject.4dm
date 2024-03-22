//%attributes = {"invisible":true}
If (False:C215)
	//  G_Insp_ApproveReject 
	//Method to Approve/Reject Inspections
	//Called from bzApprove button of [Inspections];"InspectionReview" form.
	
	//Copied from Object method created Nov-2001
	
	Mods_2005_CM05  //- twice
	// Modified by: costasmanousakis-(Designer)-(2/27/2006 13:56:46)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(12/21/2006 16:18:09)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(2/14/2007 10:06:19)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(8/29/2007 11:44:07)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 14:26:25`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(2/12/10 13:44:46)
	Mods_2010_02
	//  `Adjustments to allow reviews of multiple Insp resp bridges.
	//  `And on DBIE Reject/Approve dont prompt to send email if Cancel was pressed on the dialog 
	// Modified by: costasmanousakis-(Designer)-(8/27/10 15:06:55)
	Mods_2010_08
	//  `Changed method of looping thru records : Go thru the whole selection and check if the record is highlighted
	//  `Modified the ALerts when Inspection is not ready for review to add more info re the inspection
	// Modified by: costasmanousakis-(Designer)-(8/30/10 09:26:05)
	Mods_2010_08
	//  `Create a selection that is in the same order as the current llist from the UserSet 
	//  `- use new method ut_SelectionFromUserSet
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 14:31:13)
End if 

C_TEXT:C284($msg; vTextMsg; vtRevComments; vtPrevRevComments)
C_BOOLEAN:C305(INSP_OneStepApprove_b)
C_LONGINT:C283(vbAccept; vbReject)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($sRevType)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305($bOKtoApprove)

C_LONGINT:C283($LRecsInSet; $i; $RecordsInSele_L; $tempWin)
$LRecsInSet:=Records in set:C195("UserSet")
$RecordsInSele_L:=Records in selection:C76([Inspections:27])
If ($LRecsInSet>0)
	ut_SelectionFromUserSet("CREATE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
	
	FIRST RECORD:C50([Inspections:27])
	For ($i; 1; $LRecsInSet)
		
		RELATE ONE:C42([Inspections:27]BIN:1)
		RELATE ONE:C42([Inspections:27]Insp Type:6)
		C_LONGINT:C283($StartApproveLvl_L)
		$StartApproveLvl_L:=vApproveLvl
		If (vApproveLvl>0)
			Case of 
				: ([Bridge MHD NBIS:1]InspResp:173="MDC")
					vApproveLvl:=2
					INSP_OneStepApprove_b:=True:C214
			End case 
			
		End if 
		
		Case of 
			: (vApproveLvl=1)
				$sRevType:="DBIE Review"
			: (vApproveLvl=2)
				$sRevType:="Final Approval"
		End case 
		
		Case of 
			: (Locked:C147([Inspections:27]))
				//Inspection is locked - in use by somebody...
				$bOktoApprove:=False:C215
			: (vApproveLvl=1)
				$bOktoApprove:=[Inspections:27]InspComplete:168
				If ([Inspections:27]Insp Type:6="DV@")
					$bOktoApprove:=False:C215  //cannot approve Dive Inspections at level 1
				End if 
				
			: (vApproveLvl=2)
				If (([Inspections:27]Insp Type:6="DV@") | (INSP_OneStepApprove_b))
					$bOktoApprove:=[Inspections:27]InspComplete:168
				Else 
					$bOktoApprove:=[Inspections:27]InspComplete:168 & ([Inspections:27]InspReviewed:12=BMS Approved)
				End if 
		End case 
		
		If ($bOKtoApprove)
			
			$msg:=$sRevType+" Stage for "+[Inspection Type:31]Description:2+" Inspection "
			$msg:=$msg+<>sCR+"dated : "+String:C10([Inspections:27]Insp Date:78)
			$msg:=$msg+<>sCR+"for  BIN : "+[Inspections:27]BIN:1+"?"
			vTextMsg:=$msg
			vbAccept:=0
			vbReject:=0
			vtPrevRevComments:="DBIE Review :"+<>sCR+[Inspections:27]InspRevCmts:170+<>sCR+(15*"-")+<>sCR
			vtPrevRevComments:=vtPrevRevComments+"Area Engineer Review :"+<>sCR+[Inspections:27]InspApprCmts:169
			
			vtRevComments:=""
			vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
			
			C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
			C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
			C_TEXT:C284($Title_txt)
			FORM GET PROPERTIES:C674([Dialogs:21]; "ApproveInsp"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
			$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
			//$tempWin:=Open form window([Dialogs];"ApproveInsp")
			DIALOG:C40([Dialogs:21]; "ApproveInsp")
			CLOSE WINDOW:C154($Win_l)
			Case of 
				: (vApproveLvl=2)  //Final Approval
					Case of 
							
						: (vbAccept=1)
							
							Case of 
								: ([Inspections:27]Insp Type:6="DV@")  //Dive  Inspection
									INSP_DiveDates2SIA
								: (INSP_OneStepApprove_b)
									INSP_InspData2SIA
							End case 
							
							InitChangeStack(1)
							[Inspections:27]InspApproved:167:=BMS Approved  //mark inspection as accepted 
							PushChange(1; ->[Inspections:27]InspApproved:167)
							If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
								[Inspections:27]InspAreaEngApprDate:207:=Current date:C33(*)
								PushChange(1; ->[Inspections:27]InspAreaEngApprDate:207)
							End if 
							[Inspections:27]InspApprCmts:169:=""  //remove comments from review fields
							[Inspections:27]InspRevCmts:170:=""
							PushChange(1; ->[Inspections:27]InspRevCmts:170)
							PushChange(1; ->[Inspections:27]InspApprCmts:169)
							FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
							G_CleanUpInspection  //Clean up the inspection tables.
							
						: (vbReject=1)
							[Inspections:27]InspApproved:167:=BMS Rejected  //mark inspection as rejected
							[Inspections:27]InspReviewed:12:=BMS Not Reviewed  //mark inspection as not reviewed
							If ([Inspections:27]InspApprCmts:169="")
								[Inspections:27]InspApprCmts:169:=Current user:C182+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
							Else 
								[Inspections:27]InspApprCmts:169:=[Inspections:27]InspApprCmts:169+<>sCR+<>sCR+Current user:C182+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
							End if 
							[Inspections:27]InspComplete:168:=False:C215  //mark inspection as incomplete
							InitChangeStack(1)
							PushChange(1; ->[Inspections:27]InspApproved:167)
							PushChange(1; ->[Inspections:27]InspReviewed:12)
							PushChange(1; ->[Inspections:27]InspApprCmts:169)
							PushChange(1; ->[Inspections:27]InspComplete:168)
							FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
					End case 
					SAVE RECORD:C53([Inspections:27])  // save inspections record
					
				: (vApproveLvl=1)  //DBIE Approval
					//Above water inspections do data transfer to SIA at a DBIE approval          
					Case of 
						: (vbAccept=1)
							INSP_InspData2SIA
							InitChangeStack(1)
							[Inspections:27]InspReviewed:12:=BMS Approved  //mark inspection as approved
							If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
								[Inspections:27]InspDBIEApprDate:206:=Current date:C33(*)
								PushChange(1; ->[Inspections:27]InspDBIEApprDate:206)
							End if 
							PushChange(1; ->[Inspections:27]InspReviewed:12)
							FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
							
						: (vbReject=1)
							[Inspections:27]InspReviewed:12:=BMS Rejected  //mark inspection as rejected
							If ([Inspections:27]InspRevCmts:170="")
								[Inspections:27]InspRevCmts:170:=Current user:C182+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
							Else 
								[Inspections:27]InspRevCmts:170:=[Inspections:27]InspRevCmts:170+<>sCR+<>sCR+Current user:C182+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
							End if 
							[Inspections:27]InspComplete:168:=False:C215  //mark inspection as incomplete
							InitChangeStack(1)
							PushChange(1; ->[Inspections:27]InspReviewed:12)
							PushChange(1; ->[Inspections:27]InspRevCmts:170)
							PushChange(1; ->[Inspections:27]InspComplete:168)
							FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
					End case 
					SAVE RECORD:C53([Inspections:27])
					If (([Inspections:27]Agency:156#"Mass. Highw@") & ((vbAccept=1) | (vbReject=1)))
						Mail_SendInspRevuNotif
					End if 
					
			End case 
			
		Else 
			$msg:=[Inspection Type:31]Description:2
			If ([Inspections:27]InspRtnSpcMemFlag:209)
				$msg:=$msg+" & Spec.Memb."
			End if 
			
			$msg:=$msg+" ("+[Inspections:27]Insp Type:6+") Inspection dated "+String:C10([Inspections:27]Insp Date:78)+" for BIN "+[Inspections:27]BIN:1
			Case of 
				: (Locked:C147([Inspections:27]))
					//Inspection is locked - in use by somebody...
					C_LONGINT:C283($OtherPID)
					C_TEXT:C284($OtherUser; $OtherMachine; $OtherProc)  // Command Replaced was o_C_STRING length was 50
					LOCKED BY:C353([Inspections:27]; $OtherPID; $OtherUser; $OtherMachine; $OtherProc)
					//$msg:="Inspection "+[Inspections]Insp Type+" BIN :"+[Inspections]BIN+" date:"+String([Inspections]Insp Date)
					If ($OtherUser="")
						$msg:=$msg+<>sCR+"In your process : "+$OtherProc
					Else 
						$msg:=$msg+" is being edited by"+<>sCR+"User : "+$OtherUser+<>sCR+"From station : "+$OtherMachine
						$msg:=$msg+<>sCR+"In process : "+$OtherProc
					End if 
					
					$msg:=$msg+<>sCR+"Cannot proceed with approval at this time. Try again later."
					ALERT:C41($msg)
				: (vApproveLvl=1)
					ALERT:C41($msg+" Not Complete yet!!!")
				: (vApproveLvl=2)
					If ([Inspections:27]Insp Type:6="DVE")
						ALERT:C41($msg+" Not Complete Yet !!!")
					Else 
						ALERT:C41($msg+" Not Complete or not Approved by DBIE !!!")
					End if 
					
			End case 
		End if 
		vApproveLvl:=$StartApproveLvl_L
		NEXT RECORD:C51([Inspections:27])
		
	End for   //end of selected record loop
	
	vbSortedHeader:=True:C214  //do not do a header sort
	
	ut_SelectionFromUserSet("RESTORE"; ->[Inspections:27]; "StartingInspects"; "TempUserSet1")
	
Else 
	ALERT:C41("You must first Highlight Records to Approve!")
End if 