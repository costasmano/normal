//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: About
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: Displays an About Box when called from the Apple Menu.
	
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	// Modified by: Costas Manousakis-(Designer)-(12/26/12 10:07:54)
	Mods_2012_12
	//  `Removed the space for the 4D credits
	
End if 

C_LONGINT:C283($LWidth; $LHeight; $L4DCredits)
FORM GET PROPERTIES:C674([Dialogs:21]; "About"; $LWidth; $LHeight)
$L4DCredits:=0
$LHeight:=$LHeight+$L4DCredits
NewWindow($LWidth; $LHeight; 0)  //Centered
DIALOG:C40([Dialogs:21]; "About")
CLOSE WINDOW:C154
//End of procedure