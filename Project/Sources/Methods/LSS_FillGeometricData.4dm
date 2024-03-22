//%attributes = {"invisible":true}
If (False:C215)
	//Mods_2012_01
	//Modified by: Kenny Yang-(Designer) `10/29/14, 17:46:32   `\ 
	//LSS_FillGeometricData
	
	// Modified by: Costas Manousakis-(Designer)-(5/16/16 12:31:49)
	Mods_2016_05_bug
	//  `increase num of panels to 11
	// Modified by: Costas Manousakis-(Designer)-(5/17/16 10:12:56)
	Mods_2016_05_bug
	//  `use method ut_CountFormVars to count the vars
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 14:23:06)
	Mods_2016_05_bug
	//  `order by [LSS_TowerDistance].[LSS_TowerOrPost_txt] ASC , [LSS_TowerDistance].[LSS_SignPanel_s] ASC
End if 

C_TEXT:C284($Query_txt)
$Query_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1

ARRAY TEXT:C222($LSS_TowerPost_atxt; 0)
ARRAY TEXT:C222($LSS_SignPanel_atxt; 0)
ARRAY TEXT:C222($LSS_Distance_atxt; 0)

Begin SQL
	SELECT 
	[LSS_TowerDistance].[LSS_TowerOrPost_txt],
	[LSS_TowerDistance].[LSS_SignPanel_s],
	[LSS_TowerDistance].[LSS_Distance_txt]
	
	FROM 
	[LSS_TowerDistance]
	WHERE 
	[LSS_TowerDistance].[LSS_InspectionId_s] = :$Query_txt 
	order by [LSS_TowerDistance].[LSS_TowerOrPost_txt] ASC , [LSS_TowerDistance].[LSS_SignPanel_s] ASC
	INTO 
	:$LSS_TowerPost_atxt, 
	:$LSS_SignPanel_atxt, 
	:$LSS_Distance_atxt;
End SQL


C_LONGINT:C283($Loop_L; $Size_L; $VarCount_L)
C_POINTER:C301($TowerPost_ptr; $SignPanel_ptr; $Distance_ptr)
$Size_L:=Size of array:C274($LSS_Distance_atxt)
$VarCount_L:=ut_CountFormVars("LSS_TowerPost@_txt")
For ($Loop_L; 1; $VarCount_L)
	$TowerPost_ptr:=Get pointer:C304("LSS_TowerPost"+String:C10($Loop_L)+"_txt")
	$SignPanel_ptr:=Get pointer:C304("LSS_SignPanel"+String:C10($Loop_L)+"_txt")
	$Distance_ptr:=Get pointer:C304("LSS_Distance"+String:C10($Loop_L)+"_txt")
	
	
	If ($Loop_L>$Size_L)
		$TowerPost_ptr->:=""
		$SignPanel_ptr->:=""
		$Distance_ptr->:=""
		
	Else 
		$TowerPost_ptr->:=$LSS_TowerPost_atxt{$Loop_L}
		$SignPanel_ptr->:=$LSS_SignPanel_atxt{$Loop_L}
		$Distance_ptr->:=$LSS_Distance_atxt{$Loop_L}
		
	End if 
	
End for 