//Method: ElementDeficiencyQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 16:32:37
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		COPY NAMED SELECTION:C331([LSS_Inventory:165]; "StartingSelection")
		
		ARRAY TEXT:C222(v_171_004_atxt; 0)
		APPEND TO ARRAY:C911(v_171_004_atxt; "Select Ancillary Structure Type")
		APPEND TO ARRAY:C911(v_171_004_atxt; "ITS")
		APPEND TO ARRAY:C911(v_171_004_atxt; "Light")
		APPEND TO ARRAY:C911(v_171_004_atxt; "Sign")
		APPEND TO ARRAY:C911(v_171_004_atxt; "Signal")
		v_171_004_atxt:=1
		LSS_ClearForNewQuery
		vtSearchResultCnt:=""
		CREATE EMPTY SET:C140([LSS_Inspection:164]; "LSSInspectionSet")
		CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "FinalElementSet")
		OBJECT SET ENABLED:C1123(cboDefOp; Not:C34(cbDeficiency=0))
		OBJECT SET ENABLED:C1123(cboDeficiency; Not:C34(cbDeficiency=0))
		OBJECT SET ENABLED:C1123(cboUrgOp; Not:C34(cbUrgency=0))
		OBJECT SET ENABLED:C1123(cboUrgency; Not:C34(cbUrgency=0))
		OBJECT SET ENABLED:C1123(cboElmtCondOp; Not:C34(cbElmtCond=0))
		OBJECT SET ENABLED:C1123(cboElmtCond; Not:C34(cbElmtCond=0))
		OBJECT SET ENABLED:C1123(cboInspType; Not:C34(cbElementCat=0))
		OBJECT SET ENABLED:C1123(cboElem; Not:C34(cbElementCat=0))
		OBJECT SET ENABLED:C1123(cboDescComparison; Not:C34(cbElemDescTxt=0))
		OBJECT SET ENTERABLE:C238(SRC_ELEMDESC_txt; Not:C34(cbElemDescTxt=0))
		
		OBJECT SET ENABLED:C1123(cbDeficiency; False:C215)
		OBJECT SET ENABLED:C1123(cbUrgency; False:C215)
		OBJECT SET ENABLED:C1123(cbElmtCond; False:C215)
		OBJECT SET ENABLED:C1123(cbElementCat; False:C215)
		OBJECT SET ENABLED:C1123(cbElemDescTxt; False:C215)
		OBJECT SET ENABLED:C1123(*; "ApprovalLevel"; False:C215)
		C_BOOLEAN:C305(vIncludeComments)
		vIncludeComments:=False:C215
		
		
End case 
//End ElementDeficiencyQuery