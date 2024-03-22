//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/11/05, 13:39:15
	// ----------------------------------------------------
	// Method: WKHR_InitSumVars
	// Description
	// Initialize arrays used in summing Work hours
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
ARRAY TEXT:C222(ArrSum_ItemNos; 0)  //Item Number
ARRAY REAL:C219(ArrSum_ItemValues; 6; 0)  //Item Hours
ARRAY INTEGER:C220(ArrSum_ItemCnt; 0)
C_LONGINT:C283($NumRows; $i)
$NumRows:=Size of array:C274(Arr_AllCategories_txt)
ARRAY TEXT:C222(ArrSum_ItemNos; $NumRows)  //Item Number
ARRAY REAL:C219(ArrSum_ItemValues; 6; $NumRows)  //Item Hours
ARRAY INTEGER:C220(ArrSum_ItemCnt; $NumRows)
For ($i; 1; $NumRows)
	ArrSum_ItemNos{$i}:=Substring:C12(Arr_AllCategories_txt{$i}; 1; 3)
End for 
