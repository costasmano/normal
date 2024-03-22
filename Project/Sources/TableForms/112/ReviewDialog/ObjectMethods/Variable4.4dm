If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 



ORDER BY:C49(Current form table:C627->)
If (OK=1)
	OBJECT SET VISIBLE:C603(*; "INV_Sort@"; False:C215)
	INV_DisplayInvInspections(True:C214)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274(INV_SortBtns_aptr))
		INV_SortBtns_aptr{$i}->:=0
	End for 
	SortOrder_aL{1}:=0
End if 