//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/11/11, 16:35:40
	// ----------------------------------------------------
	// Method: ut_MakeDocErrorHandler
	// Description
	//  ` Catch make doc errors
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_03
End if 
C_LONGINT:C283(SYS_WriteDocError)
SYS_WriteDocError:=Error