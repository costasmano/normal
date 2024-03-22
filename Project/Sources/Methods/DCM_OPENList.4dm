//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/10, 11:03:36
	// ----------------------------------------------------
	// Method: Method: DCM_OPENList
	// Description
	// 
	//  ` 
	// Parameters
	// $1 : $Table_ptr
	// ----------------------------------------------------
	
	Mods_2010_12
	Mods_2011_06  // CJ Miller`06/20/11, 10:23:51      ` Type all local variables for v11
End if 
C_POINTER:C301($1)
C_TEXT:C284($MyTable_txt; $WOTable_txt; $ProjTable_txt)
$MyTable_txt:=Table name:C256($1)
$WOTable_txt:=Table name:C256(->[DCM_WorkOrders:137])
$ProjTable_txt:=Table name:C256(->[DCM_Project:138])
C_TEXT:C284($CurrWinTitle_txt; $CurrMainTitle_txt)
C_LONGINT:C283($fW_L; $FH_L; $WL_L; $WT_L; $WR_L; $WB_L; $WW_L)
C_POINTER:C301($CurrPfile_ptr)
$CurrMainTitle_txt:=MainTitle
$CurrWinTitle_txt:=Get window title:C450
$CurrPfile_ptr:=pFile
GET WINDOW RECT:C443($WL_L; $WT_L; $WR_L; $WB_L)
$WW_L:=$WR_L-$WL_L
C_BOOLEAN:C305($DoLaunch_b)

Case of 
	: ($MyTable_txt=$WOTable_txt)
		RELATE MANY SELECTION:C340([DCM_WorkOrders:137]ContractNo:1)
		ORDER BY:C49([DCM_WorkOrders:137]; [DCM_WorkOrders:137]ContractNo:1; >; [DCM_WorkOrders:137]AssignNo:2)
		FORM SET OUTPUT:C54([DCM_WorkOrders:137]; "DistrMaintIncList")
		FORM SET INPUT:C55([DCM_WorkOrders:137]; "DistrMaintInput")
		FORM GET PROPERTIES:C674([DCM_WorkOrders:137]; "DistrMaintIncList"; $fW_L; $FH_L)
		
		pFile:=->[DCM_WorkOrders:137]
		MainTitle:="Work Orders"
		$DoLaunch_b:=True:C214
		
	: ($MyTable_txt=$ProjTable_txt)
		RELATE MANY SELECTION:C340([DCM_WorkOrders:137]ContractNo:1)
		RELATE MANY SELECTION:C340([DCM_Project:138]AssignID:13)
		ORDER BY:C49([DCM_Project:138]; [DCM_WorkOrders:137]ContractNo:1; >; [DCM_WorkOrders:137]AssignNo:2; >; [DCM_Project:138]BridgeNo:4; >; [DCM_Project:138]BIN:5; >)
		
		FORM SET OUTPUT:C54([DCM_Project:138]; "DistrWorkOrderList")
		FORM SET INPUT:C55([DCM_Project:138]; "DistrWorkOrderInput")
		FORM GET PROPERTIES:C674([DCM_Project:138]; "DistrWorkOrderList"; $fW_L; $FH_L)
		
		pFile:=->[DCM_Project:138]
		MainTitle:="Bridge Projects"
		$DoLaunch_b:=True:C214
		
End case 

If ($DoLaunch_b)
	If ($WW_L<$fW_L)
		SET WINDOW RECT:C444($WL_L; $WT_L; ($WR_L+$fW_L-$WW_L); $WB_L)
	End if 
	
	RegionTitle
	MODIFY SELECTION:C204(pFile->)
	
	SET WINDOW RECT:C444($WL_L; $WT_L; $WR_L; $WB_L)
	MainTitle:=$CurrMainTitle_txt
	pFile:=$CurrPfile_ptr
	SET WINDOW TITLE:C213($CurrWinTitle_txt)
End if 