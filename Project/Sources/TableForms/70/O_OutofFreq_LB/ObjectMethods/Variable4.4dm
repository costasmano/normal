If (False:C215)
	//Script: bzAll
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
	// Modified by: manousakisc-(Designer)-(9/7/2023 11:46:43)
	Mods_2023_09
	//  `sort by date created descending
End if 

M_ShowAllRecs
ORDER BY:C49([Out of Freq:70]; [Out of Freq:70]Date_Created:1; <)
//End of script