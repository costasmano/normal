If (False:C215)
	//[Dialogs]DependencyCheck
	//July 7, 2003
	//Albert Leung
	//Resolve differences between values in inspection report and other reports.  
	//Called by CheckDependencies
	
	Mods_2005_CM01
	// Modified by: Costas Manousakis-(Designer)-(9/1/15 17:08:16)
	Mods_2015_09
	//  `Adjusted some button/object size and re-set stylesheets
	// Modified by: Costas Manousakis-(Designer)-(11/27/17 12:06:43)
	Mods_2017_11
	//  `added on Page Change event to the form events;
	//  `Replaced title on page 2 with styled text variable using the UUID var for the ratingsreports
	//  `added code on page change event to set the title when using Yr Rebuilt as a cutoff date for reports - does not work on load 
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY POINTER:C280(apChkItemVars_1; 0)
		ARRAY POINTER:C280(apChkItemVars_2; 0)
		C_LONGINT:C283($vlHiLiteColor; $k)
		
		$vlHiLiteColor:=-(Black:K11:16+(256*Yellow:K11:2))
		$k:=1
		If (Not:C34(vblnChkItem43))
			OBJECT SET ENABLED:C1123(*; "cbStructureType"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@StructureType@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@StructureType@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@StructureType@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_1; $k)
			apChkItemVars_1{$k}:=->blnStructureType
			$k:=$k+1
		End if 
		If (Not:C34(vblnChkItem107))
			OBJECT SET ENABLED:C1123(*; "cbItem107"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@Item107@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@Item107@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@Item107@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_1; $k)
			apChkItemVars_1{$k}:=->blnItem107
			$k:=$k+1
		End if 
		If (Not:C34(vblnChkItem106))
			OBJECT SET ENABLED:C1123(*; "cbItem106"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@Item106@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@Item106@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@Item106@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_1; $k)
			apChkItemVars_1{$k}:=->blnItem106
			$k:=$k+1
		End if 
		If (Not:C34(vblnChkItem21))
			OBJECT SET ENABLED:C1123(*; "cbItem21"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@Item21@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@Item21@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@Item21@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_1; $k)
			apChkItemVars_1{$k}:=->blnItem21
			$k:=$k+1
		End if 
		If (Not:C34(vblnChkItem22))
			OBJECT SET ENABLED:C1123(*; "cbItem22"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@Item22@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@Item22@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@Item22@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_1; $k)
			apChkItemVars_1{$k}:=->blnItem22
			$k:=$k+1
		End if 
		If (Not:C34(vblnChkItem26))
			OBJECT SET ENABLED:C1123(*; "cbItem26"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@Item26@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@Item26@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@Item26@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_1; $k)
			apChkItemVars_1{$k}:=->blnItem26
			$k:=$k+1
		End if 
		If (Not:C34(vblnWeightPosting))
			OBJECT SET ENABLED:C1123(*; "cbWeightPosting"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@WeightPosting@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@WeightPosting@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@WeightPosting@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_1; $k)
			apChkItemVars_1{$k}:=->blnWeightPosting
		End if 
		If (Not:C34(vblnEDJMTDate))
			OBJECT SET ENABLED:C1123(*; "cbEDJMTDate"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@EDJMTDate@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@EDJMTDate@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@EDJMTDate@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_1; $k)
			apChkItemVars_1{$k}:=->blnEDJMTDate
			$k:=$k+1
		End if 
		If (Not:C34(vblnWaivedDate))
			OBJECT SET ENABLED:C1123(*; "cbWaivedDate"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@WaivedDate@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@WaivedDate@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@WaivedDate@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_1; $k)
			apChkItemVars_1{$k}:=->blnWaivedDate
		End if 
		
		$k:=1
		If (Not:C34(vblnRatingReport))
			OBJECT SET ENABLED:C1123(*; "cbRatingReport"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@RatingReport@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@RatingReport@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@RatingReport@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_2; $k)
			apChkItemVars_2{$k}:=->blnRatingReport
			$k:=$k+1
		End if 
		If (Not:C34(vblnRatingDate))
			OBJECT SET ENABLED:C1123(*; "cbRatingDate"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@RatingDate@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@RatingDate@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@RatingDate@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_2; $k)
			apChkItemVars_2{$k}:=->blnRatingDate
			$k:=$k+1
		End if 
		If (Not:C34(vblnRecomPostingH))
			OBJECT SET ENABLED:C1123(*; "cbRecomPostingH"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@RecomPostingH@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@RecomPostingH@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@RecomPostingH@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_2; $k)
			apChkItemVars_2{$k}:=->blnRecomPostingH
			$k:=$k+1
		End if 
		If (Not:C34(vblnRecomPosting3))
			OBJECT SET ENABLED:C1123(*; "cbRecomPosting3"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@RecomPosting3@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@RecomPosting3@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@RecomPosting3@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_2; $k)
			apChkItemVars_2{$k}:=->blnRecomPosting3
			$k:=$k+1
		End if 
		If (Not:C34(vblnRecomPosting3S2))
			OBJECT SET ENABLED:C1123(*; "cbRecomPosting3S2"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@RecomPosting3S2@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@RecomPosting3S2@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@RecomPosting3S2@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_2; $k)
			apChkItemVars_2{$k}:=->blnRecomPosting3S2
			$k:=$k+1
		End if 
		If (Not:C34(vblnRecomPostingSgl))
			OBJECT SET ENABLED:C1123(*; "cbRecomPostingSgl"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET RGB COLORS:C628(*; "@RecomPostingSgl@"; Col_paletteToRGB(Abs:C99($vlHiLiteColor)%256); Col_paletteToRGB(Abs:C99($vlHiLiteColor)\256))  // **Replaced o OBJECT SET COLOR(*; "@RecomPostingSgl@"; $vlHiLiteColor)
			OBJECT SET FONT STYLE:C166(*; "@RecomPostingSgl@"; Bold:K14:2)
			INSERT IN ARRAY:C227(apChkItemVars_2; $k)
			apChkItemVars_2{$k}:=->blnRecomPostingSgl
			$k:=$k+1
		End if 
		ARRAY TEXT:C222(vtbDependencyCheck; 2)
		$k:=1
		C_LONGINT:C283($viStartPage)  //Command Replaced was o_C_INTEGER
		$viStartPage:=1
		If (Size of array:C274(apChkItemVars_1)>0)
			vtbDependencyCheck{$k}:="SIA"
			$k:=$k+1
		End if 
		If (Size of array:C274(apChkItemVars_2)>0)
			If ($k=1)
				$viStartPage:=2
				DELETE FROM ARRAY:C228(vtbDependencyCheck; 1; 1)
			End if 
			vtbDependencyCheck{$k}:="Rating Report"
		Else 
			DELETE FROM ARRAY:C228(vtbDependencyCheck; 2; 1)
		End if 
		FORM GOTO PAGE:C247($viStartPage)
	: (Form event code:C388=On Page Change:K2:54)
		C_TEXT:C284(v_65_035_txt)
		v_65_035_txt:=""
		
		If ([Bridge MHD NBIS:1]Item106:84>0)
			ST SET TEXT:C1115(v_65_035_txt; "To value from last rating report on/after Year ReBuilt (I-106) "+String:C10([Bridge MHD NBIS:1]Item106:84); ST Start text:K78:15; ST End text:K78:16)
			ST SET ATTRIBUTES:C1093(v_65_035_txt; Position:C15("on/after"; "To value from last rating report on/after Year ReBuilt (I-106) "); ST End text:K78:16; Attribute text color:K65:7; "Red")
		Else 
			ST SET TEXT:C1115(v_65_035_txt; "To value from last rating report"; ST Start text:K78:15; ST End text:K78:16)
		End if 
		
End case 