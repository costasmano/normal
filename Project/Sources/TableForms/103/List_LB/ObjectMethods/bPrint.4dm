If (False:C215)
	Mods_2020_07  //Added use of current form name to set output form, so if we are in Listbox we should be all set
	//Modified by: CJ (7/16/20 16:29:50)
End if 
FORM SET OUTPUT:C54(Current form table:C627->; "ListPrint")
PRINT SELECTION:C60(Current form table:C627->)
FORM SET OUTPUT:C54(Current form table:C627->; Current form name:C1298)
