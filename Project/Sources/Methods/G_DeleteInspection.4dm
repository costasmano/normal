//%attributes = {"invisible":true}
//procedure: G_DeleteInspection
//purpose: log the deletion of a inspection form
If (False:C215)
	//Copied from fobject method of Button ZZ5 on [Inspections];"Dive Form" 
	//  which was coded originally by: Albert Leung
	//created: 5/1/2001
	//modified: 6/2001 Include notice about Images attached.
	//Copyright © 1995-2001,  Albert S. Leung, All Rights Reserved.
	//parameters:
	//Modified :
	//Dec-2001 : Prevent deletion of approved inspection reports unless designer;
	//    re-order inspections after deletion.
	//Dec-2001 : Modify behavior depending on whether we are in "ReviewInspections" 
	//    or not.
	//Jan-2001 : Modified to adjust for change of type of InspApproved to integer and
	//    addition of InspReviewed field.
	
	Mods_2005_CM11
	// Modified by: costasmanousakis-(Designer)-(11/18/05 12:47:01)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/16/2005 15:35:57)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(11/1/2007 14:29:31)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(12/17/07 08:58:57)
	Mods_2007_CM_5401
	//  `Fix error in the loging of the deletion of CondUnits (logged only the 1st one)
	// Modified by: costasmanousakis-(Designer)-(12/2/09 09:11:34)
	Mods_2009_11
	//Fixed the delete prompt to get the correct user name
	// Modified by: costasmanousakis-(Designer)-(8/26/10 11:40:03)
	Mods_2010_08
	//  `Moved the SELECTION TO ARRAY command after the DELETE RECORD commands
	//  `It was removing the current record from the [Inspections] table
	// Modified by: costasmanousakis-(Designer)-(9/13/10 19:46:18)
	Mods_2010_09
	//  `Execute method only if on page 1 of a form???
	//  `Also require user Password before deleting
	// Modified by: costasmanousakis-(Designer)-(11/18/10 12:08:08)
	Mods_2010_11
	//  `Fixed the SELECTION TO ARRAY setting. a) search for the just deleted record, rec num=-1 
	//  `b) reduce the selection to 0 if the array is zeroed out
	// Modified by: costasmanousakis-(Designer)-(4/13/11 17:08:31)
	Mods_2011_04
	//  `Fix a bug in the deletion of array element if the index of the current inspection is not found.
	//  `Added Alert if the code is executed not on page 1.
	//  `Added code to handle the case if the record has been loaded in read-only mode and the delete button has been
	//  `pressed. This happens only if the user is in the "Area Engineers" group. See G_Insp_LockFormOnOff method.
	// Modified by: costasmanousakis-(Designer)-(5/3/11 10:30:58)
	Mods_2011_05
	//  `Fix for the bug in Selection to array / LONGINT ARRAY FROM SELECTION when records are deleted in v11
	// Modified by: Costas Manousakis-(Designer)-(3/26/15 16:40:51)
	Mods_2015_03
	//  `check for NBEs in [PON_ELEM_INSP] and show alert fror them, they will be deleted anyway.
End if 

