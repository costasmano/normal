
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/23/13, 12:44:26
//----------------------------------------------------
//Method: Object Method: Testing.LB1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_05  //r003 ` 
	//Modified by: Charles Miller (5/23/13 17:42:54)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		Compiler_LB
		If (Table name:C256(TableNumber_L)="TableOfLists")
			OBJECT SET VISIBLE:C603(*; "TableofLists@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "TableofLists@"; False:C215)
		End if 
		LISTBOX DELETE COLUMN:C830(*; "LB1"; 1; 999)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		LISTBOX SET TABLE SOURCE:C1013(*; "LB1"; TableNumber_L)
		C_LONGINT:C283($ColumnNumber_l; $Loop_L; $LastFieldNumber_L)
		C_POINTER:C301($HeaderVar_ptr)
		C_TEXT:C284($HeaderVarName_txt; $ColumnName_txt; $ButtonText_txt)
		$ColumnNumber_l:=0
		C_POINTER:C301($Field_ptr; $Button_ptr)
		$Loop_L:=0
		C_BOOLEAN:C305($Complete_b)
		
		$Complete_b:=False:C215
		$LastFieldNumber_L:=Get last field number:C255(TableNumber_L)
		Repeat 
			$Loop_L:=$Loop_L+1
			If ($Loop_L<=$LastFieldNumber_L)
				
				If (Is field number valid:C1000(TableNumber_L; $Loop_L))
					$ColumnNumber_l:=$ColumnNumber_l+1
					$Field_ptr:=Field:C253(TableNumber_L; $Loop_L)
					$ButtonText_txt:=Field name:C257($Field_ptr)
					
					LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
					LISTBOX INSERT COLUMN:C829(*; "LB1"; $ColumnNumber_l; $ColumnName_txt; $Field_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
					$Button_ptr:=Get pointer:C304("LB_Header"+String:C10($ColumnNumber_l)+"_l")
					OBJECT SET TITLE:C194($Button_ptr->; $ButtonText_txt)
					If ($ColumnNumber_l>40)
						$Complete_b:=True:C214
					End if 
				End if 
			Else 
				$Complete_b:=True:C214
			End if 
		Until ($Complete_b)
End case 
//End Object Method: Testing.LB1

