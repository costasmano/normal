POPUP_HL_MENUC(PT_DesignProjectList_HL; ->PT_ProjectListIndex_L)
If (PT_ProjectListIndex_L>0)
	If (PT_ProjectListIndex_L>1000000)
		PT_ProjectListIndex_L:=PT_ProjectListIndex_L-1000000
		PRJ_PT_EWO_s:=PT_ProjectListConsEWO_as{PT_ProjectListIndex_L}
	Else 
		PRJ_PT_EWO_s:=PT_ProjectListEWO_as{PT_ProjectListIndex_L}
	End if 
	
	PRJ_PT_EWO_s:=PT_ProjectListEWO_as{PT_ProjectListIndex_L}
	PT_ProjectID_L:=PT_ProjectListID_aL{PT_ProjectListIndex_L}
	GOTO OBJECT:C206(PRJ_PT_Hours_r)
	POST KEY:C465(Tab key:K12:28)
	POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
	PT_CostCodeName_atxt:=0
End if 