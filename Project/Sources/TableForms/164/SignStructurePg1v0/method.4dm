If (False:C215)
	//Form Method: [LSS_Inspection];"SignStructurePg1"
	// Modified by: Costas Manousakis-(Designer)-(1/15/16 12:28:01)
	Mods_2016_01_bug
	//  ` changed Cracks from the field to a check box with a boolean variable
	//  `made form type as detail form for printing ; platform : printing ; unchecked all event except on printing detail`
	//  `adjusted size/location of struct material field, struct coating line
	//  `adjusted size/location of labels in SIGN PANELS header
	//  `adjusted size/location of labels/variables in the structure location line
	//  `adjusted size/location of labels/variables in the structure type line
	//  `increased size of AssetNo
	//  `check boxes must be done in form method - check boxes are initialized on form event; added call to LSS_FillPrintCheckBoxes
	//  ` 
	// Modified by: Costas Manousakis-(Designer)-(2/24/16 13:10:48)
	Mods_2016_02_bug
	//  `fixed field : instead of Luminaire should be Sign Panels
End if 

If (Form event code:C388=On Printing Detail:K2:18)
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
		INTO 
		:$LSS_Panel_atxt, 
		:$LSS_Width_atxt, 
		:$LSS_Height_atxt, 
		:$LSS_PanelMessage_atxt,
		:$LSS_PanelType_atxt,
		:$LSS_LanesOver_atxt;
	End SQL
	
	
	
	
	C_LONGINT:C283($Loop_L; $Size_L)
	C_POINTER:C301($Panel_Ptr; $Width_ptr; $Hieght_ptr; $Message_ptr; $PanelType_ptr; $Lanes_ptr)
	$Size_L:=Size of array:C274($LSS_LanesOver_atxt)
	
	For ($Loop_L; 1; 5)
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
			$PanelType_ptr->:=$LSS_PanelType_atxt{$Loop_L}
			$Lanes_ptr->:=$LSS_LanesOver_atxt{$Loop_L}
		End if 
		
	End for 
End if 
