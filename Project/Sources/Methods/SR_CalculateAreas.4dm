//%attributes = {"invisible":true}
//Method: SR_CalculateAreas
//Description
//  ` Calculate the variables used in the 'input' and print forms for
//  ` display of deck areas.
// Will do either straight display or convert to english SqFT based on STATREP_ENGLISH_b
//  ` Data is assumed to be in metric
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 3/13/13
	// ----------------------------------------------------
	//Created : 
	Mods_2013_03
End if 
//
C_BOOLEAN:C305(STATREP_ENGLISH_b)

C_REAL:C285($UnitConv_r)
$UnitConv_r:=1
If (STATREP_ENGLISH_b)
	$UnitConv_r:=10.76391
End if 

ARRAY TEXT:C222($Owners_atxt; 0)
APPEND TO ARRAY:C911($Owners_atxt; "MBTA")
APPEND TO ARRAY:C911($Owners_atxt; "MDC")
APPEND TO ARRAY:C911($Owners_atxt; "DEM")
APPEND TO ARRAY:C911($Owners_atxt; "MTA")
APPEND TO ARRAY:C911($Owners_atxt; "MPA")
APPEND TO ARRAY:C911($Owners_atxt; "DNR")

C_LONGINT:C283($loop_L; $loop2_L)
C_POINTER:C301($Fld_ptr; $FldSD_ptr; $VarArea_ptr; $VarSDArea_ptr; $VarPct_ptr)

S_tot_A:=0
S_Tot_SD_A:=0
S_tot_NHS_A:=0
S_Tot_NHS_SD_A:=0

T_tot_A:=0
T_Tot_SD_A:=0
T_tot_NHS_A:=0
T_Tot_NHS_SD_A:=0

ST_tot_A:=0
ST_Tot_SD_A:=0
ST_tot_NHS_A:=0
ST_Tot_NHS_SD_A:=0

GR_tot_A:=0
GR_Tot_SD_A:=0
GR_tot_NHS_A:=0
GR_Tot_NHS_SD_A:=0

AG_tot_A:=0
AG_Tot_SD_A:=0
AG_tot_NHS_A:=0
AG_Tot_NHS_SD_A:=0

For ($loop_L; 1; Size of array:C274($Owners_atxt))
	$Fld_ptr:=STATREP_GetFieldPTR($Owners_atxt{$loop_L}+"_Area")
	$FldSD_ptr:=STATREP_GetFieldPTR($Owners_atxt{$loop_L}+"_SD_Area")
	$VarArea_ptr:=Get pointer:C304($Owners_atxt{$loop_L}+"_A")
	$VarSDArea_ptr:=Get pointer:C304($Owners_atxt{$loop_L}+"_SD_A")
	$VarPct_ptr:=Get pointer:C304($Owners_atxt{$loop_L}+"_SD_pArea")
	
	$VarArea_ptr->:=$UnitConv_r*($Fld_ptr->)
	$VarSDArea_ptr->:=$UnitConv_r*($FldSD_ptr->)
	$VarPct_ptr->:=f_BrgStatus_PCT(($FldSD_ptr->); ($Fld_ptr->))
	
	AG_tot_A:=AG_tot_A+$VarArea_ptr->
	AG_Tot_SD_A:=AG_Tot_SD_A+$VarSDArea_ptr->
	
	GR_tot_A:=GR_tot_A+$VarArea_ptr->
	GR_Tot_SD_A:=GR_Tot_SD_A+$VarSDArea_ptr->
	
	$Fld_ptr:=STATREP_GetFieldPTR($Owners_atxt{$loop_L}+"_NHS_Area")
	$FldSD_ptr:=STATREP_GetFieldPTR($Owners_atxt{$loop_L}+"_NHS_SD_Area")
	$VarArea_ptr:=Get pointer:C304($Owners_atxt{$loop_L}+"_NHS_A")
	$VarSDArea_ptr:=Get pointer:C304($Owners_atxt{$loop_L}+"_NHS_SD_A")
	$VarPct_ptr:=Get pointer:C304($Owners_atxt{$loop_L}+"_NHS_SD_pArea")
	$VarArea_ptr->:=$UnitConv_r*($Fld_ptr->)
	$VarSDArea_ptr->:=$UnitConv_r*($FldSD_ptr->)
	$VarPct_ptr->:=f_BrgStatus_PCT(($FldSD_ptr->); ($Fld_ptr->))
	
	AG_tot_NHS_A:=AG_tot_NHS_A+$VarArea_ptr->
	AG_Tot_NHS_SD_A:=AG_Tot_NHS_SD_A+$VarSDArea_ptr->
	GR_tot_NHS_A:=GR_tot_NHS_A+$VarArea_ptr->
	GR_Tot_NHS_SD_A:=GR_Tot_NHS_SD_A+$VarSDArea_ptr->
	
