//Method: Object Method: [BridgeRankCalc].Input.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/19/14, 14:53:01
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
	BrgRank_CopyToBridge
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388

Case of 
	: ($FormEvent_L=On Load:K2:1)
		// MUST NAME THE BUTTON VARIABLE TO THE SAME AS bToolButton
		C_LONGINT:C283(bToolButton)
		bToolButton:=0
		C_TEXT:C284(ButtonpopupText)
		ButtonpopupText:="Apply Rank To Bridge Table"
		ARRAY TEXT:C222(ButtonPopupButtonlabels_atxt; 0)
		ARRAY TEXT:C222(ButtonPopupCommands_atxt; 0)
		APPEND TO ARRAY:C911(ButtonPopupButtonlabels_atxt; "Apply Rank")
		APPEND TO ARRAY:C911(ButtonPopupCommands_atxt; "BrgRank_CopyToBridge")
		ButtonPopupCommands_atxt:=0
		
	: (($FormEvent_L=On Alternative Click:K2:36) | ($FormEvent_L=On Long Click:K2:37))
		bToolButton:=Pop up menu:C542(ButtonpopupText)
		If ((bToolButton>0) & (bToolButton<=Size of array:C274(ButtonPopupCommands_atxt)))
			OBJECT SET TITLE:C194(Self:C308->; ButtonPopupButtonlabels_atxt{bToolButton})
			EXECUTE METHOD:C1007(ButtonPopupCommands_atxt{bToolButton})
			ButtonPopupCommands_atxt:=bToolButton
		End if 
		
	: ($FormEvent_L=On Clicked:K2:4)
		bToolButton:=ButtonPopupCommands_atxt
		If ((bToolButton>0) & (bToolButton<=Size of array:C274(ButtonPopupCommands_atxt)))
			//ALERT(ButtonPopupCommands_atxt{bToolButton})
			EXECUTE METHOD:C1007(ButtonPopupCommands_atxt{bToolButton})
		Else 
			bToolButton:=Pop up menu:C542(ButtonpopupText)
			If ((bToolButton>0) & (bToolButton<=Size of array:C274(ButtonPopupCommands_atxt)))
				OBJECT SET TITLE:C194(Self:C308->; ButtonPopupButtonlabels_atxt{bToolButton})
				EXECUTE METHOD:C1007(ButtonPopupCommands_atxt{bToolButton})
				ButtonPopupCommands_atxt:=bToolButton
			End if 
			
		End if 
End case 


//End Object Method: [BridgeRankCalc].Input.bValidate