C_TEXT:C284($Text; $ElTxt; $PictTxt)  //Alert message text and parts.
C_LONGINT:C283($NoElems; $NoPicts; $NoCUs)  //Number of Elements ([ElementsSafety] records),
// [Standard Photos] records.
C_BOOLEAN:C305($vBMSInspHere_B)
$vBMSInspHere_B:=Is record loaded:C669([BMS Inspections:44])
If (FORM Get current page:C276=1)
	
	If (([Inspections:27]InspApproved:167#BMS Not Reviewed) & ([Inspections:27]InspReviewed:12#BMS Not Reviewed) & (Current user:C182#"Designer"))
		ALERT:C41("Cannot delete an Approved Inspection report!!!!")
	Else 
		$NoElems:=Records in selection:C76([ElementsSafety:29])
		$NoPicts:=Records in selection:C76([Standard Photos:36])
		
		If (([Inspections:27]InspApproved:167#BMS Not Reviewed) | ([Inspections:27]InspReviewed:12#BMS Not Reviewed))
			$Text:="Do you "+Current user:C182+" really want to delete this Inspection record, "
			$Text:=$Text+"which is in the Review process,"
		Else 
			$Text:="Do you really want to delete this inspection record"
		End if 
		$ElTxt:=""
		$PictTxt:=""
		Case of 
			: ($NoElems=1)
				$ElTxt:=" its element"
			: ($NoElems>1)
				$ElTxt:=" its "+String:C10($NoElems)+" elements"
		End case 
		Case of 
			: ($NoPicts=1)
				$PictTxt:=" its image"
			: ($NoPicts>1)
				$PictTxt:=" its "+String:C10($NoPicts)+" images"
		End case 
		
		If (($ElTxt+$PictTxt)#"")
			
			Case of 
				: ($PictTxt#"")
					$Text:=$Text+$ElTxt+" and"+$PictTxt
				: ($PictTxt="")
					$Text:=$Text+" and"+$ElTxt
			End case 
			
		End if 
		
		If ($vBMSInspHere_B)
			
			If (PON_NBEDateOn_b([Inspections:27]Insp Date:78))
				$Text:=$Text+" and a BrM Inspection"
				$NoCUs:=Records in selection:C76([PON_ELEM_INSP:179])
				$ElTxt:=""
				Case of 
					: ($NoCUs=1)
						$ElTxt:=" with its National Bridge Element"
					: ($NoCUs>1)
						$ElTxt:=" with its "+String:C10($NoCUs)+" National Bridge Elements"
				End case 
				$Text:=$Text+$ElTxt
				
			Else 
				$Text:=$Text+" and a Pontis Inspection"
				$NoCUs:=Records in selection:C76([Cond Units:45])
				$ElTxt:=""
				Case of 
					: ($NoCUs=1)
						$ElTxt:=" with its Condition Unit"
					: ($NoCUs>1)
						$ElTxt:=" with its "+String:C10($NoCUs)+" Condition Units"
				End case 
				$Text:=$Text+$ElTxt
				
			End if 
			
		End if 
		
		$Text:=$Text+"?"
		
		CONFIRM:C162($Text; "DELETE")
		If (OK=1)
			C_LONGINT:C283($passwordErr_L)
			$Text:="! ! ! WARNING : To Delete the entire Inspection, your password is required ! ! !"+<>sCR+"Enter your password to Delete the entire inspection or Cancel to abort the deleti"+"on!!"
			$Text:=Uppercase:C13($Text)
			$passwordErr_L:=OP_GetPassword($Text)
			
			If ($passwordErr_L=0)
				//check if read only state
				C_BOOLEAN:C305($CompleteDel_b)
				$CompleteDel_b:=False:C215
				If (Read only state:C362([Inspections:27]))
					//set everything to read write
					C_BOOLEAN:C305($GotAccess_b)
					SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
					$GotAccess_b:=False:C215
					$GotAccess_b:=ut_LoadRecordInteractive(->[Inspections:27])
					If ($GotAccess_b)
						$GotAccess_b:=$GotAccess_b & ut_LoadRecordInteractive(->[Combined Inspections:90])
					End if 
					If ($GotAccess_b)
						If ($vBMSInspHere_B)
							$GotAccess_b:=$GotAccess_b & ut_LoadRecordInteractive(->[BMS Inspections:44])
						End if 
					End if 
					
					If (Not:C34($GotAccess_b))
						ut_Read_Write_Tables("READ"; ->[Inspections:27]; ->[Combined Inspections:90]; ->[BMS Inspections:44]; ->[Standard Photos:36]; ->[ElementsSafety:29]; ->[Field Trip:43]; ->[Cond Units:45]; ->[BMS Field Trip:56]; ->[PON_ELEM_INSP:179])
						UNLOAD RECORD:C212([Inspections:27])
						LOAD RECORD:C52([Inspections:27])
						If (Is record loaded:C669([Combined Inspections:90]))
							UNLOAD RECORD:C212([Combined Inspections:90])
							LOAD RECORD:C52([Combined Inspections:90])
						End if 
						If (Is record loaded:C669([BMS Inspections:44]))
							UNLOAD RECORD:C212([BMS Inspections:44])
							LOAD RECORD:C52([BMS Inspections:44])
						End if 
					Else 
						ut_Read_Write_Tables("WRITE"; ->[Inspections:27]; ->[Combined Inspections:90]; ->[BMS Inspections:44]; ->[Standard Photos:36]; ->[ElementsSafety:29]; ->[Field Trip:43]; ->[Cond Units:45]; ->[BMS Field Trip:56]; ->[PON_ELEM_INSP:179])
						$CompleteDel_b:=True:C214
					End if 
					
				Else 
					//not read only - so good to go
					$CompleteDel_b:=True:C214
				End if 
				
				If ($CompleteDel_b)
					C_LONGINT:C283($CurrRec_L; $myID_L)
					$CurrRec_L:=Selected record number:C246([Inspections:27])
					//The relation automatically deletes related many records.
					LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
					LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
					If ($vBMSInspHere_B)
						LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
						QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
						If (Records in selection:C76([Cond Units:45])>0)
							InitGrpDelete
							While (Not:C34(End selection:C36([Cond Units:45])))
								PushGrpDelete(->[Cond Units:45]Cond Unit ID:1)
								NEXT RECORD:C51([Cond Units:45])
							End while 
							FlushGrpDeletions(->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
						End if 
						
					End if 
					C_LONGINT:C283($vProcState; $vProcTime)
					C_TEXT:C284($vsProcName)  // Command Replaced was o_C_STRING length was 255
					PROCESS PROPERTIES:C336(Current process:C322; $vsProcName; $vProcState; $vProcTime)
					//Save current [inspections] selection in array form
					ARRAY LONGINT:C221($InspRecIDs_aL; 0)
					//$myID_L:=Record number([Inspections])
					
					//Now delete the record  
					DELETE RECORD:C58([Inspections:27])
					DELETE RECORD:C58([Combined Inspections:90])
					If ($vBMSInspHere_B)
						DELETE RECORD:C58([BMS Inspections:44])
						If (Records in selection:C76([Cond Units:45])>0)
							DELETE SELECTION:C66([Cond Units:45])
						End if 
					End if 
					//restore the selection - it sorted as before
					SELECTION TO ARRAY:C260([Inspections:27]; $InspRecIDs_aL)
					If ($CurrRec_L>0)
						DELETE FROM ARRAY:C228($InspRecIDs_aL; $CurrRec_L)
					End if 
					If (Size of array:C274($InspRecIDs_aL)>0)
						CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $InspRecIDs_aL)
					Else 
						REDUCE SELECTION:C351([Inspections:27]; 0)
					End if 
					
					ARRAY LONGINT:C221($InspRecIDs_aL; 0)
					
					CANCEL:C270  //Exit the form
					
				End if 
				
			End if 
			
		End if 
	End if 
Else 
	ALERT:C41("To Delete the Current Inspection you must be at the "+<>sQu+"General"+<>sQu+" Tab of the Input Form!")
End if 