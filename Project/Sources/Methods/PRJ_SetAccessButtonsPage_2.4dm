//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetAccessButtonsPage_2
// User name (OS): cjmiller
// Date and time: 05/16/07, 13:49:50
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 boolean access allowed
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //r060   `05/16/07, 13:49:53 `Add code to control access 
End if 
C_BOOLEAN:C305($1; $AccessAllowed_b)
$AccessAllowed_b:=$1
OBJECT SET ENABLED:C1123(PRJ_AllowBridgeEntry_l; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(PRJ_AllowBinEntry_l; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(PRJ_AllowProjectEntry_l; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(PRJ_ProjectTypes_atxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(PRJ_SelectedBins_as; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(PRJ_BD_BrgDataSht_hL; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(PRJ_StructPrjMgr_atxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(Button1; False:C215)  // Command Replaced was o_DISABLE BUTTON 

OBJECT SET ENTERABLE:C238(*; "PRJ_BridgeMylarSigned_b"; False:C215)
OBJECT SET ENTERABLE:C238(*; "PRJ_ReviewByBridgeEng_b"; False:C215)
OBJECT SET ENTERABLE:C238(*; "PRJ_FederalReviewRequired_b"; False:C215)
OBJECT SET ENTERABLE:C238(*; "PRJ_TemporaryBridge_b"; False:C215)

If ($AccessAllowed_b)
	OBJECT SET ENABLED:C1123(PRJ_AllowBridgeEntry_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_AllowBinEntry_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_AllowProjectEntry_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_ProjectTypes_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_SelectedBins_as; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_BD_BrgDataSht_hL; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_StructPrjMgr_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(Button1; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENTERABLE:C238(*; "PRJ_BridgeMylarSigned_b"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "PRJ_ReviewByBridgeEng_b"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "PRJ_FederalReviewRequired_b"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "PRJ_TemporaryBridge_b"; True:C214)
End if 



//End PRJ_SetAccessButtonsPage_2