If (False:C215)
	// S. Hwang - April 2006
	//Mods_2006_SH01 
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	C_LONGINT:C283(vOn_Agency_OverWaterways; vOff_Agency_OverWaterways; vTotal_Agency_OverWaterways)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vTotal_Agency_LowRiskTotal; vTotal_Agency_ScourSuscept)  //Command Replaced was o_C_INTEGER
	C_TEXT:C284(vOn_Agency_UT; vOff_Agency_UT; vTotal_Agency_UT)  // Command Replaced was o_C_STRING length was 30
	C_LONGINT:C283(vTotal_Agency_ScourCrit; vTotal_Agency_Counter; vTotal_Agency_Monitor)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vOn_Agency_Analyzed; vOff_Agency_Analyzed; vTotal_Agency_Analyzed)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(vTotal_Agency_LRT_Calc; vTotal_Agency_LRT_Screen; vTotal_Agency_LRT_Culv)  //Command Replaced was o_C_INTEGER
	
	//1.
	vOn_Agency_OverWaterways:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]On_Agency_ScourCrit:26
	vOff_Agency_OverWaterways:=[Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_Agency_ScourSuscept:33+[Scour Report:129]Off_Agency_Unknown:34+[Scour Report:129]Off_Agency_Tidal:35+[Scour Report:129]Off_Agency_ScourCrit:36
	vTotal_Agency_OverWaterways:=vOn_Agency_OverWaterways+vOff_Agency_OverWaterways
	
	//2A. 
	vTotal_Agency_LowRiskTotal:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]Off_Agency_LowRiskTotal:32
	
	//2B.
	vTotal_Agency_ScourSuscept:=[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]Off_Agency_ScourSuscept:33
	
	//2C.
	vOn_Agency_UT:=String:C10([Scour Report:129]On_Agency_Unknown:24)+" / "+String:C10([Scour Report:129]On_Agency_Tidal:25)
	vOff_Agency_UT:=String:C10([Scour Report:129]Off_Agency_Unknown:34)+" / "+String:C10([Scour Report:129]Off_Agency_Tidal:35)
	vTotal_Agency_UT:=String:C10([Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]Off_Agency_Unknown:34)+" / "+String:C10([Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]Off_Agency_Tidal:35)
	
	//2D.
	vTotal_Agency_ScourCrit:=[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]Off_Agency_ScourCrit:36
	
	//3
	vOn_Agency_Analyzed:=vOn_Agency_OverWaterways-[Scour Report:129]On_Agency_ScourSuscept:23
	vOff_Agency_Analyzed:=vOff_Agency_OverWaterways-[Scour Report:129]Off_Agency_ScourSuscept:33
	vTotal_Agency_Analyzed:=vOn_Agency_Analyzed+vOff_Agency_Analyzed
	
	//4
	vTotal_Agency_Counter:=[Scour Report:129]On_Agency_Counter:27+[Scour Report:129]Off_Agency_Counter:37
	
	//5
	vTotal_Agency_Monitor:=[Scour Report:129]On_Agency_Monitor:28+[Scour Report:129]Off_Agency_Monitor:38
	
	//2A-1
	vTotal_Agency_LRT_Calc:=[Scour Report:129]On_Agency_LRT_Calc:29+[Scour Report:129]Off_Agency_LRT_Calc:39
	
	//2A-2
	vTotal_Agency_LRT_Screen:=[Scour Report:129]On_Agency_LRT_Screen:30+[Scour Report:129]Off_Agency_LRT_Screen:40
	
	//2A-3
	vTotal_Agency_LRT_Culv:=[Scour Report:129]On_Agency_LRT_Culv:31+[Scour Report:129]Off_Agency_LRT_Culv:41
	
End if 