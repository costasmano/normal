//%attributes = {"invisible":true}
// Method: PON_ElemInp_AddChild
// Description
// add a child element in an element input form
// 
// Parameters
// $1 :$AddProtSys_b
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 17:01:03
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_BOOLEAN:C305($1)
C_BOOLEAN:C305($AddProtSys_b)
$AddProtSys_b:=$1
C_BOOLEAN:C305($doAdd_b)
$doAdd_b:=True:C214
If (Modified record:C314([PON_ELEM_INSP:179]))
	C_TEXT:C284($ElemType_txt)
	
	If ($AddProtSys_b)
		$ElemType_txt:="Prot. Syst."
	Else 
		$ElemType_txt:="Defect"
	End if 
	
	CONFIRM:C162("Current element "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+" has been modified! Must Save before Continuing!"; "Save and add "+$ElemType_txt; "STOP")
	If (OK=1)
		If (PON_ELEMINP_SAVE)
			$doAdd_b:=True:C214
		End if 
	Else 
		$doAdd_b:=False:C215
	End if 
End if 

If ($doAdd_b)
	// save current selection ` need to know how deep we are
	C_TEXT:C284($TempSelName_txt)
	$TempSelName_txt:="$TempElemSelection"+String:C10(Size of array:C274(PON_ELEMDEPTH_aL))
	COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; $TempSelName_txt)
	PON_SetupChildParams
	
	PON_ADDPROTSYS_b:=$AddProtSys_b
	ADD RECORD:C56([PON_ELEM_INSP:179])
	//DELETE FROM ARRAY(PON_ELEMDEPTH_aL;Size of array(PON_ELEMDEPTH_aL);1)
	USE NAMED SELECTION:C332($TempSelName_txt)
	CLEAR NAMED SELECTION:C333($TempSelName_txt)
	PON_ELEMINPUTIL("RESETUI")
	REDRAW:C174(PON_NBE_DAM_LB)
	PON_ELEMINP_SetNavControls
	
End if 
//End PON_ElemInp_AddChild