//%attributes = {"invisible":true}
// Method: M_SearchPontisElmts
// Description
// Copied from M_SearchDefElement
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/05, 19:59:18
	// ----------------------------------------------------
	Mods_2005_CM17
	// Modified by: costasmanousakis-(Designer)-(4/4/08 17:00:33)
	Mods_2008_CM_5403  //Apply sort
	// Modified by: Costas Manousakis-(Designer)-(11/1/13 13:26:10)
	Mods_2013_11
	//  `Added  option to open a new window with the result set of cond units
End if 

C_LONGINT:C283(elmtSrchStateStat; elmtSrchPCatStat; elmtSrchQtyStat; elmtSrchEnvStat; cbOpenList)
C_LONGINT:C283($vlWinW; $vlWinHt)

READ ONLY:C145([BMS Inspections:44])
READ ONLY:C145([Cond Units:45])
READ ONLY:C145([BMS Elements:47])
READ ONLY:C145([BMS Categories:49])
READ ONLY:C145([Inspections:27])
READ ONLY:C145([Combined Inspections:90])

COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "StartSearch")
SRCP_LoadElmArrays(True:C214)
SRCP_LoadElmCat
FORM GET PROPERTIES:C674([Dialogs:21]; "SearchPontisElmts"; $vlWinW; $vlWinHt)
CENTER_WINDOW($vlWinW; $vlWinHt; Movable dialog box:K34:7)
DIALOG:C40([Dialogs:21]; "SearchPontisElmts")
CLOSE WINDOW:C154

elmtSrchStateStat:=cbElmtState
elmtSrchPCatStat:=cbPonElementCat
elmtSrchQtyStat:=cbElmtQty
elmtSrchEnvStat:=cbElmtEnv
If (Ok=1)
	If (Records in set:C195("Random Set")=0)
		If ((vElmtStateOp#"") | (cboElmtState>0))
			CreateRandomSetForPontisElmt
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
			M_PontisElementRpt
		End if 
	End if 
	If (cbOpenList=1)
		C_TEXT:C284($NamedSelectionName_txt; $ProcessName_txt; $Seq_txt; $WinTitle_txt; $QueryName_txt)
		$ProcessName_txt:="CondUnitLB"
		$NamedSelectionName_txt:="◊CondUnitSelect"
		$WinTitle_txt:="Bridge Elements"
		$QueryName_txt:="CondUnitsQuery1"
		C_POINTER:C301($Tbl_ptr)
		$Tbl_ptr:=->[Cond Units:45]
		
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
READ WRITE:C146([BMS Inspections:44])
READ WRITE:C146([Cond Units:45])
READ WRITE:C146([BMS Elements:47])
READ WRITE:C146([BMS Categories:49])
READ WRITE:C146([Inspections:27])
READ WRITE:C146([Combined Inspections:90])

RegionTitle