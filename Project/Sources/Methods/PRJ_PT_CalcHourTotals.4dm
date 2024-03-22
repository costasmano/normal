//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/13/07, 23:34:37
	// ----------------------------------------------------
	// Method: PRJ_PT_CalcHourTotals
	// Description
	// Calculate the total hours per reviewer for a project
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_TimeTracking
	// Modified by: costasmanousakis-(Designer)-(3/1/09 21:38:09)
	Mods_2009_CM_5404  //----TIMESHEETS2
End if 
ARRAY INTEGER:C220($PersonIDs_ai; 0)
ARRAY REAL:C219($PersHrs_ar; 0)
ARRAY TEXT:C222($PersEWOs_as; 0)  //Command Replaced was o_ARRAY string length was 21
ARRAY TEXT:C222($PersStage_as; 0)  //Command Replaced was o_ARRAY string length was 21
ARRAY TEXT:C222(PT_HourSummary_atxt; 0)
If (Records in selection:C76([PRJ_ProjectTimeTracking:124])>0)
	COPY NAMED SELECTION:C331([PRJ_ProjectTimeTracking:124]; "PTTIMETRACKTEMP")
	ORDER BY:C49([PRJ_ProjectTimeTracking:124]; [PRJ_ProjectTimeTracking:124]PT_Scope_s:11; >; [PRJ_ProjectTimeTracking:124]Person ID:3; >)
	SELECTION TO ARRAY:C260([PRJ_ProjectTimeTracking:124]Person ID:3; $PersonIDs_ai; [PRJ_ProjectTimeTracking:124]PT_Hours_r:6; $PersHrs_ar; [PRJ_ProjectTimeTracking:124]PT_EWO_s:8; $PersEWOs_as; [PRJ_ProjectTimeTracking:124]PT_Scope_s:11; $PersStage_as)
	SORT ARRAY:C229($PersStage_as; $PersonIDs_ai; $PersEWOs_as; $PersHrs_ar)
	C_LONGINT:C283($i; $PersIndx_L)
	C_LONGINT:C283($PersID_i)  //Command Replaced was o_C_INTEGER
	C_REAL:C285($HourTotals_r; $StageHrTotals_r)
	C_TEXT:C284($PersName_txt; $Stage_txt)
	$HourTotals_r:=0
	$StageHrTotals_r:=0
	$Stage_txt:=$PersStage_as{1}
	$PersID_i:=$PersonIDs_ai{1}
	For ($i; 1; Size of array:C274($PersonIDs_ai))
		If ($Stage_txt#$PersStage_as{$i})
			$PersIndx_L:=Find in array:C230(aPeople_ID; $PersID_i)
			If ($PersIndx_L>0)
				$PersName_txt:=aPeople{$PersIndx_L}
			Else 
				$PersName_txt:="Unknown ID"
			End if 
			INSERT IN ARRAY:C227(PT_HourSummary_atxt; Size of array:C274(PT_HourSummary_atxt)+1)
			PT_HourSummary_atxt{Size of array:C274(PT_HourSummary_atxt)}:="  "+$PersName_txt+" : "+String:C10($HourTotals_r)
			INSERT IN ARRAY:C227(PT_HourSummary_atxt; Size of array:C274(PT_HourSummary_atxt)+1)
			PT_HourSummary_atxt{Size of array:C274(PT_HourSummary_atxt)}:="Total for "+$Stage_txt+" : "+String:C10($StageHrTotals_r)
			$HourTotals_r:=$PersHrs_ar{$i}
			$PersID_i:=$PersonIDs_ai{$i}
			$Stage_txt:=$PersStage_as{$i}
			$StageHrTotals_r:=$PersHrs_ar{$i}
		Else 
			If ($PersonIDs_ai{$i}#$PersID_i)
				$PersIndx_L:=Find in array:C230(aPeople_ID; $PersID_i)
				If ($PersIndx_L>0)
					$PersName_txt:=aPeople{$PersIndx_L}
				Else 
					$PersName_txt:="Unknown ID"
				End if 
				INSERT IN ARRAY:C227(PT_HourSummary_atxt; Size of array:C274(PT_HourSummary_atxt)+1)
				PT_HourSummary_atxt{Size of array:C274(PT_HourSummary_atxt)}:="  "+$PersName_txt+" : "+String:C10($HourTotals_r)
				$HourTotals_r:=$PersHrs_ar{$i}
				$PersID_i:=$PersonIDs_ai{$i}
			Else 
				$HourTotals_r:=$HourTotals_r+$PersHrs_ar{$i}
			End if 
			$StageHrTotals_r:=$StageHrTotals_r+$PersHrs_ar{$i}
		End if 
		
	End for 
	$PersIndx_L:=Find in array:C230(aPeople_ID; $PersID_i)
	If ($PersIndx_L>0)
		$PersName_txt:=aPeople{$PersIndx_L}
	Else 
		$PersName_txt:="Unknown ID"
	End if 
	INSERT IN ARRAY:C227(PT_HourSummary_atxt; Size of array:C274(PT_HourSummary_atxt)+1)
	PT_HourSummary_atxt{Size of array:C274(PT_HourSummary_atxt)}:="  "+$PersName_txt+" : "+String:C10($HourTotals_r)
	INSERT IN ARRAY:C227(PT_HourSummary_atxt; Size of array:C274(PT_HourSummary_atxt)+1)
	PT_HourSummary_atxt{Size of array:C274(PT_HourSummary_atxt)}:="Total for "+$Stage_txt+" : "+String:C10($StageHrTotals_r)
	USE NAMED SELECTION:C332("PTTIMETRACKTEMP")
	CLEAR NAMED SELECTION:C333("PTTIMETRACKTEMP")
Else 
End if 
ARRAY INTEGER:C220($PersonIDs_ai; 0)
ARRAY REAL:C219($PersHrs_ar; 0)
ARRAY TEXT:C222($PersEWOs_as; 0)  //Command Replaced was o_ARRAY string length was 21
ARRAY TEXT:C222($PersStage_as; 0)  //Command Replaced was o_ARRAY string length was 21