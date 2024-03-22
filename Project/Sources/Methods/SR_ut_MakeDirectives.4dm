//%attributes = {"invisible":true}
//Method: SR_ut_MakeDirectives
//Description
//  `CODE THAT GENERATES COMPILER DIRECTIVES FOR VARIABLES USED
//  `IN THE STATUS REPORTS
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 3/13/13, 09:31:34
	// ----------------------------------------------------
	//Created : 
	Mods_2013_03
End if 
//

If (True:C214)
	//CODE THAT GENERATES COMPILER DIRECTIVES FOR VARIABLES USED
	//IN THE STATUS REPORTS
	C_LONGINT:C283($loop_L; $loop2_L; $loop3_L; $i)
	ARRAY TEXT:C222($Subs_atxt; 0)
	APPEND TO ARRAY:C911($Subs_atxt; "psd")
	APPEND TO ARRAY:C911($Subs_atxt; "pfo")
	APPEND TO ARRAY:C911($Subs_atxt; "pp")
	APPEND TO ARRAY:C911($Subs_atxt; "pk")
	APPEND TO ARRAY:C911($Subs_atxt; "pt")
	APPEND TO ARRAY:C911($Subs_atxt; "pa50")
	ARRAY TEXT:C222($Prefs_atxt; 0)
	APPEND TO ARRAY:C911($Prefs_atxt; "S_D")
	APPEND TO ARRAY:C911($Prefs_atxt; "T_D")
	
	C_TEXT:C284($CompVars_txt; $VarGroup_txt)
	ARRAY TEXT:C222($IntVars_atxt; 0)
	$CompVars_txt:=""
	For ($loop3_L; 1; Size of array:C274($Prefs_atxt))
		For ($loop_L; 1; STATREP_NumDistr_L)
			For ($loop2_L; 1; Size of array:C274($Subs_atxt))
				APPEND TO ARRAY:C911($IntVars_atxt; $Prefs_atxt{$loop3_L}+String:C10($loop_L)+$Subs_atxt{$loop2_L})
			End for 
		End for 
		
	End for 
	C_LONGINT:C283($OwnLoop_L; $typeLoop_L)
	For ($OwnLoop_L; 1; Size of array:C274(STATREP_OwnTypes_atxt))
		For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
			APPEND TO ARRAY:C911($IntVars_atxt; STATREP_OwnTypes_atxt{$OwnLoop_L}+"_"+STATREP_FldTypes_atxt{$typeLoop_L})
		End for 
	End for 
	
	For ($i; 1; STATREP_NumDistr_L)
		
		For ($OwnLoop_L; 1; Size of array:C274(STATREP_OwnTypes_atxt))
			
			For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
				APPEND TO ARRAY:C911($IntVars_atxt; STATREP_OwnTypes_atxt{$OwnLoop_L}+"_"+STATREP_FldTypes_atxt{$typeLoop_L})
			End for 
			
			For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
				
				If (STATREP_FldTypes_atxt{$typeLoop_L}#"total")
					APPEND TO ARRAY:C911($IntVars_atxt; STATREP_OwnTypes_atxt{$OwnLoop_L}+"_D"+String:C10($i)+"p"+STATREP_FldTypes_atxt{$typeLoop_L})
				End if 
			End for 
			
		End for 
		
	End for 
	
	For ($OwnLoop_L; 1; Size of array:C274(STATREP_OwnTypes_atxt))
		
		APPEND TO ARRAY:C911($IntVars_atxt; STATREP_OwnTypes_atxt{$OwnLoop_L}+"_total")
		
		For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
			If (STATREP_FldTypes_atxt{$typeLoop_L}#"total")
				APPEND TO ARRAY:C911($IntVars_atxt; STATREP_OwnTypes_atxt{$OwnLoop_L}+"_"+STATREP_FldTypes_atxt{$typeLoop_L})
				APPEND TO ARRAY:C911($IntVars_atxt; STATREP_OwnTypes_atxt{$OwnLoop_L}+"_p"+STATREP_FldTypes_atxt{$typeLoop_L})
			End if 
		End for 
	End for 
	
	ARRAY TEXT:C222($STAT_Agencies_atxt; 0)
	APPEND TO ARRAY:C911($STAT_Agencies_atxt; "MBTA")
	APPEND TO ARRAY:C911($STAT_Agencies_atxt; "MDC")
	APPEND TO ARRAY:C911($STAT_Agencies_atxt; "MTA")
	APPEND TO ARRAY:C911($STAT_Agencies_atxt; "MPA")
	APPEND TO ARRAY:C911($STAT_Agencies_atxt; "DEM")
	APPEND TO ARRAY:C911($STAT_Agencies_atxt; "DNR")
	For ($OwnLoop_L; 1; Size of array:C274($STAT_Agencies_atxt))
		For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
			If (STATREP_FldTypes_atxt{$typeLoop_L}#"total")
				APPEND TO ARRAY:C911($IntVars_atxt; $STAT_Agencies_atxt{$OwnLoop_L}+"_p"+STATREP_FldTypes_atxt{$typeLoop_L})
			End if 
		End for 
	End for 
	
	For ($i; 1; STATREP_NumDistr_L)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
			If ((STATREP_FldTypes_atxt{$loop_L}#"a50") & (STATREP_FldTypes_atxt{$loop_L}#"t"))
				APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+STATREP_FldTypes_atxt{$loop_L})
			End if 
		End for 
		
		APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D"+String:C10($i))
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"sd")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"fo")
		APPEND TO ARRAY:C911($IntVars_atxt; "pSubstd_D"+String:C10($i))
		APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D"+String:C10($i))
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"total")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"sd")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"fo")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"total")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"psd")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"pfo")
		APPEND TO ARRAY:C911($IntVars_atxt; "S_D"+String:C10($i)+"Subst")
		APPEND TO ARRAY:C911($IntVars_atxt; "S_D"+String:C10($i)+"pSubst")
		APPEND TO ARRAY:C911($IntVars_atxt; "T_D"+String:C10($i)+"Subst")
		APPEND TO ARRAY:C911($IntVars_atxt; "T_D"+String:C10($i)+"pSubst")
	End for 
	For ($i; 1; STATREP_NumDistr_L)
		
		APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D"+String:C10($i))
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"sd")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"fo")
		APPEND TO ARRAY:C911($IntVars_atxt; "pSubstd_D"+String:C10($i))
		APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D"+String:C10($i))
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"total")
		
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"sd")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"fo")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"psd")
		APPEND TO ARRAY:C911($IntVars_atxt; "ST_D"+String:C10($i)+"pfo")
		
	End for 
	
	
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_total")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_p")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_k")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_t")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_a50")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pSubstd")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_total")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_p")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_k")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pK")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_sdp")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_fop")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_t")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_a50")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_pSubst")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "S_total")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_p")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_k")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_t")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_a50")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_pSubst")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "T_total")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_p")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_k")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_t")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_a50")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_pSubst")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_total")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_p")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_k")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_t")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_a50")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "gr_pSubstd")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MBTA_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MDC_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MTA_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "MPA_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "DEM_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_pp")
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_Substd")
	APPEND TO ARRAY:C911($IntVars_atxt; "DNR_psub")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D1total")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D2total")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D3total")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D4total")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D5total")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D6total")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D1sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D2sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D3sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D4sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D5sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D6sd")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D1fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D2fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D3fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D4fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D5fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D6fo")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D1psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D2psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D3psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D4psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D5psd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D6psd")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D1pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D2pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D3pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D4pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D5pfo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_D6pfo")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D1")
	APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D2")
	APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D3")
	APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D4")
	APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D5")
	APPEND TO ARRAY:C911($IntVars_atxt; "Substd_D6")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "pSubstd_D1")
	APPEND TO ARRAY:C911($IntVars_atxt; "pSubstd_D2")
	APPEND TO ARRAY:C911($IntVars_atxt; "pSubstd_D3")
	APPEND TO ARRAY:C911($IntVars_atxt; "pSubstd_D4")
	APPEND TO ARRAY:C911($IntVars_atxt; "pSubstd_D5")
	APPEND TO ARRAY:C911($IntVars_atxt; "pSubstd_D6")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_total")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_sd")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_fo")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_k")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_t")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_a50")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_p")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_sdp")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_fop")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pt")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pk")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pa50")
	APPEND TO ARRAY:C911($IntVars_atxt; "ST_pp")
	
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D1Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D1pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D2Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D2pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D3Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D3pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D4Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D4pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D5Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D5pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D6Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "S_D6pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D1Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D1pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D2Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D2pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D3Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D3pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D4Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D4pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D5Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D5pSubst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D6Subst")
	APPEND TO ARRAY:C911($IntVars_atxt; "T_D6pSubst")
	
	SORT ARRAY:C229($IntVars_atxt)
	C_LONGINT:C283($loop_L; $inLoop_L; $numtests_L; $LastLoop_L)
	$numtests_L:=Size of array:C274($IntVars_atxt)
	For ($loop_L; $numtests_L; 2; -1)
		If ($IntVars_atxt{$loop_L}=$IntVars_atxt{$loop_L-1})
			DELETE FROM ARRAY:C228($IntVars_atxt; $loop_L; 1)
		End if 
	End for 
	
	$numtests_L:=Size of array:C274($IntVars_atxt)
	$VarGroup_txt:=$IntVars_atxt{1}
	
	For ($loop_L; 1; $numtests_L; 10)
		If (False:C215)
			If (Substring:C12($IntVars_atxt{$loop_L}; 1; 3)=Substring:C12($VarGroup_txt; 1; 3))
				$VarGroup_txt:=$VarGroup_txt+";"+$IntVars_atxt{$loop_L}
			Else 
				$CompVars_txt:=$CompVars_txt+"C_INTEGER("+$VarGroup_txt+")"+Char:C90(13)
				$VarGroup_txt:=$IntVars_atxt{$loop_L}
			End if 
			
		Else 
			$VarGroup_txt:=""
			$LastLoop_L:=$numtests_L-$loop_L-1
			If ($LastLoop_L>8)
				$LastLoop_L:=8
			End if 
			
			For ($inLoop_L; 0; $LastLoop_L)
				$VarGroup_txt:=$VarGroup_txt+$IntVars_atxt{$loop_L+$inLoop_L}+";"
			End for 
			$VarGroup_txt:=$VarGroup_txt+$IntVars_atxt{$loop_L+$inLoop_L}
			$CompVars_txt:=$CompVars_txt+"C_INTEGER("+$VarGroup_txt+")"+Char:C90(13)
			
		End if 
	End for 
	
	$CompVars_txt:=$CompVars_txt+Char:C90(13)
	
	ARRAY TEXT:C222($IntVars_atxt; 0)
	ARRAY TEXT:C222($Owners_atxt; 0)
	ARRAY TEXT:C222($Suff_atxt; 0)
	
	APPEND TO ARRAY:C911($Suff_atxt; "_A")
	APPEND TO ARRAY:C911($Suff_atxt; "_SD_A")
	APPEND TO ARRAY:C911($Suff_atxt; "_SD_pArea")
	APPEND TO ARRAY:C911($Suff_atxt; "_NHS_A")
	APPEND TO ARRAY:C911($Suff_atxt; "_NHS_SD_A")
	APPEND TO ARRAY:C911($Suff_atxt; "_NHS_SD_pArea")
	
	APPEND TO ARRAY:C911($Owners_atxt; "MBTA")
	APPEND TO ARRAY:C911($Owners_atxt; "MDC")
	APPEND TO ARRAY:C911($Owners_atxt; "DEM")
	APPEND TO ARRAY:C911($Owners_atxt; "MTA")
	APPEND TO ARRAY:C911($Owners_atxt; "MPA")
	APPEND TO ARRAY:C911($Owners_atxt; "DNR")
	APPEND TO ARRAY:C911($Owners_atxt; "S_tot")
	APPEND TO ARRAY:C911($Owners_atxt; "T_tot")
	APPEND TO ARRAY:C911($Owners_atxt; "ST_tot")
	APPEND TO ARRAY:C911($Owners_atxt; "GR_tot")
	APPEND TO ARRAY:C911($Owners_atxt; "AG_tot")
	
	C_LONGINT:C283($loop_L)
	C_LONGINT:C283($loop2_L)
	
	For ($loop_L; 1; Size of array:C274($Owners_atxt))
		For ($loop2_L; 1; Size of array:C274($Suff_atxt))
			APPEND TO ARRAY:C911($IntVars_atxt; $Owners_atxt{$loop_L}+$Suff_atxt{$loop2_L})
		End for 
	End for 
	
	For ($loop_L; 1; STATREP_NumDistr_L)
		For ($loop2_L; 1; Size of array:C274($Suff_atxt))
			APPEND TO ARRAY:C911($IntVars_atxt; "S"+$Suff_atxt{$loop2_L}+"_D"+String:C10($loop_L))
		End for 
	End for 
	For ($loop_L; 1; STATREP_NumDistr_L)
		For ($loop2_L; 1; Size of array:C274($Suff_atxt))
			APPEND TO ARRAY:C911($IntVars_atxt; "T"+$Suff_atxt{$loop2_L}+"_D"+String:C10($loop_L))
		End for 
	End for 
	
	SORT ARRAY:C229($IntVars_atxt)
	C_LONGINT:C283($loop_L; $inLoop_L; $numtests_L; $LastLoop_L)
	$numtests_L:=Size of array:C274($IntVars_atxt)
	For ($loop_L; $numtests_L; 2; -1)
		If ($IntVars_atxt{$loop_L}=$IntVars_atxt{$loop_L-1})
			DELETE FROM ARRAY:C228($IntVars_atxt; $loop_L; 1)
		End if 
	End for 
	
	$numtests_L:=Size of array:C274($IntVars_atxt)
	$VarGroup_txt:=$IntVars_atxt{1}
	
	For ($loop_L; 1; $numtests_L; 10)
		$VarGroup_txt:=""
		$LastLoop_L:=$numtests_L-$loop_L-1
		If ($LastLoop_L>8)
			$LastLoop_L:=8
		End if 
		
		For ($inLoop_L; 0; $LastLoop_L)
			$VarGroup_txt:=$VarGroup_txt+$IntVars_atxt{$loop_L+$inLoop_L}+";"
		End for 
		$VarGroup_txt:=$VarGroup_txt+$IntVars_atxt{$loop_L+$inLoop_L}
		$CompVars_txt:=$CompVars_txt+"C_REAL("+$VarGroup_txt+")"+Char:C90(13)
	End for 
	
	SET TEXT TO PASTEBOARD:C523($CompVars_txt)
	ALERT:C41("Compiler Directives Copied To Clipboard")
End if 
//End SR_ut_MakeDirectives