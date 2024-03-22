//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetCorrectOrder
// User name (OS): cjmiller
// Date and time: 02/03/06, 14:16:39
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 

Case of 
	: (PRJ_OrderByType_l>0)
		If (PRJ_OrderByType_l=0) | (PRJ_OrderByType_l=2)
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_ProjectType_s:4; <)
		Else 
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_ProjectType_s:4; >)
		End if 
	: (PRJ_OrderByBridge_l>0)
		If (PRJ_OrderByBridge_l=0) | (PRJ_OrderByBridge_l=2)
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; <)
		Else 
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; >)
		End if 
	: (PRJ_OrderByNonBridge_l>0)
		If (PRJ_OrderByBridge_l=0) | (PRJ_OrderByBridge_l=2)
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; <)
		Else 
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; >)
		End if 
	: (PRJ_OrderByTemp_l>0)
		If (PRJ_OrderByNonBridge_l=0) | (PRJ_OrderByNonBridge_l=2)
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; <)
		Else 
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; >)
		End if 
	: (PRJ_OrderByCity_l>0)
		If (PRJ_OrderByCity_l=0) | (PRJ_OrderByCity_l=2)
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; <)
		Else 
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; >)
		End if 
	: (PRJ_OrderByFederalAid_l>0)
		If (PRJ_OrderByFederalAid_l=0) | (PRJ_OrderByFederalAid_l=2)
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_FederalAid_s:25; <)
		Else 
			
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_FederalAid_s:25; >)
		End if 
		
End case 
//End PRJ_SetCorrectOrder