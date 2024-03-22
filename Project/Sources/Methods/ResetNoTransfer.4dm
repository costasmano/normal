//%attributes = {"invisible":true}
If (False:C215)
	//procedure: ResetNoTransfer
	//by: Albert Leung
	//created: 6/9/97
	//modified: 2/18/98 handles Status not equal to 1
	//purpose: Resets the Activity Log so that no transfers will take place
	// Modified by: costasmanousakis-(Designer)-(11/15/07 10:20:02)
	Mods_2007_CM_5401  //made sure [act log] table is in read write mode
End if 

C_LONGINT:C283($i; $Recs)
C_TEXT:C284($TextMsg)  // Command Replaced was o_C_STRING length was 80
ARRAY LONGINT:C221($aStatus; 0)
READ WRITE:C146([Activity Log:59])
QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9#1)
SELECTION TO ARRAY:C260([Activity Log:59]Status:9; $aStatus)

$Recs:=Size of array:C274($aStatus)
If ($Recs=0)
	ALERT:C41("The activity log contains nothing to reset.")
Else 
	
	For ($i; 1; $Recs)
		$aStatus{$i}:=1
	End for 
	
	If ($Recs=1)
		$TextMsg:="One pending change in log."+<>sCR+<>sCR
		$TextMsg:=$TextMsg+"Reset log so change will never be transferred?"
	Else 
		$TextMsg:=String:C10($Recs)+" pending changes in log."+<>sCR+<>sCR
		$TextMsg:=$TextMsg+"Reset log so changes will never be transferred?"
	End if 
	CONFIRM:C162($TextMsg)
	
	If (OK=1)
		START TRANSACTION:C239
		ARRAY TO SELECTION:C261($aStatus; [Activity Log:59]Status:9)
		
		If (Records in set:C195("LockedSet")=0)
			VALIDATE TRANSACTION:C240
			ALERT:C41("Activity Log now reset to no transfer!")
		Else 
			C_TEXT:C284($msg)
			$msg:=String:C10(Records in set:C195("LockedSet"))+" records are locked!"+" Do you want to commit the remaining ones, or Cancel the whole operation?"
			CONFIRM:C162($msg; "Commit"; "Cancel")
			If (OK=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
			ALERT:C41("Some records ("+String:C10(Records in set:C195("LockedSet"))+") were in use. Changes not saved!")
		End if 
	End if 
End if 
READ ONLY:C145([Activity Log:59])