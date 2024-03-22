//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/20/07, 12:37:57
	// ----------------------------------------------------
	// Method: G_MoveBtns_OM
	// Description
	// Method for move buttons on form [Dialogs];"TwoListMove"
	// 
	// Parameters
	// $1 : $Task
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(11/30/07 14:19:30)
	Mods_2007_CM_5401
End if 
C_TEXT:C284($1; $Task)
$Task:=$1
C_BOOLEAN:C305(TWOLIST_MOVEONLY_B)
C_LONGINT:C283($i; $dropPos)
C_TEXT:C284($vsItemText)  // Command Replaced was o_C_STRING length was 80
Case of 
	: ($Task="MOVEL")
		If ((Selected list items:C379(OmitList_HL)>0) & (Selected list items:C379(OmitList_HL)<=Count list items:C380(OmitList_HL)))
			GET LIST ITEM:C378(OmitList_HL; Selected list items:C379(OmitList_HL); $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
			DELETE FROM LIST:C624(OmitList_HL; $vlItemRef; *)
			If (TWOLIST_MOVEONLY_B)
			Else 
				APPEND TO LIST:C376(UseList_HL; $vsItemText; $vlItemRef)
			End if 
			G_MoveBtns_OM("Buttons")
			GOTO OBJECT:C206(OmitList_HL)
		End if 
	: ($Task="MOVELALL")
		If (Count list items:C380(OmitList_HL)>0)
			SELECT LIST ITEMS BY POSITION:C381(OmitList_HL; 0)
			REDRAW:C174(OmitList_HL)  // Command Replaced was o_REDRAW LIST 
			C_LONGINT:C283($vlSrcElem; $vlPID; $vlItemRef; $hSublist; $vlPID; $Numinlist)
			C_BOOLEAN:C305($vbExpanded)
			$Numinlist:=Count list items:C380(OmitList_HL)
			If (TWOLIST_MOVEONLY_B)
			Else 
				For ($i; 1; $Numinlist)
					GET LIST ITEM:C378(OmitList_HL; $i; $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
					APPEND TO LIST:C376(UseList_HL; $vsItemText; $vlItemRef)
				End for 
			End if 
			CLEAR LIST:C377(OmitList_HL; *)
			OmitList_HL:=New list:C375
			G_MoveBtns_OM("Buttons")
			GOTO OBJECT:C206(OmitList_HL)
			
		End if 
	: ($Task="MOVER")
		If ((Selected list items:C379(UseList_HL)>0) & (Selected list items:C379(UseList_HL)<=Count list items:C380(UseList_HL)))
			GET LIST ITEM:C378(UseList_HL; Selected list items:C379(UseList_HL); $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
			$dropPos:=Drop position:C608
			If ($dropPos=-1)
				
				If (TWOLIST_MOVEONLY_B)
					If (ut_FindInHList(OmitList_HL; $vsItemText)>0)
					Else 
						APPEND TO LIST:C376(OmitList_HL; $vsItemText; $vlItemRef)
					End if 
				Else 
					APPEND TO LIST:C376(OmitList_HL; $vsItemText; $vlItemRef)
					DELETE FROM LIST:C624(UseList_HL; $vlItemRef; *)
				End if 
			Else 
				SELECT LIST ITEMS BY POSITION:C381(OmitList_HL; $dropPos)
				If (TWOLIST_MOVEONLY_B)
					If (ut_FindInHList(OmitList_HL; $vsItemText)>0)
					Else 
						INSERT IN LIST:C625(OmitList_HL; *; $vsItemText; $vlItemRef)
					End if 
				Else 
					INSERT IN LIST:C625(OmitList_HL; *; $vsItemText; $vlItemRef)
					DELETE FROM LIST:C624(UseList_HL; $vlItemRef; *)
				End if 
				
			End if 
			G_MoveBtns_OM("Buttons")
			GOTO OBJECT:C206(UseList_HL)
		End if 
	: ($Task="MOVERALL")
		If (Count list items:C380(UseList_HL)>0)
			SELECT LIST ITEMS BY POSITION:C381(UseList_HL; 0)
			REDRAW:C174(UseList_HL)  // Command Replaced was o_REDRAW LIST 
			C_LONGINT:C283($vlSrcElem; $vlPID; $vlItemRef; $hSublist; $vlPID; $Numinlist)
			C_BOOLEAN:C305($vbExpanded)
			
			$Numinlist:=Count list items:C380(UseList_HL)
			For ($i; 1; $Numinlist)
				GET LIST ITEM:C378(UseList_HL; $i; $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
				If (TWOLIST_MOVEONLY_B)
					If (ut_FindInHList(OmitList_HL; $vsItemText)>0)
					Else 
						APPEND TO LIST:C376(OmitList_HL; $vsItemText; $vlItemRef)
					End if 
				Else 
					APPEND TO LIST:C376(OmitList_HL; $vsItemText; $vlItemRef)
				End if 
			End for 
			If (TWOLIST_MOVEONLY_B)
			Else 
				CLEAR LIST:C377(UseList_HL; *)
				UseList_HL:=New list:C375
			End if 
			G_MoveBtns_OM("Buttons")
			GOTO OBJECT:C206(UseList_HL)
		End if 
	: ($Task="Buttons")
		REDRAW:C174(OmitList_HL)  // Command Replaced was o_REDRAW LIST 
		REDRAW:C174(UseList_HL)  // Command Replaced was o_REDRAW LIST 
		If (Count list items:C380(OmitList_HL)>0)
			OBJECT SET ENABLED:C1123(bMoveL; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(bMoveLALL; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bMoveL; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(bMoveLALL; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		If (Count list items:C380(UseList_HL)>0)
			OBJECT SET ENABLED:C1123(bMoveR; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(bMoveRALL; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bMoveR; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(bMoveRALL; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
End case 