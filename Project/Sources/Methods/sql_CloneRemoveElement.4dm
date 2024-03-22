//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Bridge Section
// Date and time: 02/21/17, 13:59:47
// ----------------------------------------------------
// Method: sql_CloneRemoveElement
// Description
// 
//

// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2018_06
	
End if 
C_LONGINT:C283($1; $TableNumber_L; $2; $ArrayPosition_L)
$TableNumber_L:=$1
$ArrayPosition_L:=$2
Case of 
	: ($TableNumber_L=29)  //ElementsSafety
		DELETE FROM ARRAY:C228(v_29_007_aL; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_002_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_003_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_005_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_010_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_014_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_015_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_020_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_021_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_022_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_024_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_025_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_026_atxt; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_001_ai; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_011_ai; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_012_ai; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_013_ai; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_004_aL; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_006_ab; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_008_ab; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_009_ab; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_016_ad; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_018_ad; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_017_atm; $ArrayPosition_L; 1)
		DELETE FROM ARRAY:C228(v_29_019_atm; $ArrayPosition_L; 1)
		If (clone_UseBlobArrays_B)
			DELETE FROM ARRAY:C228(v_29_023_ablb; $ArrayPosition_L; 1)
		End if 
		If (clone_IncludeUUIDS_B)
			DELETE FROM ARRAY:C228(v_29_027_atxt; $ArrayPosition_L; 1)
		End if 
End case 
