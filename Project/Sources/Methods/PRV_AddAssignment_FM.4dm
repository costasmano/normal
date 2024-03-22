//%attributes = {"invisible":true}
// Method: PRV_AddAssignment_FM
// Description
// 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/11/13, 09:35:27
	// ----------------------------------------------------
	// First Release
	Mods_2013_02
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
	// Modified by: Costas Manousakis-(Designer)-(10/29/13 16:20:32)
	Mods_2013_10
	//  `changed dialog to use vars instead of fields
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
C_LONGINT:C283($ContinueButton_L)
$ContinueButton_L:=-15
Case of 
	: ($FormEvent_L=On Display Detail:K2:22)
		
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Data Change:K2:15)
		[Contract_Assignment_Maintenance:101]ContractNo:1:=PRV_ADD_Contract_txt
		[Contract_Assignment_Maintenance:101]ProjectIS:4:=PRV_ADD_ProjInfoNum_txt
		[Contract_Assignment_Maintenance:101]AssignNo:2:=PRV_ADD_AssignNo_L
		PRV_Variables("RELATEPINFO")
		
	: ($FormEvent_L=On Load:K2:1)
		//DISABLE BUTTON(*;"PRVContinue")
		REDUCE SELECTION:C351([PRJ_DesignContracts:123]; 0)
		REDUCE SELECTION:C351([PRJ_ProjectDetails:115]; 0)
		PRV_ADD_Contract_txt:=""
		PRV_ADD_ProjInfoNum_txt:=""
		PRV_ADD_AssignNo_L:=0
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		
	: ($FormEvent_L=$ContinueButton_L)
		C_TEXT:C284($WarningMsg_txt)
		$WarningMsg_txt:=""
		Case of 
			: ([Contract_Assignment_Maintenance:101]ProjectIS:4="")
				$WarningMsg_txt:="No Project Number Entered!"+Char:C90(13)
			: (Records in selection:C76([PRJ_ProjectFile:117])=0)
				$WarningMsg_txt:="Project Number Not Found in database!"+Char:C90(13)
		End case 
		Case of 
			: ([Contract_Assignment_Maintenance:101]ContractNo:1="")
				$WarningMsg_txt:=$WarningMsg_txt+"No Contract Number Entered!"+Char:C90(13)
			: (Records in selection:C76([PRJ_DesignContracts:123])=0)
				$WarningMsg_txt:=$WarningMsg_txt+"Contract Number Not Found in database!"+Char:C90(13)
		End case 
		
		If ($WarningMsg_txt="")
			ACCEPT:C269
		Else 
			CONFIRM:C162($WarningMsg_txt+"Continue with New Assignment?")
			If (OK=1)
				ACCEPT:C269
			End if 
		End if 
		
End case 