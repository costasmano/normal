//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/02/07, 20:33:01
	// ----------------------------------------------------
	// Method: PRJ_ExpProjUpdate
	// Description
	// <caret/>
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM10a
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_TEXT:C284(PRJ_ProjisTotalPgs_s)  // Command Replaced was o_C_STRING length was 10
PRJ_ProjisTotalPgs_s:=Request:C163("Enter total number of Projis Pages"; PRJ_ProjisTotalPgs_s)

C_TEXT:C284(XMLRowTxt_txt; $XMLHdr_txt; $XMLFtr_txt; XMLRowMod_txt)
XMLRowTxt_txt:=""
$XMLHdr_txt:=""
$XMLFtr_txt:=""
READ ONLY:C145([Parameters:107])
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="XML_ProjInfoUpd_HDR")
$XMLHdr_txt:=[Parameters:107]Description:2
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="XML_ProjInfoUpd_FTR")
$XMLFtr_txt:=[Parameters:107]Description:2
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="XML_ProjInfoUpd_ROW")
XMLRowTxt_txt:=[Parameters:107]Description:2

C_TIME:C306($DocRef_t)
$DocRef_t:=Create document:C266("")
If (Ok=1)
	SEND PACKET:C103($DocRef_t; $XMLHdr_txt)
	READ ONLY:C145([PRJ_ProjectDetails:115])
	FIRST RECORD:C50([PRJ_ProjectDetails:115])
	COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "XMLExportSelection")
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	C_LONGINT:C283($i)
	For ($i; 1; Records in selection:C76([PRJ_ProjectDetails:115]))
		GOTO SELECTED RECORD:C245([PRJ_ProjectDetails:115]; $i)
		PRJ_ProjUpdPrepRow
		SEND PACKET:C103($DocRef_t; XMLRowMod_txt)
		If (False:C215)
			USE NAMED SELECTION:C332("XMLExportSelection")
			NEXT RECORD:C51([PRJ_ProjectDetails:115])
			COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "XMLExportSelection")
		End if 
	End for 
	CLEAR NAMED SELECTION:C333("XMLExportSelection")
	READ WRITE:C146([PRJ_ProjectDetails:115])
	SEND PACKET:C103($DocRef_t; $XMLFtr_txt)
	CLOSE DOCUMENT:C267($DocRef_t)
	
	//_ O _SET DOCUMENT TYPE(Document;"XLS8")
	//_ O _SET DOCUMENT CREATOR(Document;"XCEL")
End if 
XMLRowTxt_txt:=""
$XMLHdr_txt:=""
$XMLFtr_txt:=""
XMLRowMod_txt:=""