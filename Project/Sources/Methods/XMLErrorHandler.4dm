//%attributes = {"invisible":true}
//Method: XMLErrorHandler
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/07/12, 13:12:57
	// ----------------------------------------------------
	//Created : 
	Mods_2012_12
End if 
//
C_BOOLEAN:C305(XMLError_b)
ARRAY LONGINT:C221(XMLErrorNumbers_al; 0)
ARRAY TEXT:C222(XML_InternalCodes_atxt; 0)
ARRAY TEXT:C222(XML_InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015(XMLErrorNumbers_al; XML_InternalCodes_atxt; XML_InternalDescriptions_atxt)

XMLError_b:=True:C214
//End XMLErrorHandler