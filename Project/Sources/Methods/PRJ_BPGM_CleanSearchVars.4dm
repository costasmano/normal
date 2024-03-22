//%attributes = {"invisible":true}

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/25/07, 19:42:37
	// ----------------------------------------------------
	// Method: PRJ_BPGM_CleanSearchVars
	// Description
	// Clean the search vars from the custom search form.
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 12:29:40)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/5/2007 14:32:02)
	Mods_2007_CM12_5301  //added FileNo
	// Modified by: costasmanousakis-(Designer)-(1/23/09 12:35:23)
	Mods_2009_CM_5404
	//Additions for search by Expediter, BridgeSectResp , Attribute
	
End if 
PRJ_SRCH_BDEPT_s:=Replace string:C233(PRJ_SRCH_BDEPT_s; " "; "")
PRJ_SRCH_BDEPT_s:=Replace string:C233(PRJ_SRCH_BDEPT_s; "_"; "")
PRJ_SRCH_PFile_s:=f_TrimStr(PRJ_SRCH_PFile_s; True:C214; True:C214)
PRJ_SRCH_TownName_s:=f_TrimStr(PRJ_SRCH_TownName_s; True:C214; True:C214)
PRJ_SRCH_Program_s:=f_TrimStr(PRJ_SRCH_Program_s; True:C214; True:C214)
PRJ_SRCH_Consltant_s:=f_TrimStr(PRJ_SRCH_Consltant_s; True:C214; True:C214)
PRJ_SRCH_Contractor_s:=f_TrimStr(PRJ_SRCH_Contractor_s; True:C214; True:C214)
PRJ_SRCH_AttributeKey_txt:=f_TrimStr(PRJ_SRCH_AttributeKey_txt; True:C214; True:C214)
//PRJ_SRCH_DistrNo_s:=PRJ_SRCH_DistrNo_s;True;True)
PRJ_SRCH_TotalVars_s:=PRJ_SRCH_BDEPT_s+PRJ_SRCH_PFile_s+PRJ_SRCH_TownName_s+PRJ_SRCH_Program_s
PRJ_SRCH_TotalVars_s:=PRJ_SRCH_TotalVars_s+PRJ_SRCH_Consltant_s+PRJ_SRCH_Contractor_s+PRJ_SRCH_DistrNo_s
PRJ_SRCH_TotalVars_s:=PRJ_SRCH_TotalVars_s+PRJ_SRCH_StrPrjMgr_s+PRJ_SRCH_AttributeKey_txt
PRJ_SRCH_TotalVars_s:=PRJ_SRCH_TotalVars_s+PRJ_SRCH_Expediters_txt+PRJ_SRCH_Section_txt