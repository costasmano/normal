If (False:C215)
	//[Dialogs];"SelectFromList"
	// Modified by: costasmanousakis-(Designer)-(4/17/2007 14:53:42)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(12/23/10 09:58:06)
	Mods_2010_12
	//  `Save the selected item no in a process variable
	// Modified by: Costas Manousakis-(Designer)-(2022-12-16 12:01:32)
	Mods_2022_12_bug
	//  `allow multiple selections from the hlist
	//  `If the index array pointer has been passsed in the Form object, fill it with the indexes of all selected items
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		SelectListSelected_L:=0
	: (Form event code:C388=On Clicked:K2:4)
		If ((Focus object:C278=(->SelectList_Hlist)) | (Focus object:C278=(->SelectListOKBtn)))
			ARRAY LONGINT:C221($Selected_aL; 0)
			SelectListSelected_L:=Selected list items:C379(SelectList_Hlist; $Selected_aL)
			If (OB Is defined:C1231(Form:C1466; "indexarrayptr"))
				C_POINTER:C301($indxarray_ptr)
				$indxarray_ptr:=Form:C1466.indexarrayptr
				SelectListSelected_L:=Selected list items:C379(SelectList_Hlist; $indxarray_ptr->)
			End if 
		End if 
End case 