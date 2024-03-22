//%attributes = {"invisible":true}
//Method: INSP_CommentTools
//Description
//  ` Controls the comment tools button in the General comments page of inspection input forms.

// Parameters
// $1 : $FormEvent_L (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/25/12, 18:31:20
	// ----------------------------------------------------
	//Created : 
	Mods_2012_03
	//Calls by Execute method :
	INSP_SpellCheckAll
	G_Insp_ViewAllCmts
End if 
//
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		// MUST NAME THE BUTTON VARIABLE TO THE SAME AS bViewAllCmts
		C_LONGINT:C283(bViewAllCmts)
		bViewAllCmts:=1
		C_TEXT:C284(ButtonpopupText)
		ButtonpopupText:="View All Comments;Spellcheck All Comments"
		ARRAY TEXT:C222(ButtonPopupButtonlabels_atxt; 0)
		ARRAY TEXT:C222(ButtonPopupCommands_atxt; 0)
		APPEND TO ARRAY:C911(ButtonPopupButtonlabels_atxt; "View All Comments")
		APPEND TO ARRAY:C911(ButtonPopupCommands_atxt; "G_Insp_ViewAllCmts")
		APPEND TO ARRAY:C911(ButtonPopupButtonlabels_atxt; "Spellcheck All Comments")
		APPEND TO ARRAY:C911(ButtonPopupCommands_atxt; "INSP_SpellCheckAll")
		ButtonPopupCommands_atxt:=1
		
	: (($FormEvent_L=On Alternative Click:K2:36) | ($FormEvent_L=On Long Click:K2:37) | (($FormEvent_L=On Clicked:K2:4) & (bViewAllCmts=0)))
		
		If (vbInspectionLocked)
			//bViewAllCmts:=1
		Else 
			bViewAllCmts:=Pop up menu:C542(ButtonpopupText)
			If ((bViewAllCmts>0) & (bViewAllCmts<=Size of array:C274(ButtonPopupCommands_atxt)))
				OBJECT SET TITLE:C194(Self:C308->; ButtonPopupButtonlabels_atxt{bViewAllCmts})
				EXECUTE METHOD:C1007(ButtonPopupCommands_atxt{bViewAllCmts})
				ButtonPopupCommands_atxt:=bViewAllCmts
			End if 
		End if 
		
	: ($FormEvent_L=On Clicked:K2:4)
		bViewAllCmts:=ButtonPopupCommands_atxt
		If ((bViewAllCmts>0) & (bViewAllCmts<=Size of array:C274(ButtonPopupCommands_atxt)))
			//ALERT(ButtonPopupCommands_atxt{bViewAllCmts})
			EXECUTE METHOD:C1007(ButtonPopupCommands_atxt{bViewAllCmts})
		End if 
End case 
//End INSP_CommentTools