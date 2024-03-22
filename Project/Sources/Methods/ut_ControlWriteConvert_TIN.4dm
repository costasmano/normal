//%attributes = {"invisible":true}
//Method: ut_ControlWriteConvert_TIN
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/17/21, 13:21:35
	// ----------------------------------------------------
	//Created : 
	//Mods_2021_06
End if 
//
ALL RECORDS:C47([TIN_Inspections:184])
C_BOOLEAN:C305($Complete_B; $ProcessComplete_B; $CanStart1_B; $CanStart2_B)
C_LONGINT:C283($Start_L; $Stop_L; $Count_L; $ProcessID1_L; $ProcessID2_L; $ProcessState1_L; $ProcessState2_L)
C_TEXT:C284($ProcessName1_txt; $ProcessName2_txt)

C_TIME:C306($ProcessTime1_tm; $ProcessTime2_tm)
$Count_L:=1000
$CanStart1_B:=True:C214
$CanStart2_B:=True:C214
Repeat 
	If ($CanStart1_B)
		
		$Start_L:=$Stop_L+1
		$Stop_L:=$Stop_L+$Count_L
		ARRAY LONGINT:C221($RecordNumbers_AL; 0)
		
		SELECTION RANGE TO ARRAY:C368($Start_L; $Stop_L; [TIN_Inspections:184]; $RecordNumbers_AL)
		//$ProcessID1_L:=New process(
		$CanStart1_B:=False:C215
	End if 
	If ($CanStart2_B)
		$Start_L:=$Stop_L+1
		$Stop_L:=$Stop_L+$Count_L
		ARRAY LONGINT:C221($RecordNumbers_AL; 0)
		SELECTION RANGE TO ARRAY:C368($Start_L; $Stop_L; [TIN_Inspections:184]; $RecordNumbers_AL)
		//$ProcessID2_L:=New process(
		$CanStart2_B:=False:C215
	End if 
	$ProcessComplete_B:=False:C215
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 600)  //delay 10 seconds
		PROCESS PROPERTIES:C336($ProcessID1_L; $ProcessName1_txt; $ProcessState1_L; $ProcessTime1_tm)
		$CanStart1_B:=($ProcessName1_txt#"TINProcess_1") | ($ProcessState1_L<0)
		PROCESS PROPERTIES:C336($ProcessID2_L; $ProcessName2_txt; $ProcessState2_L; $ProcessTime2_tm)
		$CanStart2_B:=($ProcessName1_txt#"TINProcess_2") | ($ProcessState2_L<0)
		
	Until ($CanStart1_B | $CanStart2_B)
	
	
Until ($Complete_B)

//End ut_ControlWriteConvert_TIN