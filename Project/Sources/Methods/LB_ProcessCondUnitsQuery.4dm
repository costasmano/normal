//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/05/12, 11:11:07
//----------------------------------------------------
//Method: LB_ProcessCondUnitsQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/5/12 11:11:08)
	Mods_2020_10  //Fix sort direction issue where pointer was not set correctly
	//Modified by: CJ (10/6/20 13:35:45)
End if 
C_LONGINT:C283($0)
$0:=0
Case of 
	: (Form event code:C388=On Load:K2:1)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt)
		
		LISTBOX SET TABLE SOURCE:C1013(*; "SelectListBox"; [LB_QueryTable:147]TableNumber_l:3)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		C_TEXT:C284($HeaderVarName_txt)
		
		//Column 1
		
		$ColumnNumber_l:=1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Inspection Type:31]Description:2; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Type")
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Bridge MHD NBIS:1]BIN:3; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "BIN")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Bridge MHD NBIS:1]BDEPT:1; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "BDEPT")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "#-##-###")
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Inspections:27]Insp Date:78; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Inspection Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 5
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [BMS Elements:47]Element No:2; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "EL #")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Element Name")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET FONT SIZE:C165(*; $ColumnName_txt; 12)
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Units")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 8
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Cond Units:45]Environment:4; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Env.")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		
		//Column 9
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Total Q")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.0")
		
		If (False:C215)
			//Column 10
			$ColumnNumber_l:=$ColumnNumber_l+1
			LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
			LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; [Cond Units:45]Percent:6; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "%/Q")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
			
		End if 
		
		//Column 11
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "State 1")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		//SET FORMAT(*;$ColumnName_txt;"##0.0 %")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.0;")
		
		//Column 12
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "State 2")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		//SET FORMAT(*;$ColumnName_txt;"##0.0 %")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.0;")
		
		//Column 13
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "State 3")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		//SET FORMAT(*;$ColumnName_txt;"##0.0 %")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.0;")
		
		//Column 14
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "State 4")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		//SET FORMAT(*;$ColumnName_txt;"##0.0 %")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.0;")
		
		//Column 15
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "r")
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "State 5")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align right:K42:4)
		//SET FORMAT(*;$ColumnName_txt;"##0.0 %")
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; "##,###,##0.0;")
		
		$ColumnNumber_l:=LISTBOX Get rows height:C836(*; "SelectListBox")
		LISTBOX SET ROWS HEIGHT:C835(*; "SelectListBox"; $ColumnNumber_l*2)
		
	: (Form event code:C388=On Display Detail:K2:22)
		C_LONGINT:C283($NoCSs)
		
		QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]BMSInspID:3=[BMS Inspections:44]Inspection ID:1)
		QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
		RELATE ONE:C42([Inspections:27]Insp Type:6)
		
		LB_Detail6_txt:=LongName
		If (<>WindowsPL_b)
			If (Length:C16(LB_Detail6_txt)>=30)
				LB_Detail6_txt:=Substring:C12(LB_Detail6_txt; 1; 30)+Char:C90(Carriage return:K15:38)+Substring:C12(LB_Detail6_txt; 31)
			End if 
		Else 
			If (Length:C16(LB_Detail6_txt)>=36)
				LB_Detail6_txt:=Substring:C12(LB_Detail6_txt; 1; 36)+Char:C90(Carriage return:K15:38)+Substring:C12(LB_Detail6_txt; 37)
			End if 
		End if 
		LB_Detail7_txt:=AnglicizeUnit([BMS Elements:47]Units:6)
		//LB_Detail9_r:=Round([Cond Units]Total Quantity;1)
		LB_Detail9_r:=Round:C94(AnglicizeQ([Cond Units:45]Total Quantity:5; [BMS Elements:47]Units:6); 1)
		$NoCSs:=5
		If ([BMS Categories:49]Num of CSs:7>0)
			$NoCSs:=[BMS Categories:49]Num of CSs:7
		End if 
		LB_Detail10_r:=Round:C94(AnglicizeQ([Cond Units:45]CondState1:10; [BMS Elements:47]Units:6); 1)
		LB_Detail11_r:=Round:C94(AnglicizeQ([Cond Units:45]CondState2:11; [BMS Elements:47]Units:6); 1)
		LB_Detail12_r:=Round:C94(AnglicizeQ([Cond Units:45]CondState3:12; [BMS Elements:47]Units:6); 1)
		LB_Detail13_r:=Round:C94(AnglicizeQ([Cond Units:45]CondState4:13; [BMS Elements:47]Units:6); 1)
		LB_Detail14_r:=Round:C94(AnglicizeQ([Cond Units:45]CondState5:14; [BMS Elements:47]Units:6); 1)
		
	: (Form event code:C388=On Header Click:K2:40)
		C_POINTER:C301($SortVariable_ptr)
		C_TEXT:C284($NameofObj_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		$SortVariable_ptr:=Get pointer:C304($NameofObj_txt)
		
		Case of 
			: ($nameofObj_txt="LB_Header9_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Cond Units:45]; [Cond Units:45]Total Quantity:5; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Cond Units:45]; [Cond Units:45]Total Quantity:5; <)
					$SortVariable_ptr->:=2
					
				End if 
				$0:=-1
			: ($nameofObj_txt="LB_Header7_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY FORMULA:C300([Cond Units:45]; AnglicizeUnit([BMS Elements:47]Units:6); >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY FORMULA:C300([Cond Units:45]; AnglicizeUnit([BMS Elements:47]Units:6); <)
					$SortVariable_ptr->:=2
					
				End if 
				$0:=-1
			: ($nameofObj_txt="LB_Header6_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY FORMULA:C300([Cond Units:45]; LongName; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY FORMULA:C300([Cond Units:45]; LongName; <)
					$SortVariable_ptr->:=2
					
				End if 
				$0:=-1
			: ($nameofObj_txt="LB_Header10_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState1:10; [BMS Elements:47]Units:6); 1); >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState1:10; [BMS Elements:47]Units:6); 1); <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($nameofObj_txt="LB_Header11_l")
				
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState2:11; [BMS Elements:47]Units:6); 1); >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState2:11; [BMS Elements:47]Units:6); 1); <)
					$SortVariable_ptr->:=2
					
				End if 
				
				$0:=-1
			: ($nameofObj_txt="LB_Header12_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState3:12; [BMS Elements:47]Units:6); 1); >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState3:12; [BMS Elements:47]Units:6); 1); <)
					$SortVariable_ptr->:=2
					
				End if 
				$0:=-1
			: ($nameofObj_txt="LB_Header13_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState4:13; [BMS Elements:47]Units:6); 1); >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState4:13; [BMS Elements:47]Units:6); 1); <)
					$SortVariable_ptr->:=2
					
				End if 
				$0:=-1
			: ($nameofObj_txt="LB_Header14_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState5:14; [BMS Elements:47]Units:6); 1); >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY FORMULA:C300([Cond Units:45]; Round:C94(AnglicizeQ([Cond Units:45]CondState5:14; [BMS Elements:47]Units:6); 1); <)
					$SortVariable_ptr->:=2
					
				End if 
				$0:=-1
				
		End case 
		
End case 
//End LB_ProcessCondUnitsQuery