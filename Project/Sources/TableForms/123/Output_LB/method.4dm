If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/7/08 12:58:31)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
		
		//: (Form event=On Display Detail | (Form event=On Printing Detail)
		//ConsName_txt:=PRJ_DesignContractLBReturnName 
		
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(ConsName_txt)
		If (User in group:C338(Current user:C182; "ReadOnly"))
			OBJECT SET ENABLED:C1123(bAdd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(bDelete; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET VISIBLE:C603(bDelete; False:C215)
			OBJECT SET VISIBLE:C603(*; "bDelete@"; False:C215)
		End if 
		ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3; >)
		ut_PRJSetWindowTitle("Design Contracts"; ->[PRJ_DesignContracts:123])
		
		
		
	: (Form event code:C388=On Activate:K2:9) | (Form event code:C388=On Close Detail:K2:24)
		UpdatFilesPalet
End case 