End for 

For ($loop_L; 1; STATREP_NumDistr_L)
	
	$Fld_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($loop_L)+"_Area")
	$FldSD_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($loop_L)+"_SD_Area")
	$VarArea_ptr:=Get pointer:C304("S_A_D"+String:C10($loop_L))
	$VarSDArea_ptr:=Get pointer:C304("S_SD_A_D"+String:C10($loop_L))
	$VarPct_ptr:=Get pointer:C304("S_SD_pArea_D"+String:C10($loop_L))
	
	$VarArea_ptr->:=$UnitConv_r*($Fld_ptr->)
	$VarSDArea_ptr->:=$UnitConv_r*($FldSD_ptr->)
	$VarPct_ptr->:=f_BrgStatus_PCT(($FldSD_ptr->); ($Fld_ptr->))
	
	S_tot_A:=S_tot_A+$VarArea_ptr->
	S_Tot_SD_A:=S_Tot_SD_A+$VarSDArea_ptr->
	ST_tot_A:=ST_tot_A+$VarArea_ptr->
	ST_Tot_SD_A:=ST_Tot_SD_A+$VarSDArea_ptr->
	GR_tot_A:=GR_tot_A+$VarArea_ptr->
	GR_Tot_SD_A:=GR_Tot_SD_A+$VarSDArea_ptr->
	
	$Fld_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($loop_L)+"_NHS_Area")
	$FldSD_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($loop_L)+"_NHS_SD_Area")
	$VarArea_ptr:=Get pointer:C304("S_NHS_A_D"+String:C10($loop_L))
	$VarSDArea_ptr:=Get pointer:C304("S_NHS_SD_A_D"+String:C10($loop_L))
	$VarPct_ptr:=Get pointer:C304("S_NHS_SD_pArea_D"+String:C10($loop_L))
	$VarArea_ptr->:=$UnitConv_r*($Fld_ptr->)
	$VarSDArea_ptr->:=$UnitConv_r*($FldSD_ptr->)
	$VarPct_ptr->:=f_BrgStatus_PCT(($FldSD_ptr->); ($Fld_ptr->))
	
	S_tot_NHS_A:=S_tot_NHS_A+$VarArea_ptr->
	S_Tot_NHS_SD_A:=S_Tot_NHS_SD_A+$VarSDArea_ptr->
	ST_tot_NHS_A:=ST_tot_NHS_A+$VarArea_ptr->
	ST_Tot_NHS_SD_A:=ST_Tot_NHS_SD_A+$VarSDArea_ptr->
	GR_tot_NHS_A:=GR_tot_NHS_A+$VarArea_ptr->
	GR_Tot_NHS_SD_A:=GR_Tot_NHS_SD_A+$VarSDArea_ptr->
	
End for 

