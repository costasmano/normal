//%attributes = {"invisible":true}
//Method: ut_CheckLSSCameraItems
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/19/19, 14:08:51
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03
End if 
//
READ ONLY:C145(*)
If (BLOB size:C605(<>ITBlob_blb)=0)
	ARRAY TEXT:C222(cboInspType; 0)
	
	QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1="IT@"; *)
	QUERY:C277([LSS_refInspectionType:167];  & ; [LSS_refInspectionType:167]LSS_Description_txt:2="Routine")
	LSS_CreateElementArraysForQuery([LSS_refInspectionType:167]LSS_AllowedElements_txt:3; True:C214)
	VARIABLE TO BLOB:C532(v_162_002_atxt; <>ITBlob_blb; *)
	VARIABLE TO BLOB:C532(v_162_001_aL; <>ITBlob_blb; *)
	VARIABLE TO BLOB:C532(LSS_Headers_atxt; <>ITBlob_blb; *)
	VARIABLE TO BLOB:C532(cboInspType; <>ITBlob_blb; *)
	
End if 
C_LONGINT:C283($offset_L)
$offset_L:=0

BLOB TO VARIABLE:C533(<>ITBlob_blb; v_162_002_atxt; $offset_L)
BLOB TO VARIABLE:C533(<>ITBlob_blb; v_162_001_aL; $offset_L)
BLOB TO VARIABLE:C533(<>ITBlob_blb; LSS_Headers_atxt; $offset_L)
BLOB TO VARIABLE:C533(<>ITBlob_blb; cboInspType; $offset_L)

ARRAY TEXT:C222($InspectionIds_atxt; 0)
ARRAY TEXT:C222($InventoryIDs_atxt; 0)
C_TEXT:C284($InspectionID_txt; $InventoryID_txt; $Report_txt; $ReportElements_txt)
ARRAY LONGINT:C221($elements_aL; 0)

CONFIRM:C162("Query for "; "desc camera"; "element = 46")
If (OK=1)
	QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_Description_txt:7="@Camera@")
	
