//Method: Form Method: WebAreaTest
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/24/14, 09:52:04
	// ----------------------------------------------------
	//Created : 
End if 
//
Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		WA OPEN URL:C1020(*; "web area"; "about:blank")
		
	: (FORM Event:C1606.code=On Validate:K2:3)
		
End case 

//End Form Method: WebAreaTest