If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// ----------------------------------------------------
	// Method: Form Method: Addendum In
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 11:28:10)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(3/31/08 13:52:13)
	Mods_2008_CM_5403  //Copy Ovrhead , netfee rates from Assignment not Contract
	// Modified by: costasmanousakis-(Designer)-(10/7/08 16:47:54)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		If (Is new record:C668([Addendum_Maintenance:102]))
			Inc_Sequence("AddendumMaint"; ->[Addendum_Maintenance:102]AddendumID:1)
			
			//push the current new record on the stack
			PUSH RECORD:C176([Addendum_Maintenance:102])
			
			//get all addendums for this assignment
			QUERY:C277([Addendum_Maintenance:102]; [Addendum_Maintenance:102]ContractNo:5=[Contract_Maintenance:97]ContractNo:1; *)
			QUERY:C277([Addendum_Maintenance:102];  & ; [Addendum_Maintenance:102]AssignNo:4=[Contract_Assignment_Maintenance:101]AssignNo:2)
			
			ARRAY INTEGER:C220($CM_AddendumNo_aI; 0)
			SELECTION TO ARRAY:C260([Addendum_Maintenance:102]AddendumNo:2; $CM_AddendumNo_aI)
			SORT ARRAY:C229($CM_AddendumNo_aI)
			
			//get back the current new record 
			POP RECORD:C177([Addendum_Maintenance:102])
			
			[Addendum_Maintenance:102]AddendumNo:2:=($CM_AddendumNo_aI{Size of array:C274($CM_AddendumNo_aI)})+1
			[Addendum_Maintenance:102]DateCreated:6:=Current date:C33(*)
			[Addendum_Maintenance:102]ContractNo:5:=[Contract_Maintenance:97]ContractNo:1
			[Addendum_Maintenance:102]Overhead:18:=[Contract_Assignment_Maintenance:101]Overhead:5
			[Addendum_Maintenance:102]Fee:17:=[Contract_Assignment_Maintenance:101]Fee:6
			[Addendum_Maintenance:102]AssignNo:4:=[Contract_Assignment_Maintenance:101]AssignNo:2
			[Addendum_Maintenance:102]AssignID:3:=[Contract_Assignment_Maintenance:101]AssignID:3
			
		End if 
		CM_RelateWorkHour(Is new record:C668([Addendum_Maintenance:102]); [Addendum_Maintenance:102]AddendumNo:2)
		C_BOOLEAN:C305(CM_ViewOnly_b)
		If (CM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(CreateWorkHrs; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(ViewWorkHrs; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(AddendAssgnLtr; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
End case 