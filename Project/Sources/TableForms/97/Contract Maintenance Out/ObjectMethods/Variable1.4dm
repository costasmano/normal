If (False:C215)
	//Script: bzAdd
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	// Modified by: costasmanousakis-(Designer)-(2/15/2006 16:38:01)
	Mods_2006_CM03
End if 

//M_AddRecords

//GP M_AddRecords hen disabled;
//the following lines duplicate its original function.
//Repeat 
CREATE SET:C116(pfile->; "CM_CONTRACTS_ORIG")
ADD RECORD:C56(pFile->)
ADD TO SET:C119(pFile->; "CM_CONTRACTS_ORIG")
USE SET:C118("CM_CONTRACTS_ORIG")
CLEAR SET:C117("CM_CONTRACTS_ORIG")
//Until (OK=0)  `Until the user clicks a Cancel button
CM_SortOutputList
WindowTitle
//End of script
