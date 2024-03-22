//%attributes = {"invisible":true}
//Method: LSS_ClearForNewQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/24/19, 11:52:47
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01  //add [LSS_ElementInspection] query and report
	//Modified by: Chuck Miller (1/24/19 11:42:45)
End if 
//

C_TEXT:C284($TypeOfClear_txt)
$TypeOfClear_txt:=""
If (Count parameters:C259=1)
	
	C_TEXT:C284($1)
	$TypeOfClear_txt:=$1
	
End if 
If ($TypeOfClear_txt="ALL")
	OBJECT SET TITLE:C194(*; "DeficiencyDesc"; "")
	OBJECT SET TITLE:C194(*; "UrgencyDesc"; "")
	OBJECT SET TITLE:C194(*; "RatingDesc"; "")
	
	//Category
	vDef:=""
	cbDeficiency:=0
	cboDefOp:=0
	cboDeficiency:=0
	vDefOp:=""
	OBJECT SET ENABLED:C1123(cbDeficiency; False:C215)
	OBJECT SET ENABLED:C1123(cboDefOp; False:C215)
	OBJECT SET ENABLED:C1123(cboDeficiency; False:C215)
	//Urgency
	cbUrgency:=0
	cboUrgOp:=0
	cboUrgency:=0
	vUrg:=""
	vUrgOp:=""
	OBJECT SET ENABLED:C1123(cbUrgency; False:C215)
	OBJECT SET ENABLED:C1123(cboUrgOp; False:C215)
	OBJECT SET ENABLED:C1123(cboUrgency; False:C215)
	
	//Element Condition
	cbElmtCond:=0
	cboElmtCondOp:=0
	cboElmtCond:=0
	vElmtCondOp:=""
	OBJECT SET ENABLED:C1123(cbElmtCond; False:C215)
	OBJECT SET ENABLED:C1123(cboElmtCondOp; False:C215)
	OBJECT SET ENABLED:C1123(cboElmtCond; False:C215)
	
	//Element Category
	cbElementCat:=0
	cboInspType:=0
	cboElem:=0
	OBJECT SET ENABLED:C1123(cbElementCat; False:C215)
	OBJECT SET ENABLED:C1123(cboInspType; False:C215)
	OBJECT SET ENABLED:C1123(cboElem; False:C215)
	
	
	//Text in element category
	SRC_ELEMDESC_txt:=""
	cbElemDescTxt:=0
	cboDescComparison:=0
	
	OBJECT SET ENABLED:C1123(cboDescComparison; False:C215)
	OBJECT SET ENTERABLE:C238(SRC_ELEMDESC_txt; False:C215)
	CLEAR VARIABLE:C89(SRC_ELEMDESC_txt)
	OBJECT SET ENABLED:C1123(cbElemDescTxt; False:C215)
	
	
	
	OBJECT SET ENABLED:C1123(*; "ApprovalLevel"; False:C215)
	OBJECT SET ENABLED:C1123(*; "PrintNow"; False:C215)
	OBJECT SET ENABLED:C1123(*; "Results"; False:C215)
	OBJECT SET ENABLED:C1123(*; "FindButton"; False:C215)
	
	
	OBJECT SET VISIBLE:C603(*; "@_Warning"; False:C215)
	OBJECT SET ENABLED:C1123(*; "FindButton"; False:C215)
	
	
	OBJECT SET RGB COLORS:C628(*; "SRC_ELEMDESC_txt"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "SRC_ELEMDESC_txt"; <>Color_Not_Editable)
Else 
	
	//deficiency
	If (cbDeficiency=1)
		OBJECT SET ENABLED:C1123(*; "Deficiency"; True:C214)
	Else 
		OBJECT SET TITLE:C194(*; "DeficiencyDesc"; "")
		
		cboDefOp:=0
		cboDeficiency:=0
		vDefOp:=""
		vDef:=""
		OBJECT SET ENABLED:C1123(*; "Deficiency"; False:C215)
		//OBJECT SET ENABLED(cboDeficiency;False)
	End if 
	//Urgency of Repair
	If (cbUrgency=1)
		OBJECT SET ENABLED:C1123(*; "Urgency"; True:C214)
	Else 
		OBJECT SET TITLE:C194(*; "UrgencyDesc"; "")
		
		cboUrgOp:=0
		cboUrgency:=0
		vUrgOp:=""
		vUrg:=""
		OBJECT SET ENABLED:C1123(*; "Urgency"; False:C215)
		//OBJECT SET ENABLED(cboUrgency;False)
	End if 
	//Element Condition:
	If (cbElmtCond=1)
		OBJECT SET ENABLED:C1123(*; "Rating"; True:C214)
	Else 
		OBJECT SET TITLE:C194(*; "RatingDesc"; "")
		
		cboElmtCondOp:=0
		cboElmtCond:=0
		vElmtCondOp:=""
		
		OBJECT SET ENABLED:C1123(*; "Rating"; False:C215)
		//OBJECT SET ENABLED(cboElmtCond;False)
	End if 
	
	//Element Categories:
	If (cbElementCat=1)
	Else 
		cboInspType:=0
		cboElem:=0
		vElmtCondOp:=""
		
		OBJECT SET ENABLED:C1123(cboInspType; False:C215)
		OBJECT SET ENABLED:C1123(cboElem; False:C215)
	End if 
	
	//Text in Custom Element Descr:
	If (cbElemDescTxt=1)
		
	Else 
		SRC_ELEMDESC_txt:=""
		cboDescComparison:=0
		OBJECT SET ENABLED:C1123(cboDescComparison; False:C215)
		OBJECT SET ENTERABLE:C238(*; "SRC_ELEMDESC_txt"; False:C215)
		
	End if 
End if 
//End LSS_ClearForNewQuery