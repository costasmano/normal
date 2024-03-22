If (False:C215)
	//Object Method: [Contract Assignments];"Assignments In".btnRetrieveCost 
	//Object Method: btnRetrieveCost 
	Mods_2005_CM13
	Mods_2005_VN02
	// Modified by: costasmanousakis-(Designer)-(12/14/2005 13:09:33)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(4/5/2006 10:44:26)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(4/3/2007 10:04:44)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/18/2007 15:20:41)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(9/27/16 12:49:38)
	Mods_2016_09
	//  `Modifed to use TableOfList lists CONSRTG_ACTCOSTST and CONSINS_ACTCOSTST to get the status 
	//  `that all BINs must be in for actual costs to be calculated.
End if 

C_TEXT:C284($vtxtMsg)
ARRAY TEXT:C222($ConsRtgActCostStat_atxt; 0)
ARRAY TEXT:C222($ConsInsActCostStat_atxt; 0)
TOL_ListToArray("CONSRTG_ACTCOSTST"; ->$ConsRtgActCostStat_atxt)
TOL_ListToArray("CONSINS_ACTCOSTST"; ->$ConsInsActCostStat_atxt)
C_BOOLEAN:C305($OkToGo_b)
$OkToGo_b:=True:C214

Case of 
	: (Size of array:C274($ConsRtgActCostStat_atxt)=0)
		$OkToGo_b:=False:C215
		ALERT:C41("Error ! Could not load Configuration list CONSRTG_ACTCOSTST for Rating status to be included in Actual Cost Calculations.")
	: (Size of array:C274($ConsInsActCostStat_atxt)=0)
		$OkToGo_b:=False:C215
		ALERT:C41("Error ! Could not load Configuration list CONSINS_ACTCOSTST for Inspection status to be included in Actual Cost Calculations.")
End case 

