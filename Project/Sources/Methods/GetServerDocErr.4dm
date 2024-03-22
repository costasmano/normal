//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/03/07, 08:23:35
	// ----------------------------------------------------
	// Method: GetServerDocErr
	// Description
	// Missing error trap method used in 
	//G_GetServerDoc_Server 
	//G_GetDirList_Server
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
//Just trap the error
C_LONGINT:C283($myError)
$myError:=Error
