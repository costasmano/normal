//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ResetForLockedRecord
// User name (OS): charlesmiller
// Date and time: 06/27/11, 15:02:33
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_06  // CJ Miller`06/28/11, 10:23:09      ` If [PRJ_ProjectDetails] locked set to non-enterable
End if 
If (Locked:C147([PRJ_ProjectDetails:115]))
	OBJECT SET VISIBLE:C603(PRJ_ProjectTypes_atxt; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_BridgeSection_atxt; False:C215)
	OBJECT SET VISIBLE:C603(Button1; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_BD_BrgDataSht_hL; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_StructPrjMgr_atxt; False:C215)
	OBJECT SET ENABLED:C1123(PRJ_SelectedBins_as; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET VISIBLE:C603(PRJ_Chapter85_l; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_AllowBridgeEntry_l; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_AllowBinEntry_l; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_AllowProjectEntry_l; False:C215)
	OBJECT SET ENABLED:C1123(PRJ_DCDropDown_atxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_RemovePF_l; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_SelectConsultant_l; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	
Else 
	OBJECT SET VISIBLE:C603(PRJ_ProjectTypes_atxt; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_BridgeSection_atxt; True:C214)
	OBJECT SET VISIBLE:C603(Button1; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_BD_BrgDataSht_hL; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_StructPrjMgr_atxt; True:C214)
	OBJECT SET ENABLED:C1123(PRJ_SelectedBins_as; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET VISIBLE:C603(PRJ_AllowBridgeEntry_l; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_AllowBinEntry_l; True:C214)
	OBJECT SET VISIBLE:C603(PRJ_AllowProjectEntry_l; True:C214)
	OBJECT SET ENABLED:C1123(PRJ_DCDropDown_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_RemovePF_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(PRJ_SelectConsultant_l; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End if 
//End PRJ_ResetForLockedRecord