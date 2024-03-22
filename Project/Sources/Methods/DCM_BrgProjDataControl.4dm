//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/17/09, 17:35:23
	// ----------------------------------------------------
	// Method: DCM_BrgProjDataControl
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt ("LOAD" | "SAVE" | "INIT")
	// ----------------------------------------------------
	
	Mods_2010_05
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		ARRAY INTEGER:C220(DCM_CUUsed_ai; 0)
		ARRAY LONGINT:C221(DCM_CUUsedElNos_aL; 0)
		ARRAY TEXT:C222(DCM_CUUsedDesc_atxt; 0)
		ARRAY INTEGER:C220(DCM_CUUsedEnv_ai; 0)
		ARRAY TEXT:C222(DCM_CUUsedUnits_atxt; 0)
		ARRAY REAL:C219(DCM_CUUsedQ_ar; 0)
		ARRAY REAL:C219(DCM_CUUsedQ1_ar; 0)
		ARRAY REAL:C219(DCM_CUUsedQ2_ar; 0)
		ARRAY REAL:C219(DCM_CUUsedQ3_ar; 0)
		ARRAY REAL:C219(DCM_CUUsedQ4_ar; 0)
		ARRAY REAL:C219(DCM_CUUsedQ5_ar; 0)
		ARRAY TEXT:C222(DCM_CUUsedComments_atxt; 0)
		ARRAY POINTER:C280(DCM_CUArrays_aptr; 6)
		
	: ($Task_txt="LOAD")
	: ($Task_txt="SAVE")
	: ($Task_txt="CLEAR")
		C_LONGINT:C283($loop_L)
		C_POINTER:C301($testPtr_ptr)
		For ($loop_L; 1; Size of array:C274(DCM_CUArrays_aptr))
			$testPtr_ptr:=DCM_CUArrays_aptr{$loop_L}
			Case of 
				: (Type:C295($testPtr_ptr->)=Real array:K8:17)
					ARRAY REAL:C219(DCM_CUArrays_aptr{$loop_L}->; 0)
				: (Type:C295($testPtr_ptr->)=Integer array:K8:18)
					ARRAY INTEGER:C220(DCM_CUArrays_aptr{$loop_L}->; 0)
				: (Type:C295($testPtr_ptr->)=LongInt array:K8:19)
					ARRAY LONGINT:C221(DCM_CUArrays_aptr{$loop_L}->; 0)
				: (Type:C295($testPtr_ptr->)=Text array:K8:16)
					C_LONGINT:C283($loop2_L)
					For ($loop2_L; 1; Size of array:C274(DCM_CUArrays_aptr{$loop_L}->))
						DCM_CUArrays_aptr{$loop_L}->{$loop2_L}:=""
					End for 
					ARRAY TEXT:C222(DCM_CUArrays_aptr{$loop_L}->; 0)
					
			End case 
			
		End for 
		
		
End case 
