//%attributes = {"invisible":true}
//Method: M_SearchNBEElmts
//Description
// Search bridge List By NBEs 
// copied from M_SearchPontisElmts
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/6/15, 13:47:27
	// ----------------------------------------------------
	// Search paths :
	// simple element search : single element, env, state, quantity or pct in state
	// element with defect 
	//  ` for parent elem spec env, state, quant or pct in state
	//  ` for defect specify min q,  max state
	//  ` 
	//  ` 
	
	
	// element with prot system 
	// element with prot system with defect
	
	//Created : 
	Mods_2015_07
	// Modified by: Costas Manousakis-(Designer)-(4/10/17 12:47:30)
	Mods_2017_04
	//  `updates
End if 
//

C_LONGINT:C283(elmtSrchStateStat; elmtSrchPCatStat; elmtSrchQtyStat; elmtSrchEnvStat; cbOpenList)
C_LONGINT:C283($vlWinW; $vlWinHt)

C_BLOB:C604($SAVED_RO_STATE_x)
$SAVED_RO_STATE_x:=ut_db_SaveROState
READ ONLY:C145(*)
COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "StartSearch")
//SRCP_LoadElmArrays (True)
//SRCP_LoadElmCat 
//Load element descriptions
PON_SETARRAYS
C_TEXT:C284($paramValue_txt; $PON_ELEM_CATEGORIES_tree)
$paramValue_txt:=ut_GetSysParameter("PON_ELEM_CATEGORIES")
$PON_ELEM_CATEGORIES_tree:=DOM Parse XML variable:C720($paramValue_txt)
QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="N"; *)
QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="N")
ARRAY TEXT:C222($allCats_atxt; 0)
ARRAY TEXT:C222($allTypes_atxt; 0)
ARRAY TEXT:C222($AllMats_atxt; 0)
DISTINCT VALUES:C339([PON_ELEM_DEFS:178]ELEM_CAT_KEY:5; $allCats_atxt)
DISTINCT VALUES:C339([PON_ELEM_DEFS:178]ELEM_TYPE_KEY:6; $allTypes_atxt)
DISTINCT VALUES:C339([PON_ELEM_DEFS:178]ELEM_MAT_KEY:7; $AllMats_atxt)

ARRAY TEXT:C222($RowValues_atx; 0)
ARRAY TEXT:C222($AttrNames_atxt; 0)
APPEND TO ARRAY:C911($AttrNames_atxt; "key")
APPEND TO ARRAY:C911($AttrNames_atxt; "name")
ARRAY TEXT:C222(PON_CATEGORIES_KEY_atxt; 0)
ARRAY TEXT:C222(PON_CATEGORIES_Desc_atxt; 0)
ARRAY POINTER:C280($AttrValueArrays_aptr; 0)
APPEND TO ARRAY:C911($AttrValueArrays_aptr; ->PON_CATEGORIES_KEY_atxt)
APPEND TO ARRAY:C911($AttrValueArrays_aptr; ->PON_CATEGORIES_Desc_atxt)

ut_DOM_To_Arrays($PON_ELEM_CATEGORIES_tree; "Category"; ->$RowValues_atx; ->$AttrNames_atxt; ->$AttrValueArrays_aptr)
DOM CLOSE XML:C722($PON_ELEM_CATEGORIES_tree)
C_LONGINT:C283($loop_L)
For ($loop_L; Size of array:C274(PON_CATEGORIES_KEY_atxt); 1; -1)
	
	If (Find in array:C230($allCats_atxt; PON_CATEGORIES_KEY_atxt{$loop_L})>0)
	Else 
		DELETE FROM ARRAY:C228(PON_CATEGORIES_KEY_atxt; $loop_L; 1)
		DELETE FROM ARRAY:C228(PON_CATEGORIES_Desc_atxt; $loop_L; 1)
		
	End if 
End for 

//add a blank to top of the list
INSERT IN ARRAY:C227(PON_CATEGORIES_Desc_atxt; 1)
INSERT IN ARRAY:C227(PON_CATEGORIES_KEY_atxt; 1)
PON_CATEGORIES_Desc_atxt{0}:="...Select Element Category"
PON_CATEGORIES_Desc_atxt{1}:="All Categories"

$paramValue_txt:=ut_GetSysParameter("PON_ELEM_TYPES")
$PON_ELEM_CATEGORIES_tree:=DOM Parse XML variable:C720($paramValue_txt)
ARRAY TEXT:C222($RowValues_atx; 0)
ARRAY TEXT:C222($AttrNames_atxt; 0)
APPEND TO ARRAY:C911($AttrNames_atxt; "key")
APPEND TO ARRAY:C911($AttrNames_atxt; "name")
ARRAY TEXT:C222(PON_TYPES_KEY_atxt; 0)
ARRAY TEXT:C222(PON_TYPES_Desc_atxt; 0)
ARRAY POINTER:C280($AttrValueArrays_aptr; 0)
APPEND TO ARRAY:C911($AttrValueArrays_aptr; ->PON_TYPES_KEY_atxt)
APPEND TO ARRAY:C911($AttrValueArrays_aptr; ->PON_TYPES_Desc_atxt)
ut_DOM_To_Arrays($PON_ELEM_CATEGORIES_tree; "Type"; ->$RowValues_atx; ->$AttrNames_atxt; ->$AttrValueArrays_aptr)

DOM CLOSE XML:C722($PON_ELEM_CATEGORIES_tree)
C_LONGINT:C283($loop_L)
For ($loop_L; Size of array:C274(PON_TYPES_KEY_atxt); 1; -1)
	
	If (Find in array:C230($allTypes_atxt; PON_TYPES_KEY_atxt{$loop_L})>0)
	Else 
		DELETE FROM ARRAY:C228(PON_TYPES_KEY_atxt; $loop_L; 1)
		DELETE FROM ARRAY:C228(PON_TYPES_Desc_atxt; $loop_L; 1)
		
	End if 
