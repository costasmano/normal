//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetUpFederalReview
// User name (OS): Charles Miller
// Date and time: 05/18/07, 14:59:38
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //r060   `05/18/07, 14:59:40
End if 
C_BOOLEAN:C305($1; $AccessAllowed_b)
If (Count parameters:C259=1)
	$AccessAllowed_b:=$1
Else 
	$AccessAllowed_b:=PRJ_ReturnAccessAllowed
End if 
If ([PRJ_ProjectDetails:115]PRJ_FederalReviewRequired_b:42)
	OBJECT SET VISIBLE:C603(*; "FederalReview@"; True:C214)
	If ($AccessAllowed_b)
		OBJECT SET RGB COLORS:C628(*; "FederalReview@"; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "FederalReview@"; <>PRJ_Color_Editable)
		OBJECT SET ENTERABLE:C238(*; "FederalReview@"; True:C214)
	Else 
		OBJECT SET RGB COLORS:C628(*; "FederalReview@"; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "FederalReview@"; <>PRJ_Color_Not_editable)
		OBJECT SET ENTERABLE:C238(*; "FederalReview@"; False:C215)
	End if 
Else 
	OBJECT SET VISIBLE:C603(*; "FederalReview@"; False:C215)
End if 

//End PRJ_SetUpFederalReview