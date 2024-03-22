If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/09/05, 15:38:59
	// ----------------------------------------------------
	// Method: Form Method: [dialogs];"Search Def Element"
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	//declare arrays for pulldowns -for compilation
	
	ARRAY TEXT:C222(cboDefOp; 0)
	ARRAY TEXT:C222(cboDeficiency; 0)
	ARRAY TEXT:C222(cboUrgOp; 0)
	ARRAY TEXT:C222(cboUrgency; 0)
	ARRAY TEXT:C222(cboElmtCondOp; 0)
	ARRAY TEXT:C222(cboElmtCond; 0)
	ARRAY TEXT:C222(cboElmtCondCode; 0)
	ARRAY TEXT:C222(cboDescComparison; 0)
	
	Mods_2004_CM12
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(9/18/09 09:57:22)
	Mods_2009_09
	//  `Additions to include search for word or phrase in Element comments
	// Modified by: costasmanousakis-(Designer)-(11/24/10 12:57:25)
	Mods_2010_11
	//  `Mods for search by element description
	// Modified by: costasmanousakis-(Designer)-(1/18/11 15:59:43)
	Mods_2011_01
	//`RR ;exclude FRZ elements
	// Modified by: Costas Manousakis-(Designer)-(3/3/14 16:51:03)
	Mods_2014_03
	//  `changed the list in the dropdowns for comparison conditions - re-worded them and added the comparison symbols; 
	//  `made dropdowns taller and wider and increased form size
	// Modified by: Costas Manousakis-(Designer)-(10/13/15 13:18:48)
	Mods_2015_10
	//  `Removed object method in cbOpenList - was setting print option
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 18:51:28)
	Mods_2021_12_bug
	//  `clear the ELMTSFILTERED set; initialize flag of filtered elements to false
	// Modified by: Costas Manousakis-(Designer)-(2023-02-23 12:15:27)
	Mods_2023_02
	//  `create empty sets ELMTSFILTERED and DVELMTSFILTERED on load - clear both on unload
End if 
C_OBJECT:C1216(SRC_BridgeElemParams_o)

