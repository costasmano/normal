//%attributes = {"invisible":true}
//Method: DEV_BuildModDateName
//Description
// build the array for the "mod date-time - method names" list
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/29/17, 16:23:12
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 
//
ARRAY TEXT:C222($Methods_atxt; 0)
ARRAY DATE:C224($modDates_ad; 0)
ARRAY LONGINT:C221($modTimes_at; 0)
C_LONGINT:C283($progress_L)
$progress_L:=Progress New
Progress SET TITLE($progress_L; "Method access...")
Progress SET MESSAGE($progress_L; "Getting list..")
METHOD GET PATHS:C1163(Path all objects:K72:16; $Methods_atxt)
Progress SET MESSAGE($progress_L; "Getting mod dates..")
METHOD GET MODIFICATION DATE:C1170($Methods_atxt; $modDates_ad; $modTimes_at)
ARRAY TEXT:C222(LBGeneric_atxt; Size of array:C274($Methods_atxt))
Progress SET MESSAGE($progress_L; "Merging date and name...")
C_LONGINT:C283($loop_L)
C_TIME:C306($modTime_t)

For ($loop_L; 1; Size of array:C274(LBGeneric_atxt))
	$modTime_t:=$modTimes_at{$loop_L}
	//LBGeneric_atxt{$loop_L}:=ut_ReturnTimeStampFromDate ($modDates_ad{$loop_L};$modTimes_at{$loop_L})+" - "+$Methods_atxt{$loop_L}
	LBGeneric_atxt{$loop_L}:=String:C10($modDates_ad{$loop_L}; ISO date:K1:8; $modTime_t)+" - "+$Methods_atxt{$loop_L}
	
End for 
Progress SET MESSAGE($progress_L; "Sorting...")

SORT ARRAY:C229(LBGeneric_atxt; $Methods_atxt; <)
C_LONGINT:C283($pick_L)
C_BOOLEAN:C305($Done_b)
$Done_b:=False:C215
Progress QUIT($progress_L)
//End DEV_BuildModDateName