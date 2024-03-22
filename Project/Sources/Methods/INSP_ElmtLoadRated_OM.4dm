//%attributes = {"invisible":true}
// Method: INSP_ElmtLoadRated_OM
// Description
//  `New method for the Element Rated checkbox in ElementSafety input forms
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 04/15/14, 18:20:25
	// ----------------------------------------------------
	// First Release
	Mods_2014_04
	// Modified by: Costas Manousakis-(Designer)-(4/25/14 11:18:06)
	Mods_2014_04
	//  `use methods INSP_LoadElmRtgDefs and INSP_SetElmRatingValue
	// Modified by: Costas Manousakis-(Designer)-(3/9/17 17:10:24)
	Mods_2017_03
	//  `no need to  assign values to the dummy filelds in [ElmtRatingLoads]
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
ARRAY TEXT:C222($ratingVarPref_atxt; 0)
ARRAY POINTER:C280($ratingField_aptr; 0)
C_LONGINT:C283($numRatings_L; $ratingLoop_L)
$numRatings_L:=INSP_LoadElmRtgDefs(->$ratingVarPref_atxt; ->$ratingField_aptr)

Case of 
	: ($FormEvent_L=On Load:K2:1)
		C_REAL:C285($loadCheck_r)
		$loadCheck_r:=0
		For ($ratingLoop_L; 1; $numRatings_L)
			If (Is record loaded:C669(Table:C252(Table:C252($ratingField_aptr{$ratingLoop_L}))->))
				$loadCheck_r:=$loadCheck_r+$ratingField_aptr{$ratingLoop_L}->
			End if 
		End for 
		
		If ($loadCheck_r<0)
			vLoadRtgNA:=1
			OBJECT SET ENTERABLE:C238(*; "DE LoadRating@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "DE LoadRating@"; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE LoadRating@"; <>Color_Not_editable)
		Else 
			OBJECT SET ENTERABLE:C238(*; "DE LoadRating@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "DE LoadRating@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE LoadRating@"; <>Color_editable)
			vLoadRtgNA:=0
		End if 
		
	: ($FormEvent_L=On Clicked:K2:4)
		If (vLoadRtgNA=1)
			INSP_SetElmRatingValue(->$ratingField_aptr; -1)
			//[ElmtRatingLoads]R_HSP46_r:=""
			//[ElmtRatingLoads]Dummy2_s:=""
			PushChange(2; ->[ElementsSafety:29]Inv H20:11)
			PushChange(2; ->[ElementsSafety:29]Inv Type 3:12)
			PushChange(2; ->[ElementsSafety:29]Inv 3S2:13)
			OBJECT SET ENTERABLE:C238(*; "DE LoadRating@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "DE LoadRating@"; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE LoadRating@"; <>Color_Not_editable)
			
		Else 
			INSP_SetElmRatingValue(->$ratingField_aptr; 0)
			PushChange(2; ->[ElementsSafety:29]Inv H20:11)
			PushChange(2; ->[ElementsSafety:29]Inv Type 3:12)
			PushChange(2; ->[ElementsSafety:29]Inv 3S2:13)
			
			//If (Is record loaded([RAILBridgeInfo]))
			//If (Is record loaded([ElmtRatingLoads]))
			//[ElmtRatingLoads]Dummy2_s:=[RAILBridgeInfo]Rating_WorkCar_desc_s
			//[ElmtRatingLoads]R_HSP46_r:=[RAILBridgeInfo]Rating_RevCar_desc_s
			//End if 
			//
			//End if 
			OBJECT SET ENTERABLE:C238(*; "DE LoadRating@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "DE LoadRating@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE LoadRating@"; <>Color_editable)
		End if 
		
End case 
//End INSP_ElmtLoadRated_OM