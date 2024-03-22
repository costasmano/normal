//%attributes = {"invisible":true}
//Method: ut_CheckLSSElements
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/19/19, 12:19:23
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03
End if 
//
C_BLOB:C604(<>HSBlob_blb; <>LIBlob_blb; <>SIBlob_blb; <>ITBlob_blb)
Compiler_FieldVariables
If (BLOB size:C605(<>HSBlob_blb)=0)
	ARRAY TEXT:C222(cboInspType; 0)
	
	QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1="HS@"; *)
	QUERY:C277([LSS_refInspectionType:167];  & ; [LSS_refInspectionType:167]LSS_Description_txt:2="Routine")
	LSS_CreateElementArraysForQuery([LSS_refInspectionType:167]LSS_AllowedElements_txt:3; True:C214)
	VARIABLE TO BLOB:C532(v_162_002_atxt; <>HSBlob_blb; *)
	VARIABLE TO BLOB:C532(v_162_001_aL; <>HSBlob_blb; *)
	VARIABLE TO BLOB:C532(LSS_Headers_atxt; <>HSBlob_blb; *)
	VARIABLE TO BLOB:C532(cboInspType; <>HSBlob_blb; *)
End if 

If (BLOB size:C605(<>LIBlob_blb)=0)
	ARRAY TEXT:C222(cboInspType; 0)
	
	QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1="LI@"; *)
	QUERY:C277([LSS_refInspectionType:167];  & ; [LSS_refInspectionType:167]LSS_Description_txt:2="Routine")
	LSS_CreateElementArraysForQuery([LSS_refInspectionType:167]LSS_AllowedElements_txt:3; True:C214)
	VARIABLE TO BLOB:C532(v_162_002_atxt; <>LIBlob_blb; *)
	VARIABLE TO BLOB:C532(v_162_001_aL; <>LIBlob_blb; *)
	VARIABLE TO BLOB:C532(LSS_Headers_atxt; <>LIBlob_blb; *)
	VARIABLE TO BLOB:C532(cboInspType; <>LIBlob_blb; *)
End if 

If (BLOB size:C605(<>SIBlob_blb)=0)
	ARRAY TEXT:C222(cboInspType; 0)
	
	QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1="SI@"; *)
	QUERY:C277([LSS_refInspectionType:167];  & ; [LSS_refInspectionType:167]LSS_Description_txt:2="Routine")
	LSS_CreateElementArraysForQuery([LSS_refInspectionType:167]LSS_AllowedElements_txt:3; True:C214)
	VARIABLE TO BLOB:C532(v_162_002_atxt; <>SIBlob_blb; *)
	VARIABLE TO BLOB:C532(v_162_001_aL; <>SIBlob_blb; *)
	VARIABLE TO BLOB:C532(LSS_Headers_atxt; <>SIBlob_blb; *)
	VARIABLE TO BLOB:C532(cboInspType; <>SIBlob_blb; *)
End if 

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

CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "TotalElmtsFound")
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "FinalElementSet")
CREATE EMPTY SET:C140([LSS_Inspection:164]; "LSSInspectionSet")
ARRAY LONGINT:C221($MissingElements_aL; 0)
ARRAY TEXT:C222($MissingElementCategories_atxt; 0)


