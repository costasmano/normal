If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// ----------------------------------------------------
	// Method: Form Method: Assignment Maintenance In
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 11:30:09)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(3/31/08 14:02:38)
	Mods_2008_CM_5403  //Copy the OveHead and NetFee rates from the contract
	// Modified by: costasmanousakis-(Designer)-(10/7/08 16:43:19)
	Mods_2008_CM_5404  // ("ACCESS")
	// Modified by: costasmanousakis-(Designer)-(11/14/08 14:02:04)
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Designer)-(2/19/09 10:39:53)
	Mods_2009_CM_5404
	//Included the new field [Contract_Assignment_Maintenance]ExtendedDesc_txt
	// and code to display the ABP flag status
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		//InitChangeStack (1)
		//set form sizes
		C_LONGINT:C283($Width; $Height; $TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		FORM GET PROPERTIES:C674([Contract_Assignment_Maintenance:101]; "Assignment Maintenance In"; $Width; $Height)
		GET WINDOW RECT:C443($TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		SET WINDOW RECT:C444($TopLeftX; $TopLeftY; $TopLeftX+$Width; $TopLeftY+$Height)
		utl_SetSpellandContextMenu
		
		If (Is new record:C668([Contract_Assignment_Maintenance:101]))
			Inc_Sequence("AssignMaint"; ->[Contract_Assignment_Maintenance:101]AssignID:3)
			[Contract_Assignment_Maintenance:101]ContractNo:1:=[Contract_Maintenance:97]ContractNo:1
			[Contract_Assignment_Maintenance:101]AssignNo:2:=(CM_AssgnNo_aI{Size of array:C274(CM_AssgnNo_aI)})+1
			[Contract_Assignment_Maintenance:101]Overhead:5:=[Contract_Maintenance:97]OverheadRate:10
			[Contract_Assignment_Maintenance:101]Fee:6:=[Contract_Maintenance:97]NetFeeRate:11
			rdoNeg:=1
			[Contract_Assignment_Maintenance:101]AcutalOrEstimate:20:="Negotiated"
		Else 
			
			Case of 
				: ([Contract_Assignment_Maintenance:101]AcutalOrEstimate:20="Negotiated")
					rdoNeg:=1
				: ([Contract_Assignment_Maintenance:101]AcutalOrEstimate:20="Actual")
					rdoActual:=1
			End case 
		End if 
		
		CM_CalculateNegotiatedCosts
		
		RELATE MANY:C262([Contract_Assignment_Maintenance:101])
		ORDER BY:C49([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]BIN:5)
		ORDER BY:C49([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AddendumNo:2)
		CM_RelateWorkHour(Is new record:C668([Contract_Assignment_Maintenance:101]))
		C_BOOLEAN:C305(CM_ViewOnly_b)
		If (CM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "rdo@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "projectType"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(vLockButton_L; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(Button1; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(CreateWorkHrs; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(ViewWorkHrs; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(AddProjectBtn; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		C_TEXT:C284(CM_ABPStatus_txt)
		Case of 
			: ([Contract_Assignment_Maintenance:101]ABPFlag_L:38=1)
				CM_ABPStatus_txt:="Accelerated Bridge"
			: ([Contract_Assignment_Maintenance:101]ABPFlag_L:38=2)
				CM_ABPStatus_txt:="Potential Accelerated Bridge"
			Else 
				CM_ABPStatus_txt:="Non ABP"
		End case 
		
	: (Form event code:C388=On Close Detail:K2:24)
		Case of 
			: (FORM Get current page:C276=1)
				QUERY:C277([Addendum_Maintenance:102]; [Addendum_Maintenance:102]ContractNo:5=[Contract_Maintenance:97]ContractNo:1; *)
				QUERY:C277([Addendum_Maintenance:102];  & ; [Addendum_Maintenance:102]AssignNo:4=[Contract_Assignment_Maintenance:101]AssignNo:2)
				ORDER BY:C49([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AddendumNo:2; >)
				CM_RelateWorkHour(Is new record:C668([Contract_Assignment_Maintenance:101]))
			: (FORM Get current page:C276=2)
				QUERY:C277([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]AssignID:13=[Contract_Assignment_Maintenance:101]AssignID:3)
				ORDER BY:C49([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]BridgeNo:4; >; [Contract_Project_Maintenance:100]BIN:5; >)
		End case 
		
End case 