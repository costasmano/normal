//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/30/11, 14:01:06
	// ----------------------------------------------------
	// Method: DCM_ReloadContr_OM
	// Description
	//  ` Object method for button on [DCM_Contracts];"DistrMaintInput".DEDCM_ReloadInfo
	// 
	// Parameters
	// $1 : $FormEvent  (Optional)
	// ----------------------------------------------------
	
	Mods_2011_08
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 
Case of 
	: ($FormEvent=On Load:K2:1)
		
	: ($FormEvent=On Data Change:K2:15)
		
	: ($FormEvent=On Clicked:K2:4)
		DCM_ContractNo_OM(On Data Change:K2:15)
		
		OBJECT SET ENTERABLE:C238(*; "DEDCMContractNo"; True:C214)
		GOTO OBJECT:C206(*; "DEDCMContractNo")
		
	Else 
		ut_GenericHelp_OM("Reload Contract Item info")
End case 
