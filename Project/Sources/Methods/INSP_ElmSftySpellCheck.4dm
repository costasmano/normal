//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/04/09, 12:24:56
	// ----------------------------------------------------
	// Method: INSP_ElmSftySpellCheck
	// Description
	// Method to make sure the comment Flag is set when spellchecking
	// Element Comments
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_04
	
	// Modified by: Costas Manousakis-(Designer)-(8/9/13 16:23:16)
	Mods_2013_08
	//  `Added case if button is pressed holding the Shift key for designer to extract the plain text 
	Mods_2021_Delete
	
End if 
//C_LONGINT($choice_L)
//$choice_L:=2
//If ((Shift down) & User in group(Current user;"Design Access Group"))
//C_TEXT($Popumenu_txt)
//$Popumenu_txt:=" ;Spell Check;Get Plain Text"
//C_LONGINT($choice_L)
//$choice_L:=Pop up menu($Popumenu_txt)

//End if 

//Case of 
//: ($choice_L=2)
//G_SpellCheckArea (AreaElmComments;->[ElementsSafety]ElmComments;2)
//[ElementsSafety]Comment Flag:=(BLOB size([ElementsSafety]ElmComments)>0)
//PushChange (2;->[ElementsSafety]Comment Flag)

//: ($choice_L=3)
//C_TEXT($plaintext_txt)
//C_LONGINT($vStartSel;$vEndSel)
//WR GET SELECTION (AreaElmComments;$vStartSel;$vEndSel)

//$plaintext_txt:=WR Get text (AreaElmComments;0;32000)
//WR EXECUTE COMMAND (AreaElmComments;wr cmd select all)
//WR EXECUTE COMMAND (AreaElmComments;wr cmd cut)
//WR APPLY STYLESHEET (AreaElmComments;1)
//WR INSERT TEXT (AreaElmComments;$plaintext_txt)
//If (WR Count (AreaElmComments;wr nb words)>0)
//WR EXECUTE COMMAND (AreaElmComments;wr cmd select all)
//[ElementsSafety]ElmComments:=WR Get styled text (AreaElmComments)
//WR SET SELECTION (AreaElmComments;$vStartSel;$vEndSel)
//Else 
//  //delete inspection comments
//SET BLOB SIZE([ElementsSafety]ElmComments;0)
//End if 
//PushChange (2;->[ElementsSafety]ElmComments)
//WR SET AREA PROPERTY (AreaElmComments;wr modified;0;"")
//WR UPDATE MODE (AreaElmComments;0)
//REDRAW(AreaElmComments)
//[ElementsSafety]Comment Flag:=(BLOB size([ElementsSafety]ElmComments)>0)
//PushChange (2;->[ElementsSafety]Comment Flag)

//End case 