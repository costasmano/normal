//%attributes = {"invisible":true}
//Method: LB_ProcessLSSElementQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/20/18, 11:40:10
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12  //add [LSS_ElementInspection] query and report
	//Modified by: Chuck Miller (1/24/19 11:42:45)
	
End if 
//
C_LONGINT:C283($0)
$0:=0
C_LONGINT:C283($progress_L; $Count_l)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($LBCol_L; $LBRow_L; $wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
		LISTBOX GET CELL POSITION:C971(*; "SelectListBox"; $LBCol_L; $LBRow_L)
		If (Contextual click:C713)
			C_LONGINT:C283($BUTTON_L)
			C_REAL:C285($x_R; $y_R)
			ARRAY TEXT:C222($MenuDiscriptor_atxt; 0)
			ARRAY TEXT:C222($MenuDiscriptor_atxt; 2)
			$MenuDiscriptor_atxt{1}:="Open Inventory Structure"
			$MenuDiscriptor_atxt{2}:="Open Inspection"
			ARRAY TEXT:C222($MenuSelected_atxt; 0)
			ARRAY TEXT:C222($MenuSelected_atxt; 2)
			$MenuSelected_atxt{1}:="1"
			$MenuSelected_atxt{2}:="2"
			
			GET MOUSE:C468($x_R; $y_R; $BUTTON_L)
			C_TEXT:C284($menuref_txt; $selected_txt)
			
			$menuref_txt:=MENU_BuildMenuFromArrays(->$MenuDiscriptor_atxt; ->$MenuSelected_atxt; "\\")
			$selected_txt:=Dynamic pop up menu:C1006($menuref_txt; ""; $x_R; $y_R)
			RELEASE MENU:C978($menuref_txt)
			GOTO SELECTED RECORD:C245([LSS_ElementInspection:163]; $LBRow_L)
			QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=[LSS_ElementInspection:163]LSS_InspectionId_s:3)
			QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=[LSS_Inspection:164]LSS_InventoryId_s:2)
			GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
			OBJECT GET COORDINATES:C663(*; "SelectListBox"; $ol; $ot; $or; $ob)
			
			Case of 
				: ($selected_txt="1")
					LSS_ControlModification(->[LSS_Inventory:165]; "Input")
					InDoubleClick_B:=False:C215
					
				: ($selected_txt="2")
					C_TEXT:C284($InputForm_txt)
					LSS_InspectionRow_L:=1
					Case of 
						: ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
							$InputForm_txt:="Input_Sign"
						: ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
							$InputForm_txt:="Input_Light"
						: ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
							$InputForm_txt:="Input_Signal"
						: ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
							$InputForm_txt:="Input_ITS"
						Else 
							
							Case of 
								: ([LSS_Inventory:165]LSS_Category_s:2="Sign")
									$InputForm_txt:="Input_Sign"
								: ([LSS_Inventory:165]LSS_Category_s:2="Signal")
									$InputForm_txt:="Input_Signal"
								: ([LSS_Inventory:165]LSS_Category_s:2="Light")
									$InputForm_txt:="Input_Light"
								: ([LSS_Inventory:165]LSS_Category_s:2="ITS")
									$InputForm_txt:="Input_ITS"
							End case 
							
					End case 
					C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
					GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
					OBJECT GET COORDINATES:C663(*; "SelectListBox"; $ol; $ot; $or; $ob)
					If (LSS_InspectionRow_L>0)
						LSS_DisplayInspection($InputForm_txt)
					End if 
					
					
			End case 
			SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
			OBJECT GET COORDINATES:C663(*; "SelectListBox"; $wl; $wt; $wr; $wb)
			
			OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; $or-$wr; $ob-$wb)
			USE NAMED SELECTION:C332("MyLocalNamedSelection")
			
			
		End if 
	: (Form event code:C388=On Load:K2:1)
		LISTBOX SET TABLE SOURCE:C1013(*; "SelectListBox"; [LB_QueryTable:147]TableNumber_l:3)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt)
		
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		C_TEXT:C284($HeaderVarName_txt)
		
		//Column 1
		$ColumnNumber_l:=1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Inspection Type")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [LSS_Inventory:165]LSS_StructureNumber_s:6; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Structure Number")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"SelectListBox";$ColumnNumber_l;$ColumnName_txt;[LSS_Inspection]LSS_InspectionDate_d;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "d")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##/##/####")
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Insp. Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Category")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		//Column 5
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Description")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [LSS_ElementInspection:163]LSS_Rating_s:4; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Cur")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [LSS_ElementInspection:163]LSS_Deficiency_s:5; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Def")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 8
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [LSS_ElementInspection:163]LSS_Urgency_s:6; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Urg")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
	: (Form event code:C388=On Display Detail:K2:22)
		
		C_LONGINT:C283($Loc_L)
		QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1=[LSS_Inspection:164]LSS_InspectionTypeId_s:3)
		
		LB_Detail1_txt:=[LSS_refInspectionType:167]LSS_Description_txt:2
		LSS_SetUpArraysforElements
		$Loc_L:=Find in array:C230(v_162_001_aL; [LSS_ElementInspection:163]LSS_ElementId_L:2)
		LB_Detail3_d:=[LSS_Inspection:164]LSS_InspectionDate_d:4
		LB_Detail4_txt:=""
		LB_Detail5_txt:=""
		If ($Loc_L>0)
			LB_Detail4_txt:=LSS_Headers_atxt{$Loc_L}
			LB_Detail5_txt:=v_162_002_atxt{$Loc_L}
			If (LB_Detail4_txt=LB_Detail5_txt)
				LB_Detail5_txt:=""
			End if 
		End if 
		If ([LSS_ElementInspection:163]LSS_Description_txt:7#"")
			LB_Detail5_txt:=[LSS_ElementInspection:163]LSS_Description_txt:7
		End if 
		
End case 
//End LB_ProcessLSSElementQuery