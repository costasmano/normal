//%attributes = {"invisible":true}
//Method: LSS_AccessibilitySave
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/15/15, 16:51:45
	// ----------------------------------------------------
	//Created : 
	Mods_2015_06
	// Modified by: Costas Manousakis-(Designer)-(9/15/15 16:14:29)
	Mods_2015_09_bug
	//  `Added check for changes in the description.
	//  `fixed pointers $Used_ptr and $Need_ptr: were pointing to wrong variables.
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
	Mods_2016_02_bug  // Add short messagde as this could take some timer as well
	//Modified by: administrator (2/9/16 17:38:07)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
If (LSS_UpdateAccessibility_B)
	SHORT_MESSAGE("Updating accessibility....")  //
	SET QUERY DESTINATION:C396(Into set:K19:2; "AccessibilitySet")
	
	QUERY:C277([LSS_Accessibility:159]; [LSS_Accessibility:159]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	ARRAY LONGINT:C221($Ids_al; 0)
	ARRAY TEXT:C222($Desc_atxt; 0)
	Begin SQL
		select [LSS_AccessibilityElement].[LSS_AccessibilityElementId_L],
		[LSS_AccessibilityElement].[LSS_Description_txt]
		from [LSS_AccessibilityElement]
		into :$Ids_al,
		:$Desc_atxt;
	End SQL
	C_POINTER:C301($Used_ptr; $Need_ptr)
	C_LONGINT:C283($Loop_L)
	C_TEXT:C284($NewDesc_txt)
	
	
	For ($Loop_L; 1; Size of array:C274($Ids_al))
		$Need_ptr:=Get pointer:C304("LSS_AccessibilityNeed"+String:C10($Ids_al{$Loop_L})+"_s")
		$Used_ptr:=Get pointer:C304("LSS_AccessibilityUsed"+String:C10($Ids_al{$Loop_L})+"_s")
		$Need_ptr->:=Replace string:C233($Need_ptr->; "_"; "")
		$Used_ptr->:=Replace string:C233($Used_ptr->; "_"; "")
		
		C_BOOLEAN:C305($DeleteMe_B)
		If ($Ids_al{$Loop_L}#7)
			$NewDesc_txt:=$Desc_atxt{$Loop_L}
			$DeleteMe_B:=True:C214
		Else 
			$NewDesc_txt:=LSSOtherDescription_s
			$DeleteMe_B:=($NewDesc_txt="")
		End if 
		
		USE SET:C118("AccessibilitySet")
		
		QUERY SELECTION:C341([LSS_Accessibility:159]; [LSS_Accessibility:159]LSS_AccessibilityElementId_L:2=$Ids_al{$Loop_L})
		InitChangeStack(2)  //[LSS_Accessibility]
		
		
		Case of 
				
			: ($Used_ptr->="") & ($Need_ptr->="") & ($DeleteMe_B) & (Records in selection:C76([LSS_Accessibility:159])=1)
				C_TEXT:C284($ErrorMethodCalled_txt)
				$ErrorMethodCalled_txt:=Method called on error:C704
				ON ERR CALL:C155("LSS_ErrorMethod")
				LogDeletion(->[LSS_Accessibility:159]LSS_AccessibilityId_s:1; ->[LSS_Accessibility:159]LSS_AccessibilityId_s:1; ->[LSS_Accessibility:159]LSS_AccessibilityId_s:1; 0)
				DELETE RECORD:C58([LSS_Accessibility:159])
				ON ERR CALL:C155($ErrorMethodCalled_txt)
			: ($Need_ptr->=[LSS_Accessibility:159]LSS_Needed_s:4) & ($Used_ptr->=[LSS_Accessibility:159]LSS_Used_s:5) & ($NewDesc_txt=[LSS_Accessibility:159]LSS_AccessibilityDescription_s:6)
				
			Else 
				C_BOOLEAN:C305($DoUpdate_B)
				$DoUpdate_B:=True:C214
				If ($Ids_al{$Loop_L}=7)
					If ($Used_ptr->="") & ($Need_ptr->="") & (LSSOtherDescription_s="")
						$DoUpdate_B:=False:C215
					End if 
				Else 
					If ($Used_ptr->="") & ($Need_ptr->="")
						$DoUpdate_B:=False:C215
					End if 
				End if 
				
				If ($DoUpdate_B)
					C_TEXT:C284($ErrorMethodCalled_txt)
					$ErrorMethodCalled_txt:=Method called on error:C704
					ON ERR CALL:C155("LSS_ErrorMethod")
					If (Records in selection:C76([LSS_Accessibility:159])=0)
						CREATE RECORD:C68([LSS_Accessibility:159])
						[LSS_Accessibility:159]LSS_InspectionId_s:3:=[LSS_Inspection:164]LSS_InspectionId_s:1
						[LSS_Accessibility:159]LSS_AccessibilityElementId_L:2:=$Ids_al{$Loop_L}
						C_LONGINT:C283($Key_L)
						Inc_Sequence("LSS_AccessibilityId_s"; ->$Key_L)
						
						[LSS_Accessibility:159]LSS_AccessibilityId_s:1:=String:C10($Key_L; <>KeyMask_s)
						LogNewRecord(->[LSS_Accessibility:159]LSS_AccessibilityId_s:1; ->[LSS_Accessibility:159]LSS_AccessibilityId_s:1; ->[LSS_Accessibility:159]LSS_AccessibilityId_s:1; 0; "LSS_Accessibility")
					End if 
					If ($Ids_al{$Loop_L}=7)
						[LSS_Accessibility:159]LSS_AccessibilityDescription_s:6:=LSSOtherDescription_s
					Else 
						[LSS_Accessibility:159]LSS_AccessibilityDescription_s:6:=$Desc_atxt{$Loop_L}
					End if 
					
					[LSS_Accessibility:159]LSS_Needed_s:4:=$Need_ptr->
					[LSS_Accessibility:159]LSS_Used_s:5:=$Used_ptr->
					ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
					APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_AccessibilityId_s")
					
					If (ACT_PushGroupChanges(Table:C252(->[LSS_Accessibility:159]); 2; ->$FieldsToSkip_atxt))
						FlushGrpChgs(2; ->[LSS_Accessibility:159]LSS_AccessibilityId_s:1; ->[LSS_Accessibility:159]LSS_AccessibilityId_s:1; ->[LSS_Accessibility:159]LSS_AccessibilityId_s:1; 0)
						SAVE RECORD:C53([LSS_Accessibility:159])
					End if 
				End if 
				ON ERR CALL:C155($ErrorMethodCalled_txt)
		End case 
		
	End for 
	CLEAR SET:C117("AccessibilitySet")
	CLOSE WINDOW:C154
End if 
//End LSS_AccessibilitySave