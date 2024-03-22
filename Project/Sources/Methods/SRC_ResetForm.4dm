//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/11/05, 07:20:04
	// ----------------------------------------------------
	// Method: SRC_ResetForm
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------		
	
	// Modified by: costasmanousakis-(Designer)-(9/18/09 09:57:22)
	Mods_2009_09
	//  `Additions to include search for word or phrase in Element comments
	// Modified by: costasmanousakis-(Designer)-(11/24/10 14:01:12)
	Mods_2010_11
	//  `Mods for search by element description
	// Modified by: costasmanousakis-(Designer)-(1/18/11 15:56:03)
	Mods_2011_01
	//`RR ; exclude FRZ
	
End if 
vDef:=""
vDefOp:=""
cboDefOp:=0
cboDeficiency:=0

vUrg:=""
vUrgOp:=""
cboUrgOp:=0
cboUrgency:=0

vElmtCondOp:=""
cboElmtCondOp:=0
cboElmtCond:=0

//    0) All the check boxes are un-checked as default
cbDeficiency:=0
cbUrgency:=0
cbElmtCond:=0
cbElementCat:=0

OBJECT SET ENABLED:C1123(cboDefOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboDeficiency; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboUrgOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboUrgency; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboElmtCondOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboElmtCond; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(aInspType_; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboElem; False:C215)  // Command Replaced was o_DISABLE BUTTON 

OBJECT SET ENABLED:C1123(*; "Deficiency"; False:C215)
OBJECT SET ENABLED:C1123(*; "Urgency"; False:C215)
OBJECT SET ENABLED:C1123(*; "Rating"; False:C215)

OBJECT SET TITLE:C194(*; "Deficiency"+"Desc"; "")
OBJECT SET TITLE:C194(*; "Urgency"+"Desc"; "")
OBJECT SET TITLE:C194(*; "Rating"+"Desc"; "")

cbElementTxt:=0
SRC_ELEMTEXT_txt:=""
cbWholeWord:=0
OBJECT SET ENABLED:C1123(cbWholeWord; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENTERABLE:C238(SRC_ELEMTEXT_txt; False:C215)

cbElemDescTxt:=0
SRC_ELEMDESC_txt:=""
cboDescComparison:=0
OBJECT SET ENABLED:C1123(cboDescComparison; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENTERABLE:C238(SRC_ELEMDESC_txt; False:C215)

LIST TO ARRAY:C288("Rating Categories"; cboElmtCond)
LIST TO ARRAY:C288("Rating Codes"; cboElmtCondCode)

//1) Fill the aInspType_ (=Element Category combo box) values
//Inspection categories for regular bridge safety inspection
SRC_EL_Util("LOADCAT")
//2) Fill the cboElem combo box values --> default value = "ALL"

SRC_EL_Util("LOADELEM")