//%attributes = {"invisible":true}
//Method: NTI_Preview
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/25/16, 17:35:14
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_POINTER:C301(NTI_Preview; $1)
End if 

C_POINTER:C301($1)
C_LONGINT:C283(vPageno)
vPageno:=0
NTI_PrintNTEList($1)
PAGE BREAK:C6

//End NTI_Preview