//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_SetDeptFont
	//Use in Inspection Print methods to adjust font size of
	//The Inspection department label.
	
	Mods_2004_CM11
	// Modified by: costasmanousakis-(Designer)-(10/27/09 15:04:40)
	Mods_2009_10
	//MassDOT change
End if 

//Adjust font size of VSINSPDEPARTMENT
Case of 
	: ((VSINSPDEPARTMENT="MASSACHUSETTS BAY@") | (VSINSPDEPARTMENT="DEPARTMENT OF CONS@"))
		OBJECT SET FONT SIZE:C165(VSINSPDEPARTMENT; 13)
	: (VSINSPDEPARTMENT="MASSACHUSETTS DEPARTMENT OF TRANSP@")
		OBJECT SET FONT SIZE:C165(VSINSPDEPARTMENT; 13)
	Else 
		OBJECT SET FONT SIZE:C165(VSINSPDEPARTMENT; 14)
End case 
