//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// SD_NewSummaryReport
	// User name (OS): cjmiller
	// Date and time: 11/23/04, 10:38:13
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM01
	Mods_2005_CM07
	Mods_2010_03  //r002 CJ Miller`03/11/10, 16:00:48      `Add code to allow for printing different sections of the SD report
	// Modified by: Costas Manousakis-()-(1/4/12 16:40:07)
	Mods_2012_01
	//  `Use the variable ◊SD_DistrictSelect_txt  to fiilter results by district;
	//  `At the end show the location where the output was generated.
End if 

C_LONGINT:C283($OuterLoop_l; $Month_l; $ArraySize_l; $Start_l; $Loop_l; $BegMonth_l; $EndMonth_l; $Year_l; $YearLoop_l; $MonthLoop_l; $NumberOfYearLoops_l; $NumberofLines_l)
C_TEXT:C284(SD_SubHeadTitle_txt)
C_TEXT:C284($QueryYear_s)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($QueryMonth_s)  // Command Replaced was o_C_STRING length was 2
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
	INSERT IN ARRAY:C227($SearchMonths_atxt; 1; 1)
	INSERT IN ARRAY:C227($SearchYears_atxt; 1; 1)
	$Year_l:=Num:C11($SearchYears_atxt{2})
	$Month_l:=Num:C11($SearchMonths_atxt{2})
	
	If ($Month_l=1)  //we are doing last years export
		$QueryYear_s:=String:C10($Year_l-1)
		$QueryMonth_s:="12"
	Else 
		$QueryYear_s:=String:C10($Year_l)
		$QueryMonth_s:=String:C10($Month_l-1; "00")
	End if 
	$SearchMonths_atxt{1}:=$QueryMonth_s
	$SearchYears_atxt{1}:=$QueryYear_s
End if 
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

$NumberofLines_l:=31
SET QUERY DESTINATION:C396(Into current selection:K19:1)

SD_SetPrintOptions
SD_ReportPage_l:=0
SD_ReportDate_d:=Current date:C33(*)
If (OK=1)
	C_BOOLEAN:C305($PerformPrint_b)
	
	For ($OuterLoop_l; 1; 2)
		$PerformPrint_b:=True:C214
		$NumberofLines_l:=32
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
			C_LONGINT:C283(SD_SummaryRptAddTotl_L; SD_SummaryRptRemTotl_L)
			SD_SummaryRptAddTotl_L:=0
			SD_SummaryRptRemTotl_L:=0
			For ($Loop_l; 1; $ArraySize_l)  //Print the structural defect report
				SD_SummaryRptMMMYYYY_s:=$SearchMonths_atxt{$Loop_l}+"/"+$SearchYears_atxt{$Loop_l}
				
				If ($Loop_l<$ArraySize_l)
					
					SD_QueryForDetailReport($OuterLoop_l; $SearchMonths_atxt{$Loop_l+1}; $SearchYears_atxt{$Loop_l+1}; "A")
					If (<>SD_DistrictSelect_txt#"")
						QUERY SELECTION:C341([SD_History:89]; [SD_History:89]Item2:12=<>SD_DistrictSelect_txt)
					End if 
					//we need to query next months data for this months additions
					
					If (Records in selection:C76([SD_History:89])=0)
						SD_SummaryRptAdded_s:="None"
					Else 
						SD_SummaryRptAdded_s:=String:C10(Records in selection:C76([SD_History:89]))
						SD_SummaryRptAddTotl_L:=SD_SummaryRptAddTotl_L+Records in selection:C76([SD_History:89])
					End if 
					
					//we need to query this months data for this months removals 
					
					SD_QueryForDetailReport($OuterLoop_l; $SearchMonths_atxt{$Loop_l}; $SearchYears_atxt{$Loop_l}; "R")
					If (<>SD_DistrictSelect_txt#"")
						QUERY SELECTION:C341([SD_History:89]; [SD_History:89]Item2:12=<>SD_DistrictSelect_txt)
					End if 
					//ok lets print defect removes
					If (Records in selection:C76([SD_History:89])=0)
						SD_SummaryRptDeleted_s:="None"
					Else 
						SD_SummaryRptDeleted_s:=String:C10(Records in selection:C76([SD_History:89]))
						SD_SummaryRptRemTotl_L:=SD_SummaryRptRemTotl_L+Records in selection:C76([SD_History:89])
					End if 
					If ($NumberofLines_l>31)  //print header and sub header
						SD_PrintHeader("SummaryTitle.Rpt")
						$NumberofLines_l:=0
					End if 
					Print form:C5([SD_History:89]; "SummmaryData.rpt")
					$NumberofLines_l:=$NumberofLines_l+1
					
				End if 
				
			End for 
			SD_SummaryRptDeleted_s:=String:C10(SD_SummaryRptRemTotl_L)
			SD_SummaryRptAdded_s:=String:C10(SD_SummaryRptAddTotl_L)
			SD_SummaryRptMMMYYYY_s:="Total"
			If ($NumberofLines_l>31)  //print header and sub header
				SD_PrintHeader("SummaryTitle.Rpt")
				$NumberofLines_l:=0
			End if 
			Print form:C5([SD_History:89]; "SummaryBreak.rpt")
			$NumberofLines_l:=$NumberofLines_l+2
		End if 
	End for 
	PAGE BREAK:C6  //send job
	If ($PerformPrint_b & (<>SD_ReportFilePath_txt#""))
		SHOW ON DISK:C922(<>SD_ReportFilePath_txt)
	End if 
	
Else 
	
	ALERT:C41("Printing cancelled")
End if 

//End SD_NewSummaryReport