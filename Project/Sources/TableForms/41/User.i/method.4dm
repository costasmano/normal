// ----------------------------------------------------
// Form Method: User.i
// User name (OS): charlesmiller
// Date and time: 05/28/09, 12:23:01
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r002 `05/28/09, 12:23:03   `Add code and tables to retrieve pontis simulation data
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		QUERY:C277([Pontis_Metric_Data:40]; [Pontis_Metric_Data:40]PM_UNiqueKey_s:1=[Pontis_Metrics:41]PM_UniqueKey_s:2)
		ORDER BY:C49([Pontis_Metric_Data:40]; [Pontis_Metric_Data:40]PMD_YKey_l:2; >)
		
		C_LONGINT:C283($Size_l)
		$Size_l:=Records in selection:C76([Pontis_Metric_Data:40])
		ARRAY LONGINT:C221(PM_YKey_al; $Size_l)
		ARRAY REAL:C219(PM_Hindex_ar; $Size_l)
		ARRAY LONGINT:C221(PM_ADT_al; $Size_l)
		ARRAY REAL:C219(PM_PTIndex_ar; $Size_l)
		ARRAY REAL:C219(PM_CIX_Supr_ar; $Size_l)
		ARRAY REAL:C219(PM_CIX_Sub_ar; $Size_l)
		ARRAY REAL:C219(PM_CIX_Joint_ar; $Size_l)
		ARRAY REAL:C219(PM_CIX_Bear_ar; $Size_l)
		ARRAY REAL:C219(PM_CIX_Deck_ar; $Size_l)
		SELECTION TO ARRAY:C260([Pontis_Metric_Data:40]PMD_ADT_l:4; PM_ADT_al; [Pontis_Metric_Data:40]PMD_CIX_Bear_r:9; PM_CIX_Bear_ar; [Pontis_Metric_Data:40]PMD_CIX_Deck_r:10; PM_CIX_Deck_ar; [Pontis_Metric_Data:40]PMD_CIX_Joint_r:8; PM_CIX_Joint_ar; [Pontis_Metric_Data:40]PMD_CIX_Sub_r:7; PM_CIX_Sub_ar; [Pontis_Metric_Data:40]PMD_CIX_Supr_r:6; PM_CIX_Supr_ar; [Pontis_Metric_Data:40]PMD_Hindex_r:3; PM_Hindex_ar; [Pontis_Metric_Data:40]PMD_PTIndex_r:5; PM_PTIndex_ar; [Pontis_Metric_Data:40]PMD_YKey_l:2; PM_YKey_al)
		
		
	: (Form event code:C388=On Unload:K2:2)
		SQL_ClearArrays("sp_RTRV_Metricdata")
		
End case 


//End Form Method: User.i