End for 

INSERT IN ARRAY:C227(PON_TYPES_KEY_atxt; 1)
INSERT IN ARRAY:C227(PON_TYPES_Desc_atxt; 1)
PON_TYPES_Desc_atxt{0}:="...Select Element Type"
PON_TYPES_Desc_atxt{1}:="All Types"

$paramValue_txt:=ut_GetSysParameter("PON_ELEM_MATERIALS")
$PON_ELEM_CATEGORIES_tree:=DOM Parse XML variable:C720($paramValue_txt)
ARRAY TEXT:C222($RowValues_atx; 0)
ARRAY TEXT:C222($AttrNames_atxt; 0)
APPEND TO ARRAY:C911($AttrNames_atxt; "key")
APPEND TO ARRAY:C911($AttrNames_atxt; "name")
ARRAY TEXT:C222(PON_MATERIALS_KEY_atxt; 0)
ARRAY TEXT:C222(PON_MATERIALS_Desc_atxt; 0)
ARRAY POINTER:C280($AttrValueArrays_aptr; 0)
APPEND TO ARRAY:C911($AttrValueArrays_aptr; ->PON_MATERIALS_KEY_atxt)
APPEND TO ARRAY:C911($AttrValueArrays_aptr; ->PON_MATERIALS_Desc_atxt)
ut_DOM_To_Arrays($PON_ELEM_CATEGORIES_tree; "Material"; ->$RowValues_atx; ->$AttrNames_atxt; ->$AttrValueArrays_aptr)

DOM CLOSE XML:C722($PON_ELEM_CATEGORIES_tree)
C_LONGINT:C283($loop_L)
For ($loop_L; Size of array:C274(PON_MATERIALS_KEY_atxt); 1; -1)
	
	If (Find in array:C230($allmats_atxt; PON_MATERIALS_KEY_atxt{$loop_L})>0)
	Else 
		DELETE FROM ARRAY:C228(PON_MATERIALS_KEY_atxt; $loop_L; 1)
		DELETE FROM ARRAY:C228(PON_MATERIALS_Desc_atxt; $loop_L; 1)
		
	End if 
End for 
INSERT IN ARRAY:C227(PON_MATERIALS_KEY_atxt; 1)
INSERT IN ARRAY:C227(PON_MATERIALS_Desc_atxt; 1)
PON_MATERIALS_Desc_atxt{0}:="...Select Element Material"
PON_MATERIALS_Desc_atxt{1}:="All Materials"

C_REAL:C285(vrSearchElmttotQty; vrSearchElmtQty)

FORM GET PROPERTIES:C674([PON_ELEM_INSP:179]; "SearchNBE"; $vlWinW; $vlWinHt)
CENTER_WINDOW($vlWinW; $vlWinHt; 0)
DIALOG:C40([PON_ELEM_INSP:179]; "SearchNBE")
CLOSE WINDOW:C154

If (Ok=1)
	If (Records in set:C195("Random Set")=0)
		If ((vElmtStateOp#"") | (cboElmtState>0))
			CreateRandomSetForNBEElmt
			USE SET:C118("Random Set")
		End if 
	Else 
		USE SET:C118("Random Set")
	End if 
	REDRAW WINDOW:C456
	C_TEXT:C284(GEN_SORTLISTCMD_txt)
	If (GEN_SORTLISTCMD_txt#"")
		EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
	End if 
	RegionTitle
	If (cbPrintNow=1)
		C_TEXT:C284($msg)
		$msg:="Print Reports for "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" BIN records ?"
		
		CONFIRM:C162($msg)
		If (OK=1)
			M_NBEElementRpt
		End if 
	End if 
	If (cbOpenList=1)
		C_TEXT:C284($NamedSelectionName_txt; $ProcessName_txt; $Seq_txt; $WinTitle_txt; $QueryName_txt)
		$ProcessName_txt:="NBEList"
		$NamedSelectionName_txt:="◊NBESelect"
		$WinTitle_txt:="National Bridge Elements"
		$QueryName_txt:="NBEQuery"
		C_POINTER:C301($Tbl_ptr)
		$Tbl_ptr:=->[PON_ELEM_INSP:179]
		
		C_LONGINT:C283($pid)
		$Seq_txt:=String:C10(LNextView($ProcessName_txt)+1)
		$ProcessName_txt:=$ProcessName_txt+" "+$Seq_txt
		$NamedSelectionName_txt:=$NamedSelectionName_txt+"_"+$Seq_txt
		$WinTitle_txt:=$WinTitle_txt+" ["+$Seq_txt+"]"
		USE SET:C118("TotalElmtsFound")
		COPY NAMED SELECTION:C331($Tbl_ptr->; $NamedSelectionName_txt)
		$pid:=New process:C317("LB_ControlListBoxDisplay"; 0; $ProcessName_txt; $QueryName_txt; Table:C252($Tbl_ptr); $WinTitle_txt; $NamedSelectionName_txt)
	End if 
	
	RegionTitle
	
Else 
	USE NAMED SELECTION:C332("StartSearch")
End if 
G_CloseAllTables(->[Bridge MHD NBIS:1])  //Release all tables except the main one.
ut_db_RestoreROState($SAVED_RO_STATE_x)
CLEAR NAMED SELECTION:C333("StartSearch")
CLEAR SET:C117("Random Set")
CLEAR SET:C117("TotalElmtsFound")  // set of elements found.
//End M_SearchNBEElmts