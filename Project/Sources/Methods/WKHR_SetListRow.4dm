//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/20/05, 13:55:25
	// ----------------------------------------------------
	// Method: WKHR_SetListRow
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
C_LONGINT:C283($1; $rownum)
$rownum:=$1
Arr_ItemNos:=$rownum
Arr_ItemDesc:=$rownum
Arr_Values_1:=$rownum
Arr_Values_2:=$rownum
Arr_Values_3:=$rownum
Arr_Values_4:=$rownum
Arr_Values_5:=$rownum
Arr_Values_6:=$rownum

QUERY:C277([WorkHour_Summary:105]; [WorkHour_Summary:105]ProjType:1=[Contract_Assignment_Maintenance:101]ProjectType:36; *)
QUERY:C277([WorkHour_Summary:105];  & ; [WorkHour_Summary:105]ItemID:2=Num:C11(Arr_ItemNos{Arr_ItemNos}))
If (Records in selection:C76([WorkHour_Summary:105])=1)
	wkhr_ItmAvg_1:=[WorkHour_Summary:105]AvgCol1:3
	wkhr_ItmAvg_2:=[WorkHour_Summary:105]AvgCol2:4
	wkhr_ItmAvg_3:=[WorkHour_Summary:105]AvgCol3:5
	wkhr_ItmAvg_4:=[WorkHour_Summary:105]AvgCol4:6
	wkhr_ItmAvg_5:=[WorkHour_Summary:105]AvgCol5:7
	wkhr_ItmAvg_6:=[WorkHour_Summary:105]AvgSum:8
Else 
	wkhr_ItmAvg_1:=0
	wkhr_ItmAvg_2:=0
	wkhr_ItmAvg_3:=0
	wkhr_ItmAvg_4:=0
	wkhr_ItmAvg_5:=0
	wkhr_ItmAvg_6:=0
End if 
