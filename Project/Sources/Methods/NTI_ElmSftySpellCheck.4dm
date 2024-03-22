//%attributes = {"invisible":true}
//Method: NTI_ElmSftySpellCheck
//Description
//
// Parameters
//$1 : NoteField Ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/18/16, 16:13:04
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_POINTER:C301(NTI_ElmSftySpellCheck; $1)
	
	Mods_2021_Delete
	
End if 
//  //
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
//G_SpellCheckArea (AreaElmComments;$1;PON_ChangeStackLvl_L)

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
//$1->:=WR Get styled text (AreaElmComments)
//WR SET SELECTION (AreaElmComments;$vStartSel;$vEndSel)
//Else 
//  //delete inspection comments
//SET BLOB SIZE($1->;0)
//End if 
//PushChange (PON_ChangeStackLvl_L;$1)
//WR SET AREA PROPERTY (AreaElmComments;wr modified;0;"")
//WR UPDATE MODE (AreaElmComments;0)
//REDRAW(AreaElmComments)

//End case 
//  //End NTI_ElmSftySpellCheck