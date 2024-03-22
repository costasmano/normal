//Method: [PRJ_ProjectDetails].BridgeProgram_LB.InspectorsOut_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck
	//User (4D) : Designer
	//Date and time: 06/23/20, 15:50:04
	// ----------------------------------------------------
	//Created : 
	Mods_2020_10  //Replace [PRJ_ProjectDetails];"BridgeProgram" with Listbox [PRJ_ProjectDetails];"BridgeProgram_LB"
	//Modified by: CJ (10/8/20 14:28:27) 
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 17:58:44)
	Mods_2021_10
	//  `added param $0 - returned by the sort method -
	//  `enabled sortable in the object properties -
	//  `corrected field for Ad Date to [PRJ_ProjectFile]PF_ScheduledAdvertising_d
	
End if 
//
C_LONGINT:C283($0)
$0:=0
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		C_LONGINT:C283($ArrayPos_L)
		$ArrayPos_L:=Find in array:C230(v_115_002_aL; Record number:C243([PRJ_ProjectDetails:115]))
		If ($ArrayPos_L>0)
			PRJ_StructPrjMgr_txt:=PRJ_StructProjMgr_atxt{$ArrayPos_L}
			PRJ_ConsultantName_txt:=PRJ_ConsName_atxt{$ArrayPos_L}
			PRJ_DEBridgeNo_s:=v_115_005_atxt{$ArrayPos_L}
		Else 
			PRJ_StructPrjMgr_txt:=""
			PRJ_ConsultantName_txt:=""
			PRJ_DEBridgeNo_s:=""
		End if 
		
	: (Form event code:C388=On Header Click:K2:40)
		
		$0:=LB_ProjectDetailSort
		
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("Reset"; Current method name:C684)
End case 
//End [PRJ_ProjectDetails].BridgeProgram_LB.InspectorsOut_LB