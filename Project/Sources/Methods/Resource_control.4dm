//%attributes = {"invisible":true}
//Method: Resource_control
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/27/18, 14:32:17
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
End if 
//
Compiler_MoveResources

C_LONGINT:C283($Win_L)
$Win_L:=Open form window:C675("SelectResources"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("SelectResources")

//End Resource_control