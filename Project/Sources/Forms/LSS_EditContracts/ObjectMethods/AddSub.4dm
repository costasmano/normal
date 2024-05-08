  //Method: LSS_EditContracts.Button
  //Description
  //
  // Parameters
  // ----------------------------------------------------
If (False:C215)
	  // ----------------------------------------------------
	  //User name (OS): Costas Manousakis
	  //User (4D) : Designer
	  //Created : 
	  //Date and time: Feb 8, 2024, 14:55:06
	  // ----------------------------------------------------
	
End if 
  //

If (Form:C1466.CurrContract#Null:C1517)
	ARRAY TEXT:C222($Subnames_atxt;0)
	COLLECTION TO ARRAY:C1562(Form:C1466.availablesubs;$Subnames_atxt)
	C_TEXT:C284($menu_txt;$newName_txt)
	$menu_txt:=MENU_BuildMenuFromArrays (->$Subnames_atxt;->$Subnames_atxt;";;;")
	
	$newName_txt:=Dynamic pop up menu:C1006($menu_txt)
	RELEASE MENU:C978($menu_txt)
	
	If ($newName_txt#"")
		
		If (Form:C1466.CurrContract.Subs#Null:C1517)
			Form:C1466.CurrContract.Subs.push(New object:C1471("name";$newName_txt))
			LISTBOX SORT COLUMNS:C916(*;"LSSSubs";1;>)  // sort the listbox
			  //CurrContract.Subs.orderBy("name asc")
			
		Else 
			Form:C1466.CurrContract.Subs:=New collection:C1472(New object:C1471("name";$newName_txt))
		End if 
		
		C_LONGINT:C283($pos_L)
		$pos_L:=Find in array:C230($Subnames_atxt;$newName_txt)
		If ($pos_L>0)
			DELETE FROM ARRAY:C228($Subnames_atxt;$pos_L;1)
			ARRAY TO COLLECTION:C1563(Form:C1466.availablesubs;$Subnames_atxt)
		End if 
	End if 
End if 


  //End LSS_EditContracts.Button   