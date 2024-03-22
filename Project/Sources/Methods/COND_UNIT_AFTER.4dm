//%attributes = {"invisible":true}
If (False:C215)
	//GP COND_UNIT_AFTER
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	
	//Used for all buttons that accept a [Cond Units] record.
	
	Mods_2005_CM06
	Mods_2005_CM17
	Mods_2011_06  // CJ Miller`06/13/11, 16:39:37      ` Type all local variables for v11
	Mods_2019_05  //Added a save record and If (Not(vbinspectionLocked)) as we do not need to run this if no changes can be made
End if 
If (Not:C34(vbinspectionLocked))
	SHORT_MESSAGE("One moment please ...")
	
	//TRACE
	C_BOOLEAN:C305($FoundDup)
	//$FoundDup:=False
	//If ([Cond Units]Element ID#Old([Cond Units]Element ID)) | ([Cond Units]Environme
	$FoundDup:=Check_DupCU
	
	If ($FoundDup)
		//It is a duplicate.   
		C_TEXT:C284($Text)
		$Text:="You must not duplicate an element/environment combination."+<>sCR+<>sCR
		$Text:=$Text+"Please go back and change either the element number or the environment."
		ALERT:C41($Text)
		
	End if 
	
	//End if 
	C_LONGINT:C283($i)
	//Store each Condition State.
	For ($i; 1; vMaxCSs)
		If (aCS{$i}#a_ptr_CSfld{$i}->)
			//The value has changed, store it in the field.
			a_ptr_CSfld{$i}->:=aCS{$i}
			PushChange(2; a_ptr_CSfld{$i})
		End if 
	End for 
	
	FlushGrpChgs(2; ->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
	
	SAVE RECORD:C53([Cond Units:45])
End if 
If (False:C215)
	//If (Not($FoundDup))
	//This Condition Unit is okay; save any changes.  
	
	//  SAVE RECORD([Cond Units])
	
	//*** Obsolete.  
	//    `First, find and delete any old related records.
	//  RELATE MANY([Cond Units])
	//  SEARCH SELECTION([Cond State Insp];[Cond State Insp]New=False)
	//  DELETE SELECTION([Cond State Insp])
	
	//    `Find the remaining new records.
	//  RELATE MANY([Cond Units])
	//  SORT SELECTION([Cond State Insp];[Cond State Insp]Cond State No)
	//  vNoOldRecs:=Records in selection([Cond State Insp])
	//  If (vNoOldRecs#vNoCSs) | (vNoOldRecs<vMinCSs) | (vNoOldRecs>vMaxCSs)
	//    $Text:="The number of Condition State records ("+String(vNoOldRecs)
	//    $Text:=$Text+") is not valid.  Call for instructions."
	//    ALERT($Text)
	//  End if 
	
	//    `Save the new records, but first flag them as saved (old).
	//  For ($i;1;vNoOldRecs)
	//    [Cond State Insp]New:=False
	//    [Cond State Insp]Amount:=aCS{$i}
	//    SAVE RECORD([Cond State Insp])
	//    NEXT RECORD([Cond State Insp])
	//  End for 
	
	//  FIRST RECORD([Cond State Insp])
	
	//End if 
End if 
CLOSE WINDOW:C154
vCanned:=False:C215