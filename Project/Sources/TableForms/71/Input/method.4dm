
//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 09/01/16, 13:00:39
//----------------------------------------------------
//Method: [Integral Bridge].Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_09  //Change from FlushChanges to FlushGRPChanges
	//Modified by: Chuck Miller (9/1/16 12:59:42)
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		InitChangeStack(1)
		
	: (Form event code:C388=On Validate:K2:3)
		FlushGrpChgs(1; ->[Integral Bridge:71]Code:1; ->[Integral Bridge:71]Code:1; ->[Integral Bridge:71]Code:1; 0)
End case 
//End [Integral Bridge].Input

