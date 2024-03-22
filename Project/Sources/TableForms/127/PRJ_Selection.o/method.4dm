// ----------------------------------------------------
// Form Method: PRJ_Selection.o
// User name (OS): cjmiller
// Date and time: 11/30/06, 10:59:50
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5302  //r003 `10/09/07, 15:56:35`Add filter event so we never get to input frm
	// Modified by: costasmanousakis-(Designer)-(11/19/07 15:57:53)
	Mods_2007_CM_5401
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (<>SelectionOption_txt="Consultant") | (<>SelectionOption_txt="OverideConsultant")
			OBJECT SET VISIBLE:C603(PRJ_DetailInfo_txt; False:C215)
			OBJECT SET VISIBLE:C603(PRJ_SelectName_atxt; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(PRJ_DetailInfo_txt; True:C214)
			OBJECT SET VISIBLE:C603(PRJ_SelectName_atxt; True:C214)
		End if 
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
	: (Form event code:C388=On Display Detail:K2:22)
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[Conslt_Name:127]ConsultantNameID_l:1)
	: (Form event code:C388=On Double Clicked:K2:5)
		FILTER EVENT:C321
		<>PRJ_SelectedData_txt:=String:C10([Conslt_Name:127]ConsultantNameID_l:1)
		If (<>SelectionOption_txt="Consultant") | (<>SelectionOption_txt="OverideConsultant")
			POST OUTSIDE CALL:C329(<>ProjectProcess_l)
			//HIDE PROCESS(Current process)
			//PAUSE PROCESS(Current process)
		Else 
			CANCEL:C270
		End if 
End case 
//End Form Method: PRJ_Selection.o