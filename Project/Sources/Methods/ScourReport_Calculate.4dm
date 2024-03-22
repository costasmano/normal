//%attributes = {"invisible":true}
If (False:C215)
	//by: Susie Hwang
	//created: 4/21/2006
	//purpose: Calculates the variables used in Bridge Scour Reports
	//Mods_2006_SH01 
End if 

C_TEXT:C284(vOn_Sum_OverWaterways; vOff_Sum_OverWaterways; vTotal_Sum_OverWaterways)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_LowRiskTotal; vOff_Sum_LowRiskTotal; vTotal_Sum_LowRiskTotal)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_ScourSuscept; vOff_Sum_ScourSuscept; vTotal_Sum_ScourSuscept)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_UT; vOff_Sum_UT; vTotal_Sum_UT)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_ScourCrit; vOff_Sum_ScourCrit; vTotal_Sum_ScourCrit)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_Analyzed; vOff_Sum_Analyzed; vTotal_Sum_Analyzed)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_Counter; vOff_Sum_Counter; vTotal_Sum_Counter)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_Analyzed; vOff_Sum_Analyzed; vTotal_Sum_Analyzed)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_Monitor; vOff_Sum_Monitor; vTotal_Sum_Monitor)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_LRT_Calc; vOff_Sum_LRT_Calc; vTotal_Sum_LRT_Calc)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_LRT_Screen; vOff_Sum_LRT_Screen; vTotal_Sum_LRT_Screen)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vOn_Sum_LRT_Culv; vOff_Sum_LRT_Culv; vTotal_Sum_LRT_Culv)  // Command Replaced was o_C_STRING length was 30
//`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
C_LONGINT:C283(vOn_State_OverWaterways; vOff_State_OverWaterways; vTotal_State_OverWaterways)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vTotal_State_LowRiskTotal; vTotal_State_ScourSuscept)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vOn_State_UT; vOff_State_UT; vTotal_State_UT)  // Command Replaced was o_C_STRING length was 30
C_LONGINT:C283(vTotal_State_ScourCrit; vTotal_State_Counter; vTotal_State_Monitor)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vOn_State_Analyzed; vOff_State_Analyzed; vTotal_State_Analyzed)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vTotal_State_LRT_Calc; vTotal_State_LRT_Screen; vTotal_State_LRT_Culv)  //Command Replaced was o_C_INTEGER
//`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
C_LONGINT:C283(vOn_Agency_OverWaterways; vOff_Agency_OverWaterways; vTotal_Agency_OverWaterways)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vTotal_Agency_LowRiskTotal; vTotal_Agency_ScourSuscept)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vOn_Agency_UT; vOff_Agency_UT; vTotal_Agency_UT)  // Command Replaced was o_C_STRING length was 30
C_LONGINT:C283(vTotal_Agency_ScourCrit; vTotal_Agency_Counter; vTotal_Agency_Monitor)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vOn_Agency_Analyzed; vOff_Agency_Analyzed; vTotal_Agency_Analyzed)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vTotal_Agency_LRT_Calc; vTotal_Agency_LRT_Screen; vTotal_Agency_LRT_Culv)  //Command Replaced was o_C_INTEGER
//`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
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
//`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

