//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/22/06, 12:38:57
	// ----------------------------------------------------
	// Method: INV_EnterCommentReply
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
	Mods_2009_03  //CJM  r001   `03/06/09, 14:40:24`Upgrade from open form window to open window
End if 
C_BOOLEAN:C305($vbAddRevCmts)
$vbAddRevCmts:=(INV_ReviewCommtsDisp_txt="")

C_TEXT:C284(vtExtraText; vtPreviousText)
C_TEXT:C284(vsExtraTextLabel)  // Command Replaced was o_C_STRING length was 132
If ($vbAddRevCmts)
	vsExtraTextLabel:="Add comments"
Else 
	vsExtraTextLabel:="Enter Reply to comments"
End if 
vtPreviousText:=INV_ReviewCommtsOrig_txt
vtExtraText:=INV_ReviewCommtsAdd_txt

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "GetInspExtraCmts"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$tempwin:=Open form window([Dialogs];"GetInspExtraCmts";Movable form dialog box )
DIALOG:C40([Dialogs:21]; "GetInspExtraCmts")
CLOSE WINDOW:C154($Win_l)
If (OK=1)
	vtExtraText:=f_TrimStr(vtExtraText; True:C214; True:C214)
	If (Length:C16(vtExtraText)>0)
		INV_ReviewCommtsAdd_txt:=vtExtraText
		INV_ReviewCommtsDisp_txt:=INV_ReviewCommtsOrig_txt+<>sCR+Current user:C182+" - "+String:C10(Current date:C33(*))+" : "+INV_ReviewCommtsAdd_txt
		[InventoryPhotoInsp:112]ApproveComments_txt:7:=INV_ReviewCommtsDisp_txt
		PushChange(1; ->[InventoryPhotoInsp:112]ApproveComments_txt:7)
	Else 
		If (Length:C16(INV_ReviewCommtsAdd_txt)>0)  //There was text before-got cleared.
			INV_ReviewCommtsAdd_txt:=""
			INV_ReviewCommtsDisp_txt:=INV_ReviewCommtsOrig_txt
			[InventoryPhotoInsp:112]ApproveComments_txt:7:=INV_ReviewCommtsDisp_txt
			PushChange(1; ->[InventoryPhotoInsp:112]ApproveComments_txt:7)
		End if 
	End if 
	
End if 
vtPreviousText:=""
vtExtraText:=""