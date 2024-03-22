//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_NewDetailReport
// User name (OS): cjmiller
// Date and time: 11/09/04, 16:02:06
// ----------------------------------------------------
// Description
// This method will control printing of detail structural defect report
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2009_12  // r004 CJ Miller`12/29/09, 15:08:43      ``Add [Bridge MHD NBIS]LegacyOwner to SD Data
	Mods_2010_03  //r002 CJ Miller`03/11/10, 16:02:23      `Add code to allow for printing different sections of the SD report
	Mods_2011_06  // CJ Miller`06/14/11, 10:53:49      ` Type all local variables for v11
	// Modified by: Costas Manousakis-()-(1/4/12 16:40:07)
	Mods_2012_01
	//  `Use the variable ◊SD_DistrictSelect_txt  to fiilter results by district;
	//  `At the end show the location where the output was generated.
End if 
C_BOOLEAN:C305($PerformPrint_b)

C_LONGINT:C283($InnerLoop_l; $OuterLoop_l; $ArraySize_l; $Start_l; $Loop_l; $BegMonth_l; $EndMonth_l; $Year_l; $YearLoop_l; $MonthLoop_l; $NumberOfYearLoops_l; $NumberofLines_l)
C_TEXT:C284(SD_SubHeadTitle_txt)
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
If (False:C215)  //decided not to report on previous month
	//INSERT ELEMENT($SearchMonths_atxt;1;1)
	//INSERT ELEMENT($SearchYears_atxt;1;1)
	//$Year_l:=Num($SearchYears_atxt{2})
	//C_LONGINT($Month_l)
	//
	//$Month_l:=Num($SearchMonths_atxt{2})
	//C_STRING(4;$QueryYear_s)
	//C_STRING(2;$QueryMonth_s)
	//If ($Month_l=1)  `we are doing last years export
	//$QueryYear_s:=String($Year_l-1)
	//$QueryMonth_s:="12"
	//Else 
	//$QueryYear_s:=String($Year_l)
	//$QueryMonth_s:=String($Month_l-1;"00")
	//End if 
	//$SearchMonths_atxt{1}:=$QueryMonth_s
	//$SearchYears_atxt{1}:=$QueryYear_s
End if 
C_LONGINT:C283($Month_l)
C_TEXT:C284($QueryYear_s)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($QueryMonth_s)  // Command Replaced was o_C_STRING length was 2

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
//End Set up search arrays

