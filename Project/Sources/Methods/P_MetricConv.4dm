//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: P_MetricConv
	//ACI University Programming Classes
	//Created by: Jim Steinman
	//Date: 10/5/95
	
	//Purpose:  Displays the files palette
	
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	// Modified by: costasmanousakis-(Designer)-(3/11/10 16:39:05)
	Mods_2010_03
	//  `Get the form properties to determine window size
End if 

//ControlMenuBar (1)

C_LONGINT:C283($w; $h)
FORM GET PROPERTIES:C674([Dialogs:21]; "MetricConverter"; $w; $h)

NewWindow($w; $h; 3; -(Palette form window:K39:9); "Metric Conversion Palette"; "CloseLayout")

DIALOG:C40([Dialogs:21]; "MetricConverter")
CLOSE WINDOW:C154
//End of procedure 