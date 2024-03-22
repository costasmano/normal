//%attributes = {"invisible":true}
//Method: NTI_ElemInp_AddChild
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 13:05:59
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_BOOLEAN:C305(NTI_ElemInp_AddChild; $1)
	// Modified by: Costas Manousakis-(Designer)-(3/22/18 17:47:23)
	Mods_2018_03
	//  `additions for protective systems
	// Modified by: Costas Manousakis-(Designer)-(6/24/21 10:02:06)
	Mods_2021_WP
	//  `
End if 
//
C_BOOLEAN:C305($1)
C_BOOLEAN:C305($AddProtSys_b)
$AddProtSys_b:=$1
C_BOOLEAN:C305($doAdd_b)
$doAdd_b:=True:C214
If (NTI_ModifiedRecord(Current form table:C627))
	C_TEXT:C284($ElemType_txt)
	
	If ($AddProtSys_b)
		$ElemType_txt:="Prot. Syst."
	Else 
		$ElemType_txt:="Defect"
	End if 
	
	
	Case of 
		: (Current form table:C627=(->[NTI_ELEM_BIN_INSP:183]))
			CONFIRM:C162("Current element "+String:C10([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)+" has been modified! Must Save before Continuing!"; "Save and add "+$ElemType_txt; "STOP")
			
		: (Current form table:C627=(->[NTI_ELEM_TIN_INSP:185]))
			CONFIRM:C162("Current element "+String:C10([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)+" has been modified! Must Save before Continuing!"; "Save and add "+$ElemType_txt; "STOP")
			
	End case 
	
	If (OK=1)
		If (NTI_ELEMINP_SAVE(Current form table:C627))
			$doAdd_b:=True:C214
		End if 
	Else 
		$doAdd_b:=False:C215
	End if 
End if 

If ($doAdd_b)
	// save current selection ` need to know how deep we are
	C_TEXT:C284($TempSelName_txt)
	//check if the current elemkey is the last in PON_ELEMDEPTH_aL
	C_LONGINT:C283($CurrKey_L)
	Case of 
		: (Current form table:C627=(->[NTI_ELEM_BIN_INSP:183]))
			$CurrKey_L:=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3
		: (Current form table:C627=(->[NTI_ELEM_TIN_INSP:185]))
			$CurrKey_L:=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3
	End case 
	
	APPEND TO ARRAY:C911(PON_ELEMDEPTH_aL; $CurrKey_L)
	$TempSelName_txt:="$TempElemSelection"+String:C10(Size of array:C274(PON_ELEMDEPTH_aL))
	COPY NAMED SELECTION:C331(Current form table:C627->; $TempSelName_txt)
	NTI_SetupChildParams(Current form table:C627)
	
	PON_ADDPROTSYS_b:=$AddProtSys_b
	C_LONGINT:C283($CurrWriteArea_L)
	$CurrWriteArea_L:=AreaElmComments
	
	ADD RECORD:C56(Current form table:C627->)
	
	DELETE FROM ARRAY:C228(PON_ELEMDEPTH_aL; Size of array:C274(PON_ELEMDEPTH_aL); 1)
	USE NAMED SELECTION:C332($TempSelName_txt)
	CLEAR NAMED SELECTION:C333($TempSelName_txt)
	AreaElmComments:=$CurrWriteArea_L
	
	Case of 
		: (Current form table:C627=(->[NTI_ELEM_BIN_INSP:183]))
			NTI_ELEMINPUTIL("RESETUI")
			//NTI_ElmtRemarksArea (->[NTI_ELEM_BIN_INSP]ELEM_NOTES;AreaElmComments;On Load)
			INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[NTI_ELEM_BIN_INSP:183]ELEM_NOTES:9; "formEvent"; On Load:K2:1; "changeStack"; PON_ChangeStackLvl_L))
			
		: (Current form table:C627=(->[NTI_ELEM_TIN_INSP:185]))
			NTI_ELEMINPUTIL_TIN("RESETUI")
			//NTI_ElmtRemarksArea (->[NTI_ELEM_TIN_INSP]ELEM_NOTES;AreaElmComments;On Load)
			INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9; "formEvent"; On Load:K2:1; "changeStack"; PON_ChangeStackLvl_L))
			
	End case 
	//REDRAW(PON_NBE_DAM_LB)
	NTI_ELEMINP_SetNavControls
	
End if 

//End NTI_ElemInp_AddChild