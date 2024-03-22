//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/18/07, 12:21:37
	// ----------------------------------------------------
	// Method: PRJ_BPGM_InitSRCHVars
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/5/2007 14:31:02)
	Mods_2007_CM12_5301  // added File No.
	// Modified by: costasmanousakis-(Designer)-(1/10/09 22:36:53)
	Mods_2009_CM_5404
	//Additions for search by project attribute
	
	// Modified by: costasmanousakis-(Designer)-(1/22/09 22:36:53)
	Mods_2009_CM_5404
	//Additions for search by Expediter, BridgeSectResp
	
End if 
C_TEXT:C284(PRJ_SRCH_TownName_s; PRJ_SRCH_Consltant_s; PRJ_SRCH_Contractor_s; PRJ_SRCH_Program_s; PRJ_SRCH_DistrNo_s; PRJ_SRCH_TotalVars_s)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(PRJ_SRCH_StrPrjMgr_s; PRJ_SRCH_PFile_s)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284(PRJ_SRCH_BDEPT_s)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(PRJ_SRCH_Result_txt)
C_LONGINT:C283(PRJ_SRCH_AttributeKey_l)
C_TEXT:C284(PRJ_SRCH_AttributeKey_txt; PRJ_SRCH_Expediters_txt; PRJ_SRCH_Section_txt)
PRJ_SRCH_Consltant_s:=""
PRJ_SRCH_BDEPT_s:=""
PRJ_SRCH_PFile_s:=""
PRJ_SRCH_TownName_s:=""
PRJ_SRCH_Program_s:=""
PRJ_SRCH_Contractor_s:=""
PRJ_SRCH_DistrNo_s:=""
PRJ_SRCH_StrPrjMgr_s:=""
PRJ_SRCH_Expediters_txt:=""
PRJ_SRCH_Section_txt:=""
PRJ_SRCH_AttributeKey_txt:=""

ARRAY POINTER:C280(PRJ_SRCH_SearchValues_aptr; 11)
PRJ_SRCH_SearchValues_aptr{1}:=->PRJ_SRCH_TownName_s
PRJ_SRCH_SearchValues_aptr{2}:=->PRJ_SRCH_BDEPT_s
PRJ_SRCH_SearchValues_aptr{3}:=->PRJ_SRCH_Program_s
PRJ_SRCH_SearchValues_aptr{4}:=->PRJ_SRCH_Consltant_s
PRJ_SRCH_SearchValues_aptr{5}:=->PRJ_SRCH_Contractor_s
PRJ_SRCH_SearchValues_aptr{6}:=->PRJ_SRCH_DistrNo_s
PRJ_SRCH_SearchValues_aptr{7}:=->PRJ_SRCH_StrPrjMgr_s
PRJ_SRCH_SearchValues_aptr{8}:=->PRJ_SRCH_PFile_s
PRJ_SRCH_SearchValues_aptr{9}:=->PRJ_SRCH_AttributeKey_txt
PRJ_SRCH_SearchValues_aptr{10}:=->PRJ_SRCH_Expediters_txt
PRJ_SRCH_SearchValues_aptr{11}:=->PRJ_SRCH_Section_txt

ARRAY TEXT:C222(PRJ_SRCH_StrPrjMgr_atxt; 0)
ARRAY LONGINT:C221(PRJ_SRCH_StrPrjMgr_al; 0)
COPY ARRAY:C226(PRJ_StructPrjMgr_atxt; PRJ_SRCH_StrPrjMgr_atxt)
COPY ARRAY:C226(PRJ_StructPrjMgrID_al; PRJ_SRCH_StrPrjMgr_al)
INSERT IN ARRAY:C227(PRJ_SRCH_StrPrjMgr_atxt; (Size of array:C274(PRJ_SRCH_StrPrjMgr_atxt)+1))
INSERT IN ARRAY:C227(PRJ_SRCH_StrPrjMgr_al; (Size of array:C274(PRJ_SRCH_StrPrjMgr_al)+1))
PRJ_SRCH_StrPrjMgr_atxt{Size of array:C274(PRJ_SRCH_StrPrjMgr_atxt)}:="None Selected"
PRJ_SRCH_StrPrjMgr_al{Size of array:C274(PRJ_SRCH_StrPrjMgr_al)}:=0
PRJ_SRCH_StrPrjMgr_atxt:=0
PRJ_SRCH_Result_txt:=""

ARRAY TEXT:C222(PRJ_SRCH_Attributes_atxt; 0)
ARRAY LONGINT:C221(PRJ_SRCH_AttributesKey_al; 0)
READ ONLY:C145([PRJ_Attributes:130])
ALL RECORDS:C47([PRJ_Attributes:130])
ORDER BY:C49([PRJ_Attributes:130]; [PRJ_Attributes:130]ATTR_Name_s:2; >)
SELECTION TO ARRAY:C260([PRJ_Attributes:130]ATTR_Name_s:2; PRJ_SRCH_Attributes_atxt; [PRJ_Attributes:130]ATTR_ID_l:1; PRJ_SRCH_AttributesKey_al)

PRJ_SRCH_Expediters_atxt:=0  //this array is loaded from PRJ_LoadDropDownLists

ARRAY TEXT:C222(PRJ_SRCH_Section_atxt; 0)
COPY ARRAY:C226(PRJ_BridgeSection_atxt; PRJ_SRCH_Section_atxt)
PRJ_SRCH_Section_atxt:=0