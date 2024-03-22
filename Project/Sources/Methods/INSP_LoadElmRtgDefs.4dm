//%attributes = {"invisible":true}
//Method: INSP_LoadElmRtgDefs
//Description
//  ` Set up arrays for element ratings 
// Parameters
//$0 : $Numratings_L
// $1 : $VarPrefArray_ptr
// $2 : $FieldArray_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/25/14, 09:20:17
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04
	// Modified by: Costas Manousakis-(Designer)-(3/6/17 15:53:23)
	Mods_2017_03
	//  `added vHSP46_ in the arrays  linked to [ElmtRatingLoads]R_HSP46_r
End if 
//
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

C_POINTER:C301($VarPrefArray_ptr; $FieldArray_ptr)
$VarPrefArray_ptr:=$1
$FieldArray_ptr:=$2
C_LONGINT:C283($Numratings_L)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vH20_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElementsSafety:29]Inv H20:11)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vTyp3_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElementsSafety:29]Inv Type 3:12)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "v3S2_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElementsSafety:29]Inv 3S2:13)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vNEOPLAN_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_Neoplan_r:8)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vNABI_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_NABI_r:9)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vHA_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_HybridArtic_r:14)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vE80_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_E80_r:3)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vF40_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_F40PH_r:4)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vR286K_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_286K_r:5)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vR263K_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_263K_r:6)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vR315K_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_315K_r:7)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vRevenue_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_Revenue_r:10)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vWorkCar_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_WorkCar_r:12)

APPEND TO ARRAY:C911($VarPrefArray_ptr->; "vHSP46_")
APPEND TO ARRAY:C911($FieldArray_ptr->; ->[ElmtRatingLoads:158]R_HSP46_r:11)

$Numratings_L:=Size of array:C274($VarPrefArray_ptr->)

$0:=$Numratings_L
//End INSP_LoadElmRtgDefs