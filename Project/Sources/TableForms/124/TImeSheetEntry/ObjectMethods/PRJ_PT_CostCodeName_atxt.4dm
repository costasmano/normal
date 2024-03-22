POPUPMENUC(->PT_CostCodeName_atxt; ->PT_CostCodeEWO_atxt; ->PRJ_PT_EWO_s)
POPUPMENUC(->PT_CostCodeName_atxt; ->PT_CostCodeIDs_aL; ->PT_ProjectID_L)
If (Form event code:C388=On Clicked:K2:4)
	GOTO OBJECT:C206(PRJ_PT_Hours_r)
	POST KEY:C465(Tab key:K12:28)
	POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
	SELECT LIST ITEMS BY POSITION:C381(PT_DesignProjectList_HL; 0)
	SELECT LIST ITEMS BY POSITION:C381(PT_ConstructionProjectList_HL; 0)
	REDRAW:C174(PT_DesignProjectList_HL)  // Command Replaced was o_REDRAW LIST 
	REDRAW:C174(PT_ConstructionProjectList_HL)  // Command Replaced was o_REDRAW LIST 
	PT_ProjectListIndex_L:=0
	
End if 