C_TEXT:C284($Category_txt)
C_LONGINT:C283($offset_L)
C_LONGINT:C283($Loop_L; $InnerLoop_L)
For ($Loop_L; 1; 4)
	$offset_L:=0
	Case of 
		: ($Loop_L=1)  //sign
			BLOB TO VARIABLE:C533(<>HSBlob_blb; v_162_002_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>HSBlob_blb; v_162_001_aL; $offset_L)
			BLOB TO VARIABLE:C533(<>HSBlob_blb; LSS_Headers_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>HSBlob_blb; cboInspType; $offset_L)
			
			$Category_txt:="Sign"
		: ($Loop_L=2)  //ITS
			BLOB TO VARIABLE:C533(<>ITBlob_blb; v_162_002_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>ITBlob_blb; v_162_001_aL; $offset_L)
			BLOB TO VARIABLE:C533(<>ITBlob_blb; LSS_Headers_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>ITBlob_blb; cboInspType; $offset_L)
			
			$Category_txt:="ITS"
		: ($Loop_L=3)  //signal
			BLOB TO VARIABLE:C533(<>SIBlob_blb; v_162_002_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>SIBlob_blb; v_162_001_aL; $offset_L)
			BLOB TO VARIABLE:C533(<>SIBlob_blb; LSS_Headers_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>SIBlob_blb; cboInspType; $offset_L)
			
			$Category_txt:="Signal"
		: ($Loop_L=4)  //Light
			BLOB TO VARIABLE:C533(<>LIBlob_blb; v_162_002_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>LIBlob_blb; v_162_001_aL; $offset_L)
			BLOB TO VARIABLE:C533(<>LIBlob_blb; LSS_Headers_atxt; $offset_L)
			BLOB TO VARIABLE:C533(<>LIBlob_blb; cboInspType; $offset_L)
			
			$Category_txt:="Light"
			
			
			
	End case 
	ARRAY TEXT:C222($InventoryIDs_atxt; 0)
	CLEAR VARIABLE:C89($InventoryIDs_atxt)
	Begin SQL
		
		select
		[LSS_Inventory].[LSS_InventoryId_s]
		from
		[LSS_Inventory]
		where
		[LSS_Inventory].[LSS_Category_s] = :$Category_txt
		into
		:$InventoryIDs_atxt;
		
		
		
		
	End SQL
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "LSSInspectionSet")
	QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InventoryId_s:2; $InventoryIDs_atxt)
	USE SET:C118("LSSInspectionSet")
	ARRAY TEXT:C222($InspectionIDs_atxt; 0)
	CLEAR VARIABLE:C89($InspectionIDs_atxt)
	
	SELECTION TO ARRAY:C260([LSS_Inspection:164]LSS_InspectionId_s:1; $InspectionIDs_atxt)
	SET QUERY DESTINATION:C396(Into set:K19:2; "TotalElmtsFound")
	QUERY WITH ARRAY:C644([LSS_ElementInspection:163]LSS_InspectionId_s:3; $InspectionIDs_atxt)
	USE SET:C118("TotalElmtsFound")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	ARRAY LONGINT:C221($DistinctElements_aL; 0)
	CLEAR VARIABLE:C89($DistinctElements_aL)
	DISTINCT VALUES:C339([LSS_ElementInspection:163]LSS_ElementId_L:2; $DistinctElements_aL)
	
	
	For ($InnerLoop_L; 1; Size of array:C274($DistinctElements_aL))
		If (Find in array:C230(v_162_001_aL; $DistinctElements_aL{$InnerLoop_L})>0)
		Else 
			APPEND TO ARRAY:C911($MissingElements_aL; $DistinctElements_aL{$InnerLoop_L})
			APPEND TO ARRAY:C911($MissingElementCategories_atxt; $Category_txt)
			SET QUERY DESTINATION:C396(Into set:K19:2; "InterimSet")
			USE SET:C118("TotalElmtsFound")
			QUERY SELECTION:C341([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_ElementId_L:2=$DistinctElements_aL{$InnerLoop_L})
			UNION:C120("InterimSet"; "FinalElementSet"; "FinalElementSet")
			
			
		End if 
		
		
	End for 
	
	
	//v_162_001_aL element numbers
	
End for 
C_TEXT:C284($Report_txt)
For ($Loop_L; 1; Size of array:C274($MissingElements_aL))
	$Report_txt:=$Report_txt+$MissingElementCategories_atxt{$Loop_L}+Char:C90(Tab:K15:37)+String:C10($MissingElements_aL{$Loop_L})+Char:C90(Carriage return:K15:38)
End for 

C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266("")
SEND PACKET:C103($Doc_tm; $Report_txt)
CLOSE DOCUMENT:C267($Doc_tm)
USE SET:C118("FinalElementSet")
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)

QR REPORT:C197([LSS_ElementInspection:163]; Char:C90(1))


//End ut_CheckLSSElements