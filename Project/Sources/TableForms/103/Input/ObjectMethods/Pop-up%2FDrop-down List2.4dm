If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: Object Method: WKHR_PageTitles
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(11/30/2005 10:38:30)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/21/2005 16:43:00)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(8/1/08 16:07:26)
	Mods_2008_CM_5404
	//  `bug fix of declaration of WKHR_ShowRevTotals_B
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=1
		FORM GOTO PAGE:C247(1)
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($LastPage)
		$LastPage:=Size of array:C274(Self:C308->)
		Case of 
			: (Self:C308->=1)
				OBJECT SET VISIBLE:C603(*; "Matrix@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Title_@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "ClearWKHRAllBtn"; True:C214)
				FORM GOTO PAGE:C247(Self:C308->)
			: (Self:C308->=$LastPage)
				OBJECT SET VISIBLE:C603(*; "Matrix@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Title_@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "ClearWKHRAllBtn"; True:C214)
				FORM GOTO PAGE:C247(3)
				
			: (Self:C308->=($LastPage-1))
				OBJECT SET VISIBLE:C603(*; "ClearWKHRAllBtn"; True:C214)
				OBJECT SET VISIBLE:C603(*; "Matrix@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "Title_@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "Title_tot@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "ClearWKHRAllBtn"; False:C215)
				FORM GOTO PAGE:C247(17)
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
				WKHR_CategoryNo:=Self:C308->
				CategoryPrefix:=Substring:C12(Self:C308->{WKHR_CategoryNo}; 1; 3)
				C_LONGINT:C283($PrefixPos_L)
				$PrefixPos_L:=Find in array:C230(<>a_WKH_Index_Name; CategoryPrefix)
				WKHR_MaxItemNo:=Arr_WKHR_MinItemN{$PrefixPos_L}
				WKHR_MaxDefItemNo:=<>a_WKH_LastDefID{$PrefixPos_L}
				WKHR_LoadItemHRs
				
		End case 
End case 
