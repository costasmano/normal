//%attributes = {"invisible":true}
//GP: Inspection Help

//CENTER_WINDOW (600;400;720)
C_LONGINT:C283($tempwin)

Case of 
	: ([Inspections:27]Insp Type:6="DV@")
		//$tempwin:=Open form window([Dialogs];"CondRatingHlpUW";Movable form dialog box )
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "CondRatingHlpUW"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Movable form dialog box:K39:8)
		DIALOG:C40([Dialogs:21]; "CondRatingHlpUW")
	Else 
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "CondRatingHelp"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Movable form dialog box:K39:8)
		
		//$tempwin:=Open form window([Dialogs];"CondRatingHelp";Movable form dialog box )
		DIALOG:C40([Dialogs:21]; "CondRatingHelp")
		
End case 
CLOSE WINDOW:C154($Win_l)