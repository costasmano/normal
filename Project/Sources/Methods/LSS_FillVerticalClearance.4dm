//%attributes = {"invisible":true}
//LSS_FillVerticalClearance 
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(5/16/16 12:30:32)
	Mods_2016_05_bug
	//  `Increased num of panels to 11
	// Modified by: Costas Manousakis-(Designer)-(5/17/16 10:09:47)
	Mods_2016_05_bug
	//  `use method ut_CountFormVars to count the vars
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 12:27:11)
	Mods_2016_05_bug
	//  `order by [LSS_VerticalClearance]LSS_Panel_txt
End if 


C_TEXT:C284($Query_txt)
$Query_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1

ARRAY TEXT:C222($LSS_Panel_atxt; 0)
ARRAY LONGINT:C221($LSS_Feet_aL; 0)
ARRAY LONGINT:C221($LSS_Inches_aL; 0)
ARRAY REAL:C219($LSS_Meter_aR; 0)

Begin SQL
	SELECT 
	[LSS_VerticalClearance].[LSS_Panel_txt],
	[LSS_VerticalClearance].[LSS_Feet_L],
	[LSS_VerticalClearance].[LSS_Inches_L],
	[LSS_VerticalClearance].[LSS_Meters_r]
	FROM
	[LSS_VerticalClearance]
	WHERE 
	[LSS_VerticalClearance].[LSS_InspectionId_s] = :$Query_txt 
	order by [LSS_VerticalClearance].[LSS_Panel_txt] ASC
	INTO 
	:$LSS_Panel_atxt, 
	:$LSS_Feet_aL, 
	:$LSS_Inches_aL, 
	:$LSS_Meter_aR;
End SQL


C_LONGINT:C283($Loop_L; $Size_L; $VarCount_L)
C_POINTER:C301($Panel_Ptr; $Feet_ptr; $Inches_ptr; $Meter_ptr)
$Size_L:=Size of array:C274($LSS_Meter_aR)

$VarCount_L:=ut_CountFormVars("LSS_Panel@_txt")

For ($Loop_L; 1; $VarCount_L)
	$Panel_Ptr:=Get pointer:C304("LSS_Panel"+String:C10($Loop_L)+"_txt")
	
	$Feet_ptr:=Get pointer:C304("LSS_Feet"+String:C10($Loop_L)+"_txt")
	$Inches_ptr:=Get pointer:C304("LSS_Inch"+String:C10($Loop_L)+"_txt")
	$Meter_ptr:=Get pointer:C304("LSS_Meter"+String:C10($Loop_L)+"_txt")
	
	
	If ($Loop_L>$Size_L)
		$Panel_Ptr->:=""
		$Feet_ptr->:=""
		$Inches_ptr->:=""
		$Meter_ptr->:=""
		
	Else 
		$Panel_Ptr->:=$LSS_Panel_atxt{$Loop_L}
		$Feet_ptr->:=String:C10($LSS_Feet_aL{$Loop_L})
		$Inches_ptr->:=String:C10($LSS_Inches_aL{$Loop_L})
		$Meter_ptr->:=String:C10($LSS_Meter_aR{$Loop_L}; "###.##")
		
	End if 
	
End for 