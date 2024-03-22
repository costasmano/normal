//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/28/08, 09:25:17
	// ----------------------------------------------------
	// Method: CM_AssgnRate_OM
	// Description
	// Object method for the assignment rates objects (overhead and net fee)
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_REAL:C285($TLFTotal_check_r)
		$TLFTotal_check_r:=[Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13+[Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30
		$TLFTotal_check_r:=$TLFTotal_check_r+[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25+[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
		If ($TLFTotal_check_r>0)
			If (CM_ADDENCALBASE=0)
				CONFIRM:C162("Update costs based on current salary values or Total Limit Fees?"; "Salary"; "TLF")
				If (OK=1)
					CM_ADDENCALBASE:=1
				Else 
					CM_ADDENCALBASE:=2
				End if 
				
			End if 
			
			If (CM_ADDENCALBASE=1)  //Calc base on salary
				If (Records in selection:C76([Addendum_Maintenance:102])>0)
					ALERT:C41("Updating Addendums!!")
					While (Not:C34(End selection:C36([Addendum_Maintenance:102])))
						CM_AssgnValues_OM("ADDEND_DES"; "SALARY")
						CM_AssgnValues_OM("ADDEND_CONSTR"; "SALARY")
						SAVE RECORD:C53([Addendum_Maintenance:102])
						NEXT RECORD:C51([Addendum_Maintenance:102])
					End while 
					
				End if 
				
				CM_AssgnValues_OM("EST_DES"; "SALARY")
				CM_AssgnValues_OM("EST_CONSTR"; "SALARY")
				
				CM_AssgnValues_OM("ACTUAL_DES"; "SALARY")
				CM_AssgnValues_OM("ACTUAL_CONSTR"; "SALARY")
				
			Else 
				If (Records in selection:C76([Addendum_Maintenance:102])>0)
					ALERT:C41("Updating Addendums!!")
					While (Not:C34(End selection:C36([Addendum_Maintenance:102])))
						CM_AssgnValues_OM("ADDEND_DES"; "TOTAL")
						CM_AssgnValues_OM("ADDEND_CONSTR"; "TOTAL")
						SAVE RECORD:C53([Addendum_Maintenance:102])
						NEXT RECORD:C51([Addendum_Maintenance:102])
					End while 
					
				End if 
				CM_AssgnValues_OM("EST_DES"; "TOTAL")
				CM_AssgnValues_OM("EST_CONSTR"; "TOTAL")
				
				CM_AssgnValues_OM("ACTUAL_DES"; "TOTAL")
				CM_AssgnValues_OM("ACTUAL_CONSTR"; "TOTAL")
			End if 
			
		End if 
End case 