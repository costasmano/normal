If (vbInspectionLocked)
	C_LONGINT:C283($stored_L)
	$stored_L:=Find in array:C230(PON_ENVKEY_aL; [PON_ELEM_INSP:179]ENVKEY:5)
	Self:C308->:=$stored_L
	
Else 
	C_LONGINT:C283($temp_KEY_L)
	POPUPMENUC(Self:C308; ->PON_ENVKEY_aL; ->$temp_KEY_L)
	
	C_BOOLEAN:C305($Unique_OK_B)
	// need to verify uniqueness-cannot have another
	$Unique_OK_B:=PON_VERIFYUNIQELEM_b([PON_ELEM_INSP:179]ELEM_KEY:3; $temp_KEY_L; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; [PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)
	If ($Unique_OK_B)
		[PON_ELEM_INSP:179]ENVKEY:5:=$temp_KEY_L
		If (([PON_ELEM_INSP:179]ELEM_KEY:3>0) & ([PON_ELEM_INSP:179]ENVKEY:5>0))
			OBJECT SET ENTERABLE:C238([PON_ELEM_INSP:179]ELEM_QUANTITY:7; True:C214)
			OBJECT SET RGB COLORS:C628([PON_ELEM_INSP:179]ELEM_QUANTITY:7; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR([PON_ELEM_INSP]ELEM_QUANTITY; PON_Color_Editable_L)
		End if 
		// need to check children elements to change the enviroment
		If ((PON_ELEM_PROTSYS_L>0) | (PON_ELEM_DAMAGE_L>0))
			ALERT:C41("There are Protective Systems and/or Defects attached to this element! they will be changed to the new Enviroment when this element is saved!")
		End if 
	Else 
		// reset the popup
		ALERT:C41("There is already an element with same Number / Enviroment / Parent / Grandparent! ")
		C_LONGINT:C283($inList_L)
		$inList_L:=Find in array:C230(PON_ENVKEY_aL; [PON_ELEM_INSP:179]ENVKEY:5)
		If ($inList_L<=0)
			$inList_L:=0
		End if 
		Self:C308->:=$inList_L
	End if 
End if 