//%attributes = {"invisible":true}
//Method: SR_SDMetricsDetail_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/03/19, 13:00:06
	// ----------------------------------------------------
	//Created : 
	Mods_2019_09
End if 
//

SR_StatusRptPrint_FM

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_TEXT:C284($format_txt; $Pct_fmt_txt)
		$format_txt:="###,###,###,##0"
		$Pct_fmt_txt:="##0;NA;0"
		//fill out the objects 
		//S_SD_P_Dx  : % SD State Dx
		//S_NHS_SD_P_D1
		//T_SD_P_D1
		//T_NHS_SD_P_D1
		//ST_D1
		//ST_SD_D1
		//ST_SD_P_D1
		//ST_NHS_D1
		//ST_NHS_SD_D1
		//ST_NHS_SD_P_D1
		
		C_LONGINT:C283($Dist_L)
		C_POINTER:C301($S_Area_ptr; $S_SD_area_ptr; $T_area_ptr; $T_SD_area_ptr; $S_NHS_Area_ptr; $S_NHS_SD_Area_ptr; $T_NHS_Area_ptr; $T_NHS_SD_Area_ptr)
		C_REAL:C285($S_area; $S_SD_Area; $t_area; $t_SD_area; $S_NHS_Area; $S_NHS_SD_area; $T_NHS_Area; $T_NHS_SD_area)
		C_REAL:C285($ST_area; $ST_SD_Area; $ST_NHS_Area; $ST_NHS_SD_area)
		C_REAL:C285($Sqm_ft)
		$Sqm_ft:=1/(0.3048*0.3048)
		For ($Dist_L; 1; 6)
			$S_Area_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($Dist_L)+"_Area")
			$S_SD_area_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($Dist_L)+"_SD_Area")
			$S_NHS_Area_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($Dist_L)+"_NHS_Area")
			$S_NHS_SD_Area_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($Dist_L)+"_NHS_SD_Area")
			
			$T_area_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($Dist_L)+"_Area")
			$T_SD_area_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($Dist_L)+"_SD_Area")
			$T_NHS_Area_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($Dist_L)+"_NHS_Area")
			$T_NHS_SD_Area_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($Dist_L)+"_NHS_SD_Area")
			
			$S_area:=$S_Area_ptr->
			$S_SD_Area:=$S_SD_area_ptr->
			$S_NHS_area:=$S_NHS_Area_ptr->
			$S_NHS_SD_Area:=$S_NHS_SD_area_ptr->
			
			$T_area:=$T_Area_ptr->
			$T_SD_Area:=$T_SD_area_ptr->
			$T_NHS_area:=$T_NHS_Area_ptr->
			$T_NHS_SD_Area:=$T_NHS_SD_area_ptr->
			
			
			If (STATREP_ENGLISH_b)
				$S_area:=$S_area*$Sqm_ft
				$S_SD_Area:=$S_SD_Area*$Sqm_ft
				$S_NHS_area:=$S_NHS_area*$Sqm_ft
				$S_NHS_SD_Area:=$S_NHS_SD_Area*$Sqm_ft
				
				$T_area:=$T_area*$Sqm_ft
				$T_SD_Area:=$T_SD_Area*$Sqm_ft
				$T_NHS_area:=$T_NHS_area*$Sqm_ft
				$T_NHS_SD_Area:=$T_NHS_SD_Area*$Sqm_ft
				
			End if 
			
			$S_area:=Round:C94($S_area; 0)
			$S_SD_Area:=Round:C94($S_SD_Area; 0)
			$S_NHS_area:=Round:C94($S_NHS_area; 0)
			$S_NHS_SD_Area:=Round:C94($S_NHS_SD_Area; 0)
			
			$T_area:=Round:C94($T_area; 0)
			$T_SD_Area:=Round:C94($T_SD_Area; 0)
			$T_NHS_area:=Round:C94($T_NHS_area; 0)
			$T_NHS_SD_Area:=Round:C94($T_NHS_SD_Area; 0)
			
			
			$ST_area:=$S_area+$T_area
			$ST_SD_Area:=$S_SD_Area+$T_SD_Area
			$ST_NHS_area:=$S_NHS_area+$T_NHS_area
			$ST_NHS_SD_Area:=$S_NHS_SD_Area+$T_NHS_SD_Area
			
			OBJECT SET TITLE:C194(*; "S_D"+String:C10($Dist_L); String:C10($S_area; $format_txt))
			OBJECT SET TITLE:C194(*; "S_SD_D"+String:C10($Dist_L); String:C10($S_SD_Area; $format_txt))
			OBJECT SET TITLE:C194(*; "S_SD_P_D"+String:C10($Dist_L); String:C10(f_BrgStatus_PCT($S_SD_Area; $S_area); $Pct_fmt_txt))
			
			OBJECT SET TITLE:C194(*; "S_NHS_D"+String:C10($Dist_L); String:C10($S_NHS_area; $format_txt))
			OBJECT SET TITLE:C194(*; "S_NHS_SD_D"+String:C10($Dist_L); String:C10($S_NHS_SD_Area; $format_txt))
			OBJECT SET TITLE:C194(*; "S_NHS_SD_P_D"+String:C10($Dist_L); String:C10(f_BrgStatus_PCT($S_NHS_SD_Area; $S_NHS_area); $Pct_fmt_txt))
			
			OBJECT SET TITLE:C194(*; "T_D"+String:C10($Dist_L); String:C10($T_area; $format_txt))
			OBJECT SET TITLE:C194(*; "T_SD_D"+String:C10($Dist_L); String:C10($T_SD_Area; $format_txt))
			OBJECT SET TITLE:C194(*; "T_SD_P_D"+String:C10($Dist_L); String:C10(f_BrgStatus_PCT($T_SD_Area; $T_area); $Pct_fmt_txt))
			
			OBJECT SET TITLE:C194(*; "T_NHS_D"+String:C10($Dist_L); String:C10($T_NHS_area; $format_txt))
			OBJECT SET TITLE:C194(*; "T_NHS_SD_D"+String:C10($Dist_L); String:C10($T_NHS_SD_Area; $format_txt))
			OBJECT SET TITLE:C194(*; "T_NHS_SD_P_D"+String:C10($Dist_L); String:C10(f_BrgStatus_PCT($T_NHS_SD_Area; $T_NHS_area); $Pct_fmt_txt))
			
			OBJECT SET TITLE:C194(*; "ST_D"+String:C10($Dist_L); String:C10($ST_area; $format_txt))
			OBJECT SET TITLE:C194(*; "ST_SD_D"+String:C10($Dist_L); String:C10($ST_SD_Area; $format_txt))
			OBJECT SET TITLE:C194(*; "ST_SD_P_D"+String:C10($Dist_L); String:C10(f_BrgStatus_PCT($ST_SD_Area; $ST_area); $Pct_fmt_txt))
			
			OBJECT SET TITLE:C194(*; "ST_NHS_D"+String:C10($Dist_L); String:C10($ST_NHS_area; $format_txt))
			OBJECT SET TITLE:C194(*; "ST_NHS_SD_D"+String:C10($Dist_L); String:C10($ST_NHS_SD_Area; $format_txt))
			OBJECT SET TITLE:C194(*; "ST_NHS_SD_P_D"+String:C10($Dist_L); String:C10(f_BrgStatus_PCT($ST_NHS_SD_Area; $ST_NHS_Area); $Pct_fmt_txt))
			
		End for 
		C_LONGINT:C283($Agency_L)
		ARRAY TEXT:C222($prefixes_atxt; 0)
		APPEND TO ARRAY:C911($prefixes_atxt; "MDC")
		APPEND TO ARRAY:C911($prefixes_atxt; "DEM")
		APPEND TO ARRAY:C911($prefixes_atxt; "MBTA")
		APPEND TO ARRAY:C911($prefixes_atxt; "MPA")
		APPEND TO ARRAY:C911($prefixes_atxt; "DNR")  //show under other
		
		For ($Agency_L; 1; Size of array:C274($prefixes_atxt))
			
			$S_Area_ptr:=STATREP_GetFieldPTR($prefixes_atxt{$Agency_L}+"_Area")
			$S_SD_area_ptr:=STATREP_GetFieldPTR($prefixes_atxt{$Agency_L}+"_SD_Area")
			$S_NHS_Area_ptr:=STATREP_GetFieldPTR($prefixes_atxt{$Agency_L}+"_NHS_Area")
			$S_NHS_SD_Area_ptr:=STATREP_GetFieldPTR($prefixes_atxt{$Agency_L}+"_NHS_SD_Area")
			
			$S_area:=$S_Area_ptr->
			$S_SD_Area:=$S_SD_area_ptr->
			$S_NHS_area:=$S_NHS_Area_ptr->
			$S_NHS_SD_Area:=$S_NHS_SD_area_ptr->
			
			If (STATREP_ENGLISH_b)
				$S_area:=$S_area*$Sqm_ft
				$S_SD_Area:=$S_SD_Area*$Sqm_ft
				$S_NHS_area:=$S_NHS_area*$Sqm_ft
				$S_NHS_SD_Area:=$S_NHS_SD_Area*$Sqm_ft
				
			End if 
			
			$S_area:=Round:C94($S_area; 0)
			$S_SD_Area:=Round:C94($S_SD_Area; 0)
			$S_NHS_area:=Round:C94($S_NHS_area; 0)
			$S_NHS_SD_Area:=Round:C94($S_NHS_SD_Area; 0)
			
			OBJECT SET TITLE:C194(*; $prefixes_atxt{$Agency_L}+"_"; String:C10($S_area; $format_txt))
			OBJECT SET TITLE:C194(*; $prefixes_atxt{$Agency_L}+"_SD"; String:C10($S_SD_Area; $format_txt))
			OBJECT SET TITLE:C194(*; $prefixes_atxt{$Agency_L}+"_SD_P"; String:C10(f_BrgStatus_PCT($S_SD_Area; $S_area); $Pct_fmt_txt))
			
			OBJECT SET TITLE:C194(*; $prefixes_atxt{$Agency_L}+"_NHS"; String:C10($S_NHS_area; $format_txt))
			OBJECT SET TITLE:C194(*; $prefixes_atxt{$Agency_L}+"_NHS_SD"; String:C10($S_NHS_SD_Area; $format_txt))
			OBJECT SET TITLE:C194(*; $prefixes_atxt{$Agency_L}+"_NHS_SD_P"; String:C10(f_BrgStatus_PCT($S_NHS_SD_Area; $S_NHS_area); $Pct_fmt_txt))
			
		End for 
		
End case 

//End SR_SDMetricsDetail_FM