//bEditTeam
//[BMS Inspections];"Inspections In"
//button to change team members

C_LONGINT:C283($i; $Recs)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($ID)
C_BOOLEAN:C305($Delete)

CENTER_WINDOW(500; 300)
DIALOG:C40([Dialogs:21]; "TeamMember")
CLOSE WINDOW:C154

//TRACE

If (Ok=1)
	
	START TRANSACTION:C239
	
	//Preserve current selection of BMS Condition Units.
	//(Not strictly necessary: The layout procedure calls DISPL_CUs,
	//which does a Relate Many.)
	CUT NAMED SELECTION:C334([Cond Units:45]; "Temp")
	
	COPY ARRAY:C226(aTempTeam; aInspTeam)
	COPY ARRAY:C226(aTempTmID; aInspTeamID)
	
	//Check each existing record.  If the team member is still in the updated
	//array, keep the record.  If not, delete the record.
	$Recs:=Size of array:C274(aTempTeam)
	ARRAY BOOLEAN:C223($aTeamCheck; $Recs)  //An element will be set to True if a record already exists.
	For ($i; 1; $Recs)
		$aTeamCheck{$i}:=False:C215
	End for 
	RELATE MANY:C262([BMS Inspections:44]Inspection ID:1)
	FIRST RECORD:C50([BMS Field Trip:56])
	CREATE EMPTY SET:C140([BMS Field Trip:56]; "SetForDeletion")
	For ($i; 1; Records in selection:C76([BMS Field Trip:56]))
		$ID:=Find in array:C230(aTempTmID; [BMS Field Trip:56]Person ID:2)
		If ($ID>0)
			If ($aTeamCheck{$ID}=False:C215)
				//Keep this record.
				$aTeamCheck{$ID}:=True:C214
				$Delete:=False:C215
			Else 
				//Delete record - it's a duplicate.
				$Delete:=True:C214
			End if 
		Else 
			//Delete record - It's no longer in the array.
			$Delete:=True:C214
		End if 
		If ($Delete)
			ADD TO SET:C119([BMS Field Trip:56]; "SetForDeletion")
			LogDeletion(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ->[Personnel:42]Person ID:1)
		End if 
		NEXT RECORD:C51([BMS Field Trip:56])
	End for 
	
	//Now check if any members in the array need to have a record added.
	For ($i; 1; $Recs)
		If (Not:C34($aTeamCheck{$i}))
			CREATE RECORD:C68([BMS Field Trip:56])
			[BMS Field Trip:56]Inspection ID:1:=[BMS Inspections:44]Inspection ID:1
			[BMS Field Trip:56]Person ID:2:=aTempTmID{$i}
			SAVE RECORD:C53([BMS Field Trip:56])
			LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
		End if 
	End for 
	
	USE SET:C118("SetForDeletion")
	DELETE SELECTION:C66([BMS Field Trip:56])
	If (Records in set:C195("LockedSet")>0)
		ALERT:C41("Some team member records were in use. Update cancelled. Please try again later.")
		CANCEL TRANSACTION:C241
	Else 
		VALIDATE TRANSACTION:C240
	End if 
	CLEAR SET:C117("SetForDeletion")
	
	USE NAMED SELECTION:C332("Temp")
End if 