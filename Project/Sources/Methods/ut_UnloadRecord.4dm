//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/27/06, 13:53:42
	// ----------------------------------------------------
	// Method: ut_UnloadRecord
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
C_POINTER:C301($1; $TablePointer)
$TablePointer:=$1
UNLOAD RECORD:C212($TablePointer->)
READ ONLY:C145($TablePointer->)
LOAD RECORD:C52($TablePointer->)
