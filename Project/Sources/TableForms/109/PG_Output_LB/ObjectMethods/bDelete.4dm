If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2022-12-27 19:38:26)
	Mods_2022_12_bug
	//  `fixed deletion to check for locked records
	//  `display the list as is (same sort) with the deleted records removed
End if 
C_LONGINT:C283($n)
$n:=Records in set:C195("UserSet")

If ($n=0)
	ALERT:C41("There are no selected records.")
Else 
	If ($n=1)
		C_LONGINT:C283($col_L; $row_L)
		LISTBOX GET CELL POSITION:C971(*; "PersonalGroup_LB"; $col_L; $row_L)
		GOTO SELECTED RECORD:C245(Current form table:C627->; $row_L)
		CONFIRM:C162("Do you really want to delete group "+[PERS_Groups:109]PERS_GroupName_s:2+" ?")
	Else 
		CONFIRM:C162("Do you really want to delete these "+String:C10($n)+" groups?")
	End if 
	If (OK=1)
		C_LONGINT:C283($loop_L)
		ARRAY LONGINT:C221($records_aL; 0)
		SELECTION TO ARRAY:C260(Current form table:C627->; $records_aL)
		
		USE SET:C118("UserSet")
		ARRAY LONGINT:C221($tobeDeleted_aL; 0)
		SELECTION TO ARRAY:C260(Current form table:C627->; $tobeDeleted_aL)
		CLEAR SET:C117("LockedSet")
		DELETE SELECTION:C66(Current form table:C627->)
		If (Records in set:C195("Lockedset")>0)
			ALERT:C41("There were "+String:C10(Records in set:C195("LockedSet"))+" records locked in other processes!")
			USE SET:C118("LockedSet")
			ARRAY LONGINT:C221($Locked_aL; 0)
			SELECTION TO ARRAY:C260(Current form table:C627->; $Locked_aL)
			For ($loop_L; Size of array:C274($tobeDeleted_aL); 1; -1)
				If (Find in array:C230($Locked_aL; $tobeDeleted_aL{$loop_L})>0)
					//record locked - not deleted - remove it from the deleted array
					DELETE FROM ARRAY:C228($tobeDeleted_aL; $loop_L; 1)
				End if 
			End for 
			
		End if 
		
		//clear out deleted records from current selection set
		For ($loop_L; Size of array:C274($records_aL); 1; -1)
			If (Find in array:C230($tobeDeleted_aL; $records_aL{$loop_L})>0)
				DELETE FROM ARRAY:C228($records_aL; $loop_L; 1)
			End if 
		End for 
		CREATE SELECTION FROM ARRAY:C640(Current form table:C627->; $records_aL)
	End if 
	
	
	If (Records in selection:C76(Current form table:C627->)=Records in table:C83(Current form table:C627->))
		SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
			String:C10(Records in table:C83(Current form table:C627->))+\
			"]")
		
	Else 
		SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
			String:C10(Records in selection:C76(Current form table:C627->))+\
			" of "+String:C10(Records in table:C83(Current form table:C627->))+\
			"]")
		
	End if 
	
End if   // if ok to delete