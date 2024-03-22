//%attributes = {"invisible":true}
If (False:C215)
	//M_SearchDefElement 
	//SJH  4/30/2004
	//This procedure searches a for bridges with deficient elements
	
	Mods_2004_CM03
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(7/8/08 17:12:31)
	Mods_2008_CM_5404  // ("ElmtSearch")
	//  ` chgd search win type and title; Changed wording of printing prompt 
	// Modified by: costasmanousakis-(Designer)-(9/18/09 09:57:22)
	Mods_2009_09
	//  `Additions to include search for word or phrase in Element comments- and a missing check
	//  ` for the elementCat based search.
	// Modified by: costasmanousakis-(Designer)-(11/24/10 12:53:49)
	Mods_2010_11
	//  `Mods for search by element description.
	// Modified by: Costas Manousakis-(Designer)-(1/17/12 10:30:45)
	Mods_2012_01
	//  `Added code to open a new window with the results of the element search
	// Modified by: Costas Manousakis-(Designer)-(6/8/17 16:13:41)
	Mods_2017_06_bug
	//  `use methods ut_db_SaveROState ut_db_RestoreROState
	// Modified by: Costas Manousakis-(Designer)-(4/10/19 16:53:29)
	Mods_2019_04
	//  `use "Plain form window" for window type of search dialogue and use Open form window
End if 

C_LONGINT:C283(elmtSrchDefStat; elmtSrchUrgStat; elmtSrchCondStat; elmtSrchCatStat; elmtSrchTxtStat; elmtSrchDescStat; cbOpenList)
C_LONGINT:C283(cbDeficiency; cbUrgency; cbElmtCond; cbElementCat; cbElementTxt; cbElemDescTxt)
C_TEXT:C284(SRC_ELEMTEXT_txt; SRC_ELEMDESC_txt)
C_LONGINT:C283($vlWinW; $vlWinHt)

C_BLOB:C604($ROStates_x)
$ROStates_x:=ut_db_SaveROState

READ ONLY:C145([Inspections:27])
READ ONLY:C145([ElementsSafety:29])
READ ONLY:C145([Inspection Type:31])
READ ONLY:C145([ElementDict:30])
READ ONLY:C145([Bridge MHD NBIS:1])

COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "StartSearch")

FORM GET PROPERTIES:C674([Dialogs:21]; "Search Def Element"; $vlWinW; $vlWinHt)
//CENTER_WINDOW ($vlWinW;$vlWinHt;Plain form window;"Element Search")
C_LONGINT:C283($win_id)
$win_id:=Open form window:C675([Dialogs:21]; "Search Def Element"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Dialogs:21]; "Search Def Element")
CLOSE WINDOW:C154

elmtSrchDefStat:=cbDeficiency
elmtSrchUrgStat:=cbUrgency
elmtSrchCondStat:=cbElmtCond
elmtSrchCatStat:=cbElementCat
elmtSrchTxtStat:=cbElementTxt
elmtSrchDescStat:=cbElemDescTxt
If (Ok=1)
	If (Records in set:C195("Random Set")=0)
		If ((vDefOp#"") | (vDef#"") | (vUrgOp#"") | (vUrg#"") | (vElmtCondOp#"") | (cboElmtCond>0) | (cbElementTxt=1) | (cbElemDescTxt=1) | (cbElementCat=1))
			CreateRandomSetForDefElement
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
		$msg:="Print Report for "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" BIN records"
		$msg:=$msg+" with a total of "+String:C10(Records in set:C195("TotalElmtsFound"))+" elements"
		
		If (vIncludeComments)
			$msg:=$msg+" (Including the comments for each element) ?"
		Else 
			$msg:=$msg+"  ?"
		End if 
		
		CONFIRM:C162($msg)
		If (OK=1)
			M_DeficientElementRpt
		End if 
	End if 
	
	If (cbOpenList=1)
		C_TEXT:C284($NamedSelectionName_txt; $ProcessName_txt; $Seq_txt; $WinTitle_txt; $QueryName_txt)
		$ProcessName_txt:="Elements LB"
		$NamedSelectionName_txt:="◊ElementsSelect"
		$WinTitle_txt:="ELEMENTS"
		$QueryName_txt:="ELEMSafetyQuery2"
		C_POINTER:C301($Tbl_ptr)
		$Tbl_ptr:=->[ElementsSafety:29]
		
		C_LONGINT:C283($pid)
		$Seq_txt:=String:C10(LNextView($ProcessName_txt)+1)
		$ProcessName_txt:=$ProcessName_txt+" "+$Seq_txt
		$NamedSelectionName_txt:=$NamedSelectionName_txt+"_"+$Seq_txt
		$WinTitle_txt:=$WinTitle_txt+" ["+$Seq_txt+"]"
		USE SET:C118("TotalElmtsFound")
		COPY NAMED SELECTION:C331($Tbl_ptr->; $NamedSelectionName_txt)
		
		$pid:=New process:C317("LB_ControlListBoxDisplay"; 0; $ProcessName_txt; $QueryName_txt; Table:C252($Tbl_ptr); $WinTitle_txt; $NamedSelectionName_txt)
		
	End if 
	
Else 
	USE NAMED SELECTION:C332("StartSearch")
End if 
CLEAR NAMED SELECTION:C333("StartSearch")
CLEAR SET:C117("Random Set")
CLEAR SET:C117("TotalElmtsFound")  // set of elements found.
G_CloseAllTables(->[Bridge MHD NBIS:1])  //Release all tables except the main one.

ut_db_RestoreROState($ROStates_x)

RegionTitle