//%attributes = {"invisible":true}
//Method: LSS_ControlDeficiencyQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/10/19, 12:16:32
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01
End if 
//
C_LONGINT:C283($w)
C_BOOLEAN:C305(vIncludeComments)
C_TEXT:C284(VDEFOP; VURGOP)  // Command Replaced was o_C_STRING length was 2
ARRAY TEXT:C222(CBODEFOP; 0)
C_TEXT:C284(VURG)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(VELMTCONDOP)
ARRAY TEXT:C222(CBOURGENCY; 0)
ARRAY TEXT:C222(CBOURGOP; 0)

ARRAY TEXT:C222(cboInspType; 0)
ARRAY TEXT:C222(cboElem; 0)
ARRAY TEXT:C222(cboUrgency; 0)
ARRAY TEXT:C222(cboDeficiency; 0)
ARRAY TEXT:C222(vApprovalLevel; 0)
C_TEXT:C284(VDEF)  // Command Replaced was o_C_STRING length was 5

C_BLOB:C604(<>HSBlob_blb; <>LIBlob_blb; <>SIBlob_blb; <>ITBlob_blb)

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
ARRAY TEXT:C222(cboElmtCond; 0)
ARRAY TEXT:C222(cboElmtCond; 8)
cboElmtCond{1}:=""
cboElmtCond{2}:="1 Good"
cboElmtCond{3}:="2 Fair"
cboElmtCond{4}:="3 Poor"
cboElmtCond{5}:="4 Critical"
cboElmtCond{6}:="H Hidden/inaccessible"
cboElmtCond{7}:="R Removed"
cboElmtCond{8}:="X Unknown"
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "TotalElmtsFound")
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "FinalElementSet")
CREATE EMPTY SET:C140([LSS_Inspection:164]; "LSSInspectionSet")
CREATE EMPTY SET:C140([LSS_Inventory:165]; "LSS_Inventory")
CREATE EMPTY SET:C140([LSS_Inventory:165]; "LSS_InventorySet")
CREATE EMPTY SET:C140([LSS_Inventory:165]; "InventorySet")


$w:=Open form window:C675("ElementDeficiencyQuery"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)

DIALOG:C40("ElementDeficiencyQuery")
CLOSE WINDOW:C154($w)
//End LSS_ControlDeficiencyQuery