//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/20/05, 22:54:32
	// ----------------------------------------------------
	// Method: WKHR_Input_GotoPage
	// Description
	// Handle Goto page events from the pulldown
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(12/3/07 12:20:53)
	Mods_2007_CM_5401  //hide or show the accept reviewer buttons-
	//  `change for number of form pages changed to 4
	// Modified by: costasmanousakis-(Designer)-(8/1/08 16:07:26)
	Mods_2008_CM_5404
	//  `bug fix of declaration of WKHR_ShowRevTotals_B
End if 
C_LONGINT:C283($LastPage)
$LastPage:=Size of array:C274(WKHR_PageTitles)
Case of 
	: (WKHR_PageTitles=1)
		OBJECT SET VISIBLE:C603(*; "Matrix@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Title_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "ClearWKHRAllBtn"; True:C214)
		FORM GOTO PAGE:C247(WKHR_PageTitles)
	: (WKHR_PageTitles=$LastPage)
		OBJECT SET VISIBLE:C603(*; "Matrix@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Title_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "ClearWKHRAllBtn"; True:C214)
		FORM GOTO PAGE:C247(3)
		
	: (WKHR_PageTitles=($LastPage-1))
		OBJECT SET VISIBLE:C603(*; "ClearWKHRAllBtn"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Matrix@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Title_@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Title_tot@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "ClearWKHRAllBtn"; False:C215)
		FORM GOTO PAGE:C247(4)
		WKHR_ItalisizeLabels
		C_BOOLEAN:C305(WKHR_ShowRevTotals_B)
		If (Size of array:C274(Arr_WKHR_ReviewRef)>0)
			WKHR_ShowRevTotals_B:=True:C214
			WKHR_CalcTotals
			OBJECT SET VISIBLE:C603(*; "ShowReviewtotals"; True:C214)
			OBJECT SET TITLE:C194(*; "ShowReviewtotals"; "Show Reviewer Totals")
		Else 
			OBJECT SET VISIBLE:C603(*; "ShowReviewtotals"; False:C215)
		End if 
		
	Else 
		OBJECT SET VISIBLE:C603(*; "ClearWKHRAllBtn"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Matrix@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Title_@"; True:C214)
		C_LONGINT:C283(WKHR_CategoryNo; WKHR_MaxItemNo; WKHR_MaxDefItemNo)  //Command Replaced was o_C_INTEGER
		FORM GOTO PAGE:C247(2)
		WKHR_CategoryNo:=WKHR_PageTitles
		CategoryPrefix:=Substring:C12(WKHR_PageTitles{WKHR_CategoryNo}; 1; 3)
		C_LONGINT:C283($PrefixPos_L)
		$PrefixPos_L:=Find in array:C230(<>a_WKH_Index_Name; CategoryPrefix)
		WKHR_MaxItemNo:=Arr_WKHR_MinItemN{$PrefixPos_L}
		WKHR_MaxDefItemNo:=<>a_WKH_LastDefID{$PrefixPos_L}
		WKHR_LoadItemHRs
		OBJECT SET VISIBLE:C603(*; "AccptReview@"; False:C215)
		If (WKHR_RoleDesigner_b)
			If (([Work_Estimate:103]WkHrEstReviewed:33=BMS Rejected) | ([Work_Estimate:103]WkHrEstApproved:18=BMS Rejected))
				If (wkhr_RevPgTotal_6>0)
					OBJECT SET VISIBLE:C603(*; "AccptReview@"; True:C214)
				End if 
			End if 
		End if 
		
End case 