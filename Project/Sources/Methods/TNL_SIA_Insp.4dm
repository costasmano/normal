//%attributes = {"invisible":true}
//Method: TNL_SIA_Insp
//Description
//
// Parameters
// $1 : $Dir_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/30/13, 08:50:22
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
End if 
//
C_TEXT:C284($1; $Dir_txt)
$Dir_txt:=$1
Case of 
	: ($Dir_txt="SIA2INSP")
		[TunnelInspection:152]Ceiling_Rtg_s:5:=[TunnelInfo:151]Ceiling_Rtg_s:8
		[TunnelInspection:152]Cleanliness_Rtg_s:11:=[TunnelInfo:151]Cleanliness_RTG_s:14
		[TunnelInspection:152]CrossPassage_Rtg_s:7:=[TunnelInfo:151]CrossPassage_Rtg_s:10
		[TunnelInspection:152]Egress_Rtg_s:8:=[TunnelInfo:151]Egress_Rtg_s:11
		[TunnelInspection:152]Roadway_Rtg_s:4:=[TunnelInfo:151]Roadway_Rtg_s:7
		[TunnelInspection:152]Structural_Rtg_s:3:=[TunnelInfo:151]Structural_Rtg_s:6
		[TunnelInspection:152]SupplyAirDuct_Rtg_s:6:=[TunnelInfo:151]SupplyAirDuct_Rtg_s:9
		[TunnelInspection:152]UtilityRoom_Rtg_s:9:=[TunnelInfo:151]UtilityRoom_Rtg_s:12
		[TunnelInspection:152]Wetness_Rtg_s:10:=[TunnelInfo:151]Wetness_RTG_s:13
		
		[TunnelInspection:152]AirMeter_s:12:=[TunnelInfo:151]AirMeter_s:15
		[TunnelInspection:152]EscapeAir_s:13:=[TunnelInfo:151]EscapeAir_s:16
		[TunnelInspection:152]ScissorLift_s:14:=[TunnelInfo:151]ScissorLift_s:17
		
		[TunnelInspection:152]Ceiling_Prev_Rtg_s:18:=[TunnelInfo:151]Ceiling_Rtg_s:8
		[TunnelInspection:152]Cleanliness_Prev_Rtg_s:24:=[TunnelInfo:151]Cleanliness_RTG_s:14
		[TunnelInspection:152]CrossPassage_Prev_Rtg_s:20:=[TunnelInfo:151]CrossPassage_Rtg_s:10
		[TunnelInspection:152]Egress_Prev_Rtg_s:21:=[TunnelInfo:151]Egress_Rtg_s:11
		[TunnelInspection:152]Roadway_Prev_Rtg_s:17:=[TunnelInfo:151]Roadway_Rtg_s:7
		[TunnelInspection:152]Structural_Prev_Rtg_s:16:=[TunnelInfo:151]Structural_Rtg_s:6
		[TunnelInspection:152]SupplyAirDuct_Prev_Rtg_s:19:=[TunnelInfo:151]SupplyAirDuct_Rtg_s:9
		[TunnelInspection:152]UtilityRoom_Prev_Rtg_s:22:=[TunnelInfo:151]UtilityRoom_Rtg_s:12
		[TunnelInspection:152]Wetness_Prev_Rtg_s:23:=[TunnelInfo:151]Wetness_RTG_s:13
		
	: ($Dir_txt="INSP2SIA")
		
		Case of 
			: ([Inspections:27]Insp Type:6="TAL")
				[TunnelInfo:151]Ceiling_Rtg_s:8:=[TunnelInspection:152]Ceiling_Rtg_s:5
				[TunnelInfo:151]Cleanliness_RTG_s:14:=[TunnelInspection:152]Cleanliness_Rtg_s:11
				[TunnelInfo:151]CrossPassage_Rtg_s:10:=[TunnelInspection:152]CrossPassage_Rtg_s:7
				[TunnelInfo:151]Egress_Rtg_s:11:=[TunnelInspection:152]Egress_Rtg_s:8
				[TunnelInfo:151]Roadway_Rtg_s:7:=[TunnelInspection:152]Roadway_Rtg_s:4
				[TunnelInfo:151]Structural_Rtg_s:6:=[TunnelInspection:152]Structural_Rtg_s:3
				[TunnelInfo:151]SupplyAirDuct_Rtg_s:9:=[TunnelInspection:152]SupplyAirDuct_Rtg_s:6
				[TunnelInfo:151]UtilityRoom_Rtg_s:12:=[TunnelInspection:152]UtilityRoom_Rtg_s:9
				[TunnelInfo:151]Wetness_RTG_s:13:=[TunnelInspection:152]Wetness_Rtg_s:10
				
				[TunnelInfo:151]AirMeter_s:15:=[TunnelInspection:152]AirMeter_s:12
				[TunnelInfo:151]EscapeAir_s:16:=[TunnelInspection:152]EscapeAir_s:13
				[TunnelInfo:151]ScissorLift_s:17:=[TunnelInspection:152]ScissorLift_s:14
				
			: ([Inspections:27]Insp Type:6="TOV")
				[TunnelInfo:151]Ceiling_Rtg_s:8:=[TunnelInspection:152]Ceiling_Rtg_s:5
				[TunnelInfo:151]Wetness_RTG_s:13:=[TunnelInspection:152]Wetness_Rtg_s:10
				
				[TunnelInfo:151]AirMeter_s:15:=[TunnelInspection:152]AirMeter_s:12
				[TunnelInfo:151]EscapeAir_s:16:=[TunnelInspection:152]EscapeAir_s:13
				[TunnelInfo:151]ScissorLift_s:17:=[TunnelInspection:152]ScissorLift_s:14
				
		End case 
		
		
End case 

//End TNL_SIA_Insp