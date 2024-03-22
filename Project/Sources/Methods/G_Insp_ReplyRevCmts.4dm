//%attributes = {"invisible":true}
// ----------------------------------------------------
// G_Insp_ReplyRevCmts
// User name (OS): charlesmiller
// Date and time: 03/06/09, 14:22:04
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	//G_Insp_ReplyRevCmts
	
	Mods_2005_CM16
	Mods_2009_03  //CJM  r001   `03/06/09, 14:21:58`Upgrade from open form window to open window
	// Modified by: Costas Manousakis-(Designer)-(2022-05-13 15:58:50)
	Mods_2022_05
	//  `window type to plain form window
End if 
C_POINTER:C301($1; $vpFldPtr)
C_TEXT:C284($2; $vsReplyTo)  // Command Replaced was o_C_STRING length was 80
$vpFldPtr:=$1
$vsReplyTo:=$2

C_BOOLEAN:C305(vbAddRevCmts)

C_TEXT:C284(vtExtraText)
C_TEXT:C284(vsExtraTextLabel)  // Command Replaced was o_C_STRING length was 132
If (vbAddRevCmts)
	vsExtraTextLabel:="Add to "+$vsReplyTo+" comments"
Else 
	vsExtraTextLabel:="Enter Reply to "+$vsReplyTo+" comments"
End if 

vtExtraText:=""
If (Length:C16($vpFldPtr->)>0)
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Dialogs:21]; "GetInspExtraCmts"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10)
	//$tempwin:=Open form window([Dialogs];"GetInspExtraCmts";Movable form dialog box )
	DIALOG:C40([Dialogs:21]; "GetInspExtraCmts")
	CLOSE WINDOW:C154($Win_l)
	
	If (OK=1)
		vtExtraText:=f_TrimStr(vtExtraText; True:C214; True:C214)
		If (Length:C16(vtExtraText)>0)
			vtExtraText:=<>sCR+Current user:C182+" - "+String:C10(Current date:C33(*))+" : "+vtExtraText
			$vpFldPtr->:=$vpFldPtr->+vtExtraText
			PushChange(1; $vpFldPtr)
		End if 
		If (vbAddRevCmts)
			OBJECT SET ENABLED:C1123(*; "DE Button Save@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
	End if 
End if 
//End G_Insp_ReplyRevCmts