//``````````````````````````````` 1.   ````````````````````````````````
vOn_State_OverWaterways:=[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_State_ScourCrit:6
vOff_State_OverWaterways:=[Scour Report:129]Off_State_LowRiskTotal:12+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_State_ScourCrit:16
vTotal_State_OverWaterways:=vOn_State_OverWaterways+vOff_State_OverWaterways

vOn_Agency_OverWaterways:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]On_Agency_ScourCrit:26
vOff_Agency_OverWaterways:=[Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_Agency_ScourSuscept:33+[Scour Report:129]Off_Agency_Unknown:34+[Scour Report:129]Off_Agency_Tidal:35+[Scour Report:129]Off_Agency_ScourCrit:36
vTotal_Agency_OverWaterways:=vOn_Agency_OverWaterways+vOff_Agency_OverWaterways

vOn_MA_OverWaterways:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_State_ScourCrit:6
vOff_MA_OverWaterways:=[Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_Agency_ScourSuscept:33+[Scour Report:129]Off_Agency_Unknown:34+[Scour Report:129]Off_Agency_Tidal:35+[Scour Report:129]Off_Agency_ScourCrit:36+[Scour Report:129]Off_State_LowRiskTotal:12+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_State_ScourCrit:16
vTotal_MA_OverWaterways:=vOn_MA_OverWaterways+vOff_MA_OverWaterways

vOn_Sum_OverWaterways:=String:C10(vOn_State_OverWaterways)+" / "+String:C10(vOn_Agency_OverWaterways)
vOff_Sum_OverWaterways:=String:C10(vOff_State_OverWaterways)+" / "+String:C10(vOff_Agency_OverWaterways)
vTotal_Sum_OverWaterways:=String:C10(vTotal_State_OverWaterways)+" / "+String:C10(vTotal_Agency_OverWaterways)
//``````````````````````````````` 2A.   ````````````````````````````````
vTotal_State_LowRiskTotal:=[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]Off_State_LowRiskTotal:12
vTotal_Agency_LowRiskTotal:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]Off_Agency_LowRiskTotal:32

vOn_MA_LowRiskTotal:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_State_LowRiskTotal:2
vOff_MA_LowRiskTotal:=[Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_State_LowRiskTotal:12
vTotal_MA_LowRiskTotal:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]Off_State_LowRiskTotal:12

vOn_Sum_LowRiskTotal:=String:C10([Scour Report:129]On_State_LowRiskTotal:2)+" / "+String:C10([Scour Report:129]On_Agency_LowRiskTotal:22)
vOff_Sum_LowRiskTotal:=String:C10([Scour Report:129]Off_State_LowRiskTotal:12)+" / "+String:C10([Scour Report:129]Off_Agency_LowRiskTotal:32)
vTotal_Sum_LowRiskTotal:=String:C10(vTotal_State_LowRiskTotal)+" / "+String:C10(vTotal_Agency_LowRiskTotal)

//```````````````````````````````` 2B.  ````````````````````````````````` 
vTotal_State_ScourSuscept:=[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]Off_State_ScourSuscept:13
vTotal_Agency_ScourSuscept:=[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]Off_Agency_ScourSuscept:33

vOn_MA_ScourSuscept:=[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_Agency_ScourSuscept:23
vOff_MA_ScourSuscept:=[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_Agency_ScourSuscept:33
vTotal_MA_ScourSuscept:=[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]Off_Agency_ScourSuscept:33

vOn_Sum_ScourSuscept:=String:C10([Scour Report:129]On_State_ScourSuscept:3)+" / "+String:C10([Scour Report:129]On_Agency_ScourSuscept:23)
vOff_Sum_ScourSuscept:=String:C10([Scour Report:129]Off_State_ScourSuscept:13)+" / "+String:C10([Scour Report:129]Off_Agency_ScourSuscept:33)
vTotal_Sum_ScourSuscept:=String:C10(vTotal_State_ScourSuscept)+" / "+String:C10(vTotal_Agency_ScourSuscept)
//```````````````````````````````  2C.  ````````````````````````````````
vOn_State_UT:=String:C10([Scour Report:129]On_State_Unknown:4)+" / "+String:C10([Scour Report:129]On_State_Tidal:5)
vOff_State_UT:=String:C10([Scour Report:129]Off_State_Unknown:14)+" / "+String:C10([Scour Report:129]Off_State_Tidal:15)

vOn_Agency_UT:=String:C10([Scour Report:129]On_Agency_Unknown:24)+" / "+String:C10([Scour Report:129]On_Agency_Tidal:25)
vOff_Agency_UT:=String:C10([Scour Report:129]Off_Agency_Unknown:34)+" / "+String:C10([Scour Report:129]Off_Agency_Tidal:35)

vOn_MA_UT:=String:C10([Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_Agency_Unknown:24)+" / "+String:C10([Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_Agency_Tidal:25)
vOff_MA_UT:=String:C10([Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_Agency_Unknown:34)+" / "+String:C10([Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_Agency_Tidal:35)
vTotal_MA_UT:=String:C10([Scour Report:129]On_State_Unknown:4+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]Off_Agency_Unknown:34)+" / "+String:C10([Scour Report:129]On_State_Tidal:5+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]Off_Agency_Tidal:35)

vTotal_State_UT:=String:C10([Scour Report:129]On_State_Unknown:4+[Scour Report:129]Off_State_Unknown:14)+" / "+String:C10([Scour Report:129]On_State_Tidal:5+[Scour Report:129]Off_State_Tidal:15)
vTotal_Agency_UT:=String:C10([Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]Off_Agency_Unknown:34)+" / "+String:C10([Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]Off_Agency_Tidal:35)

vOn_Sum_UT:="("+vOn_State_UT+") / ("+vOn_Agency_UT+")"
vOff_Sum_UT:="("+vOff_State_UT+") / ("+vOff_Agency_UT+")"
vTotal_Sum_UT:="("+vTotal_State_UT+") / ("+vTotal_Agency_UT+")"
//```````````````````````````````  2D.  ````````````````````````````````
vTotal_State_ScourCrit:=[Scour Report:129]On_State_ScourCrit:6+[Scour Report:129]Off_State_ScourCrit:16
vTotal_Agency_ScourCrit:=[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]Off_Agency_ScourCrit:36

vOn_MA_ScourCrit:=[Scour Report:129]On_State_ScourCrit:6+[Scour Report:129]On_Agency_ScourCrit:26
vOff_MA_ScourCrit:=[Scour Report:129]Off_State_ScourCrit:16+[Scour Report:129]Off_Agency_ScourCrit:36
vTotal_MA_ScourCrit:=[Scour Report:129]On_State_ScourCrit:6+[Scour Report:129]Off_State_ScourCrit:16+[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]Off_Agency_ScourCrit:36

vOn_Sum_ScourCrit:=String:C10([Scour Report:129]On_State_ScourCrit:6)+" / "+String:C10([Scour Report:129]On_Agency_ScourCrit:26)
vOff_Sum_ScourCrit:=String:C10([Scour Report:129]Off_State_ScourCrit:16)+" / "+String:C10([Scour Report:129]Off_Agency_ScourCrit:36)
vTotal_Sum_ScourCrit:=String:C10(vTotal_State_ScourCrit)+" / "+String:C10(vTotal_Agency_ScourCrit)
//```````````````````````````````  3.  ````````````````````````````````
vOn_State_Analyzed:=vOn_State_OverWaterways-[Scour Report:129]On_State_ScourSuscept:3
vOff_State_Analyzed:=vOff_State_OverWaterways-[Scour Report:129]Off_State_ScourSuscept:13
vTotal_State_Analyzed:=vOn_State_Analyzed+vOff_State_Analyzed

vOn_Agency_Analyzed:=vOn_Agency_OverWaterways-[Scour Report:129]On_Agency_ScourSuscept:23
vOff_Agency_Analyzed:=vOff_Agency_OverWaterways-[Scour Report:129]Off_Agency_ScourSuscept:33
vTotal_Agency_Analyzed:=vOn_Agency_Analyzed+vOff_Agency_Analyzed

vOn_MA_Analyzed:=([Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_State_ScourCrit:6)-([Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_Agency_ScourSuscept:23)
vOff_MA_Analyzed:=([Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_Agency_ScourSuscept:33+[Scour Report:129]Off_Agency_Unknown:34+[Scour Report:129]Off_Agency_Tidal:35+[Scour Report:129]Off_Agency_ScourCrit:36+[Scour Report:129]Off_State_LowRiskTotal:12+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_State_ScourCrit:16)-([Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_Agency_ScourSuscept:33)
vTotal_MA_Analyzed:=([Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_State_ScourCrit:6)-([Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_Agency_ScourSuscept:23)+([Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_Agency_ScourSuscept:33+[Scour Report:129]Off_Agency_Unknown:34+[Scour Report:129]Off_Agency_Tidal:35+[Scour Report:129]Off_Agency_ScourCrit:36+[Scour Report:129]Off_State_LowRiskTotal:12+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_State_ScourCrit:16)-([Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_Agency_ScourSuscept:33)

vOn_Sum_Analyzed:=String:C10(vOn_State_Analyzed)+" / "+String:C10(vOn_Agency_Analyzed)
vOff_Sum_Analyzed:=String:C10(vOff_State_Analyzed)+" / "+String:C10(vOff_Agency_Analyzed)
vTotal_Sum_Analyzed:=String:C10(vTotal_State_Analyzed)+" / "+String:C10(vTotal_Agency_Analyzed)
//```````````````````````````````  4.  ````````````````````````````````
vTotal_State_Counter:=[Scour Report:129]On_State_Counter:7+[Scour Report:129]Off_State_Counter:17
vTotal_Agency_Counter:=[Scour Report:129]On_Agency_Counter:27+[Scour Report:129]Off_Agency_Counter:37

vOn_MA_Counter:=[Scour Report:129]On_State_Counter:7+[Scour Report:129]On_Agency_Counter:27
vOff_MA_Counter:=[Scour Report:129]Off_State_Counter:17+[Scour Report:129]Off_Agency_Counter:37
vTotal_MA_Counter:=[Scour Report:129]On_State_Counter:7+[Scour Report:129]Off_State_Counter:17+[Scour Report:129]On_Agency_Counter:27+[Scour Report:129]Off_Agency_Counter:37

vOn_Sum_Counter:=String:C10([Scour Report:129]On_State_Counter:7)+" / "+String:C10([Scour Report:129]On_Agency_Counter:27)
vOff_Sum_Counter:=String:C10([Scour Report:129]Off_State_Counter:17)+" / "+String:C10([Scour Report:129]Off_Agency_Counter:37)
vTotal_Sum_Counter:=String:C10(vTotal_State_Counter)+" / "+String:C10(vTotal_Agency_Counter)
//```````````````````````````````  5.  ````````````````````````````````
vTotal_State_Monitor:=[Scour Report:129]On_State_Monitor:8+[Scour Report:129]Off_State_Monitor:18
vTotal_Agency_Monitor:=[Scour Report:129]On_Agency_Monitor:28+[Scour Report:129]Off_Agency_Monitor:38

vOn_MA_Monitor:=[Scour Report:129]On_State_Monitor:8+[Scour Report:129]On_Agency_Monitor:28
vOff_MA_Monitor:=[Scour Report:129]Off_State_Monitor:18+[Scour Report:129]Off_Agency_Monitor:38
vTotal_MA_Monitor:=[Scour Report:129]On_State_Monitor:8+[Scour Report:129]Off_State_Monitor:18+[Scour Report:129]On_Agency_Monitor:28+[Scour Report:129]Off_Agency_Monitor:38

vOn_Sum_Monitor:=String:C10([Scour Report:129]On_State_Monitor:8)+" / "+String:C10([Scour Report:129]On_Agency_Monitor:28)
vOff_Sum_Monitor:=String:C10([Scour Report:129]Off_State_Monitor:18)+" / "+String:C10([Scour Report:129]Off_Agency_Monitor:38)
vTotal_Sum_Monitor:=String:C10(vTotal_State_Monitor)+" / "+String:C10(vTotal_Agency_Monitor)

//```````````````````````````````LOW RISK TOTAL SECTION  ````````````````````````````````
//``````````````````````````````` 2A-1 ```````````````````````````````` 
vTotal_State_LRT_Calc:=[Scour Report:129]On_State_LRT_Calc:9+[Scour Report:129]Off_State_LRT_Calc:19
vTotal_Agency_LRT_Calc:=[Scour Report:129]On_Agency_LRT_Calc:29+[Scour Report:129]Off_Agency_LRT_Calc:39

vOn_MA_LRT_Calc:=[Scour Report:129]On_State_LRT_Calc:9+[Scour Report:129]On_Agency_LRT_Calc:29
vOff_MA_LRT_Calc:=[Scour Report:129]Off_State_LRT_Calc:19+[Scour Report:129]Off_Agency_LRT_Calc:39
vTotal_MA_LRT_Calc:=[Scour Report:129]On_State_LRT_Calc:9+[Scour Report:129]On_Agency_LRT_Calc:29+[Scour Report:129]Off_State_LRT_Calc:19+[Scour Report:129]Off_Agency_LRT_Calc:39

vOn_Sum_LRT_Calc:=String:C10([Scour Report:129]On_State_LRT_Calc:9)+" / "+String:C10([Scour Report:129]On_Agency_LRT_Calc:29)
vOff_Sum_LRT_Calc:=String:C10([Scour Report:129]Off_State_LRT_Calc:19)+" / "+String:C10([Scour Report:129]Off_Agency_LRT_Calc:39)
vTotal_Sum_LRT_Calc:=String:C10(vTotal_State_LRT_Calc)+" / "+String:C10(vTotal_Agency_LRT_Calc)
//``````````````````````````````` 2A-2 ```````````````````````````````` 
vTotal_State_LRT_Screen:=[Scour Report:129]On_State_LRT_Screen:10+[Scour Report:129]Off_State_LRT_Screen:20
vTotal_Agency_LRT_Screen:=[Scour Report:129]On_Agency_LRT_Screen:30+[Scour Report:129]Off_Agency_LRT_Screen:40

vOn_MA_LRT_Screen:=[Scour Report:129]On_State_LRT_Screen:10+[Scour Report:129]On_Agency_LRT_Screen:30
vOff_MA_LRT_Screen:=[Scour Report:129]Off_State_LRT_Screen:20+[Scour Report:129]Off_Agency_LRT_Screen:40
vTotal_MA_LRT_Screen:=[Scour Report:129]On_State_LRT_Screen:10+[Scour Report:129]On_Agency_LRT_Screen:30+[Scour Report:129]Off_State_LRT_Screen:20+[Scour Report:129]Off_Agency_LRT_Screen:40

vOn_Sum_LRT_Screen:=String:C10([Scour Report:129]On_State_LRT_Screen:10)+" / "+String:C10([Scour Report:129]On_Agency_LRT_Screen:30)
vOff_Sum_LRT_Screen:=String:C10([Scour Report:129]Off_State_LRT_Screen:20)+" / "+String:C10([Scour Report:129]Off_Agency_LRT_Screen:40)
vTotal_Sum_LRT_Screen:=String:C10(vTotal_State_LRT_Screen)+" / "+String:C10(vTotal_Agency_LRT_Screen)
//``````````````````````````````` 2A-3 ```````````````````````````````` 
vTotal_State_LRT_Culv:=[Scour Report:129]On_State_LRT_Culv:11+[Scour Report:129]Off_State_LRT_Culv:21
vTotal_Agency_LRT_Culv:=[Scour Report:129]On_Agency_LRT_Culv:31+[Scour Report:129]Off_Agency_LRT_Culv:41

vOn_MA_LRT_Culv:=[Scour Report:129]On_State_LRT_Culv:11+[Scour Report:129]On_Agency_LRT_Culv:31
vOff_MA_LRT_Culv:=[Scour Report:129]Off_State_LRT_Culv:21+[Scour Report:129]Off_Agency_LRT_Culv:41
vTotal_MA_LRT_Culv:=[Scour Report:129]On_State_LRT_Culv:11+[Scour Report:129]On_Agency_LRT_Culv:31+[Scour Report:129]Off_State_LRT_Culv:21+[Scour Report:129]Off_Agency_LRT_Culv:41

vOn_Sum_LRT_Culv:=String:C10([Scour Report:129]On_State_LRT_Culv:11)+" / "+String:C10([Scour Report:129]On_Agency_LRT_Culv:31)
vOff_Sum_LRT_Culv:=String:C10([Scour Report:129]Off_State_LRT_Culv:21)+" / "+String:C10([Scour Report:129]Off_Agency_LRT_Culv:41)
vTotal_Sum_LRT_Culv:=String:C10(vTotal_State_LRT_Culv)+" / "+String:C10(vTotal_Agency_LRT_Culv)
