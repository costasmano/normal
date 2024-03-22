//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: P_FilesPalette
	//ACI University Programming Classes
	//Created by: Jim Steinman
	//Date: 10/5/95
	
	//Purpose:  Displays the files palette
	
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(5/23/11 13:00:20)
	Mods_2011_05
	//  `Removed call to ControlMenuBar - not needed for Pallete window form
	Mods_2011_06  // CJ Miller`06/13/11, 16:41:50      ` Type all local variables for v11
End if 

//ControlMenuBar (1)
C_LONGINT:C283($vlWdth; $vlHt)
FORM GET PROPERTIES:C674([zDialogs:68]; "FilesPalette"; $vlWdth; $vlHt)
NewWindow($vlWdth; $vlHt; 3; -(Palette form window:K39:9); "Window Palette"; "CloseLayout")
//ControlMenuBar (1)
DIALOG:C40([zDialogs:68]; "FilesPalette")
<>LFilePalPID:=0
CLOSE WINDOW:C154
//End of procedure 