//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_ReturnSummaryInArrays
// User name (OS): cjmiller
// Date and time: 12/09/04, 09:54:39
// ----------------------------------------------------
// Description
// This method is the same as SD_NewSummaryReport except data gets returned in arr
//To process correctly the following variables must be set
//◊SD_EndYear_s
//◊SD_BeginYear_s
//◊SD_BeginMonth_s
//◊SD_EndMonth_s
//aIt8OwnerDes arra must be filled as follows and set accordingly
//		COPY ARRAY(◊aIt8OwnerDes;aIt8OwnerDes)
//INSERT ELEMENT(aIt8OwnerDes;1;1)
//aIt8OwnerDes{1}:="ALL"
//COPY ARRAY(◊aIt8OwnerCode;aIt8OwnerCode)
//INSERT ELEMENT(aIt8OwnerCode;1;1)
//aIt8OwnerDes{1}:="ALL"
//aIt8OwnerDes:=1
//It is assumed that
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 11:04:03      ` Type all local variables for v11
End if 
C_TEXT:C284($QueryYear_s)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($QueryMonth_s)  // Command Replaced was o_C_STRING length was 2

C_LONGINT:C283($OuterLoop_l; $Month_l; $ArraySize_l; $Start_l; $Loop_l; $BegMonth_l; $EndMonth_l; $Year_l; $YearLoop_l; $MonthLoop_l; $NumberOfYearLoops_l; $NumberofLines_l)
//Set up search arrays
Case of 
		
	: (<>SD_BeginYear_s=<>SD_EndYear_s) & (<>SD_BeginMonth_s=<>SD_EndMonth_s)  //one month report
		ARRAY TEXT:C222($SearchYears_atxt; 1)
		ARRAY TEXT:C222($SearchMonths_atxt; 1)
		$SearchYears_atxt{1}:=<>SD_BeginYear_s
		$SearchMonths_atxt{1}:=<>SD_BeginMonth_s
	: (<>SD_BeginYear_s=<>SD_EndYear_s) & (<>SD_BeginMonth_s#<>SD_EndMonth_s)  //multi months in same year
		
		$ArraySize_l:=(Num:C11(<>SD_EndMonth_s)-Num:C11(<>SD_BeginMonth_s))+1
		ARRAY TEXT:C222($SearchYears_atxt; $ArraySize_l)
		ARRAY TEXT:C222($SearchMonths_atxt; $ArraySize_l)
		$Start_l:=1
		For ($Loop_l; Num:C11(<>SD_BeginMonth_s); Num:C11(<>SD_EndMonth_s))
			$SearchYears_atxt{$Start_l}:=<>SD_BeginYear_s
			$SearchMonths_atxt{$Start_l}:=String:C10($Loop_l; "00")
			$Start_l:=$Start_l+1
		End for 
		
	Else 
		
		ARRAY TEXT:C222($SearchYears_atxt; 0)
		ARRAY TEXT:C222($SearchMonths_atxt; 0)
		$Start_l:=1
		$ArraySize_l:=1
		$NumberOfYearLoops_l:=(Num:C11(<>SD_EndYear_s)-Num:C11(<>SD_BeginYear_s))+1
		$Year_l:=Num:C11(<>SD_BeginYear_s)
		For ($YearLoop_l; 1; $NumberOfYearLoops_l)
			Case of 
				: ($YearLoop_l=1)
					$BegMonth_l:=Num:C11(<>SD_BeginMonth_s)
					$EndMonth_l:=12
				: ($YearLoop_l=$NumberOfYearLoops_l)
					$BegMonth_l:=1
					$EndMonth_l:=Num:C11(<>SD_EndMonth_s)
				Else 
					$BegMonth_l:=1
					$EndMonth_l:=12
			End case 
			$Start_l:=1
			For ($MonthLoop_l; $BegMonth_l; $EndMonth_l)
				INSERT IN ARRAY:C227($SearchYears_atxt; $ArraySize_l; 1)
				INSERT IN ARRAY:C227($SearchMonths_atxt; $ArraySize_l; 1)
				
				$SearchYears_atxt{$ArraySize_l}:=String:C10($Year_l; "0000")
				$SearchMonths_atxt{$ArraySize_l}:=String:C10($MonthLoop_l; "00")
				$ArraySize_l:=$ArraySize_l+1
			End for 
			$Year_l:=$Year_l+1
			
		End for 
End case 



$ArraySize_l:=Size of array:C274($SearchMonths_atxt)
$ArraySize_l:=$ArraySize_l+1
INSERT IN ARRAY:C227($SearchMonths_atxt; $ArraySize_l; 1)
INSERT IN ARRAY:C227($SearchYears_atxt; $ArraySize_l; 1)
$ArraySize_l:=Size of array:C274($SearchMonths_atxt)

$Year_l:=Num:C11($SearchYears_atxt{$ArraySize_l-1})
$Month_l:=Num:C11($SearchMonths_atxt{$ArraySize_l-1})
If ($Month_l=12)  //we are doing last years export
	$QueryYear_s:=String:C10($Year_l+1)
	$QueryMonth_s:="01"
Else 
	$QueryYear_s:=String:C10($Year_l)
	$QueryMonth_s:=String:C10($Month_l+1; "00")
End if 
$SearchMonths_atxt{$ArraySize_l}:=$QueryMonth_s
$SearchYears_atxt{$ArraySize_l}:=$QueryYear_s

ARRAY TEXT:C222(SD_ReturnDescription_txt; 2)
ARRAY TEXT:C222(SD_ReturnAdded_txt; 2)
ARRAY TEXT:C222(SD_ReturnRemoved_txt; 2)
SD_ReturnDescription_txt{1}:="Part I Overall SD Bridge Records"

SD_ReturnDescription_txt{2}:="Part II Posted Bridge Records"

For ($OuterLoop_l; 1; 2)
	
	
	For ($Loop_l; 1; $ArraySize_l)  //Print the structural defect report
		SD_SummaryRptMMMYYYY_s:=$SearchMonths_atxt{$Loop_l}+"/"+$SearchYears_atxt{$Loop_l}
		
		If ($Loop_l<$ArraySize_l)
			
			SD_QueryForDetailReport($OuterLoop_l; $SearchMonths_atxt{$Loop_l+1}; $SearchYears_atxt{$Loop_l+1}; "A")
			//we need to query next months data for this months additions
			
			If (Records in selection:C76([SD_History:89])=0)
				SD_ReturnAdded_txt{$OuterLoop_l}:="None"
			Else 
				SD_ReturnAdded_txt{$OuterLoop_l}:=String:C10(Records in selection:C76([SD_History:89]))
			End if 
			
			
			//we need to query this months data for this months removals 
			
			SD_QueryForDetailReport($OuterLoop_l; $SearchMonths_atxt{$Loop_l}; $SearchYears_atxt{$Loop_l}; "R")
			//ok lets print defect removes
			If (Records in selection:C76([SD_History:89])=0)
				SD_ReturnRemoved_txt{$OuterLoop_l}:="None"
			Else 
				SD_ReturnRemoved_txt{$OuterLoop_l}:=String:C10(Records in selection:C76([SD_History:89]))
			End if 
			
			
		End if 
		
	End for 
End for 
//End SD_ReturnSummaryInArrays