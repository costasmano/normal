//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_GetSelectedBridges
// User name (OS): cjmiller
// Date and time: 01/19/06, 11:23:16
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //12/14/06, 11:16:54`Add order by for display
	Mods_2007_CJMv2  //04/30/07, 11:50:26`Fix compiler errors
End if 
OBJECT SET VISIBLE:C603(Button2; False:C215)
ALL RECORDS:C47([Bridge MHD NBIS:1])
COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "UserRegionA")
C_POINTER:C301(pFIle)
C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
MainTitle:=""
pFile:=->[Bridge MHD NBIS:1]
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=<>PRJ_SelectedData_txt+"@")
ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; >; [Bridge MHD NBIS:1]BIN:3; >)
<>PRJ_SelectedData_txt:=""
//End PRJ_GetSelectedBridges