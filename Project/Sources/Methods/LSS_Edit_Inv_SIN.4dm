//%attributes = {"invisible":true}
// Method : LSS_Edit_Inv_SIN   
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/03/15, 11:10:01
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09_bug
	Compiler_FieldVariables
	// Modified by: Costas Manousakis-(Designer)-(1/11/16 13:50:14)
	Mods_2016_01_bug
	//  `if Dialog is canceled make sure we reset values before  the dialog was opened
	// Modified by: Costas Manousakis-(Designer)-(1/14/16 17:30:10)
	Mods_2016_01_bug
	//  `Addition of changing  the town/District
End if 
//
C_LONGINT:C283($W; $H)
//verify existring inspections'
C_LONGINT:C283($CompleteCount_L; $ApprovedCount_Ll; $ReviewedCount_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $CompleteCount_L)
QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Complete_b:39=True:C214)
SET QUERY DESTINATION:C396(Into variable:K19:4; $ApprovedCount_Ll)
QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_ApprovedDate_d:44#!00-00-00!)
SET QUERY DESTINATION:C396(Into variable:K19:4; $ReviewedCount_L)
QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_ReviewDate_d:42#!00-00-00!)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($CompleteCount_L=0) & ($ApprovedCount_Ll=0) & ($ReviewedCount_L=0)
Else 
	C_TEXT:C284($Msg_txt)
	$Msg_txt:="There are "
	If ($CompleteCount_L>0)
		$Msg_txt:=$Msg_txt+String:C10($CompleteCount_L)+" Completed inspections"+Char:C90(Carriage return:K15:38)
	End if 
	If ($ApprovedCount_Ll>0)
		$Msg_txt:=$Msg_txt+String:C10($ApprovedCount_Ll)+" Approved inspections"+Char:C90(Carriage return:K15:38)
	End if 
	If ($ReviewedCount_L>0)
		$Msg_txt:=$Msg_txt+String:C10($ReviewedCount_L)+" Reviewed inspections"+Char:C90(Carriage return:K15:38)
	End if 
	$Msg_txt:=$Msg_txt+"Changing the Inventory and Structure number will require re-printing of these inspections!"
	ALERT:C41($Msg_txt)
	
End if 

FORM GET PROPERTIES:C674([LSS_Inventory:165]; "Edit_SIN"; $W; $H)
C_LONGINT:C283($CurrIDNum_L; $CurrDist_L)
C_TEXT:C284($currSIN_txt; $currInvCat_txt; $currInvType_txt; $CurrRoute_txt; $currRouteDir_txt; $CurrTown_txt)
C_REAL:C285($currKiloPt_r; $currMilePt_r)
$CurrIDNum_L:=[LSS_Inventory:165]LSS_IdentificationNumber_L:5
$currSIN_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
$currInvCat_txt:=[LSS_Inventory:165]LSS_Category_s:2
$currInvType_txt:=[LSS_Inventory:165]LSS_InventoryType_s:28
$CurrRoute_txt:=[LSS_Inventory:165]LSS_Route_s:9
$currRouteDir_txt:=[LSS_Inventory:165]LSS_RouteDirection_s:14
$CurrTown_txt:=[LSS_Inventory:165]LSS_Town_s:4
$CurrDist_L:=[LSS_Inventory:165]LSS_District_L:3

CENTER_WINDOW($W; $H; Plain window:K34:13; "Edit Structure Number")
DIALOG:C40([LSS_Inventory:165]; "Edit_SIN")
If (OK=1)
	[LSS_Inventory:165]LSS_StructureNumber_s:6:=v_165_006_txt
	[LSS_Inventory:165]LSS_IdentificationNumber_L:5:=v_165_005_L
	//other fileds are modified in the dialog.
Else 
	[LSS_Inventory:165]LSS_IdentificationNumber_L:5:=$CurrIDNum_L
	[LSS_Inventory:165]LSS_StructureNumber_s:6:=$currSIN_txt
	[LSS_Inventory:165]LSS_Category_s:2:=$currInvCat_txt
	[LSS_Inventory:165]LSS_InventoryType_s:28:=$currInvType_txt
	[LSS_Inventory:165]LSS_Route_s:9:=$CurrRoute_txt
	[LSS_Inventory:165]LSS_RouteDirection_s:14:=$currRouteDir_txt
	[LSS_Inventory:165]LSS_Town_s:4:=$CurrTown_txt
	[LSS_Inventory:165]LSS_District_L:3:=$CurrDist_L
End if 
CLOSE WINDOW:C154

//End LSS_EditSIN