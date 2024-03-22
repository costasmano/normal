//Method: ElementDeficiencyQuery.v_171_004_atxt1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 17:02:58
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//

If (v_171_004_atxt>1)
	LSS_ClearForNewQuery
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	C_LONGINT:C283($offset_L)
	$offset_L:=0
	ARRAY TEXT:C222(v_162_002_atxt; 0)
	ARRAY TEXT:C222(LSS_Headers_atxt; 0)
	ARRAY TEXT:C222(cboInspType; 0)
	ARRAY LONGINT:C221(v_162_001_aL; 0)
	C_TEXT:C284($REFInspType_txt)
	Case of 
		: (v_171_004_atxt{v_171_004_atxt}="Sign")
			BLOB TO VARIABLE:C533(<>HSBlob_blb; v_162_002_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>HSBlob_blb; v_162_001_aL; $offset_L)
			BLOB TO VARIABLE:C533(<>HSBlob_blb; LSS_Headers_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>HSBlob_blb; cboInspType; $offset_L)
			$REFInspType_txt:="HS%"
		: (v_171_004_atxt{v_171_004_atxt}="ITS")
			BLOB TO VARIABLE:C533(<>ITBlob_blb; v_162_002_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>ITBlob_blb; v_162_001_aL; $offset_L)
			BLOB TO VARIABLE:C533(<>ITBlob_blb; LSS_Headers_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>ITBlob_blb; cboInspType; $offset_L)
			$REFInspType_txt:="IT%"
			
		: (v_171_004_atxt{v_171_004_atxt}="Signal")
			BLOB TO VARIABLE:C533(<>SIBlob_blb; v_162_002_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>SIBlob_blb; v_162_001_aL; $offset_L)
			BLOB TO VARIABLE:C533(<>SIBlob_blb; LSS_Headers_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>SIBlob_blb; cboInspType; $offset_L)
			$REFInspType_txt:="SI%"
			
			
		: (v_171_004_atxt{v_171_004_atxt}="Light")
			BLOB TO VARIABLE:C533(<>LIBlob_blb; v_162_002_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>LIBlob_blb; v_162_001_aL; $offset_L)
			BLOB TO VARIABLE:C533(<>LIBlob_blb; LSS_Headers_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>LIBlob_blb; cboInspType; $offset_L)
			$REFInspType_txt:="LI%"
			
	End case 
	
	
	//QUERY([LSS_refInspectionType]; & ;[LSS_refInspectionType]LSS_Description_txt="Routine")
	//LSS_CreateElementArraysForQuery ([LSS_refInspectionType]LSS_AllowedElements_txt;True)
	//lets get the appropriate inspection snad put them in a set
	C_TEXT:C284($Category_txt)
	$Category_txt:=v_171_004_atxt{v_171_004_atxt}
	ARRAY TEXT:C222($InventoryIDs_atxt; 0)
	C_LONGINT:C283($Loop_l)
	C_TEXT:C284($DistrictTitle_txt)
	ARRAY TEXT:C222($MenuDiscriptor_atxt; 0)
	ARRAY TEXT:C222($MenuSelected_atxt; 0)
	ARRAY TEXT:C222($MenuDiscriptor_atxt; 7)
	ARRAY TEXT:C222($MenuSelected_atxt; 7)
	$MenuDiscriptor_atxt{1}:="ALL"
	$MenuSelected_atxt{1}:="ALL"
	For ($Loop_l; 2; 7)
		$MenuDiscriptor_atxt{$Loop_L}:="District "+String:C10($Loop_l-1)
		$MenuSelected_atxt{$Loop_L}:=String:C10($Loop_l-1)
	End for 
	C_LONGINT:C283($l; $t; $r; $b)
	C_TEXT:C284($menuref_txt; $selected_txt)
	OBJECT GET COORDINATES:C663(*; "v_171_004_atxt"; $l; $t; $r; $b)
	
	
	
	$menuref_txt:=MENU_BuildMenuFromArrays(->$MenuDiscriptor_atxt; ->$MenuSelected_atxt; "\\")
	$selected_txt:=Dynamic pop up menu:C1006($menuref_txt; "ALL"; $r+30; $t)
	RELEASE MENU:C978($menuref_txt)
	ARRAY TEXT:C222($REFInspTypeIDs_atxt; 0)
	
	If ($selected_txt="ALL")
		$DistrictTitle_txt:="ALL"
		
		Begin SQL
			select
			[LSS_Inventory].[LSS_InventoryId_s]
			from
			[LSS_Inventory]
			where
			[LSS_Inventory].[LSS_Category_s] = :$Category_txt
			into
			:$InventoryIDs_atxt;
			
			select [LSS_refInspectionType].[LSS_InspectionTypeId_s]
			from
			[LSS_refInspectionType]
			where
			[LSS_refInspectionType].[LSS_InspectionTypeId_s] like :$REFInspType_txt
			and 
			([LSS_refInspectionType].[LSS_Description_txt] = 'Routine'
			or 
			[LSS_refInspectionType].[LSS_Description_txt] = 'Initial')
			into 
			:$REFInspTypeIDs_atxt;
		End SQL
		
	Else 
		$Loop_l:=Num:C11($selected_txt)
		$DistrictTitle_txt:="District "+$selected_txt
		Begin SQL
			select
			[LSS_Inventory].[LSS_InventoryId_s]
			from
			[LSS_Inventory]
			where
			[LSS_Inventory].[LSS_Category_s] = :$Category_txt
			AND
			[LSS_Inventory].[LSS_District_L] = :$Loop_l
			into
			:$InventoryIDs_atxt;
			
			
			select [LSS_refInspectionType].[LSS_InspectionTypeId_s]
			from
			[LSS_refInspectionType]
			where
			[LSS_refInspectionType].[LSS_InspectionTypeId_s] like :$REFInspType_txt
			and 
			([LSS_refInspectionType].[LSS_Description_txt] = 'Routine'
			or 
			[LSS_refInspectionType].[LSS_Description_txt] = 'Initial')
			into 
			:$REFInspTypeIDs_atxt;
		End SQL
		
		
	End if 
	
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "InspectionStartSet")
	CREATE EMPTY SET:C140([LSS_Inspection:164]; "LSSInspectionSet")
	QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InventoryId_s:2; $InventoryIDs_atxt)
	USE SET:C118("InspectionStartSet")
	QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Complete_b:39=True:C214; *)
	QUERY SELECTION:C341([LSS_Inspection:164];  | ; [LSS_Inspection:164]LSS_Approved_L:43=BMS Approved)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	USE SET:C118("InspectionStartSet")
	C_TEXT:C284($Message_txt)
	$Message_txt:=""
	
	DISTINCT VALUES:C339([LSS_Inspection:164]LSS_InventoryId_s:2; $InventoryIDs_atxt)
	ARRAY LONGINT:C221($RecordNumbers_aL; 0)
	C_LONGINT:C283($INVLoop_L; $INSPLoop_L; $Progress_L)
	$Progress_L:=Progress New
	Progress SET TITLE($progress_L; "Selecting Inspection records for "+String:C10(Size of array:C274($InventoryIDs_atxt))+" Inventory records")
	ARRAY TEXT:C222(v_164_002_atxt; 0)
	ARRAY LONGINT:C221(InspectionRecs_AL; 0; 0)
	For ($INVLoop_L; 1; Size of array:C274($InventoryIDs_atxt))
		C_LONGINT:C283($pos_L)
		Progress SET PROGRESS($Progress_L; $INVLoop_L/Size of array:C274($InventoryIDs_atxt))
		USE SET:C118("InspectionStartSet")
		QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InventoryId_s:2=$InventoryIDs_atxt{$INVLoop_L})
		ORDER BY:C49([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionDate_d:4; <)
		$INSPLoop_L:=1
		C_BOOLEAN:C305($Complete_B)
		$Complete_B:=False:C215
		C_LONGINT:C283($Norecords_L)
		$Norecords_L:=Records in selection:C76([LSS_Inspection:164])
		C_LONGINT:C283($Size_L)
		C_BOOLEAN:C305($Append_B)
		
		If ($Norecords_L>1)
			
			$Append_B:=True:C214
			Repeat 
				
				GOTO SELECTED RECORD:C245([LSS_Inspection:164]; $INSPLoop_L)
				If (Find in array:C230($REFInspTypeIDs_atxt; [LSS_Inspection:164]LSS_InspectionTypeId_s:3)>0)
					$Complete_B:=True:C214
				End if 
				APPEND TO ARRAY:C911($RecordNumbers_aL; Record number:C243([LSS_Inspection:164]))
				
				$pos_L:=Find in array:C230(v_164_002_atxt; [LSS_Inspection:164]LSS_InventoryId_s:2)
				If ($pos_L>0)
					
				Else 
					If ($Complete_B) & ($INSPLoop_L=1)
						$Append_B:=False:C215
					Else 
						If ($INSPLoop_L=1)
							$Size_L:=Size of array:C274(InspectionRecs_AL)
							INSERT IN ARRAY:C227(InspectionRecs_AL; $Size_L+1)
						End if 
						APPEND TO ARRAY:C911(v_164_002_atxt; [LSS_Inspection:164]LSS_InventoryId_s:2)
						
					End if 
				End if 
				$INSPLoop_L:=$INSPLoop_L+1
				If ($Append_B)
					INSERT IN ARRAY:C227(InspectionRecs_AL{$Size_L+1}; $INSPLoop_L-1)
					InspectionRecs_AL{$Size_L+1}{$INSPLoop_L-1}:=Record number:C243([LSS_Inspection:164])
				End if 
			Until ($Complete_B | ($INSPLoop_L>Records in selection:C76([LSS_Inspection:164])))
		Else 
			GOTO SELECTED RECORD:C245([LSS_Inspection:164]; $INSPLoop_L)
			APPEND TO ARRAY:C911($RecordNumbers_aL; Record number:C243([LSS_Inspection:164]))
		End if 
	End for 
	If (Not:C34(Is compiled mode:C492))
		QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_InventoryId_s:1; v_164_002_atxt)
		ARRAY TEXT:C222($Structures_atxt; 0)
		SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_StructureNumber_s:6; $Structures_atxt)
		For ($Loop_l; 1; Size of array:C274($Structures_atxt))
			
			If ($Loop_l=Size of array:C274($Structures_atxt))
				$Message_txt:=$Message_txt+$Structures_atxt{$Loop_L}
			Else 
				
				$Message_txt:=$Message_txt+$Structures_atxt{$Loop_L}+","
				
			End if 
		End for 
		If ($Message_txt#"")
			ALERT:C41("The following structures have more than one inspection being considered and has been set to the pasteboard."+Char:C90(Carriage return:K15:38)+$Message_txt)
			SET TEXT TO PASTEBOARD:C523($Message_txt)
		End if 
	End if 
	Progress QUIT($progress_L)
	CREATE SELECTION FROM ARRAY:C640([LSS_Inspection:164]; $RecordNumbers_aL)
	CREATE SET:C116([LSS_Inspection:164]; "LSSInspectionSet")  //all potential inspections
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	USE SET:C118("LSSInspectionSet")
	DISTINCT VALUES:C339([LSS_Inspection:164]LSS_InventoryId_s:2; $InventoryIDs_atxt)
	ARRAY TEXT:C222($InspectionIDs_atxt; 0)
	DISTINCT VALUES:C339([LSS_Inspection:164]LSS_InspectionId_s:1; $InspectionIDs_atxt)
	SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_StartElementSet")
	QUERY WITH ARRAY:C644([LSS_ElementInspection:163]LSS_InspectionId_s:3; $InspectionIDs_atxt)
	C_BOOLEAN:C305($Enabled_B)
	$Enabled_B:=(Records in set:C195("LSSInspectionSet")>0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	OBJECT SET ENABLED:C1123(cbDeficiency; $Enabled_B)
	OBJECT SET ENABLED:C1123(cbUrgency; $Enabled_B)
	OBJECT SET ENABLED:C1123(cbElmtCond; $Enabled_B)
	OBJECT SET ENABLED:C1123(cbElementCat; $Enabled_B)
	OBJECT SET ENABLED:C1123(cbElemDescTxt; $Enabled_B)
	OBJECT SET ENABLED:C1123(*; "ApprovalLevel"; $Enabled_B)
	
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_Inventory")
	QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_InventoryId_s:1; $InventoryIDs_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$DistrictTitle_txt:=$DistrictTitle_txt+": "+String:C10(Records in set:C195("LSS_Inventory"))+" Inventory records"
	OBJECT SET TITLE:C194(*; "DistrictTitle"; $DistrictTitle_txt)
	
	
End if 

//End ElementDeficiencyQuery.v_171_004_atxt1