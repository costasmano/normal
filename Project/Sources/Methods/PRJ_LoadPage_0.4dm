//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_LoadPage_0
// User name (OS): cjmiller
// Date and time: 04/11/06, 15:10:25
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //03/15/07, 15:59:18` remove * form bridge de variable
End if 
RELATE MANY:C262([PRJ_ProjectDetails:115])

If ([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
	PRJ_DEBridgeNo_s:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5
	OBJECT SET VISIBLE:C603(*; "PRJ_NONBridgeNotes@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "SummaryNonBridge"; False:C215)
	OBJECT SET VISIBLE:C603(*; "SummaryBridge"; True:C214)
	PRJ_LoadBridgeData
Else 
	PRJ_DEBridgeNo_s:=[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7
	OBJECT SET VISIBLE:C603(*; "PRJ_NONBridgeNotes@"; True:C214)
	OBJECT SET VISIBLE:C603(*; "SummaryNonBridge"; True:C214)
	OBJECT SET VISIBLE:C603(*; "SummaryBridge"; False:C215)
End if 
PRJ_SetUpStructuralPrjMgr(->[PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39)
PRJ_LoadDesignContractData
PRJ_LoadConstructionContract
If ([PRJ_ProjectDetails:115]PRJ_BeamUnit_l:28#0) & ([PRJ_ProjectDetails:115]PRJ_BeamCost_r:27#0)
	PRJ_BeamUnitCost_s:=String:C10(Round:C94(([PRJ_ProjectDetails:115]PRJ_BeamCost_r:27/[PRJ_ProjectDetails:115]PRJ_BeamUnit_l:28); 2))
Else 
	PRJ_BeamUnitCost_s:="Beam Unit 0"
End if 

OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; False:C215)
OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Not_editable)

//End PRJ_LoadPage_0
