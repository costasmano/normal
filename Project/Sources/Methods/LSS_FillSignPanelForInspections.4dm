//%attributes = {"invisible":true}
//Method: LSS_FillSignPanelForInspections
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/10/18, 15:04:06
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
End if 
//
FORM_FixHairLine

LSS_FillPrintCheckBoxes

C_TEXT:C284($Query_txt)
$Query_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1

ARRAY TEXT:C222($LSS_Panel_atxt; 0)
ARRAY TEXT:C222($LSS_Width_atxt; 0)
ARRAY TEXT:C222($LSS_Height_atxt; 0)
ARRAY TEXT:C222($LSS_PanelMessage_atxt; 0)
ARRAY TEXT:C222($LSS_PanelType_atxt; 0)
ARRAY TEXT:C222($LSS_LanesOver_atxt; 0)

Begin SQL
	SELECT 
	[LSS_SignPanel].[LSS_Panel_s], 
	[LSS_SignPanel].[LSS_Width_s], 
	[LSS_SignPanel].[LSS_Height_s], 
	[LSS_SignPanel].[LSS_PanelMessage_txt], 
	[LSS_SignPanel].[LSS_PanelType_s], 
	[LSS_SignPanel].[LSS_LanesPanelOver_txt]
	FROM 
	[LSS_SignPanel] 
	WHERE 
	[LSS_SignPanel].[LSS_InspectionId_s] = :$Query_txt 
	order by [LSS_Panel_s] ASC
	INTO 
	:$LSS_Panel_atxt, 
	:$LSS_Width_atxt, 
	:$LSS_Height_atxt, 
	:$LSS_PanelMessage_atxt,
	:$LSS_PanelType_atxt,
	:$LSS_LanesOver_atxt;
End SQL

C_LONGINT:C283($Loop_L; $Size_L; $varCount_L)
C_POINTER:C301($Panel_Ptr; $Width_ptr; $Hieght_ptr; $Message_ptr; $PanelType_ptr; $Lanes_ptr)
$Size_L:=Size of array:C274($LSS_LanesOver_atxt)
$varCount_L:=ut_CountFormVars("LSS_PanelType@_txt")
For ($Loop_L; 1; $varCount_L)
	$Panel_Ptr:=Get pointer:C304("LSS_Panel"+String:C10($Loop_L)+"_txt")
	
	$Width_ptr:=Get pointer:C304("LSS_Width"+String:C10($Loop_L)+"_txt")
	$Hieght_ptr:=Get pointer:C304("LSS_Height"+String:C10($Loop_L)+"_txt")
	$Message_ptr:=Get pointer:C304("LSS_Message"+String:C10($Loop_L)+"_txt")
	$PanelType_ptr:=Get pointer:C304("LSS_PanelType"+String:C10($Loop_L)+"_txt")
	$Lanes_ptr:=Get pointer:C304("LSS_LanesOver"+String:C10($Loop_L)+"_txt")
	
	If ($Loop_L>$Size_L)
		$Panel_Ptr->:=""
		$Width_Ptr->:=""
		$Hieght_Ptr->:=""
		$Message_Ptr->:=""
		$PanelType_ptr->:=""
		$Lanes_Ptr->:=""
	Else 
		$Panel_Ptr->:=$LSS_Panel_atxt{$Loop_L}
		$Width_ptr->:=$LSS_Width_atxt{$Loop_L}
		$Hieght_ptr->:=$LSS_Height_atxt{$Loop_L}
		$Message_ptr->:=$LSS_PanelMessage_atxt{$Loop_L}
		ut_FitPrintFormObject($Message_ptr; 7; 5)
		$PanelType_ptr->:=$LSS_PanelType_atxt{$Loop_L}
		$Lanes_ptr->:=$LSS_LanesOver_atxt{$Loop_L}
	End if 
	
End for 
//End LSS_FillSignPanelForInspections