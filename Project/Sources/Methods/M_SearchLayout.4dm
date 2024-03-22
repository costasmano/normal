//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_SearchLayout
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: Changes the current input layout to a layout named Search.
	//Uses that layout as a Search tool.
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

FORM SET INPUT:C55(pFile->; "Search")
QUERY BY EXAMPLE:C292(pFile->)
WindowTitle
//Switch back to the regular input layout.
FORM SET INPUT:C55(pFile->; "Input")
//End of procedure