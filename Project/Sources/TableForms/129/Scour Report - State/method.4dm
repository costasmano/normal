If (False:C215)
	// S. Hwang - April 2006
	//Mods_2006_SH01 
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	C_LONGINT:C283(vOn_State_OverWaterways; vOff_State_OverWaterways; vTotal_State_OverWaterways)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vTotal_State_LowRiskTotal; vTotal_State_ScourSuscept)  //Command Replaced was o_C_INTEGER
	C_TEXT:C284(vOn_State_UT; vOff_State_UT; vTotal_State_UT)  // Command Replaced was o_C_STRING length was 30
	C_LONGINT:C283(vTotal_State_ScourCrit; vTotal_State_Counter; vTotal_State_Monitor)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_State_Analyzed; vOff_State_Analyzed; vTotal_State_Analyzed)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vTotal_State_LRT_Calc; vTotal_State_LRT_Screen; vTotal_State_LRT_Culv)  //Command Replaced was o_C_INTEGER
	
	//1.
	vOn_State_OverWaterways:=[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_State_ScourCrit:6
	vOff_State_OverWaterways:=[Scour Report:129]Off_State_LowRiskTotal:12+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_State_ScourCrit:16
	vTotal_State_OverWaterways:=vOn_State_OverWaterways+vOff_State_OverWaterways
	
	//2A. 
	vTotal_State_LowRiskTotal:=[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]Off_State_LowRiskTotal:12
	
	//2B.
	vTotal_State_ScourSuscept:=[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]Off_State_ScourSuscept:13
	
	//2C.
	vOn_State_UT:=String:C10([Scour Report:129]On_State_Unknown:4)+" / "+String:C10([Scour Report:129]On_State_Tidal:5)
	vOff_State_UT:=String:C10([Scour Report:129]Off_State_Unknown:14)+" / "+String:C10([Scour Report:129]Off_State_Tidal:15)
	vTotal_State_UT:=String:C10([Scour Report:129]On_State_Unknown:4+[Scour Report:129]Off_State_Unknown:14)+" / "+String:C10([Scour Report:129]On_State_Tidal:5+[Scour Report:129]Off_State_Tidal:15)
	
	//2D.
	vTotal_State_ScourCrit:=[Scour Report:129]On_State_ScourCrit:6+[Scour Report:129]Off_State_ScourCrit:16
	
	//3
	vOn_State_Analyzed:=vOn_State_OverWaterways-[Scour Report:129]On_State_ScourSuscept:3
	vOff_State_Analyzed:=vOff_State_OverWaterways-[Scour Report:129]Off_State_ScourSuscept:13
	vTotal_State_Analyzed:=vOn_State_Analyzed+vOff_State_Analyzed
	
	//4
	vTotal_State_Counter:=[Scour Report:129]On_State_Counter:7+[Scour Report:129]Off_State_Counter:17
	
	//5
	vTotal_State_Monitor:=[Scour Report:129]On_State_Monitor:8+[Scour Report:129]Off_State_Monitor:18
	
	//2A-1
	vTotal_State_LRT_Calc:=[Scour Report:129]On_State_LRT_Calc:9+[Scour Report:129]Off_State_LRT_Calc:19
	
	//2A-2
	vTotal_State_LRT_Screen:=[Scour Report:129]On_State_LRT_Screen:10+[Scour Report:129]Off_State_LRT_Screen:20
	
	//2A-3
	vTotal_State_LRT_Culv:=[Scour Report:129]On_State_LRT_Culv:11+[Scour Report:129]Off_State_LRT_Culv:21
	
End if 