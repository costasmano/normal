If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/11/2006 08:56:20)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(5/15/2006 14:14:26)
	Mods_2006_CMz1
	// Modified by: costasmanousakis-(Designer)-(1/30/2007 09:47:56)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(10/8/08 09:56:32)
	Mods_2008_CM_5404  // ("ACCESS")
	// Modified by: costasmanousakis-(Designer)-(1/27/09 11:44:54)
	Mods_2009_CM_5404
	//Adjusted margins and the incl list for better display,
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		InitChangeStack(2)
		If (Is new record:C668([ExtendTime_Maintenance:98]))
			[ExtendTime_Maintenance:98]ContractNo:1:=[Contract_Maintenance:97]ContractNo:1
			Inc_Sequence("ExtTimeMaint"; ->[ExtendTime_Maintenance:98]EOT_ID:2)
			
			//set the default value of Initial Date = date from Contracts table    
			If ([Contract_Maintenance:97]ExtendedCompleteDate:6=!00-00-00!)
				[ExtendTime_Maintenance:98]InitialDate:6:=[Contract_Maintenance:97]InitialCompleteDate:5
			Else 
				[ExtendTime_Maintenance:98]InitialDate:6:=[Contract_Maintenance:97]ExtendedCompleteDate:6
			End if 
			
		End if 
		C_TEXT:C284(vGenericHlpMsgVar1_S)
		vGenericHlpMsgVar1_S:="Print Memo to Contract Administrator"
		CM_DisplayFYFunds
		CM_FYFundRecalc
		C_BOOLEAN:C305(vCM_ExtTimFYFundChg_b)
		vCM_ExtTimFYFundChg_b:=False:C215
		C_BOOLEAN:C305(CM_ViewOnly_b)
		If (CM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(CM_ExtTImePrint; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (<>CM_LogChanges_b)
			FlushGrpChgs(2; ->[Contract_Maintenance:97]ContractNo:1; ->[ExtendTime_Maintenance:98]ContractNo:1; ->[ExtendTime_Maintenance:98]EOT_ID:2; 1)
		End if 
	: (Form event code:C388=On Unload:K2:2)
		ARRAY REAL:C219(arr_CM_FYFundAlloc_r; 0)
		ARRAY INTEGER:C220(arr_CM_FYAlloc_I; 0)
End case 