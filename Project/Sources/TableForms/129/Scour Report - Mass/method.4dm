If (False:C215)
	// S. Hwang - April 2006
	//Mods_2006_SH01 
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	C_LONGINT:C283(vOn_MA_OverWaterways; vOff_MA_OverWaterways; vTotal_MA_OverWaterways)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_MA_LowRiskTotal; vOff_MA_LowRiskTotal; vTotal_MA_LowRiskTotal)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_MA_ScourSuscept; vOff_MA_ScourSuscept; vTotal_MA_ScourSuscept)  //Command Replaced was o_C_INTEGER
	C_TEXT:C284(vOn_MA_UT; vOff_MA_UT; vTotal_MA_UT)  // Command Replaced was o_C_STRING length was 30
	C_LONGINT:C283(vOn_MA_ScourCrit; vOff_MA_ScourCrit; vTotal_MA_ScourCrit)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_MA_Analyzed; vOff_MA_Analyzed; vTotal_MA_Analyzed)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_MA_Counter; vOff_MA_Counter; vTotal_MA_Counter)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_MA_Analyzed; vOff_MA_Analyzed; vTotal_MA_Analyzed)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_MA_Monitor; vOff_MA_Monitor; vTotal_MA_Monitor)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_MA_LRT_Calc; vOff_MA_LRT_Calc; vTotal_MA_LRT_Calc)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_MA_LRT_Screen; vOff_MA_LRT_Screen; vTotal_MA_LRT_Screen)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_MA_LRT_Culv; vOff_MA_LRT_Culv; vTotal_MA_LRT_Culv)  //Command Replaced was o_C_INTEGER
	//1.
	vOn_MA_OverWaterways:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_State_ScourCrit:6
	vOff_MA_OverWaterways:=[Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_Agency_ScourSuscept:33+[Scour Report:129]Off_Agency_Unknown:34+[Scour Report:129]Off_Agency_Tidal:35+[Scour Report:129]Off_Agency_ScourCrit:36+[Scour Report:129]Off_State_LowRiskTotal:12+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_State_ScourCrit:16
	vTotal_MA_OverWaterways:=vOn_MA_OverWaterways+vOff_MA_OverWaterways
	
	//2A. 
	vOn_MA_LowRiskTotal:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_State_LowRiskTotal:2
	vOff_MA_LowRiskTotal:=[Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_State_LowRiskTotal:12
	vTotal_MA_LowRiskTotal:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]Off_State_LowRiskTotal:12
	
	//2B.
	vOn_MA_ScourSuscept:=[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_Agency_ScourSuscept:23
	vOff_MA_ScourSuscept:=[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_Agency_ScourSuscept:33
	vTotal_MA_ScourSuscept:=[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]Off_Agency_ScourSuscept:33
	
	//2C.
	vOn_MA_UT:=String:C10([Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_Agency_Unknown:24)+" / "+String:C10([Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_Agency_Tidal:25)
	vOff_MA_UT:=String:C10([Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_Agency_Unknown:34)+" / "+String:C10([Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_Agency_Tidal:35)
	vTotal_MA_UT:=String:C10([Scour Report:129]On_State_Unknown:4+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]Off_Agency_Unknown:34)+" / "+String:C10([Scour Report:129]On_State_Tidal:5+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]Off_Agency_Tidal:35)
	
	//2D.
	vOn_MA_ScourCrit:=[Scour Report:129]On_State_ScourCrit:6+[Scour Report:129]On_Agency_ScourCrit:26
	vOff_MA_ScourCrit:=[Scour Report:129]Off_State_ScourCrit:16+[Scour Report:129]Off_Agency_ScourCrit:36
	vTotal_MA_ScourCrit:=[Scour Report:129]On_State_ScourCrit:6+[Scour Report:129]Off_State_ScourCrit:16+[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]Off_Agency_ScourCrit:36
	
	//3
	vOn_MA_Analyzed:=([Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_State_ScourCrit:6)-([Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_Agency_ScourSuscept:23)
	vOff_MA_Analyzed:=([Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_Agency_ScourSuscept:33+[Scour Report:129]Off_Agency_Unknown:34+[Scour Report:129]Off_Agency_Tidal:35+[Scour Report:129]Off_Agency_ScourCrit:36+[Scour Report:129]Off_State_LowRiskTotal:12+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_State_ScourCrit:16)-([Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_Agency_ScourSuscept:33)
	vTotal_MA_Analyzed:=([Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_State_ScourCrit:6)-([Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_Agency_ScourSuscept:23)+([Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_Agency_ScourSuscept:33+[Scour Report:129]Off_Agency_Unknown:34+[Scour Report:129]Off_Agency_Tidal:35+[Scour Report:129]Off_Agency_ScourCrit:36+[Scour Report:129]Off_State_LowRiskTotal:12+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_State_ScourCrit:16)-([Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_Agency_ScourSuscept:33)
	
	//4
	vOn_MA_Counter:=[Scour Report:129]On_State_Counter:7+[Scour Report:129]On_Agency_Counter:27
	vOff_MA_Counter:=[Scour Report:129]Off_State_Counter:17+[Scour Report:129]Off_Agency_Counter:37
	vTotal_MA_Counter:=[Scour Report:129]On_State_Counter:7+[Scour Report:129]Off_State_Counter:17+[Scour Report:129]On_Agency_Counter:27+[Scour Report:129]Off_Agency_Counter:37
	
	//5
	vOn_MA_Monitor:=[Scour Report:129]On_State_Monitor:8+[Scour Report:129]On_Agency_Monitor:28
	vOff_MA_Monitor:=[Scour Report:129]Off_State_Monitor:18+[Scour Report:129]Off_Agency_Monitor:38
	vTotal_MA_Monitor:=[Scour Report:129]On_State_Monitor:8+[Scour Report:129]Off_State_Monitor:18+[Scour Report:129]On_Agency_Monitor:28+[Scour Report:129]Off_Agency_Monitor:38
	
	//2A-1
	vOn_MA_LRT_Calc:=[Scour Report:129]On_State_LRT_Calc:9+[Scour Report:129]On_Agency_LRT_Calc:29
	vOff_MA_LRT_Calc:=[Scour Report:129]Off_State_LRT_Calc:19+[Scour Report:129]Off_Agency_LRT_Calc:39
	vTotal_MA_LRT_Calc:=[Scour Report:129]On_State_LRT_Calc:9+[Scour Report:129]On_Agency_LRT_Calc:29+[Scour Report:129]Off_State_LRT_Calc:19+[Scour Report:129]Off_Agency_LRT_Calc:39
	
	//2A-2
	vOn_MA_LRT_Screen:=[Scour Report:129]On_State_LRT_Screen:10+[Scour Report:129]On_Agency_LRT_Screen:30
	vOff_MA_LRT_Screen:=[Scour Report:129]Off_State_LRT_Screen:20+[Scour Report:129]Off_Agency_LRT_Screen:40
	vTotal_MA_LRT_Screen:=[Scour Report:129]On_State_LRT_Screen:10+[Scour Report:129]On_Agency_LRT_Screen:30+[Scour Report:129]Off_State_LRT_Screen:20+[Scour Report:129]Off_Agency_LRT_Screen:40
	
	//2A-3
	vOn_MA_LRT_Culv:=[Scour Report:129]On_State_LRT_Culv:11+[Scour Report:129]On_Agency_LRT_Culv:31
	vOff_MA_LRT_Culv:=[Scour Report:129]Off_State_LRT_Culv:21+[Scour Report:129]Off_Agency_LRT_Culv:41
	vTotal_MA_LRT_Culv:=[Scour Report:129]On_State_LRT_Culv:11+[Scour Report:129]On_Agency_LRT_Culv:31+[Scour Report:129]Off_State_LRT_Culv:21+[Scour Report:129]Off_Agency_LRT_Culv:41
End if 