//Method: [Conslt_Name].Conslt_Name_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 07/07/20, 13:32:01
	// ----------------------------------------------------
	//Created : 
	Mods_2020_07
End if 
//
Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Load:K2:1)
		ut_SetSortColumns(2; 1)
		SortColumn1_l:=1
		ORDER BY:C49([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2; >)
	: (Form event code:C388=On Display Detail:K2:22)
		PRJ_SetUpStructuralPrjMgr(->[Conslt_Name:127]; [Conslt_Name:127]CurrentStructureProjectMgr_l:4)
		
End case 
//End [Conslt_Name].Conslt_Name_LB