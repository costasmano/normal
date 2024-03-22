//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/08/14, 14:17:11
//----------------------------------------------------
//Method: clone_ControlConnect
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_BOOLEAN:C305(SQLError_b)
ON ERR CALL:C155("clone_SQLError")
C_LONGINT:C283($Winref_L)
$Winref_L:=Open form window:C675("Connect_d"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("Connect_d")
CLOSE WINDOW:C154($Winref_L)

//End clone_ControlConnect