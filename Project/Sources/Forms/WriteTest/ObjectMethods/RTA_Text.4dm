
C_LONGINT:C283($StartSel; $EndSel)
C_LONGINT:C283($i; $n; $p)
C_LONGINT:C283($FontSize)
C_LONGINT:C283($FontStyle)
C_LONGINT:C283($FontColor)
C_LONGINT:C283($BgndColor)

C_TEXT:C284($ZoneName)
C_TEXT:C284($PopFontNames; $PopFontSizes; $PlainButtonName; $BoldButtonName; $ItalicButtonName)
C_TEXT:C284($UnderlineButtonName; $StrikeButtonName; $FontButtonColor; $BgndButtonColor)
C_TEXT:C284($FontName)

C_POINTER:C301($PtrPopFontNames; $PtrPopFontSizes; $PtrPlainButton; $PtrBoldButton; $PtrItalicButton; $PtrUnderlineButton; $PtrStrikeButton; $PtrFontButtonColor; $PtrBgndButtonColor)

$ZoneName:="RTA_Text"  // change THIS if you change the name of the area

$PopFontNames:="RTA_FontNames"
$PopFontSizes:="RTA_FontSizes"
$PlainButtonName:="RTA_Standard"
$BoldButtonName:="RTA_Bold"
$ItalicButtonName:="RTA_Italic"
$UnderlineButtonName:="RTA_Underline"
$StrikeButtonName:="RTA_Strike"
$FontButtonColor:="RTA_FontColor"
$BgndButtonColor:="RTA_BgndColor"


$PtrPopFontNames:=OBJECT Get pointer:C1124(Object named:K67:5; $PopFontNames)
$PtrPopFontSizes:=OBJECT Get pointer:C1124(Object named:K67:5; $PopFontSizes)
$PtrPlainButton:=OBJECT Get pointer:C1124(Object named:K67:5; $PlainButtonName)
$PtrBoldButton:=OBJECT Get pointer:C1124(Object named:K67:5; $BoldButtonName)
$PtrItalicButton:=OBJECT Get pointer:C1124(Object named:K67:5; $ItalicButtonName)
$PtrUnderlineButton:=OBJECT Get pointer:C1124(Object named:K67:5; $UnderlineButtonName)
$PtrStrikeButton:=OBJECT Get pointer:C1124(Object named:K67:5; $StrikeButtonName)
$PtrFontButtonColor:=OBJECT Get pointer:C1124(Object named:K67:5; $FontButtonColor)
$PtrBgndButtonColor:=OBJECT Get pointer:C1124(Object named:K67:5; $BgndButtonColor)


