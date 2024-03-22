//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_SearchEditor
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: Display Search Editor for ptrFile».
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	
	// Modified by: costasmanousakis-(Designer)-(1/24/11 13:43:46)
	Mods_2011_01
	//  ` Added setting Auto Relations to True True before the search
End if 

C_BOOLEAN:C305($AutoOne_b; $AutoMany_b)
GET AUTOMATIC RELATIONS:C899($AutoOne_b; $AutoMany_b)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
QUERY:C277(pFile->)
WindowTitle
SET AUTOMATIC RELATIONS:C310($AutoOne_b; $AutoMany_b)

//End of procedure