//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_ReportByOwner
// User name (OS): cjmiller
// Date and time: 04/19/05, 14:48:14
// ----------------------------------------------------
// Description
// This method will print summary report including subtotals by owner
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03
	Mods_2009_12  // r004 CJ Miller`12/29/09, 15:15:48      ``Add [Bridge MHD NBIS]LegacyOwner to SD Data
	Mods_2010_03  //r002 CJ Miller`03/11/10, 15:59:59      `Add code to allow for printing different sections of the SD report
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	// Modified by: Costas Manousakis-()-(1/4/12 16:40:07)
	Mods_2012_01
	//  `Use the variable ◊SD_DistrictSelect_txt  to fiilter results by district;
	//  `At the end show the location where the output was generated.
End if 
C_TEXT:C284($QueryYear_s)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($QueryMonth_s)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($InnerLoop1_l; $InnerLoop_l; $OuterLoop_l; $MaxLines_l; $Month_l; $ArraySize_l; $Start_l; $Loop_l; $BegMonth_l; $EndMonth_l; $Year_l; $YearLoop_l; $MonthLoop_l; $NumberOfYearLoops_l; $NumberofLines_l)
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
If (<>SD_Detail_l=1)
	$MaxLines_l:=24
Else 
	$MaxLines_l:=50
End if 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SD_SetPrintOptions

SD_ReportPage_l:=0
SD_ReportDate_d:=Current date:C33(*)
C_BOOLEAN:C305($printDouble_b)
C_BOOLEAN:C305($printSingle_b)

