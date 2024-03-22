//%attributes = {"invisible":true}
//Method: ut_ComboMenuC
//Description
// manage a combo menu
// Parameters
// $1 : $ComboMenu_ptr
// $2 : $Data_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/25/14, 16:57:48
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_POINTER:C301($1; $ComboMenu_ptr)
C_POINTER:C301($2; $Data_ptr)
$ComboMenu_ptr:=$1
$Data_ptr:=$2
Case of 
	: (Form event code:C388=On Load:K2:1)
		$ComboMenu_ptr->{0}:=$Data_ptr->
		
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
		$Data_ptr->:=$ComboMenu_ptr->{0}
		
End case 

//End ut_ComboMenuC