C_POINTER:C301($PtrRichTextArea)
$PtrRichTextArea:=OBJECT Get pointer:C1124(Object named:K67:5; $ZoneName)
If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))
	
	
	Case of 
			
		: (Form event code:C388=On Load:K2:1)
			
			If ($PtrRichTextArea->="")
				$PtrRichTextArea->:=" "
				
				//Let's try to set a default FONT 
				If (Not:C34(Is nil pointer:C315($PtrPopFontNames)))
					ARRAY TEXT:C222($_Fonts; 0)
					
					APPEND TO ARRAY:C911($_Fonts; "Lucida Grande")
					APPEND TO ARRAY:C911($_Fonts; "Segoe UI")
					APPEND TO ARRAY:C911($_Fonts; "Arial")
					APPEND TO ARRAY:C911($_Fonts; "Times New Roman")
					
					$n:=Size of array:C274($_Fonts)
					For ($i; 1; $n)
						$FontName:=$_Fonts{$i}
						$p:=Find in array:C230($PtrPopFontNames->; $FontName)
						If ($p>0)
							ST SET ATTRIBUTES:C1093($PtrRichTextArea->; 1; 7; Attribute font name:K65:5; $FontName)
							$PtrPopFontNames->:=$p
							$i:=$n  // exit loop
						End if 
					End for 
					
				End if 
				
				//Let's try to set a default SIZE 
				If (Not:C34(Is nil pointer:C315($PtrPopFontSizes)))
					For ($i; 12; 20)
						$FontSize:=$i
						$p:=Find in array:C230($PtrPopFontSizes->; $FontSize)
						If ($p>0)
							ST SET ATTRIBUTES:C1093($PtrRichTextArea->; 1; 7; Attribute text size:K65:6; $FontSize)
							$PtrPopFontSizes->:=$p
							$i:=20
						End if 
					End for 
				End if 
				
			End if 
			
		: (Form event code:C388=On Selection Change:K2:29)
			
			GET HIGHLIGHT:C209($PtrRichTextArea->; $StartSel; $EndSel)
			
			// FONT NAME
			If (Not:C34(Is nil pointer:C315($PtrPopFontNames)))
				ST GET ATTRIBUTES:C1094($PtrRichTextArea->; $StartSel; $EndSel; Attribute font name:K65:5; $FontName)
				$p:=Find in array:C230($PtrPopFontNames->; $FontName)
				If ($p>0)
					$PtrPopFontNames->:=$p
				Else 
					$PtrPopFontNames->:=0
				End if 
			End if 
			
			// FONT SIZE
			If (Not:C34(Is nil pointer:C315($PtrPopFontSizes)))
				ST GET ATTRIBUTES:C1094($PtrRichTextArea->; $StartSel; $EndSel; Attribute text size:K65:6; $FontSize)
				$p:=Find in array:C230($PtrPopFontSizes->; $FontSize)
				If ($p>0)
					$PtrPopFontSizes->:=$p
				Else 
					$PtrPopFontSizes->:=0
				End if 
			End if 
			
			// Bold
			If (Not:C34(Is nil pointer:C315($PtrBoldButton)))
				ST GET ATTRIBUTES:C1094($PtrRichTextArea->; $StartSel; $EndSel; Attribute bold style:K65:1; $FontStyle)
				$PtrBoldButton->:=$FontStyle  // 0 - 1 - 2
			End if 
			
			// Italic
			If (Not:C34(Is nil pointer:C315($PtrItalicButton)))
				ST GET ATTRIBUTES:C1094($PtrRichTextArea->; $StartSel; $EndSel; Attribute italic style:K65:2; $FontStyle)
				$PtrItalicButton->:=$FontStyle  // 0 - 1 - 2
			End if 
			
			// Underline
			If (Not:C34(Is nil pointer:C315($PtrUnderlineButton)))
				ST GET ATTRIBUTES:C1094($PtrRichTextArea->; $StartSel; $EndSel; Attribute underline style:K65:4; $FontStyle)
				$PtrUnderlineButton->:=$FontStyle  // 0 - 1 - 2
			End if 
			
			// Strike
			If (Not:C34(Is nil pointer:C315($PtrStrikeButton)))
				ST GET ATTRIBUTES:C1094($PtrRichTextArea->; $StartSel; $EndSel; Attribute strikethrough style:K65:3; $FontStyle)
				$PtrStrikeButton->:=$FontStyle  // 0 - 1 - 2
			End if 
			
			//font color
			ST GET ATTRIBUTES:C1094($PtrRichTextArea->; $StartSel; $EndSel; Attribute text color:K65:7; $FontColor)
			
			If ($FontColor>=0)
				OBJECT SET RGB COLORS:C628(*; "RTA_FontSample"; $FontColor; $FontColor)
				OBJECT SET VISIBLE:C603(*; "RTA_FontSample"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "RTA_FontSample"; False:C215)
			End if 
			
			//bgnd color
			ST GET ATTRIBUTES:C1094($PtrRichTextArea->; $StartSel; $EndSel; Attribute background color:K65:8; $BgndColor)
			If ($BgndColor>=0)
				OBJECT SET RGB COLORS:C628(*; "RTA_BgndSample"; $BgndColor; $BgndColor)
				OBJECT SET VISIBLE:C603(*; "RTA_BgndSample"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "RTA_BgndSample"; False:C215)
			End if 
			
		: (Form event code:C388=On Double Clicked:K2:5)
			
			GET HIGHLIGHT:C209($PtrRichTextArea->; $StartSel; $EndSel)
			C_LONGINT:C283($Type)
			C_TEXT:C284($SelectedText; $URL; $Expression)
			$Type:=ST Get content type:C1286($PtrRichTextArea->)
			Case of 
				: ($Type=0)
					// plain text
					
				: ($Type=1)
					// URL
					ST GET URL:C1288($PtrRichTextArea->; $SelectedText; $URL)
					$URL:=Request:C163("URL ?"; $URL)
					If (ok=1)
						ST INSERT URL:C1280($PtrRichTextArea->; $SelectedText; $URL; $StartSel; $EndSel)
						ST SET ATTRIBUTES:C1093($PtrRichTextArea->; $StartSel; $StartSel+1; Attribute underline style:K65:4; 1)
					End if 
					
				: ($Type=2)
					// expression
					$Expression:=ST Get expression:C1287($PtrRichTextArea->)
					$Expression:=Request:C163("Expression"; $Expression)
					If (ok=1)
						ST INSERT EXPRESSION:C1281($PtrRichTextArea->; $Expression; $StartSel; $EndSel)
					End if 
					
				: ($Type=3)
					// more to come ? ;o)
					
			End case 
	End case 
	
Else 
	ALERT:C41("The name of the zone has been changed! Please, modify the button scripts!")
End if 



