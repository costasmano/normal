If (False:C215)
	//Script: bzAdd
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
End if 

//M_AddRecords 
CONFIRM:C162("The report generated will reflect OOF status for Bridges in Dist 1-5 and agencies! It has not been configured to account for District 6!")
If (OK=1)
	CREATE RECORD:C68([Out of Freq:70])
	GenerateOOF
	SAVE RECORD:C53([Out of Freq:70])
	MODIFY RECORD:C57([Out of Freq:70])
	
	
	WindowTitle
End if 
//End of procedure

//End of script
