//%attributes = {"invisible":true}
// ----------------------------------------------------
// Compiler_PRJArrays
// User name (OS): cjmiller
// Date and time: 10/02/07, 11:48:13
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5302  //r001 `10/02/07, 11:48:15
	Mods_2008_December  //CJM `r001    `12/17/08, 13:01:38 `Add new page to project input form with project file and design contract information    
	Mods_2013_01  //r001 ` ` Modify PRJ_BridgeSection_atxt so that first element read Technical Review. Additionally made that and PRJProjectTabs_as and PRJ_DefaultPage_atxt use table of lists
	//Modified by: Charles Miller (2/5/13 10:37:35)
End if 
ARRAY TEXT:C222(PRJ_ProjectTypes_atxt; 0)
ARRAY TEXT:C222(PRJ_StructReviewers_atxt; 0)
ARRAY LONGINT:C221(PRJ_StructReviewersID_al; 0)
ARRAY TEXT:C222(PRJ_StructPrjMgr_atxt; 0)
ARRAY LONGINT:C221(PRJ_StructPrjMgrID_al; 0)

ARRAY TEXT:C222(PRJ_ConsultantReviewers_atxt; 0)
ARRAY LONGINT:C221(PRJ_ConsultantReviewersID_al; 0)

ARRAY TEXT:C222(PRJProjectTabs_as; 0)  //Command Replaced was o_ARRAY string length was 17
ARRAY TEXT:C222(PRJ_DetailHead_atxt; 0)
ARRAY TEXT:C222(PRJ_Detail_atxt; 0)
ARRAY TEXT:C222(PRJ_BridgeSection_atxt; 0)



ARRAY DATE:C224(PRJ_Attribute_ad; 0)
ARRAY TEXT:C222(PRJ_AttributeDescription_atxt; 0)
ARRAY TEXT:C222(PRJ_ConsultantFNames_atxt; 0)
ARRAY TEXT:C222(PRJ_ConsultantLNames_atxt; 0)
ARRAY LONGINT:C221(PRJ_ConsultantIDs_al; 0)
ARRAY LONGINT:C221(PRJ_ConsultantID_al; 0)
ARRAY TEXT:C222(PRJ_ConsultantName_atxt; 0)


ARRAY TEXT:C222(PRJ_DefaultPage_atxt; 0)
ARRAY TEXT:C222(PRJ_RTRV_ContractNo_atxt; 0)
ARRAY TEXT:C222(PRJ_StructProjMgr_atxt; 0)
ARRAY TEXT:C222(Group_atxt; 0)
ARRAY TEXT:C222(Type_atxt; 0)
ARRAY TEXT:C222(Bin_atxt; 0)
ARRAY LONGINT:C221(PRJBackGroundColor_aL; 0)
ARRAY TEXT:C222(BinDescP2_atxt; 0)



//End Compiler_PRJArrays