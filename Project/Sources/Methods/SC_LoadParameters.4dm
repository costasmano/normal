//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:57:23
	// ----------------------------------------------------
	// Method: SC_LoadParameters
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(6/10/08 10:12:01)
	Mods_2008_CM_5403("SCOUR")
	//Load table 70_26, 60_61, FailProb
End if 
C_REAL:C285(SC_TravelCostPassenger_r; SC_TravelCostTruck_r; SC_DesignSpeed_r; SC_Occupancy_r; SC_KilometerCost_r)
C_REAL:C285(SC_CategoryALimit_r; SC_CategoryBLimit_r; SC_CategoryCLimit_r; SC_CategoryDLimit_r)
C_REAL:C285(SC_InterStateMaxDet_r; SC_NonInterStateMaxDet_r; SC_LocalRdMaxDet_r; SC_CostPerFatality)
C_LONGINT:C283(SC_MaxLife_L; SC_MinLife_L)
C_REAL:C285(SC_BrgReplCost_r; SC_BrgPrjOvrhdFactor_r)
C_TEXT:C284(SC_ITEM113Filter_txt)
READ ONLY:C145([Parameters:107])
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_CAT_A")
SC_CategoryALimit_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_CAT_B")
SC_CategoryBLimit_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_CAT_C")
SC_CategoryCLimit_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_CAT_D")
SC_CategoryDLimit_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TCP")
SC_TravelCostPassenger_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TCT")
SC_TravelCostTruck_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_DS")
SC_DesignSpeed_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_O")
SC_Occupancy_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_KC")
SC_KilometerCost_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_INT_Max19")
SC_InterStateMaxDet_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_NInt_Max19")
SC_NonInterStateMaxDet_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_Local_Max19")
SC_LocalRdMaxDet_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_FATCost")
SC_CostPerFatality:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_MAXLIFE")
SC_MaxLife_L:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_MINLIFE")
SC_MinLife_L:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_Item113Filter")
SC_ITEM113Filter_txt:=[Parameters:107]Value:3
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="BRG_REPLCOST_AVG")
SC_BrgReplCost_r:=Num:C11([Parameters:107]Value:3)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="BRG_PROJOVRFACTOR")
SC_BrgPrjOvrhdFactor_r:=Num:C11([Parameters:107]Value:3)
SC_BrgReplCost_r:=SC_BrgReplCost_r*SC_BrgPrjOvrhdFactor_r

ARRAY TEXT:C222(SC_TBLFail_colH_atxt; 0)
ARRAY TEXT:C222(SC_TBLFail_RowH_atxt; 0)
ARRAY TEXT:C222(SC_TBL6061_RowH_atxt; 0)
ARRAY TEXT:C222(SC_TBL6061_ColH_atxt; 0)
ARRAY TEXT:C222(SC_TBL71vs26_colH_atxt; 0)
C_BLOB:C604($temp_blob)

ARRAY TEXT:C222(SC_TBL6061_Rows_atxt; 0)
ARRAY TEXT:C222(SC_TBLFail_Rows_atxt; 0)
ARRAY TEXT:C222(SC_TBL71vs26_Cols_atxt; 0)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TBLFail_colH")
$temp_blob:=ut_ParseTextToArrayDelim([Parameters:107]Value:3; ",")
BLOB TO VARIABLE:C533($temp_blob; SC_TBLFail_colH_atxt)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TBLFail_RowH")
$temp_blob:=ut_ParseTextToArrayDelim([Parameters:107]Value:3; ",")
BLOB TO VARIABLE:C533($temp_blob; SC_TBLFail_RowH_atxt)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TBL6061_RowH")
$temp_blob:=ut_ParseTextToArrayDelim([Parameters:107]Value:3; ",")
BLOB TO VARIABLE:C533($temp_blob; SC_TBL6061_RowH_atxt)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TBL6061_ColH")
$temp_blob:=ut_ParseTextToArrayDelim([Parameters:107]Value:3; ",")
BLOB TO VARIABLE:C533($temp_blob; SC_TBL6061_ColH_atxt)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TBL71vs26_colH")
$temp_blob:=ut_ParseTextToArrayDelim([Parameters:107]Value:3; ",")
BLOB TO VARIABLE:C533($temp_blob; SC_TBL71vs26_colH_atxt)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TBL6061_Row@"; *)
QUERY:C277([Parameters:107];  & ; [Parameters:107]ParamCode:1#"SC_TBL6061_RowH")
ORDER BY:C49([Parameters:107]; [Parameters:107]ParamCode:1)
SELECTION TO ARRAY:C260([Parameters:107]Value:3; SC_TBL6061_Rows_atxt)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TBLFail_Row@"; *)
QUERY:C277([Parameters:107];  & ; [Parameters:107]ParamCode:1#"SC_TBLFail_RowH")
ORDER BY:C49([Parameters:107]; [Parameters:107]ParamCode:1)
SELECTION TO ARRAY:C260([Parameters:107]Value:3; SC_TBLFail_Rows_atxt)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_TBL71vs26_Col@"; *)
QUERY:C277([Parameters:107];  & ; [Parameters:107]ParamCode:1#"SC_TBL71vs26_ColH")
ORDER BY:C49([Parameters:107]; [Parameters:107]ParamCode:1)
SELECTION TO ARRAY:C260([Parameters:107]Description:2; SC_TBL71vs26_Cols_atxt)

SET BLOB SIZE:C606($temp_blob; 0)
UNLOAD RECORD:C212([Parameters:107])
REDUCE SELECTION:C351([Parameters:107]; 0)