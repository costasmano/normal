If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(11/2/10 16:09:17)
	Mods_2010_11
	//  `Added button to add records
End if 

Repeat 
	ADD RECORD:C56(Current form table:C627->)
	If (OK=1)
		CONFIRM:C162("Continue Adding Records to table "+Table name:C256(Current form table:C627)+"?")
	End if 
	
Until (OK=0)

ALL RECORDS:C47(Current form table:C627->)
C_POINTER:C301($fld_ptr)
$fld_ptr:=Field:C253(Table:C252(Current form table:C627); 1)
ORDER BY:C49(Current form table:C627->; $fld_ptr->)