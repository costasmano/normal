//%attributes = {"invisible":true}
//G_InitCondRepVars
//  `Initialize Condition Report Vars
//parameters
// $1 : STATREP_NumDistr_L (optional) defaults to 6
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(3/1/2006 10:21:28)
	Mods_2006_CM03
	Mods_2009_10("MASSDOT")
	//  `Added D6 variables ; and a series of variables starting with STATREP_ to help and control the generation
	//  `of status reports
	// Modified by: costasmanousakis-(Designer)-(8/5/10 11:02:47)
	Mods_2010_08
	//  `changed STATREP_DistrictMethod_b to STATREP_DistrictMethod_L
	// Modified by: costasmanousakis-(Designer)-(3/18/11 17:20:03)
	Mods_2011_03
	//  `Added at the end code that generates comipler directives for all variables
	//  `Call Compiler_SR 
	// Modified by: Costas Manousakis-(Designer)-(3/13/13 14:16:40)
	Mods_2013_03
	//  `Clean up code, removed code that generates compiler directives to a new method SR_ut_MakeDirectives
End if 
C_LONGINT:C283(STATREP_NumDistr_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	STATREP_NumDistr_L:=$1
Else 
	STATREP_NumDistr_L:=6
End if 

If (False:C215)
	READ ONLY:C145([Town Data:2])
	ALL RECORDS:C47([Town Data:2])
	ARRAY TEXT:C222($TwnDataDistr_as; 0)  //Command Replaced was o_ARRAY string length was 2
	DISTINCT VALUES:C339([Town Data:2]District:6; $TwnDataDistr_as)
	STATREP_NumDistr_L:=Size of array:C274($TwnDataDistr_as)
	
End if 

ARRAY TEXT:C222(STATREP_FldTypes_atxt; 0)
APPEND TO ARRAY:C911(STATREP_FldTypes_atxt; "total")
APPEND TO ARRAY:C911(STATREP_FldTypes_atxt; "sd")
APPEND TO ARRAY:C911(STATREP_FldTypes_atxt; "fo")
APPEND TO ARRAY:C911(STATREP_FldTypes_atxt; "p")
APPEND TO ARRAY:C911(STATREP_FldTypes_atxt; "k")
APPEND TO ARRAY:C911(STATREP_FldTypes_atxt; "t")
APPEND TO ARRAY:C911(STATREP_FldTypes_atxt; "a50")

ARRAY TEXT:C222(STATREP_OwnTypes_atxt; 2)
STATREP_OwnTypes_atxt{1}:="S"
STATREP_OwnTypes_atxt{2}:="T"

ARRAY TEXT:C222(STATREP_DataName_as; 0)  //Command Replaced was o_ARRAY string length was 5

APPEND TO ARRAY:C911(STATREP_DataName_as; "total")
APPEND TO ARRAY:C911(STATREP_DataName_as; "sd")
APPEND TO ARRAY:C911(STATREP_DataName_as; "psd")
APPEND TO ARRAY:C911(STATREP_DataName_as; "fo")
APPEND TO ARRAY:C911(STATREP_DataName_as; "pfo")
APPEND TO ARRAY:C911(STATREP_DataName_as; "p")
APPEND TO ARRAY:C911(STATREP_DataName_as; "pp")
APPEND TO ARRAY:C911(STATREP_DataName_as; "k")
APPEND TO ARRAY:C911(STATREP_DataName_as; "pk")
APPEND TO ARRAY:C911(STATREP_DataName_as; "t")
APPEND TO ARRAY:C911(STATREP_DataName_as; "pt")
APPEND TO ARRAY:C911(STATREP_DataName_as; "a50")
APPEND TO ARRAY:C911(STATREP_DataName_as; "pa50")

C_LONGINT:C283($numDataNames_L)
$numDataNames_L:=Size of array:C274(STATREP_DataName_as)
C_BOOLEAN:C305(STATREP_OwnerMethod_b; STATREP_UseLegacyOwn_b)
C_LONGINT:C283(STATREP_DistrictMethod_L)

C_LONGINT:C283(STATREP_NumFlds_L; STATREP_TblNum_L)
ARRAY INTEGER:C220(astate; (STATREP_NumDistr_L+1); $numDataNames_L)
ARRAY INTEGER:C220(atown; (STATREP_NumDistr_L+1); $numDataNames_L)

If (False:C215)
	//explanation of astate and aTown arrays
	//astate | atown {i}{j}
	//i = district number 
	//j =
	//  `1 = total bin count
	//  `2 = SD Count
	//  `3 = % SD
	//  `4 = FO count
	//  `5 = % FO
	//  `6 = Posted count
	//  `7 = % Posted
	//  `8 = Closed count
	//  `9 = % Closed
	//  `10 = TempBridge count
	//  `11 = % TempBridge
	//  `12 = Age>50 count
	//  `13 = % Age>50
	
	//agency arrays are same as j for astate and atown
End if 


ARRAY INTEGER:C220(aMBTA; $numDataNames_L)
ARRAY INTEGER:C220(aMDC; $numDataNames_L)
ARRAY INTEGER:C220(aMTA; $numDataNames_L)
ARRAY INTEGER:C220(aMPA; $numDataNames_L)
ARRAY INTEGER:C220(aDEM; $numDataNames_L)
ARRAY INTEGER:C220(aDNR; $numDataNames_L)
ARRAY INTEGER:C220(astate_z; $numDataNames_L)  // total for state owned
ARRAY INTEGER:C220(atown_z; $numDataNames_L)  //total for town owned
ARRAY INTEGER:C220(atotal; $numDataNames_L)  // grand totals

//initialize variables used in the detail and print forms
C_LONGINT:C283(S_total; S_sd; S_psd; S_fo; S_pfo; S_p; S_pp; S_k; S_pk; S_t; S_pt; S_a50; S_pa50)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(T_total; T_sd; T_psd; T_fo; T_pfo; T_p; T_pp; T_k; T_pk; T_t; T_pt; T_a50; T_pa50)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(S_Subst; S_pSubst)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(T_Subst; T_pSubst)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(gr_total; gr_sd; gr_psd; gr_fo; gr_pfo; gr_p; gr_pp; gr_k; gr_pk; gr_t; gr_pt; gr_a50; gr_pa50)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(gr_Substd; gr_pSubstd)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(MBTA_psd; MBTA_pfo; MBTA_pp; MBTA_pk; MBTA_pt; MBTA_pa50)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(MBTA_Substd; MBTA_psub)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(MDC_psd; MDC_pfo; MDC_pp; MDC_pk; MDC_pt; MDC_pa50)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(MDC_Substd; MDC_psub)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(MTA_psd; MTA_pfo; MTA_pp; MTA_pk; MTA_pt; MTA_pa50)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(MTA_Substd; MTA_psub)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(MPA_psd; MPA_pfo; MPA_pp; MPA_pk; MPA_pt; MPA_pa50)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(MPA_Substd; MPA_psub)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(DEM_psd; DEM_pfo; DEM_pp; DEM_pk; DEM_pt; DEM_pa50)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(DEM_Substd; DEM_psub)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(DNR_psd; DNR_pfo; DNR_pp; DNR_pk; DNR_pt; DNR_pa50)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(DNR_Substd; DNR_psub)  //Command Replaced was o_C_INTEGER

C_LONGINT:C283(ST_D1total; ST_D2total; ST_D3total; ST_D4total; ST_D5total; ST_D6total)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(ST_D1sd; ST_D2sd; ST_D3sd; ST_D4sd; ST_D5sd; ST_D6sd)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(ST_D1fo; ST_D2fo; ST_D3fo; ST_D4fo; ST_D5fo; ST_D6fo)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(ST_D1psd; ST_D2psd; ST_D3psd; ST_D4psd; ST_D5psd; ST_D6psd)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(ST_D1pfo; ST_D2pfo; ST_D3pfo; ST_D4pfo; ST_D5pfo; ST_D6pfo)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(Substd_D1; Substd_D2; Substd_D3; Substd_D4; Substd_D5; Substd_D6)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(pSubstd_D1; pSubstd_D2; pSubstd_D3; pSubstd_D4; pSubstd_D5; pSubstd_D6)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(ST_total; ST_sd; ST_fo; ST_Subst; ST_k; ST_t; ST_a50; ST_p)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(ST_sdp; ST_fop; ST_pSubst; ST_pt; ST_pk; ST_pa50; ST_pp)  //Command Replaced was o_C_INTEGER

C_LONGINT:C283(S_D1Subst; S_D1pSubst; S_D2Subst; S_D2pSubst; S_D3Subst; S_D3pSubst; S_D4Subst; S_D4pSubst; S_D5Subst; S_D5pSubst; S_D6Subst; S_D6pSubst)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(T_D1Subst; T_D1pSubst; T_D2Subst; T_D2pSubst; T_D3Subst; T_D3pSubst; T_D4Subst; T_D4pSubst; T_D5Subst; T_D5pSubst; T_D6Subst; T_D6pSubst)  //Command Replaced was o_C_INTEGER

Compiler_SR

STATREP_NumFlds_L:=Get last field number:C255(->[Status Report:69])
STATREP_TblNum_L:=Table:C252(->[Status Report:69])
ARRAY POINTER:C280(STATREP_Fields_aptr; STATREP_NumFlds_L)
ARRAY TEXT:C222(STATREP_FieldNames_atxt; STATREP_NumFlds_L)
C_LONGINT:C283($i)
For ($i; 1; STATREP_NumFlds_L)
	STATREP_Fields_aptr{$i}:=Field:C253(STATREP_TblNum_L; $i)
	STATREP_FieldNames_atxt{$i}:=Field name:C257(STATREP_Fields_aptr{$i})
End for 