If (False:C215)
	//Form Method: [Dialogs];"GetInspExtraCmts"
	// Modified by: costasmanousakis-(Designer)-(12/10/09 09:26:55)
	Mods_2009_12
	//added code to keep in front and center the buttons upon resixe
	// Modified by: costasmanousakis-(Designer)-(7/12/11 14:29:17)
	Mods_2011_07
	//  `Removed the code on the Deactivate event. It was causing flashing of the window
	//  `when the spellcheck was invoked.
	// Modified by: Costas Manousakis-(Designer)-(3/16/12 09:50:46)
	Mods_2012_03
	//  `Added  On Outside Call to cancel form
	// Modified by: Costas Manousakis-(Designer)-(2/19/14 12:23:24)
	Mods_2014_02_bug
	//  `resized the textlabel and allowed to grow horiz; added the  Blankmenu and enabled menu for copy - paste operations
	// Modified by: Costas Manousakis-(Designer)-(2022-05-13 15:08:53)
	Mods_2022_05
	//  `added Multistyle text area with style buttons;  uses Form.Multistyle passed from Dialog command
	//  `adjusted size of buttons and minimum width
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305($multistyle_b)
		$multistyle_b:=False:C215
		If (OB Is defined:C1231(Form:C1466; "Multistyle"))
			$multistyle_b:=OB Get:C1224(Form:C1466; "Multistyle"; Is boolean:K8:9)
		End if 
		OBJECT SET VISIBLE:C603(*; "Multistyletext@"; $multistyle_b)
		OBJECT SET VISIBLE:C603(*; "PlainText"; Not:C34($multistyle_b))
		
	: (Form event code:C388=On Deactivate:K2:10)
		//SHOW WINDOW
		//BRING TO FRONT(Current process)
	: (Form event code:C388=On Resize:K2:27)
		C_LONGINT:C283($l_L; $t_L; $r_L; $B_L; $Winw_L; $ButtonW_L; $ButtonL; $LMar_L)
		GET WINDOW RECT:C443($l_L; $t_L; $r_L; $B_L)
		$Winw_L:=$r_L-$l_L
		OBJECT GET COORDINATES:C663(*; "Button@"; $l_L; $t_L; $r_L; $B_L)
		$ButtonW_L:=$r_L-$l_L
		$ButtonL:=$l_L
		$LMar_L:=($Winw_L-$ButtonW_L)/2
		If ($LMar_L<0)
			$LMar_L:=0
		End if 
		OBJECT MOVE:C664(*; "Button@"; ($LMar_L-$ButtonL); 0)
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
		
End case 