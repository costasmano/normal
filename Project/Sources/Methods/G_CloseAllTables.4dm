//%attributes = {"invisible":true}
If (False:C215)
	//G_CloseAllTables
	//Method to reduce selection of all tables to 0 and
	//unload any loaded records. 
	//Exclude a table passed as a pointer.
	// Modified by: Costas Manousakis-(Designer)-(4/11/16 17:41:32)
	Mods_2016_04_bug
	//  `Added check for table number valid
End if 

C_POINTER:C301($1)  //pointer to table not to be closed.
C_LONGINT:C283($vnumtables; $vRecsSel; $i)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($vTablePointer)
C_TEXT:C284($vsSkipTable)  // Command Replaced was o_C_STRING length was 80
If (Count parameters:C259=1)
	$vsSkipTable:=Table name:C256($1)
Else 
	$vsSkipTable:=""
End if 

$vnumtables:=Get last table number:C254
For ($i; 1; $vnumtables)
	If (Is table number valid:C999($i))
		$vTablePointer:=Table:C252($i)
		$vRecsSel:=Records in selection:C76($vTablePointer->)
		If ($vRecsSel>0)
			
			If (Table name:C256($vTablePointer)#$vsSkipTable)
				REDUCE SELECTION:C351($vTablePointer->; 0)
			End if 
		End if 
		If (Is record loaded:C669($vTablePointer->))
			If (Table name:C256($vTablePointer)#$vsSkipTable)
				UNLOAD RECORD:C212($vTablePointer->)
			End if 
		End if 
	End if 
End for 