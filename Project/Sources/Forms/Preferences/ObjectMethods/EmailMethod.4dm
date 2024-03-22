//Method: "Preferences".EmailMethod
//Description
// use var v_57_015_txt for temp storage
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/08/20, 17:16:48
	// ----------------------------------------------------
	//Created : 
	Mods_2020_01_bug
End if 
//
C_POINTER:C301($MyVar_ptr)
$MyVar_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
C_LONGINT:C283($indx_L)

Case of 
	: (Form event code:C388=On Load:K2:1)
		$indx_L:=Find in array:C230($MyVar_ptr->; v_57_015_txt)
		If ($indx_L>0)
			$MyVar_ptr->:=$indx_L
		Else 
			$MyVar_ptr->:=0
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		$indx_L:=$MyVar_ptr->
		If ($indx_L>0)
			v_57_015_txt:=$MyVar_ptr->{$indx_L}
		End if 
End case 

//End "Preferences".EmailMethod