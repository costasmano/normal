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
End if 
//

Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		C_LONGINT:C283($ArrayPos_L)
		$ArrayPos_L:=Find in array:C230(v_115_002_aL; Record number:C243([PRJ_ProjectDetails:115]))
		If ($ArrayPos_L>0)
			PRJ_RoadwayOver_txt:=PRJ_RWYOver_atxt{$ArrayPos_L}
			PRJ_RoadwayUnder_txt:=PRJ_RWYUnder_atxt{$ArrayPos_L}
			PRJ_ConsultantName_txt:=PRJ_ConsName_atxt{$ArrayPos_L}
			PRJ_UnderConstr_txt:=v_127_005_atxt{$ArrayPos_L}
			PRJ_InitInsp_D:=v_117_014_ad{$ArrayPos_L}
			v_139_059_txt:=v_139_059_atxt{$ArrayPos_L}
			If (v_117_014_ad{$ArrayPos_L}=!00-00-00!)
				PRJ_BPGM_AdDate_d:=v_117_005_ad{$ArrayPos_L}
			Else 
				If (v_117_014_ad{$ArrayPos_L}<v_117_005_ad{$ArrayPos_L})
					PRJ_BPGM_AdDate_d:=v_117_005_ad{$ArrayPos_L}
				Else 
					PRJ_BPGM_AdDate_d:=v_117_014_ad{$ArrayPos_L}
				End if 
			End if 
			
			If (v_116_004_ad{$ArrayPos_L}#!00-00-00!)
				PRJ_RatingDone_s:=f_Boolean2String(v_115_006_ab{$ArrayPos_L}; "YN")
			Else 
				PRJ_RatingDone_s:="N"
			End if 
		End if 
	: (Form event code:C388=On Header Click:K2:40)
		
		LB_BridgeProgramSort
		
		
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("Reset"; Current method name:C684)
End case 
//End [PRJ_ProjectDetails].BridgeProgram_LB.InspectorsOut_LB