Else 
	QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Category_s:2="ITS")
	SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_InventoryId_s:1; $InventoryIDs_atxt)
	QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InventoryId_s:2; $InventoryIDs_atxt)
	SELECTION TO ARRAY:C260([LSS_Inspection:164]LSS_InspectionId_s:1; $InspectionIds_atxt)
	QUERY WITH ARRAY:C644([LSS_ElementInspection:163]LSS_InspectionId_s:3; $InspectionIds_atxt)
	QUERY SELECTION:C341([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_ElementId_L:2=46)
	
End if 
C_LONGINT:C283($Loop_L; $Pos46_L; $Pos16_L; $Pos78_l; $Pos79_L; $innerloop_L; $Pos_L)

For ($Loop_L; 1; Records in selection:C76([LSS_ElementInspection:163]))
	
	GOTO SELECTED RECORD:C245([LSS_ElementInspection:163]; $Loop_L)
	ARRAY LONGINT:C221($elements_aL; 0)
	CLEAR VARIABLE:C89($elements_aL)
	ARRAY TEXT:C222($elementDescriptions_atxt; 0)
	CLEAR VARIABLE:C89($elementDescriptions_atxt)
	$InspectionID_txt:=[LSS_ElementInspection:163]LSS_InspectionId_s:3
	QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=$InspectionID_txt)
	QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=[LSS_Inspection:164]LSS_InventoryId_s:2)
	
	$ReportElements_txt:=""
	Begin SQL
		select
		[LSS_ElementInspection].[LSS_ElementId_L],
		[LSS_ElementInspection].[LSS_Description_txt]
		from
		[LSS_ElementInspection]
		where
		[LSS_ElementInspection].[LSS_InspectionId_s] = :$InspectionID_txt
		into
		:$elements_aL,
		:$elementDescriptions_atxt;
	End SQL
	
	$Pos46_L:=Find in array:C230($elements_aL; 46)
	$Pos16_L:=Find in array:C230($elements_aL; 16)
	$Pos78_l:=Find in array:C230($elements_aL; 78)
	$Pos79_L:=Find in array:C230($elements_aL; 79)
	Case of 
		: ([LSS_ElementInspection:163]LSS_ElementId_L:2=46)
			$Pos46_L:=0
		: ([LSS_ElementInspection:163]LSS_ElementId_L:2=16)
			$Pos16_L:=0
		: ([LSS_ElementInspection:163]LSS_ElementId_L:2=78)
			$Pos78_l:=0
		: ([LSS_ElementInspection:163]LSS_ElementId_L:2=79)
			$Pos79_L:=0
	End case 
	ARRAY LONGINT:C221($FoundElements_al; 0)
	CLEAR VARIABLE:C89($FoundElements_al)
	ARRAY TEXT:C222($FoundDescriptions_atxt; 0)
	CLEAR VARIABLE:C89($FoundDescriptions_atxt)
	
	If ($Pos46_L>0)
		APPEND TO ARRAY:C911($FoundElements_al; 46)
		APPEND TO ARRAY:C911($FoundDescriptions_atxt; $elementDescriptions_atxt{$Pos46_L})
	End if 
	If ($Pos16_L>0)
		APPEND TO ARRAY:C911($FoundElements_al; 16)
		APPEND TO ARRAY:C911($FoundDescriptions_atxt; $elementDescriptions_atxt{$Pos16_L})
	End if 
	If ($Pos78_l>0)
		APPEND TO ARRAY:C911($FoundElements_al; 78)
		APPEND TO ARRAY:C911($FoundDescriptions_atxt; $elementDescriptions_atxt{$Pos78_l})
	End if 
	If ($Pos79_l>0)
		APPEND TO ARRAY:C911($FoundElements_al; 79)
		APPEND TO ARRAY:C911($FoundDescriptions_atxt; $elementDescriptions_atxt{$Pos79_l})
	End if 
	If (Size of array:C274($FoundElements_al)>0)
		If ($Report_txt="")
			$Report_txt:="Structure Number"+Char:C90(Tab:K15:37)+\
				"Category"+Char:C90(Tab:K15:37)+\
				"Inspection Date"+Char:C90(Tab:K15:37)+\
				"This Element No"+Char:C90(Tab:K15:37)+\
				"Description"+Char:C90(Tab:K15:37)+\
				"Rating"+Char:C90(Tab:K15:37)+\
				"Deficiency"+Char:C90(Tab:K15:37)+\
				"Urgency"+Char:C90(Tab:K15:37)+\
				"Other Elements Number"+Char:C90(Tab:K15:37)+\
				"Internal Description"+Char:C90(Tab:K15:37)+\
				"Inspection Type Description"+Char:C90(Carriage return:K15:38)
		End if 
		$Report_txt:=$Report_txt+[LSS_Inventory:165]LSS_StructureNumber_s:6+Char:C90(Tab:K15:37)+\
			[LSS_Inventory:165]LSS_Category_s:2+Char:C90(Tab:K15:37)+\
			String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4)+Char:C90(Tab:K15:37)+\
			String:C10([LSS_ElementInspection:163]LSS_ElementId_L:2)+Char:C90(Tab:K15:37)+\
			[LSS_ElementInspection:163]LSS_Description_txt:7+Char:C90(Tab:K15:37)+\
			[LSS_ElementInspection:163]LSS_Rating_s:4+Char:C90(Tab:K15:37)+\
			[LSS_ElementInspection:163]LSS_Deficiency_s:5+Char:C90(Tab:K15:37)+\
			[LSS_ElementInspection:163]LSS_Urgency_s:6+Char:C90(Tab:K15:37)
		For ($innerloop_L; 1; Size of array:C274($FoundElements_al))
			$Pos_L:=Find in array:C230(v_162_001_aL; $FoundElements_al{$innerloop_L})
			
			$Report_txt:=$Report_txt+String:C10($FoundElements_al{$innerloop_L})+Char:C90(Tab:K15:37)+\
				$FoundDescriptions_atxt{$innerloop_L}+Char:C90(Tab:K15:37)
			
			If ($Pos_L>0)
				
				$Report_txt:=$Report_txt+v_162_002_atxt{$Pos_L}
			End if 
			If ($innerloop_L=Size of array:C274($FoundElements_al))
				$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
			Else 
				$Report_txt:=$Report_txt+Char:C90(Tab:K15:37)
			End if 
			
		End for 
		
		
		
	End if 
End for 
If ($Report_txt="")
	
Else 
	C_TIME:C306($Doc_tm)
	$Doc_tm:=Create document:C266("")
	
	SEND PACKET:C103($Doc_tm; $Report_txt)
	
	CLOSE DOCUMENT:C267($Doc_tm)
	
End if 
//End ut_CheckLSSCameraItems