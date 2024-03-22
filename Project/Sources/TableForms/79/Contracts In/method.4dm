If (False:C215)
	//Form Method: [Contracts];"Contracts In"
	
	Mods_2004_CM12
	// Modified by: costasmanousakis-(Designer)-(1/17/2006 14:01:44)
	Mods_2006_CM03
	If (False:C215)
		// Modified by: costasmanousakis-(Designer)-(10/7/08 12:58:31)
		Mods_2008_CM_5404  // ("ACCESS")
	End if 
	// Modified by: costasmanousakis-(Designer)-(9/17/10 10:41:54)
	Mods_2010_09
	//  `Added option "Review Rating" to cboType
	// Modified by: Costas Manousakis-(Designer)-(4/1/13 13:37:04)
	Mods_2013_04
	//  `set all  included subforms to automatic width
	Mods_2013_07  //r001 `   `Add variable zz1 to so that for existing records cursor would not start in contract number field as one was blanked  out
	//Also set up so that if any sub records the field [Contracts]ContractNo is not enterable
	//Modified by: Charles Miller (7/8/13 16:34:27)
	// Modified by: Costas Manousakis-(Designer)-(2/10/16 14:37:55)
	Mods_2016_02_bug
	//  `Added splitters  and enabled resizing of lists, and text entry areas in the comments
	// Modified by: Costas Manousakis-(Designer)-(5/11/16 17:36:51)
	Mods_2016_05_bug
	//  `removed  Default Values from cboStatus and cboType - using Table of lists 
	// Modified by: Costas Manousakis-(Designer)-(2021-10-13T00:00:00 13:46:24)
	Mods_2021_10
	//  `changed picture of PRJ_GotoPrjInfo_FN to File projbtn.png
	// Modified by: Costas Manousakis-(Designer)-(2023-06-16 11:59:45)
	Mods_2023_06_bug
	//  `changed _o_object set color with Object set rgb colors
	//  `execute G_CalculateTLFandDE and G_ContractsCheckNegative only when record is not new when on Load event
End if 

C_LONGINT:C283($topLeftL; $topLeftT)
C_LONGINT:C283($lformWidth; $lformHeight)

$topLeftL:=16
$topLeftT:=44

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		InitChangeStack(1)
		C_BOOLEAN:C305(InspRtgContrAccess_b)
		OBJECT SET RGB COLORS:C628([Contracts:79]ContractNo:1; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Contracts]ContractNo;<>Color_Editable)
		OBJECT SET ENTERABLE:C238([Contracts:79]ContractNo:1; True:C214)
		If (Is new record:C668([Contracts:79]))
			
			Inc_Sequence("Contract"; ->[Contracts:79]ContractID:29)
		Else 
			GOTO OBJECT:C206(zz1)
			OBJECT SET ENTERABLE:C238([Contracts:79]ContractNo:1; False:C215)
			OBJECT SET RGB COLORS:C628([Contracts:79]ContractNo:1; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Contracts]ContractNo;<>Color_not_editable)
			Case of 
				: (Records in selection:C76([Contract Assignments:83])>0)
				: (Records in selection:C76([Contract FundTransfer:80])>0)
				: (Records in selection:C76([Contract AddFund:82])>0)
				: (Records in selection:C76([Contract ExtendTime:81])>0)
				: (Records in selection:C76([Contract Invoice:84])>0)
					
				Else 
					
					OBJECT SET ENTERABLE:C238([Contracts:79]ContractNo:1; True:C214)
					OBJECT SET RGB COLORS:C628([Contracts:79]ContractNo:1; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Contracts]ContractNo;<>Color_Editable)
			End case 
			
			G_CalculateTLFandDE
			G_ContractsCheckNegative
			//ORDER BY([Contract Invoice];[Contract Invoice]InvoiceNo;>)
			ORDER BY:C49([Contract Assignments:83]; [Contract Assignments:83]AssignNo:2; >)
			
		End if 
		
		If (InspRtgContrAccess_b)
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(bAdd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboStatus; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboType; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(btnShowAddress; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
		
	: (Form event code:C388=On Close Detail:K2:24)
		If (User in group:C338(Current user:C182; "ReadOnly"))
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(bAdd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboStatus; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboType; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(btnShowAddress; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		//RELATE MANY([Contracts])
		//ORDER BY([Contract Assignments];[Contract Assignments]AssignNo;>)
		Case of 
			: (FORM Get current page:C276=2)  //Funds Tab        
				ORDER BY:C49([Contract FundTransfer:80]; [Contract FundTransfer:80]DateApproval:5; >)
				ORDER BY:C49([Contract AddFund:82]; [Contract AddFund:82]DateApproval:5; >)
				
			: (FORM Get current page:C276=3)  //Extention of Time Tab        
				ORDER BY:C49([Contract ExtendTime:81]; [Contract ExtendTime:81]InitialDate:6; >)
				
			: (FORM Get current page:C276=5)  //Assignment Summary Tab        
				ORDER BY:C49([Contract Assignments:83]; [Contract Assignments:83]AssignNo:2; >)
				
			: (FORM Get current page:C276=6)  //Payment/Invoices Tab        
				ORDER BY:C49([Contract Invoice:84]; [Contract Invoice:84]InvoiceNo:2; >)
		End case 
		
	: (Form event code:C388=On Validate:K2:3)
		If (False:C215)
			FlushGrpChgs(1; ->[Contracts:79]ContractID:29; ->[Contracts:79]ContractID:29; ->[Contracts:79]ContractID:29; 1)
		End if 
End case 