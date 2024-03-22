// ----------------------------------------------------
// Form Method: Contract Maintenance In
// User name (OS): charlesmiller
// Date and time: 03/06/09, 12:43:27
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/12/2005 16:07:05)
	// Modified by: costasmanousakis-(Designer)-(1/18/2006 09:06:12)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/10/2006 16:37:39)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 14:23:18)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/11/2006 09:45:40)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(9/1/2006 15:49:25)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(10/8/08 15:23:08)
	Mods_2008_CM_5404  // ("ACCESS")
	// Modified by: costasmanousakis-(Designer)-(1/20/09 15:40:39)
	Mods_2009_CM_5404
	//Create an assgnment record when new contract record is created.
	// Modified by: costasmanousakis-(Designer)-(1/29/10 10:17:06)
	Mods_2010_01
	//  `Change the view only code to make sure only people in BridgeMaintCtrl have ReadWrite access
	// Modified by: costasmanousakis-(Designer)-(5/27/11 14:18:07)
	Mods_2011_05
	//  `adjusted logic of the ViewOnly variable.
End if 

C_BOOLEAN:C305(<>CM_LogChanges_b)

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(CM_NewContractRec_b; CM_ViewOnly_b)
		CM_NewContractRec_b:=False:C215
		C_TEXT:C284($Current_user_txt)
		$Current_user_txt:=Current user:C182
		CM_ViewOnly_b:=(Not:C34(User in group:C338($Current_user_txt; "BridgeMaintCtrl") | User in group:C338($Current_user_txt; "Design Access Group")))
		InitChangeStack(1)
		utl_SetSpellandContextMenu
		
		//set form sizes
		C_LONGINT:C283($Width; $Height; $TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		FORM GET PROPERTIES:C674([Contract_Maintenance:97]; "Contract Maintenance In"; $Width; $Height)
		GET WINDOW RECT:C443($TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		If (($BottomRightX-$TopLeftX)<$Width)
			$BottomRightX:=$TopLeftX+$Width
		End if 
		If (($BottomRightY-$TopLeftY)<$Height)
			$BottomRightY:=$TopLeftY+$Height
		End if 
		
		SET WINDOW RECT:C444($TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		
		If (Is new record:C668([Contract_Maintenance:97]))
			Inc_Sequence("ContractMaint"; ->[Contract_Maintenance:97]ContractID:2)
			//[Contract_Maintenance]RetainageAmtInit:=5000
			//[Contract_Maintenance]RetainagePct:=5
			[Contract_Maintenance:97]OverheadRate:10:=132  //%
			[Contract_Maintenance:97]NetFeeRate:11:=12  //%
			CREATE RECORD:C68([Contract_Assignment_Maintenance:101])
			[Contract_Assignment_Maintenance:101]ContractNo:1:=[Contract_Maintenance:97]ContractNo:1
			[Contract_Assignment_Maintenance:101]Description:35:="No Assignments for this contract"
			[Contract_Assignment_Maintenance:101]AssignNo:2:=1
			Inc_Sequence("AssignMaint"; ->[Contract_Assignment_Maintenance:101]AssignID:3)
			SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
			
			CM_NewContractRec_b:=True:C214
		End if 
		
		G_MaintenanceCheckNegative
		G_MaintenanceCalculateTLFandDE
		CM_BuildArrays
		CM_SetupRelated(-1)  //Set up all related records
		OBJECT SET ENTERABLE:C238(*; "DEContractNo@"; True:C214)
		If (CM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Add@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Close Detail:K2:24)
		CM_SetupRelated(FORM Get current page:C276)
		CM_BuildArrays(False:C215)  //don't reload
		
	: (Form event code:C388=On Validate:K2:3)
		If (<>CM_LogChanges_b)
			If (CM_NewContractRec_b)
				LogNewRecord(->[Contract_Maintenance:97]ContractID:2; ->[Contract_Maintenance:97]ContractID:2; ->[Contract_Maintenance:97]ContractID:2; 0; "ContractMaint")
			End if 
			FlushGrpChgs(1; ->[Contract_Maintenance:97]ContractID:2; ->[Contract_Maintenance:97]ContractID:2; ->[Contract_Maintenance:97]ContractID:2; 0)
		End if 
End case 


//End Form Method: Contract Maintenance In