Case of 
	: (Form event code:C388=On Load:K2:1)
		CREATE EMPTY SET:C140([ElementsSafety:29]; "ELMTSFILTERED")
		CREATE EMPTY SET:C140([ElementsSafety:29]; "DVELMTSFILTERED")
		
		C_TEXT:C284(vDefOp; vUrgOp)  // Command Replaced was o_C_STRING length was 2
		C_TEXT:C284(vDef; vUrg)  // Command Replaced was o_C_STRING length was 5
		C_BOOLEAN:C305(vAddTo; vIncludeComments; vPrintNow)
		C_BOOLEAN:C305(vbAnyCompleted; vbAnyApprvDBIE; vInspApproved)
		C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3
		C_TEXT:C284(vtSearchResultCnt)
		vtSearchResultCnt:=""
		
		cbDeficiency:=elmtSrchDefStat
		cbUrgency:=elmtSrchUrgStat
		cbElmtCond:=elmtSrchCondStat
		cbElementCat:=elmtSrchCatStat
		cbElementTxt:=elmtSrchTxtStat
		cbElemDescTxt:=elmtSrchDescStat
		
		If (OB Is defined:C1231(SRC_BridgeElemParams_o; "SearchType"))
			
			cbDeficiency:=OB Get:C1224(SRC_BridgeElemParams_o; "DefCheckBx"; Is longint:K8:6)
			vDefOp:=OB Get:C1224(SRC_BridgeElemParams_o; "DefOper")
			vDef:=OB Get:C1224(SRC_BridgeElemParams_o; "DefCond")
			OBJECT SET TITLE:C194(*; "DeficiencyDesc"; OB Get:C1224(SRC_BridgeElemParams_o; "DefMessage"))
			
			cbUrgency:=OB Get:C1224(SRC_BridgeElemParams_o; "UrgCheckBx"; Is longint:K8:6)
			vUrgOp:=OB Get:C1224(SRC_BridgeElemParams_o; "UrgOper")
			vUrg:=OB Get:C1224(SRC_BridgeElemParams_o; "UrgCond")
			OBJECT SET TITLE:C194(*; "UrgencyDesc"; OB Get:C1224(SRC_BridgeElemParams_o; "UrgMessage"))
			
			C_TEXT:C284($ElemRtgCode_txt)
			cbElmtCond:=OB Get:C1224(SRC_BridgeElemParams_o; "ElmRatingCheckBx"; Is longint:K8:6)
			vElmtCondOp:=OB Get:C1224(SRC_BridgeElemParams_o; "ElmRatingOper")
			$ElemRtgCode_txt:=OB Get:C1224(SRC_BridgeElemParams_o; "ElmRatingCode")
			OBJECT SET TITLE:C194(*; "RatingDesc"; OB Get:C1224(SRC_BridgeElemParams_o; "ElmRatingMessage"))
			
			cbElementCat:=OB Get:C1224(SRC_BridgeElemParams_o; "ElmCatCheckBx"; Is longint:K8:6)
			cboInspType:=OB Get:C1224(SRC_BridgeElemParams_o; "ElmCategory"; Is longint:K8:6)
			If (OB Get:C1224(SRC_BridgeElemParams_o; "ElmCategory"; Is longint:K8:6)>0)
				//
				CurCat:=aInspCod_{cboInspType}
				SRC_EL_Util("LOADELEM")
				cboelem:=OB Get:C1224(SRC_BridgeElemParams_o; "ElmCode"; Is longint:K8:6)
			End if 
			
			cbElemDescTxt:=OB Get:C1224(SRC_BridgeElemParams_o; "ElemDescrCheckBx"; Is longint:K8:6)
			SRC_ELEMDESC_txt:=OB Get:C1224(SRC_BridgeElemParams_o; "ElemDescr")
			
			cbElementTxt:=OB Get:C1224(SRC_BridgeElemParams_o; "ElemCommentCheckBx"; Is longint:K8:6)
			SRC_ELEMTEXT_txt:=OB Get:C1224(SRC_BridgeElemParams_o; "ElemCommentText")
			cbWholeWord:=OB Get:C1224(SRC_BridgeElemParams_o; "ElemCommentWholeWord"; Is longint:K8:6)
			
			vApprovalLevel:=OB Get:C1224(SRC_BridgeElemParams_o; "ApprovalLevel"; Is longint:K8:6)
			If (False:C215)
				//here for reference only
				OB SET:C1220(SRC_BridgeElemParams_o; \
					"DefCheckBx"; cbDeficiency; \
					"DefOper"; vDefOp; \
					"DefCond"; vDef; \
					"DefMessage"; OBJECT Get title:C1068(*; "DeficiencyDesc"); \
					"UrgCheckBx"; cbUrgency; \
					"UrgOper"; vUrgOp; \
					"UrgCond"; vUrg; \
					"UrgMessage"; OBJECT Get title:C1068(*; "UrgencyDesc"); \
					"ElmRatingCheckBx"; cbElmtCond; \
					"ElmRatingOper"; vElmtCondOp; \
					"ElmRatingCode"; cboElmtCondCode{cboElmtCond}; \
					"ElmRatingMessage"; OBJECT Get title:C1068(*; "RatingDesc"); \
					"ElmCatCheckBx"; cbElementCat; \
					"ElmCategory"; $InspType_L; \
					"ElmCode"; $elem_L; \
					"ElemDescrCheckBx"; cbElemDescTxt; \
					"ElemDescr"; SRC_ELEMDESC_txt; \
					"ElemDescrCond"; $descComp_L; \
					"ElemCommentCheckBx"; cbElementTxt; \
					"ElemCommentText"; SRC_ELEMTEXT_txt; \
					"ElemCommentWholeWord"; cbWholeWord)
				
			End if 
			
		End if 
		If ((cbDeficiency=0) & (cbUrgency=0) & (cbElmtCond=0) & (cbElementCat=0) & (cbElementTxt=0) & (cbElemDescTxt=0))
			SRC_ResetForm
		End if 
		If (cbDeficiency=0)
			OBJECT SET ENABLED:C1123(cboDefOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboDeficiency; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Deficiency"; False:C215)
			vDef:=""
			vDefOp:=""
			cboDefOp:=0
			cboDeficiency:=0
		Else 
			OBJECT SET ENABLED:C1123(cboDefOp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboDeficiency; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Deficiency"; True:C214)
		End if 
		If (cbUrgency=0)
			OBJECT SET ENABLED:C1123(cboUrgOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboUrgency; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Urgency"; False:C215)
			vUrg:=""
			vUrgOp:=""
			cboUrgOp:=0
			cboUrgency:=0
		Else 
			OBJECT SET ENABLED:C1123(cboUrgOp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboUrgency; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Urgency"; True:C214)
		End if 
		If (cbElmtCond=0)
			OBJECT SET ENABLED:C1123(cboElmtCondOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboElmtCond; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Rating"; False:C215)
			LIST TO ARRAY:C288("Rating Categories"; cboElmtCond)
			LIST TO ARRAY:C288("Rating Codes"; cboElmtCondCode)
			vElmtCondOp:=""
			cboElmtCondOp:=0
			cboElmtCond:=0
		Else 
			OBJECT SET ENABLED:C1123(cboElmtCondOp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboElmtCond; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Rating"; True:C214)
			
		End if 
		If (cbElementCat=0)
			SRC_EL_Util("LOADCAT")
			
			//2) Fill the cboElem combo box values --> default value = "ALL"
			
			SRC_EL_Util("LOADELEM")
			
		Else 
			OBJECT SET ENABLED:C1123(cboInspType; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboElem; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
		OBJECT SET ENTERABLE:C238(SRC_ELEMDESC_txt; (cbElemDescTxt=1))
		Case of 
			: (cbElemDescTxt=0)
				cboDescComparison:=0
				OBJECT SET ENABLED:C1123(cboDescComparison; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			: (cbElemDescTxt=1)
				OBJECT SET ENABLED:C1123(cboDescComparison; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End case 
		
		OBJECT SET ENTERABLE:C238(SRC_ELEMTEXT_txt; (cbElementTxt=1))
		Case of 
			: (cbElementTxt=0)
				OBJECT SET ENABLED:C1123(cbWholeWord; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				
			: (cbElementTxt=1)
				OBJECT SET ENABLED:C1123(cbWholeWord; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				cbIncludeComments:=1
				vIncludeComments:=True:C214
				cbPrintNow:=1
				vPrintNow:=True:C214
		End case 
		
		OB SET:C1220(SRC_BridgeElemParams_o; "ElementsFiltered"; False:C215)  //initialize the flag to false
		
	: (Form event code:C388=On Unload:K2:2)
		//C_TEXT($curr_txt)
		//$curr_txt:=OBJECT Get name(Object current)
		//$curr_txt:=OBJECT Get name(Object with focus)
		C_LONGINT:C283($InspType_L; $elem_L; $descComp_L; $elemCondIndx_L; $Approval_L)
		$InspType_L:=cboInspType
		$elem_L:=cboElem
		$descComp_L:=cboDescComparison
		$elemCondIndx_L:=cboElmtCond
		$Approval_L:=VAPPROVALLEVEL
		
		CLEAR SET:C117("ELMTSFILTERED")
		CLEAR SET:C117("DVELMTSFILTERED")
		
		OB SET:C1220(SRC_BridgeElemParams_o; \
			"SearchType"; "BridgeElement"; \
			"ApprovalLevel"; $Approval_L; \
			"DefCheckBx"; cbDeficiency; \
			"DefOper"; vDefOp; \
			"DefCond"; vDef; \
			"DefMessage"; OBJECT Get title:C1068(*; "DeficiencyDesc"); \
			"UrgCheckBx"; cbUrgency; \
			"UrgOper"; vUrgOp; \
			"UrgCond"; vUrg; \
			"UrgMessage"; OBJECT Get title:C1068(*; "UrgencyDesc"); \
			"ElmRatingCheckBx"; cbElmtCond; \
			"ElmRatingOper"; vElmtCondOp; \
			"ElmRatingCode"; cboElmtCondCode{cboElmtCond}; \
			"ElmRatingMessage"; OBJECT Get title:C1068(*; "RatingDesc"); \
			"ElmCatCheckBx"; cbElementCat; \
			"ElmCategory"; $InspType_L; \
			"ElmCode"; $elem_L; \
			"ElemDescrCheckBx"; cbElemDescTxt; \
			"ElemDescr"; SRC_ELEMDESC_txt; \
			"ElemDescrCond"; $descComp_L; \
			"ElemCommentCheckBx"; cbElementTxt; \
			"ElemCommentText"; SRC_ELEMTEXT_txt; \
			"ElemCommentWholeWord"; cbWholeWord)
		
End case 