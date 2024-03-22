//%attributes = {"invisible":true}
//Method: PON_RecordAllChanges
//Description
// Record all changes made to the NBE element
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/24/15, 10:30:31
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(5/4/16 13:43:46)
	Mods_2016_05_bug
	//  `check if changes were made then set moddate and moduser IF not a new record
End if 
//

If (Is new record:C668([PON_ELEM_INSP:179]))
	LogNewRecord(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; "PON_ELEM_INSP")
End if 

PushAllChanges(PON_ChangeStackLvl_L; ->[PON_ELEM_INSP:179]; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[PON_ELEM_INSP:179]ELEMID:22; ->[PON_ELEM_INSP:179]INSPID:21)
If (Size of array:C274(ptr_changes{PON_ChangeStackLvl_L})>0)
	//changes were made - mark it - if not new record
	If (Is new record:C668([PON_ELEM_INSP:179]))
	Else 
		[PON_ELEM_INSP:179]ELEM_MODTIME:18:=ISODateTime(Current date:C33(*); Current time:C178(*))
		[PON_ELEM_INSP:179]ELEM_MODUSERKEY:25:=Current user:C182
		PushChange(PON_ChangeStackLvl_L; ->[PON_ELEM_INSP:179]ELEM_MODTIME:18)
		PushChange(PON_ChangeStackLvl_L; ->[PON_ELEM_INSP:179]ELEM_MODUSERKEY:25)
	End if 
End if 
FlushGrpChgs(PON_ChangeStackLvl_L; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28#Old:C35([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28))
	If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
		LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
	Else 
		LogChanges(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
	End if 
	
End if 
If ([PON_ELEM_INSP:179]ELEM_PARENTID:27#Old:C35([PON_ELEM_INSP:179]ELEM_PARENTID:27))
	If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
		LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
	Else 
		LogChanges(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
	End if 
End if 
//End PON_RecordAllChanges