$NumberofLines_l:=50
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SD_SetPrintOptions
C_LONGINT:C283(SD_ReportPage_l)
SD_ReportPage_l:=0
SD_ReportDate_d:=Current date:C33(*)
If (OK=1)
	
	For ($OuterLoop_l; 1; 2)
		$NumberofLines_l:=50
		$PerformPrint_b:=True:C214
		If ($OuterLoop_l=1)
			If (<>SD_PrintHistory_l=1)
				SD_SubHeadTitle_txt:="Part I Overall SD Bridge Records"
			Else 
				$PerformPrint_b:=False:C215
			End if 
		Else 
			If (<>SD_PrintPosted_l=1)
				SD_SubHeadTitle_txt:="Part II Posted Bridge Records"
			Else 
				$PerformPrint_b:=False:C215
			End if 
		End if 
		If ($PerformPrint_b)
			For ($Loop_l; 1; $ArraySize_l)  //Print the structural defect report
				SD_SummaryRptMMMYYYY_s:=$SearchMonths_atxt{$Loop_l}+"/"+$SearchYears_atxt{$Loop_l}
				SD_SummaryRptDeleted_s:="None"
				If ($Loop_l<$ArraySize_l)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					SD_QueryForDetailReport($OuterLoop_l; $SearchMonths_atxt{$Loop_l+1}; $SearchYears_atxt{$Loop_l+1}; "A")
					If (<>SD_DistrictSelect_txt#"")
						QUERY SELECTION:C341([SD_History:89]; [SD_History:89]Item2:12=<>SD_DistrictSelect_txt)
					End if 
					//we need to query next months data for this months additions
					CREATE SET:C116([SD_History:89]; "AddedSet")
					
					If (Records in selection:C76([SD_History:89])=0)
						SD_SummaryRptAdded_s:="None"
					Else 
						SD_SummaryRptAdded_s:=String:C10(Records in selection:C76([SD_History:89]))
					End if 
					
					
					//we need to query this months data for this months removals 
					//and never need to query the last element  in array ikn that it is populated for 
					SD_QueryForDetailReport($OuterLoop_l; $SearchMonths_atxt{$Loop_l}; $SearchYears_atxt{$Loop_l}; "R")
					If (<>SD_DistrictSelect_txt#"")
						QUERY SELECTION:C341([SD_History:89]; [SD_History:89]Item2:12=<>SD_DistrictSelect_txt)
					End if 
					CREATE SET:C116([SD_History:89]; "RemovedSet")
					//ok lets print defect removes
					If (Records in selection:C76([SD_History:89])=0)
						SD_SummaryRptDeleted_s:="None"
					Else 
						SD_SummaryRptDeleted_s:=String:C10(Records in set:C195("RemovedSet"))
					End if 
					If ($NumberofLines_l>24)  //print header and sub header
						SD_PrintHeader("DetailTitle.Rpt")
						$NumberofLines_l:=0
					End if 
					Print form:C5([SD_History:89]; "DetailSubTotal.rpt")
					$NumberofLines_l:=$NumberofLines_l+1
					
					USE SET:C118("AddedSet")
					//ok now we print added records
					If (<>SD_UseLegacy_l=0)
						ORDER BY:C49([SD_History:89]; [SD_History:89]SD_Owner_s:17; >; [SD_History:89]Item2:12; >; [SD_History:89]Item8:6; >)
					Else 
						ORDER BY:C49([SD_History:89]; [SD_History:89]SD_PreviousOwner_s:19; >; [SD_History:89]Item2:12; >; [SD_History:89]Item8:6; >)
					End if 
					
					For ($InnerLoop_l; 1; Records in selection:C76([SD_History:89]))
						If ($NumberofLines_l>24)  //print header and sub header
							SD_PrintHeader("DetailTitle.Rpt")
							$NumberofLines_l:=0
						End if 
						GOTO SELECTED RECORD:C245([SD_History:89]; $InnerLoop_l)
						SD_ReportStatus_s:="Added"
						
						Print form:C5([SD_History:89]; "DetailData.Rpt")
						$NumberofLines_l:=$NumberofLines_l+1
					End for 
					
					
					If (Records in selection:C76([SD_History:89])>0)
						Print form:C5([SD_History:89]; "UnderLine.rpt")
						$NumberofLines_l:=$NumberofLines_l+1
					End if 
					
					
					USE SET:C118("RemovedSet")
					If (<>SD_UseLegacy_l=0)
						ORDER BY:C49([SD_History:89]; [SD_History:89]SD_Owner_s:17; >; [SD_History:89]Item2:12; >; [SD_History:89]Item8:6; >)
					Else 
						ORDER BY:C49([SD_History:89]; [SD_History:89]SD_PreviousOwner_s:19; >; [SD_History:89]Item2:12; >; [SD_History:89]Item8:6; >)
					End if 
					
					For ($InnerLoop_l; 1; Records in selection:C76([SD_History:89]))
						If ($NumberofLines_l>24)  //print header and sub header
							SD_PrintHeader("DetailTitle.Rpt")
							$NumberofLines_l:=0
						End if 
						GOTO SELECTED RECORD:C245([SD_History:89]; $InnerLoop_l)
						SD_ReportStatus_s:="Removed"
						
						Print form:C5([SD_History:89]; "DetailData.Rpt")
						$NumberofLines_l:=$NumberofLines_l+1
					End for 
					
					Print form:C5([SD_History:89]; "DoubleUnderLine.Rpt")
					$NumberofLines_l:=$NumberofLines_l+1
					
					
				End if 
				
				
			End for 
		End if 
		If ($PerformPrint_b & (<>SD_ReportFilePath_txt#""))
			SHOW ON DISK:C922(<>SD_ReportFilePath_txt)
		End if 
		
	End for 
	
Else 
	ALERT:C41("Printing cancelled")
End if 

//End SD_NewDetailReport