For ($loop_L; 1; STATREP_NumDistr_L)
	
	$Fld_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($loop_L)+"_Area")
	$FldSD_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($loop_L)+"_SD_Area")
	$VarArea_ptr:=Get pointer:C304("T_A_D"+String:C10($loop_L))
	$VarSDArea_ptr:=Get pointer:C304("T_SD_A_D"+String:C10($loop_L))
	$VarPct_ptr:=Get pointer:C304("T_SD_pArea_D"+String:C10($loop_L))
	
	$VarArea_ptr->:=$UnitConv_r*($Fld_ptr->)
	$VarSDArea_ptr->:=$UnitConv_r*($FldSD_ptr->)
	$VarPct_ptr->:=f_BrgStatus_PCT(($FldSD_ptr->); ($Fld_ptr->))
	
	T_tot_A:=T_tot_A+$VarArea_ptr->
	T_Tot_SD_A:=T_Tot_SD_A+$VarSDArea_ptr->
	ST_tot_A:=ST_tot_A+$VarArea_ptr->
	ST_Tot_SD_A:=ST_Tot_SD_A+$VarSDArea_ptr->
	GR_tot_A:=GR_tot_A+$VarArea_ptr->
	GR_Tot_SD_A:=GR_Tot_SD_A+$VarSDArea_ptr->
	
	$Fld_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($loop_L)+"_NHS_Area")
	$FldSD_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($loop_L)+"_NHS_SD_Area")
	$VarArea_ptr:=Get pointer:C304("T_NHS_A_D"+String:C10($loop_L))
	$VarSDArea_ptr:=Get pointer:C304("T_NHS_SD_A_D"+String:C10($loop_L))
	$VarPct_ptr:=Get pointer:C304("T_NHS_SD_pArea_D"+String:C10($loop_L))
	
	$VarArea_ptr->:=$UnitConv_r*($Fld_ptr->)
	$VarSDArea_ptr->:=$UnitConv_r*($FldSD_ptr->)
	$VarPct_ptr->:=f_BrgStatus_PCT(($FldSD_ptr->); ($Fld_ptr->))
	
	T_tot_NHS_A:=T_tot_NHS_A+$VarArea_ptr->
	T_Tot_NHS_SD_A:=T_Tot_NHS_SD_A+$VarSDArea_ptr->
	ST_tot_NHS_A:=ST_tot_NHS_A+$VarArea_ptr->
	ST_Tot_NHS_SD_A:=ST_Tot_NHS_SD_A+$VarSDArea_ptr->
	GR_tot_NHS_A:=GR_tot_NHS_A+$VarArea_ptr->
	GR_Tot_NHS_SD_A:=GR_Tot_NHS_SD_A+$VarSDArea_ptr->
	
End for 

S_tot_SD_pArea:=f_BrgStatus_PCT(S_Tot_SD_A; S_tot_A)
S_tot_NHS_SD_pArea:=f_BrgStatus_PCT(S_Tot_NHS_SD_A; S_tot_NHS_A)

T_tot_SD_pArea:=f_BrgStatus_PCT(T_Tot_SD_A; T_tot_A)
T_tot_NHS_SD_pArea:=f_BrgStatus_PCT(T_Tot_NHS_SD_A; T_tot_NHS_A)

ST_tot_SD_pArea:=f_BrgStatus_PCT(ST_Tot_SD_A; ST_tot_A)
ST_tot_NHS_SD_pArea:=f_BrgStatus_PCT(ST_Tot_NHS_SD_A; ST_tot_NHS_A)

AG_tot_SD_pArea:=f_BrgStatus_PCT(AG_Tot_SD_A; AG_tot_A)
AG_tot_NHS_SD_pArea:=f_BrgStatus_PCT(AG_Tot_NHS_SD_A; AG_tot_NHS_A)

GR_tot_SD_pArea:=f_BrgStatus_PCT(GR_Tot_SD_A; GR_tot_A)
GR_tot_NHS_SD_pArea:=f_BrgStatus_PCT(GR_Tot_NHS_SD_A; GR_tot_NHS_A)

//End SR_CalculateAreas