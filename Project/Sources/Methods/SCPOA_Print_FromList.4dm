//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/09, 11:13:40
	// ----------------------------------------------------
	// Method: SCPOA_Print_FromList
	// Description
	//  ` Print from the list of POAs
	// 
	// Parameters
	// $1 : SCPOA_PrintPreview_b
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(12/11/09 15:06:04)
	Mods_2009_12
	//  `Changes/Additions for new version of POA
	// Modified by: costasmanousakis-(Designer)-(5/19/11 16:46:44)
	Mods_2011_05  //Copied to Server on : 05/19/11, 16:47:55
	//  `Bug fix
	// Modified by: costasmanousakis-(Designer)-(5/19/11 20:01:27)
	Mods_2011_05
	//  `Another Bug Fix on the confirm dialog
	// Modified by: costasmanousakis-(Designer)-(6/8/11 16:06:37)
	Mods_2011_06
	//  `To select between the old/new version of POA use call to  SCPOA_Variables ("OLDNEWVERSION")
	// Modified by: Costas Manousakis-(Designer)-(3/16/12 10:47:56)
	Mods_2012_03
	//  `use the new method SCPOA_Print_A
	
End if 
C_BOOLEAN:C305(SCPOA_PrintPreview_b)

SCPOA_PrintPreview_b:=False:C215
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	SCPOA_PrintPreview_b:=$1
End if 
C_LONGINT:C283($NumHighlighted; $NumInList)
$NumInList:=Records in selection:C76([ScourPOA:132])
GET HIGHLIGHTED RECORDS:C902([ScourPOA:132]; "$Highlight")
$NumHighlighted:=Records in set:C195("$Highlight")
C_BOOLEAN:C305($PrintTheList_b; $PrintHighlight_B)
$PrintHighlight_B:=False:C215
$PrintTheList_b:=False:C215
C_TEXT:C284($Action_txt)
If (SCPOA_PrintPreview_b)
	$Action_txt:="Preview"
Else 
	$Action_txt:="Print"
End if 

C_TEXT:C284($FldNoteMsg_txt; $msg_txt)
$FldNoteMsg_txt:=" Any Field Notes will be launched in the current PDF software."
$msg_txt:=$Action_txt+" the Scour Plan of Action, Locus map, Detour Route map, and Field Notes for the "
Case of 
	: ($NumInList=0)
		ALERT:C41("There are no Scour Plan of Action Records listed!")
	: ($NumHighlighted=$NumInList)
		$msg_txt:=$msg_txt+"listed "+String:C10($NumHighlighted)+" record(s)?"
	: ($NumHighlighted>0)
		$msg_txt:=$msg_txt+"selected "+String:C10($NumHighlighted)+" record(s)?"
		$PrintHighlight_B:=True:C214
	Else 
		$msg_txt:=$msg_txt+String:C10($NumInList)+" listed record(s)?"
End case 
If ($NumInList>0)
	$msg_txt:=$msg_txt+$FldNoteMsg_txt
	CONFIRM:C162($msg_txt)
	If (OK=1)
		$PrintTheList_b:=True:C214
		SCPOA_PrintSumm_L:=1
		SCPOA_PrintPOA_L:=1
		SCPOA_PrintLocus_L:=1
		SCPOA_PrintDetour_L:=1
		SCPOA_PrintFLDNotes_L:=1
		C_BOOLEAN:C305($GotSections_B)
		$GotSections_B:=False:C215
		C_LONGINT:C283($w_L; $H_L)
		FORM GET PROPERTIES:C674([ScourPOA:132]; "PrintSelection"; $w_L; $H_L)
		CENTER_WINDOW($w_L; $H_L; Plain window:K34:13)
		DIALOG:C40([ScourPOA:132]; "PrintSelection")
		CLOSE WINDOW:C154
		If (OK=1)
			If ((SCPOA_PrintSumm_L+SCPOA_PrintPOA_L+SCPOA_PrintLocus_L+SCPOA_PrintDetour_L+SCPOA_PrintFLDNotes_L)>0)
				$GotSections_B:=True:C214
			End if 
		End if 
		$PrintTheList_b:=$GotSections_B
		If ($PrintTheList_b)
			SCPOA_Variables("OLDNEWVERSION")
		End if 
		
	End if 
End if 

If ($PrintTheList_b)
	C_LONGINT:C283($LastScale_l; $LastOrient_l)
	GET PRINT OPTION:C734(Orientation option:K47:2; $LastOrient_l)
	GET PRINT OPTION:C734(Scale option:K47:3; $LastScale_l)
	SET PRINT OPTION:C733(Orientation option:K47:2; 1)
	SET PRINT OPTION:C733(Scale option:K47:3; 100)
	
	PRINT SETTINGS:C106
	If (OK=1)
		SCPOA_Variables("INIT")
		SCPOA_Variables("CLEAR")
		C_BOOLEAN:C305($BrgRO_b)
		$BrgRO_b:=Read only state:C362([Bridge MHD NBIS:1])
		READ ONLY:C145([Bridge MHD NBIS:1])
		C_BOOLEAN:C305($ShowPrintSet_b)
		$ShowPrintSet_b:=False:C215
		FIRST RECORD:C50([ScourPOA:132])
		While (Not:C34(End selection:C36([ScourPOA:132])))
			RELATE ONE:C42([ScourPOA:132]BIN:2)
			If ($PrintHighlight_B)
				If (Is in set:C273("$Highlight"))
					SCPOA_Variables("CLEARDETOURBRIDGES")
					SCPOA_Variables("CLEAR")
					SCPOA_Variables("LOAD")
					SCPOA_UpdateDetourAvgs
					SCPOA_FieldNoteCtrl("INIT")
					SCPOA_FieldNoteCtrl("GETNAMES")
					SCPOA_Print_A($ShowPrintSet_b; SCPOA_PrintPreview_b)
				End if 
			Else 
				SCPOA_Variables("CLEARDETOURBRIDGES")
				SCPOA_Variables("CLEAR")
				SCPOA_Variables("LOAD")
				SCPOA_UpdateDetourAvgs
				SCPOA_FieldNoteCtrl("INIT")
				SCPOA_FieldNoteCtrl("GETNAMES")
				SCPOA_Print_A($ShowPrintSet_b; SCPOA_PrintPreview_b)
			End if 
			
			NEXT RECORD:C51([ScourPOA:132])
		End while 
		SCPOA_Variables("CLEAR")
		If (Not:C34($BrgRO_b))
			READ WRITE:C146([Bridge MHD NBIS:1])
		End if 
		
	End if 
	G_PrintOptions($LastOrient_l; " "; $LastScale_l)
	
End if 

CLEAR SET:C117("$Highlight")