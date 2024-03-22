//Method: Object Method: [NBIS Secondary].2nd In.ZZ8
//Description
// SAVE button
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/21/14, 17:13:32
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
If (Modified record:C314([NBIS Secondary:3]))
	//need to check Item5a not existing for same BIN
	C_BOOLEAN:C305($VerifyRecord_b; $SaveRecord_b)
	$VerifyRecord_b:=True:C214
	$SaveRecord_b:=False:C215
	ARRAY TEXT:C222($otherItem5_atxt; 0)
	ARRAY TEXT:C222($otherItem6a_atxt; 0)
	SIA_CheckOther2ND(->$otherItem5_atxt; ->$otherItem6a_atxt; [NBIS Secondary:3]BIN:1; [NBIS Secondary:3]NBISSecondaryKey_l:39)
	C_TEXT:C284($item5a_s; $item5b_s; $item5c_s; $item5e_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284($item5d_s)  // Command Replaced was o_C_STRING length was 5
	$Item5a_s:=Substring:C12([NBIS Secondary:3]Item5:4; 1; 1)
	C_LONGINT:C283($Same5a_L)
	$Same5a_L:=Find in array:C230($otherItem5_atxt; ($Item5a_s+"@"))
	If ($Same5a_L>0)
		$VerifyRecord_b:=False:C215
		ALERT:C41("Item 5A ["+$Item5a_s+"] is already defined in another secondary record : Item5 = "+$otherItem5_atxt{$Same5a_L}+"  Item6A = "+$otherItem6a_atxt{$Same5a_L}+" . Use another character for Item5A!")
	Else 
		//check if other parts of 5A make sense with 6A
		SIA_GetItem5FromFeature([NBIS Secondary:3]Item6A:5; ->$item5b_s; ->$item5c_s; ->$item5d_s; ->$item5e_s)
		C_TEXT:C284($item5Warnings_txt)
		$item5Warnings_txt:=""
		If ($item5b_s#Substring:C12([NBIS Secondary:3]Item5:4; 2; 1))
			$item5Warnings_txt:=$item5Warnings_txt+"Item 5B should be : "+$item5b_s+" instead of "+Substring:C12([NBIS Secondary:3]Item5:4; 2; 1)+Char:C90(13)
		End if 
		If ($item5c_s#Substring:C12([NBIS Secondary:3]Item5:4; 3; 1))
			$item5Warnings_txt:=$item5Warnings_txt+"Item 5C should be : "+$item5c_s+" instead of "+Substring:C12([NBIS Secondary:3]Item5:4; 3; 1)+Char:C90(13)
		End if 
		
		If ($item5d_s#Substring:C12([NBIS Secondary:3]Item5:4; 4; 5))
			$item5Warnings_txt:=$item5Warnings_txt+"Item 5D should be : "+$item5d_s+" instead of "+Substring:C12([NBIS Secondary:3]Item5:4; 4; 5)+Char:C90(13)
		End if 
		If ($item5e_s#Substring:C12([NBIS Secondary:3]Item5:4; 9; 1))
			$item5Warnings_txt:=$item5Warnings_txt+"Item 5E should be : "+$item5e_s+" instead of "+Substring:C12([NBIS Secondary:3]Item5:4; 9; 1)+Char:C90(13)
		End if 
		
		If ($item5Warnings_txt#"")
			$item5Warnings_txt:="Possible Conflict(s) between Item 5 and Item 6A !"+(2*Char:C90(13))+$item5Warnings_txt+Char:C90(13)
			$item5Warnings_txt:=$item5Warnings_txt+"If you Save and Exit, Item 5 and 6A will remain as is."+Char:C90(13)
			$item5Warnings_txt:=$item5Warnings_txt+"To make any changes choose Stay in Form."
			G_MyConfirm($item5Warnings_txt; "Save and Exit"; "Stay In Form")
			
			If (OK=1)
				$SaveRecord_b:=True:C214
				$VerifyRecord_b:=False:C215
			Else 
				$VerifyRecord_b:=False:C215
			End if 
			
		End if 
		
	End if 
	
	If ($VerifyRecord_b)
		CONFIRM:C162("Save changes to the Secondary record?"; "Save and Exit"; "Stay in Form")
		$SaveRecord_b:=(OK=1)
	End if 
	If ($SaveRecord_b)
		
		If (Is new record:C668([NBIS Secondary:3]))
			LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[NBIS Secondary:3]BIN:1; ->[NBIS Secondary:3]NBISSecondaryKey_l:39; 1; "[NBIS Secondary]")
		End if 
		
		//##Save changes made to activity log
		PushAllChanges(1; ->[NBIS Secondary:3]; ->[NBIS Secondary:3]BIN:1; ->[NBIS Secondary:3]NBISSecondaryKey_l:39)
		FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[NBIS Secondary:3]BIN:1; ->[NBIS Secondary:3]NBISSecondaryKey_l:39; 1)
		SAVE RECORD:C53([NBIS Secondary:3])
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 

//End Object Method: [NBIS Secondary].2nd In.ZZ8