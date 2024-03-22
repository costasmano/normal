If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/7/08 12:58:03)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		InitChangeStack(1)
		If (Is new record:C668([Contract Assignments:83]))
			[Contract Assignments:83]ContractNo:1:=[Contracts:79]ContractNo:1
			Inc_Sequence("ConAssignments"; ->[Contract Assignments:83]AssignID:3)
			rdoNeg:=1
			[Contract Assignments:83]AcutalOrEstimate:20:="Negotiated"
			[Contract Assignments:83]OverHeadRate:23:=[Contracts:79]OverheadRate:10
			[Contract Assignments:83]NetFeeRate:22:=[Contracts:79]NetFeeRate:11
		Else 
			Case of 
				: ([Contract Assignments:83]AcutalOrEstimate:20="Negotiated")
					rdoNeg:=1
				: ([Contract Assignments:83]AcutalOrEstimate:20="Actual")
					rdoActual:=1
			End case 
		End if 
		C_BOOLEAN:C305(InspRtgContrAccess_b)
		If (InspRtgContrAccess_b)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "rdo@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(btnRetrieveCost; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (False:C215)
			FlushGrpChgs(1; ->[Contracts:79]ContractNo:1; ->[Contract Assignments:83]ContractNo:1; ->[Contract Assignments:83]AssignID:3; 1)
		End if 
End case 