If ($OkToGo_b)
	C_TEXT:C284($InspCostMsg_txt; $RtgCostMsg_txt)
	C_LONGINT:C283($loop_L)
	$RtgCostMsg_txt:=$ConsRtgActCostStat_atxt{1}
	For ($loop_L; 2; Size of array:C274($ConsRtgActCostStat_atxt))
		$RtgCostMsg_txt:=$RtgCostMsg_txt+"/"+$ConsRtgActCostStat_atxt{$loop_L}
	End for 
	$InspCostMsg_txt:=$ConsInsActCostStat_atxt{1}
	For ($loop_L; 2; Size of array:C274($ConsInsActCostStat_atxt))
		$InspCostMsg_txt:=$InspCostMsg_txt+"/"+$ConsInsActCostStat_atxt{$loop_L}
	End for 
	
	$vtxtMsg:="Click Yes to retrieve cost data from Consultant Inspections and Ratings."
	$vtxtMsg:=$vtxtMsg+" Click No to cancel."
	CONFIRM:C162($vtxtMsg; "Yes"; "No")
	
	If (OK=1)
		C_LONGINT:C283($j; $lRecordCount)
		C_REAL:C285(rNegSalary; rNegIndirectCost; rNegNetFee; rNegTotalLimitFee; rNegTotalDirectCost; rNegTotal)
		C_REAL:C285(rActSalary; rActIndirectCost; rActNetFee; rActTotalLimitFee; rActTotalDirectCost; rActTotal)
		C_BOOLEAN:C305($bAllActualCostsFinal)
		rNegSalary:=0
		rNegIndirectCost:=0
		rNegNetFee:=0
		rNegTotalLimitFee:=0
		rNegTotalDirectCost:=0
		rNegTotal:=0
		
		rActSalary:=0
		rActIndirectCost:=0
		rActNetFee:=0
		rActTotalLimitFee:=0
		rActTotalDirectCost:=0
		rActTotal:=0
		$bAllActualCostsFinal:=True:C214
		C_TEXT:C284($ErrText_txt)
		$ErrText_txt:=""
		QUERY:C277([Cons Inspection:64]; [Cons Inspection:64]ConContractNo:7=[Contracts:79]ContractNo:1; *)
		QUERY:C277([Cons Inspection:64];  & ; [Cons Inspection:64]AssignConNumber:6=[Contract Assignments:83]AssignNo:2)
		$lRecordCount:=Records in selection:C76([Cons Inspection:64])
		
		If ($lRecordCount>0)
			
			For ($j; 1; $lRecordCount)
				GOTO SELECTED RECORD:C245([Cons Inspection:64]; $j)
				RELATE MANY:C262([Cons Inspection:64])
				FIRST RECORD:C50([Cons Inspection Cost:76])
				
				//retrieve negotiate costs
				//don't calculate if status = Rescinded - the cost will be 0
				If (Not:C34([Cons Inspection:64]AssignStatus:24="Rescinded"))
					rNegSalary:=rNegSalary+[Cons Inspection Cost:76]Neg Salary:3
					rNegIndirectCost:=rNegIndirectCost+[Cons Inspection Cost:76]Neg IndirectCost:4
					rNegNetFee:=rNegNetFee+[Cons Inspection Cost:76]Neg NetFee:5
					rNegTotalLimitFee:=rNegTotalLimitFee+[Cons Inspection Cost:76]Neg TotalLimitFee:6
					rNegTotalDirectCost:=rNegTotalDirectCost+[Cons Inspection Cost:76]Neg TotalDirectCost:18
					rNegTotal:=rNegTotal+[Cons Inspection Cost:76]Neg TotalCost:19
				End if 
				
				//retrieve actual costs
				If (Find in array:C230($ConsInsActCostStat_atxt; [Cons Inspection:64]AssignStatus:24)>0)  //="Rescinded") | ([Cons Inspection]AssignStatus="Completed"))
					If ([Cons Inspection Cost:76]FinalCost_B:49)
						rActSalary:=rActSalary+[Cons Inspection Cost:76]Act Salary:22
						rActIndirectCost:=rActIndirectCost+[Cons Inspection Cost:76]Act IndirectCost:23
						rActNetFee:=rActNetFee+[Cons Inspection Cost:76]Act NetFee:24
						rActTotalLimitFee:=rActTotalLimitFee+[Cons Inspection Cost:76]Act TotalLimitFee:25
						rActTotalDirectCost:=rActTotalDirectCost+[Cons Inspection Cost:76]Act TotalDirectCost:37
						rActTotal:=rActTotal+[Cons Inspection Cost:76]Act TotalCost:38
					Else 
						$bAllActualCostsFinal:=False:C215
						$ErrText_txt:=$ErrText_txt+"Insp. BIN "+[Cons Inspection:64]BIN:1+": No Final Cost"+<>sCR
					End if 
				Else 
					$bAllActualCostsFinal:=False:C215
					$ErrText_txt:=$ErrText_txt+"Insp. BIN "+[Cons Inspection:64]BIN:1+": Not "+$InspCostMsg_txt+<>sCR
				End if 
				
			End for 
		End if   //If records found in [Cons Inspection]
		
		QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]ContractNoRat:14=[Contracts:79]ContractNo:1; *)
		QUERY:C277([Conslt Rating:63];  & ; [Conslt Rating:63]AssignNoRat:12=[Contract Assignments:83]AssignNo:2)
		//$lActualCostCount:=0
		$lRecordCount:=Records in selection:C76([Conslt Rating:63])
		If ($lRecordCount>0)
			
			FIRST RECORD:C50([Conslt Rating:63])
			For ($j; 1; $lRecordCount)
				GOTO SELECTED RECORD:C245([Conslt Rating:63]; $j)
				RELATE MANY:C262([Conslt Rating:63])
				FIRST RECORD:C50([Conslt Rating Cost:74])
				
				//retrieve negotiate costs
				//don't calculate if status = Rescinded - the cost will be 0
				If (Not:C34([Conslt Rating:63]AssignStatus:43="Rescinded"))
					rNegSalary:=rNegSalary+[Conslt Rating Cost:74]Neg Salary:3
					rNegIndirectCost:=rNegIndirectCost+[Conslt Rating Cost:74]Neg IndirectCost:4
					rNegNetFee:=rNegNetFee+[Conslt Rating Cost:74]Neg NetFee:5
					rNegTotalLimitFee:=rNegTotalLimitFee+[Conslt Rating Cost:74]Neg TotalLimitFee:6
					rNegTotalDirectCost:=rNegTotalDirectCost+[Conslt Rating Cost:74]Neg TotalDirectCost:17
					rNegTotal:=rNegTotal+[Conslt Rating Cost:74]Neg TotalCost:18
				End if 
				
				//retrieve actual costs
				If (Find in array:C230($ConsRtgActCostStat_atxt; [Conslt Rating:63]AssignStatus:43)>0)  //="Rescinded") | ([Conslt Rating]AssignStatus="Completed") | ([Conslt Rating]AssignStatus="Rejected W/O@"))
					If ([Conslt Rating Cost:74]FinalCost_B:41)
						rActSalary:=rActSalary+[Conslt Rating Cost:74]Act Salary:21
						rActIndirectCost:=rActIndirectCost+[Conslt Rating Cost:74]Act IndirectCost:39
						rActNetFee:=rActNetFee+[Conslt Rating Cost:74]Act NetFee:22
						rActTotalLimitFee:=rActTotalLimitFee+[Conslt Rating Cost:74]Act TotalLimitFee:23
						rActTotalDirectCost:=rActTotalDirectCost+[Conslt Rating Cost:74]Act TotalDirectCost:34
						rActTotal:=rActTotal+[Conslt Rating Cost:74]Act TotalCost:35
					Else 
						$bAllActualCostsFinal:=False:C215
						$ErrText_txt:=$ErrText_txt+"Ratg. BIN "+[Conslt Rating:63]BIN:1+": No Final Cost"+<>sCR
					End if 
				Else 
					$bAllActualCostsFinal:=False:C215
					$ErrText_txt:=$ErrText_txt+"Ratg. BIN "+[Conslt Rating:63]BIN:1+": Not "+$RtgCostMsg_txt+<>sCR
				End if 
				
			End for 
		End if   //If records found in [Conslt Rating]
		
		[Contract Assignments:83]Est_Salary:10:=rNegSalary
		[Contract Assignments:83]Est_IndirectCost:11:=rNegIndirectCost
		[Contract Assignments:83]Est_NetFee:12:=rNegNetFee
		[Contract Assignments:83]Est_TotalLimitFee:13:=rNegTotalLimitFee
		[Contract Assignments:83]Est_DirectExpense:14:=rNegTotalDirectCost
		[Contract Assignments:83]Est_Total:15:=rNegTotal
		
		If ($bAllActualCostsFinal)
			[Contract Assignments:83]Actual_Salary:4:=rActSalary
			[Contract Assignments:83]Actual_IndirectCost:5:=rActIndirectCost
			[Contract Assignments:83]Actual_NetFee:6:=rActNetFee
			[Contract Assignments:83]Actual_TotalLimitFee:7:=rActTotalLimitFee
			[Contract Assignments:83]Actual_DirectExpense:8:=rActTotalDirectCost
			[Contract Assignments:83]Actual_Total:9:=rActTotal
		Else 
			$ErrText_txt:="Not all Projects for this Assignment have Correct Status AND have Fi"+"nal Actual Costs!"+<>sCR+$ErrText_txt
			
			If (Round:C94([Contract Assignments:83]Actual_Total:9; 2)=0)
				ALERT:C41($ErrText_txt)
			Else 
				$ErrText_txt:=$ErrText_txt+Char:C90(13)+"Set Actual costs to zero?"
				CONFIRM:C162($ErrText_txt; "Set Actual Costs to Zero"; "Leave as is")
				If (OK=1)
					[Contract Assignments:83]Actual_Salary:4:=0
					[Contract Assignments:83]Actual_IndirectCost:5:=0
					[Contract Assignments:83]Actual_NetFee:6:=0
					[Contract Assignments:83]Actual_TotalLimitFee:7:=0
					[Contract Assignments:83]Actual_DirectExpense:8:=0
					[Contract Assignments:83]Actual_Total:9:=0
				End if 
			End if 
		End if 
		REDRAW WINDOW:C456  //???
	End if 
End if 