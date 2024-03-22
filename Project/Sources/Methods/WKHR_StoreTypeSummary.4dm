//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/11/05, 14:51:14
	// ----------------------------------------------------
	// Method: WKHR_StoreTypeSummary
	// Description
	// Compute final numbers and store in table
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_TEXT:C284($1; $ProjType)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283($2; $DivideBy; $NumItems; $i)
$ProjType:=$1
$DivideBy:=$2
$NumItems:=Size of array:C274(ArrSum_ItemNos)
ARRAY TEXT:C222($arr_CatType; $NumItems)  //Command Replaced was o_ARRAY string length was 40
ARRAY INTEGER:C220($arr_ItemNos; $NumItems)
ARRAY LONGINT:C221($arr_Val1; $NumItems)
ARRAY LONGINT:C221($arr_Val2; $NumItems)
ARRAY LONGINT:C221($arr_Val3; $NumItems)
ARRAY LONGINT:C221($arr_Val4; $NumItems)
ARRAY LONGINT:C221($arr_Val5; $NumItems)
ARRAY LONGINT:C221($arr_Val6; $NumItems)
For ($i; 1; $NumItems)
	$arr_CatType{$i}:=$ProjType
	$arr_ItemNos{$i}:=Num:C11(ArrSum_ItemNos{$i})
	If (ArrSum_ItemCnt{$i}>0)
		$arr_Val1{$i}:=ArrSum_ItemValues{1}{$i}\ArrSum_ItemCnt{$i}
		$arr_Val2{$i}:=ArrSum_ItemValues{2}{$i}\ArrSum_ItemCnt{$i}
		$arr_Val3{$i}:=ArrSum_ItemValues{3}{$i}\ArrSum_ItemCnt{$i}
		$arr_Val4{$i}:=ArrSum_ItemValues{4}{$i}\ArrSum_ItemCnt{$i}
		$arr_Val5{$i}:=ArrSum_ItemValues{5}{$i}\ArrSum_ItemCnt{$i}
		$arr_Val6{$i}:=ArrSum_ItemValues{6}{$i}\ArrSum_ItemCnt{$i}
	End if 
End for 
QUERY:C277([WorkHour_Summary:105]; [WorkHour_Summary:105]ProjType:1=$ProjType)
ARRAY TO SELECTION:C261($arr_CatType; [WorkHour_Summary:105]ProjType:1; $arr_ItemNos; [WorkHour_Summary:105]ItemID:2; $arr_Val1; [WorkHour_Summary:105]AvgCol1:3; $arr_Val2; [WorkHour_Summary:105]AvgCol2:4; $arr_Val3; [WorkHour_Summary:105]AvgCol3:5; $arr_Val4; [WorkHour_Summary:105]AvgCol4:6; $arr_Val5; [WorkHour_Summary:105]AvgCol5:7; $arr_Val6; [WorkHour_Summary:105]AvgSum:8)
