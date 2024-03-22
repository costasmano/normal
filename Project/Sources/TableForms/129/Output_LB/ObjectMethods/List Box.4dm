//Method: [Scour Report].Output_LB.List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/31/22, 16:34:57
	// ----------------------------------------------------
	//Created : 
	Mods_2022_05
End if 
//
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		vOn_MA_OverWaterways:=[Scour Report:129]On_Agency_LowRiskTotal:22+[Scour Report:129]On_Agency_ScourSuscept:23+[Scour Report:129]On_Agency_Unknown:24+[Scour Report:129]On_Agency_Tidal:25+[Scour Report:129]On_Agency_ScourCrit:26+[Scour Report:129]On_State_LowRiskTotal:2+[Scour Report:129]On_State_ScourSuscept:3+[Scour Report:129]On_State_Unknown:4+[Scour Report:129]On_State_Tidal:5+[Scour Report:129]On_State_ScourCrit:6
		vOff_MA_OverWaterways:=[Scour Report:129]Off_Agency_LowRiskTotal:32+[Scour Report:129]Off_Agency_ScourSuscept:33+[Scour Report:129]Off_Agency_Unknown:34+[Scour Report:129]Off_Agency_Tidal:35+[Scour Report:129]Off_Agency_ScourCrit:36+[Scour Report:129]Off_State_LowRiskTotal:12+[Scour Report:129]Off_State_ScourSuscept:13+[Scour Report:129]Off_State_Unknown:14+[Scour Report:129]Off_State_Tidal:15+[Scour Report:129]Off_State_ScourCrit:16
		vTotal_MA_OverWaterways:=vOn_MA_OverWaterways+vOff_MA_OverWaterways
		
End case 
//End [Scour Report].Output_LB.List Box