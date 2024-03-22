If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(1/23/08 12:12:52)
	Mods_2007_CM_5401
	Mods_2011_06  // CJ Miller`06/20/11, 11:36:56      ` Type all local variables for v11
End if 

If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($Msg_txt)
	If (Records in selection:C76([Work_Estimate:103])>0)
		$Msg_txt:="Are you sure you want to delete this Assignment? It has an accompanying Work hou"+"r proposal which will also be deleted!"
	Else 
		$Msg_txt:="Are you sure you want to delete this Assignment?"
	End if 
	
	CONFIRM:C162($Msg_txt; "Delete"; "Cancel")
	If (OK=1)
		C_BOOLEAN:C305($OKtoDelete_b)
		If (Records in selection:C76([Work_Estimate:103])>0)
			$OKtoDelete_b:=ut_LoadRecordInteractive(->[Work_Estimate:103])
		Else 
			$OKtoDelete_b:=True:C214
		End if 
		
		If ($OKtoDelete_b)
			If (Records in selection:C76([Work_Estimate:103])>0)
				LogDeletion(->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; 0)
				DELETE RECORD:C58([Work_Estimate:103])
			End if 
			
			If (False:C215)
				If (Not:C34(Is new record:C668([Contract_Assignment_Maintenance:101])))
					LogDeletion(->[Contract_Maintenance:97]ContractNo:1; ->[Contract_Assignment_Maintenance:101]ContractNo:1; ->[Contract_Assignment_Maintenance:101]AssignID:3; 1)
				End if 
			End if 
			
			DELETE RECORD:C58([Contract_Assignment_Maintenance:101])
			
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
					$TLFactualSpent:=$TLFactualSpent+[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25+[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
					$DEactualSpent:=$DEactualSpent+[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
					
					$approxSpent:=$approxSpent+[Contract_Assignment_Maintenance:101]Actual_Total:9
					$TLFapproxSpent:=$TLFapproxSpent+[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25+[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
					$DEapproxSpent:=$DEapproxSpent+[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
					
				Else 
					//$approxSpent:=$approxSpent+[Contract_Assignment_Maintenance]Est_Total
					//$TLFapproxSpent:=$TLFapproxSpent+[Contract_Assignment_Maintenance]Est_TotalLimitFee+[Contract_Assignment_Maintenance]Est_ConstrTotalLimitFee
					//$DEapproxSpent:=$DEapproxSpent+[Contract_Assignment_Maintenance]Est_DirectExpense
					
					CM_CalculateNegotiatedCosts
					$approxSpent:=$approxSpent+vEstTotal
					$TLFapproxSpent:=$TLFapproxSpent+vEstTotalLimitFee+vEstConstrTotalLimitFee
					$DEapproxSpent:=$DEapproxSpent+vEstDirectExpense
				End if 
				$actualSpent:=$actualSpent+[Contract_Assignment_Maintenance:101]Actual_Total:9
				NEXT RECORD:C51([Contract_Assignment_Maintenance:101])
			End for 
			
			//Total Encumbered      
			[Contract_Maintenance:97]ApproxSpent:17:=$approxSpent
			[Contract_Maintenance:97]ActualSpent:18:=$actualSpent
			[Contract_Maintenance:97]ApproxRemainingFund:19:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ApproxSpent:17
			[Contract_Maintenance:97]ActualRemainingFund:20:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ActualSpent:18
			
			//Total Limiting Fee  
			vTLFapproxSpent:=$TLFapproxSpent
			vTLFapproxRemaining:=[Contract_Maintenance:97]InitContractTotalLimitFee:14-vTLFapproxSpent
			vTLFactualSpent:=$TLFactualSpent
			vTLFactualRemaining:=[Contract_Maintenance:97]InitContractTotalLimitFee:14-vTLFactualSpent
			
			//Direct Expense
			vDEapproxSpent:=$DEapproxSpent
			vDEapproxRemaining:=[Contract_Maintenance:97]InitContractTotDirctExpense:15-vDEapproxSpent
			vDEactualSpent:=$DEactualSpent
			vDEactualRemaining:=[Contract_Maintenance:97]InitContractTotDirctExpense:15-vDEactualSpent
			
			SAVE RECORD:C53([Contract_Maintenance:97])
			CANCEL:C270
			
		Else 
			ALERT:C41("Could not get access to delete the Work Hour Proposal!  Deletion of this Assignme"+"nt Canceled!")
		End if 
		
	End if 
End if 