//%attributes = {"invisible":true}
// Method: INSP_ReAssignDBIE
// Description
//   ` Assign new dbie to a list of inspections
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/19/11, 08:34:13
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2011_09
	// Modified by: Costas Manousakis-(Designer)-(2022-03-18T00:00:00 15:32:40)
	Mods_2022_03
	//Add call to Synch_ReturnForward to reset new style vsForward
End if 

C_LONGINT:C283($Recs_L)
COPY NAMED SELECTION:C331([Inspections:27]; "PREASSIGNEDINSPLIST")
$Recs_L:=Records in set:C195("UserSet")
If ($Recs_L>0)
	USE SET:C118("UserSet")
End if 
C_BOOLEAN:C305($DoneSelecting_b; $CancelQuery_b)
$DoneSelecting_b:=False:C215
$CancelQuery_b:=False:C215
Repeat 
	CONFIRM:C162("You have currently chosen "+String:C10($Recs_L)+" Inspections! Search more from current selection of "+String:C10(Records in selection:C76([Inspections:27]))+" ?"; "Search Again"; "Done Searching")
	If (OK=1)
		QUERY SELECTION:C341([Inspections:27])
		If (OK=1)
			$Recs_L:=Records in selection:C76([Inspections:27])
		Else 
			$CancelQuery_b:=True:C214
			$DoneSelecting_b:=True:C214
		End if 
	Else 
		$DoneSelecting_b:=True:C214
	End if 
	
Until ($DoneSelecting_b)
Case of 
	: ($Recs_L=0)
		ALERT:C41("No Inspection records selected!")
	: ($CancelQuery_b)
		ALERT:C41("Search was Canceled!")
	Else 
		InitPers
		C_LONGINT:C283($BIEIndex_L; $NewDBIE_L; $OldDBIE_L; $NumSwitched_L)
		ALERT:C41("Choose DBIE to switch FROM")
		$BIEIndex_L:=G_PickFromList(->aBIE)
		C_BOOLEAN:C305($DoSwitch_b)
		$DoSwitch_b:=False:C215
		$OldDBIE_L:=0
		$NumSwitched_L:=0
		If ($BIEIndex_L>0)
			$DoSwitch_b:=True:C214
			$OldDBIE_L:=aBIE_ID{$BIEIndex_L}
		Else 
			CONFIRM:C162("No restriction on the original DBIE, or Cancel?"; "Any DBIE"; "Cancel")
			If (OK=1)
				$DoSwitch_b:=True:C214
			End if 
			
		End if 
		If ($DoSwitch_b)
			ALERT:C41("Choose DBIE to switch TO")
			$BIEIndex_L:=G_PickFromList(->aBIE)
			$NewDBIE_L:=aBIE_ID{$BIEIndex_L}
			CONFIRM:C162("Assign "+String:C10(Records in selection:C76([Inspections:27]))+" to DBIE "+aBIE{$BIEIndex_L}+" (ID="+String:C10($NewDBIE_L)+") ?")
			If (OK=1)
				
				FIRST RECORD:C50([Inspections:27])
				While (Not:C34(End selection:C36([Inspections:27])))
					If (ut_LoadRecordInteractive(->[Inspections:27]))
						
						If (($OldDBIE_L=0) | ([Inspections:27]DBrInspEngr:3=$OldDBIE_L))
							If ([Inspections:27]DBrInspEngr:3#$NewDBIE_L)
								
								vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
								
								[Inspections:27]DBrInspEngr:3:=$NewDBIE_L
								LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
								SAVE RECORD:C53([Inspections:27])
								$NumSwitched_L:=$NumSwitched_L+1
							End if 
							
						End if 
						
					End if 
					
					NEXT RECORD:C51([Inspections:27])
				End while 
				ALERT:C41("Assigned "+String:C10($NumSwitched_L)+" Inspections to "+aBIE{$BIEIndex_L})
			End if 
			
		End if 
		
End case 

USE NAMED SELECTION:C332("PREASSIGNEDINSPLIST")
CLEAR NAMED SELECTION:C333("PREASSIGNEDINSPLIST")