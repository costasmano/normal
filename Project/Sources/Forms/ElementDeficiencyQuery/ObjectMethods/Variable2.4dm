//Method: ElementDeficiencyQuery.Variable1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/13/18, 12:32:35
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//


LSS_ClearForNewQuery("ALL")
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "TotalElmtsFound")
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "InterimSet")
CREATE EMPTY SET:C140([LSS_ElementInspection:163]; "FinalElementSet")
OBJECT SET ENABLED:C1123(cbDeficiency; True:C214)
OBJECT SET ENABLED:C1123(cbUrgency; True:C214)
OBJECT SET ENABLED:C1123(cbElmtCond; True:C214)
OBJECT SET ENABLED:C1123(cbElementCat; True:C214)
OBJECT SET ENABLED:C1123(cbElemDescTxt; True:C214)
OBJECT SET ENABLED:C1123(*; "ApprovalLevel"; True:C214)
vtSearchResultCnt:=""

//End ElementDeficiencyQuery.Variable1