If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/8/2005 13:53:42)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(11/21/07 12:30:29)
	Mods_2007_CM_5401
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	If (False:C215)
		If (Is new record:C668([Contract_Assignment_Maintenance:101]))
			LogNewRecord(->[Contract_Maintenance:97]ContractNo:1; ->[Contract_Assignment_Maintenance:101]ContractNo:1; ->[Contract_Assignment_Maintenance:101]AssignID:3; 1; "AssignMaint")
		End if 
	End if 
	
	//check for unique assignment number before saving it
	C_LONGINT:C283($vlRecCount)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $vlRecCount)
	
	QUERY:C277([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]ContractNo:1=[Contract_Maintenance:97]ContractNo:1; *)
	QUERY:C277([Contract_Assignment_Maintenance:101];  & ; [Contract_Assignment_Maintenance:101]AssignNo:2=[Contract_Assignment_Maintenance:101]AssignNo:2)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If (($vlRecCount>0) & (Is new record:C668([Contract_Assignment_Maintenance:101])))
		ALERT:C41("This assignment number is already being used. Please enter a different one!")
	Else 
		C_LONGINT:C283($numWkHrs; $i; $NumProjects_L)
		C_BOOLEAN:C305($DoTheSave_b)
		$DoTheSave_b:=True:C214
		SET QUERY DESTINATION:C396(Into variable:K19:4; $numWkHrs)
		QUERY:C277([Work_Estimate:103]; [Work_Estimate:103]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $NumProjects_L)
		QUERY:C277([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]AssignID:13=[Contract_Assignment_Maintenance:101]AssignID:3)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If (($NumProjects_L=0) & ([Contract_Assignment_Maintenance:101]ProjectType:36#""))
			C_BOOLEAN:C305($SomeDate_b)
			$SomeDate_b:=([Contract_Assignment_Maintenance:101]ReqFeeProposalDate:16#!00-00-00!)
			$SomeDate_b:=$SomeDate_b | ([Contract_Assignment_Maintenance:101]NTPdate_written:17#!00-00-00!)
			$SomeDate_b:=$SomeDate_b | ([Contract_Assignment_Maintenance:101]NTPdate_verbal:18#!00-00-00!)
			If (($SomeDate_b) | ($numWkHrs>0))
				C_TEXT:C284($msg_txt)
				$msg_txt:="You have not defined any Projects for a "+[Contract_Assignment_Maintenance:101]ProjectType:36+" assignment!"
				$Msg_txt:=$msg_txt+<>sCR+"Do you wish to Add projects in the Projects tab?"
				CONFIRM:C162($msg_txt; "ADD"; "Exit and Save")
				If (OK=1)
					FORM GOTO PAGE:C247(2)
					$DoTheSave_b:=False:C215
				End if 
				
			Else 
				
			End if 
			
		End if 
		If ($DoTheSave_b)
			
			SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
			
			QUERY:C277([Work_Estimate:103]; [Work_Estimate:103]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3)
			C_LONGINT:C283($numWkHrs; $i)
			$numWkHrs:=Records in selection:C76([Work_Estimate:103])
			If ($numWkHrs>0)
				For ($i; 1; $numWkHrs)
					GOTO SELECTED RECORD:C245([Work_Estimate:103]; $i)
					LOAD RECORD:C52([Work_Estimate:103])
					InitChangeStack(1)
					Case of 
						: ([Work_Estimate:103]AddendumNo:29=0)
							If ([Work_Estimate:103]AssignDesc:4#[Contract_Assignment_Maintenance:101]Description:35)
								[Work_Estimate:103]AssignDesc:4:=[Contract_Assignment_Maintenance:101]Description:35
								PushChange(1; ->[Work_Estimate:103]AssignDesc:4)
							End if 
							If ([Work_Estimate:103]ProjInfoNo:26#[Contract_Assignment_Maintenance:101]ProjectIS:4)
								[Work_Estimate:103]ProjInfoNo:26:=[Contract_Assignment_Maintenance:101]ProjectIS:4
								PushChange(1; ->[Work_Estimate:103]ProjInfoNo:26)
							End if 
							
						: ([Work_Estimate:103]AddendumNo:29>0)
							If ([Work_Estimate:103]ProjInfoNo:26#[Contract_Assignment_Maintenance:101]ProjectIS:4)
								[Work_Estimate:103]ProjInfoNo:26:=[Contract_Assignment_Maintenance:101]ProjectIS:4
								PushChange(1; ->[Work_Estimate:103]ProjInfoNo:26)
							End if 
							
					End case 
					If (Modified record:C314([Work_Estimate:103]))
						SAVE RECORD:C53([Work_Estimate:103])
						FlushGrpChgs(1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; 0)
					End if 
					
				End for 
				
			End if 
			//update approx and actual spent in [Contract_Maintenance]  
			C_REAL:C285($approxSpent; $actualSpent)
			$approxSpent:=0
			$actualSpent:=0
			C_REAL:C285($TLFapproxSpent; $TLFactualSpent)
			$TLFapproxSpent:=0
			$TLFactualSpent:=0
			C_REAL:C285($DEapproxSpent; $DEactualSpent)
			$DEapproxSpent:=0
			$DEactualSpent:=0
			C_LONGINT:C283($j)
			QUERY:C277([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]ContractNo:1=[Contract_Maintenance:97]ContractNo:1)
			FIRST RECORD:C50([Contract_Assignment_Maintenance:101])
			For ($j; 1; Records in selection:C76([Contract_Assignment_Maintenance:101]))
				If ([Contract_Assignment_Maintenance:101]AcutalOrEstimate:20="Actual")
					$actualSpent:=$actualSpent+[Contract_Assignment_Maintenance:101]Actual_Total:9
					//this change reflects to adding design
					$TLFactualSpent:=$TLFactualSpent+[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25+[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
					$DEactualSpent:=$DEactualSpent+[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
					
					$approxSpent:=$approxSpent+[Contract_Assignment_Maintenance:101]Actual_Total:9
					//this change reflects to adding design
					$TLFapproxSpent:=$TLFapproxSpent+[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25+[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
					$DEapproxSpent:=$DEapproxSpent+[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
					
				Else 
					
					CM_CalculateNegotiatedCosts
					$approxSpent:=$approxSpent+vEstTotal
					$TLFapproxSpent:=$TLFapproxSpent+vEstTotalLimitFee+vEstConstrTotalLimitFee
					$DEapproxSpent:=$DEapproxSpent+vEstDirectExpense
				End if 
				NEXT RECORD:C51([Contract_Assignment_Maintenance:101])
			End for 
			
			//Total Encumbered  
			[Contract_Maintenance:97]ApproxSpent:17:=$approxSpent
			[Contract_Maintenance:97]ActualSpent:18:=$actualSpent
			[Contract_Maintenance:97]ApproxRemainingFund:19:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ApproxSpent:17
			[Contract_Maintenance:97]ActualRemainingFund:20:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ActualSpent:18
			
			//Total Limiting Fee  
			vTLFapproxSpent:=$TLFapproxSpent
			vTLFapproxRemaining:=vTLFupdated-vTLFapproxSpent
			vTLFactualSpent:=$TLFactualSpent
			vTLFactualRemaining:=vTLFupdated-vTLFactualSpent
			
			//Direct Expense
			vDEapproxSpent:=$DEapproxSpent
			vDEapproxRemaining:=vDEupdated-vDEapproxSpent
			vDEactualSpent:=$DEactualSpent
			vDEactualRemaining:=vDEupdated-vDEactualSpent
			
			SAVE RECORD:C53([Contract_Maintenance:97])
			ACCEPT:C269
			
		End if 
	End if 
End if 