If (OK=1)
	If (<>SD_IncludeALL_l=1)
		COPY ARRAY:C226(aIt8OwnerCode; aIt8OwnerDesIncludedCode)
		COPY ARRAY:C226(aIt8OwnerDes; aIt8OwnerDesIncluded)
		
	End if 
	C_BOOLEAN:C305($PerformPrint_b)
	
	
	For ($OuterLoop_l; 1; 2)
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
			$NumberofLines_l:=$MaxLines_l+1
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
					
					CREATE SET:C116([SD_History:89]; "AddedSet")
					
					//we need to query this months data for this months removals 
					
					SD_QueryForDetailReport($OuterLoop_l; $SearchMonths_atxt{$Loop_l}; $SearchYears_atxt{$Loop_l}; "R")
					If (<>SD_DistrictSelect_txt#"")
						QUERY SELECTION:C341([SD_History:89]; [SD_History:89]Item2:12=<>SD_DistrictSelect_txt)
					End if 
					
					//ok lets print defect removes
					CREATE SET:C116([SD_History:89]; "RemovedSet")
					
					If (Records in selection:C76([SD_History:89])=0)
						SD_SummaryRptDeleted_s:="None"
					Else 
						SD_SummaryRptDeleted_s:=String:C10(Records in selection:C76([SD_History:89]))
						SD_SummaryRptRemTotl_L:=SD_SummaryRptRemTotl_L+Records in selection:C76([SD_History:89])
					End if 
					If ($NumberofLines_l>($MaxLines_l))  //print header and sub header
						If (<>SD_Detail_l=0)
							SD_PrintHeader("SummaryTitle.Rpt")
							$NumberofLines_l:=0
						Else 
							SD_PrintHeader("DetailTitle.Rpt")
							$NumberofLines_l:=2
						End if 
						
					End if 
					If (<>SD_Detail_l=1)
						If ($NumberofLines_l=2)
						Else 
							Print form:C5([SD_History:89]; "DoubleUnderLine.rpt")
							$NumberofLines_l:=$NumberofLines_l+2
						End if 
						Print form:C5([SD_History:89]; "DetailSubTotal.rpt")
					Else 
						Print form:C5([SD_History:89]; "SummmaryData.rpt")
					End if 
					$NumberofLines_l:=$NumberofLines_l+1
					For ($InnerLoop_l; 1; Size of array:C274(aIt8OwnerDesIncludedCode))
						USE SET:C118("AddedSet")
						If (<>SD_UseLegacy_l=0)
							QUERY SELECTION:C341([SD_History:89]; [SD_History:89]SD_Owner_s:17=aIt8OwnerDesIncludedCode{$InnerLoop_l})
						Else 
							QUERY SELECTION:C341([SD_History:89]; [SD_History:89]SD_PreviousOwner_s:19=aIt8OwnerDesIncludedCode{$InnerLoop_l})
						End if 
						
						If (Records in selection:C76([SD_History:89])=0)
							SD_SummaryByOwner_s:=""
						Else 
							SD_SummaryByOwner_s:=String:C10(Records in selection:C76([SD_History:89]))+" added for "+aIt8OwnerDesIncluded{$InnerLoop_l}
							If ($NumberofLines_l>$MaxLines_l)  //print header and sub header
								If (<>SD_Detail_l=0)
									SD_PrintHeader("SummaryTitle.Rpt")
									$NumberofLines_l:=0
								Else 
									SD_PrintHeader("DetailTitle.Rpt")
									$NumberofLines_l:=2
								End if 
								
							End if 
							Print form:C5([SD_History:89]; "SubByOwner.rpt")
							$NumberofLines_l:=$NumberofLines_l+2
						End if 
						
						If (<>SD_Detail_l=1)
							For ($InnerLoop1_l; 1; Records in selection:C76([SD_History:89]))
								GOTO SELECTED RECORD:C245([SD_History:89]; $InnerLoop1_l)
								If ($NumberofLines_l>$MaxLines_l)  //print header and sub header
									If (<>SD_Detail_l=0)
										SD_PrintHeader("SummaryTitle.Rpt")
										$NumberofLines_l:=0
									Else 
										SD_PrintHeader("DetailTitle.Rpt")
										$NumberofLines_l:=2
									End if 
									
								End if 
								Print form:C5([SD_History:89]; "DetailData.Rpt")
								$NumberofLines_l:=$NumberofLines_l+1
								
							End for 
						End if 
					End for 
					If (<>SD_Detail_l=0)
						If (SD_SummaryRptAdded_s="None") & (SD_SummaryRptDeleted_s="None")
							Print form:C5([SD_History:89]; "DoubleUnderLine.Rpt")
						Else 
							Print form:C5([SD_History:89]; "Underline.Rpt")
						End if 
					End if 
					$NumberofLines_l:=$NumberofLines_l+1
					For ($InnerLoop_l; 1; Size of array:C274(aIt8OwnerDesIncludedCode))
						USE SET:C118("RemovedSet")
						If (<>SD_UseLegacy_l=0)
							QUERY SELECTION:C341([SD_History:89]; [SD_History:89]SD_Owner_s:17=aIt8OwnerDesIncludedCode{$InnerLoop_l})
						Else 
							QUERY SELECTION:C341([SD_History:89]; [SD_History:89]SD_PreviousOwner_s:19=aIt8OwnerDesIncludedCode{$InnerLoop_l})
						End if 
						
						If (Records in selection:C76([SD_History:89])=0)
							SD_SummaryByOwner_s:=""
						Else 
							SD_SummaryByOwner_s:=String:C10(Records in selection:C76([SD_History:89]))+" removed for "+aIt8OwnerDesIncluded{$InnerLoop_l}
							If ($NumberofLines_l>($MaxLines_l))  //print header and sub header
								If (<>SD_Detail_l=0)
									SD_PrintHeader("SummaryTitle.Rpt")
									$NumberofLines_l:=0
								Else 
									SD_PrintHeader("DetailTitle.Rpt")
									$NumberofLines_l:=2
								End if 
							End if 
							If (<>SD_Detail_l=1)
								If ($NumberofLines_l=2)
								Else 
									Print form:C5([SD_History:89]; "Underline.Rpt")
									$NumberofLines_l:=$NumberofLines_l+1
								End if 
							End if 
							Print form:C5([SD_History:89]; "SubByOwner.rpt")
							$NumberofLines_l:=$NumberofLines_l+2
						End if 
						If ($InnerLoop_l=Size of array:C274(aIt8OwnerDesIncludedCode))
							If (<>SD_Detail_l=0)
								If (SD_SummaryRptAdded_s="None") & (SD_SummaryRptDeleted_s="None")
								Else 
									Print form:C5([SD_History:89]; "DoubleUnderLine.rpt")
									$NumberofLines_l:=$NumberofLines_l+1
								End if 
							End if 
						End if 
						If (<>SD_Detail_l=1)
							For ($InnerLoop1_l; 1; Records in selection:C76([SD_History:89]))
								GOTO SELECTED RECORD:C245([SD_History:89]; $InnerLoop1_l)
								If ($NumberofLines_l>$MaxLines_l)  //print header and sub header
									If (<>SD_Detail_l=0)
										SD_PrintHeader("SummaryTitle.Rpt")
										$NumberofLines_l:=0
									Else 
										SD_PrintHeader("DetailTitle.Rpt")
										$NumberofLines_l:=2
									End if 
								End if 
								Print form:C5([SD_History:89]; "DetailData.Rpt")
								$NumberofLines_l:=$NumberofLines_l+1
								
							End for 
						End if 
					End for 
					
				End if 
				
			End for 
			
			SD_SummaryRptDeleted_s:=String:C10(SD_SummaryRptRemTotl_L)
			SD_SummaryRptAdded_s:=String:C10(SD_SummaryRptAddTotl_L)
			SD_SummaryRptMMMYYYY_s:="Total"
			If ($NumberofLines_l>$MaxLines_l)  //print header and sub header
				If (<>SD_Detail_l=0)
					SD_PrintHeader("SummaryTitle.Rpt")
					$NumberofLines_l:=0
				Else 
					SD_PrintHeader("DetailTitle.Rpt")
					$NumberofLines_l:=2
				End if 
				
			End if 
			Print form:C5([SD_History:89]; "SummaryBreak.rpt")
			$NumberofLines_l:=$NumberofLines_l+2
		End if 
	End for 
	PAGE BREAK:C6  //send job
	CLEAR SET:C117("RemovedSet")
	CLEAR SET:C117("AddedSet")
	If ($PerformPrint_b & (<>SD_ReportFilePath_txt#""))
		SHOW ON DISK:C922(<>SD_ReportFilePath_txt)
	End if 
	
Else 
	
	ALERT:C41("Printing cancelled")
End if 
SET PRINT OPTION:C733(Destination option:K47:7; 1)  //back to printer
//End sd_con
