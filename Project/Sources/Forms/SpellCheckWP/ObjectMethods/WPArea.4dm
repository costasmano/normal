//Method: SpellAllTest.WPArea
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-03-17T00:00:00, 12:40:05
	// ----------------------------------------------------
	//Created : 
	
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On After Edit:K2:43)
		C_POINTER:C301($wp_ptr)
		$wp_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")
		OB SET:C1220($wp_ptr->; "modified"; True:C214)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

//End SpellAllTest.WPArea