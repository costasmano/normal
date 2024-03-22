//Method: [NTI_TunnelInfo];"NTIED_Print"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/24/18, 13:42:14
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
	// Modified by: Costas Manousakis-(Designer)-(12/7/18 14:26:01)
	Mods_2018_12_bug
	//  `change the title of TIN to BOAT when not TIN.
	//  `Fix Title of subsection 2.9
	// Modified by: Costas Manousakis-(Designer)-(2022-03-24 15:58:26)
	Mods_2022_03
	//  `fixed wrong object name for overhead item end inspection date
End if 
//
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_LONGINT:C283($start_L)
		$start_L:=Length:C16([NTI_TunnelInfo:181]NTI_i1_s:6)-2
		OBJECT SET TITLE:C194(*; "VentZone"; Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; $start_L; 3))
		OBJECT SET TITLE:C194(*; "TIN"; Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 5; 2))
		
		If (Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 4; 1)="T")
			OBJECT SET TITLE:C194(*; "TINBOAT"; "TIN")
		Else 
			OBJECT SET TITLE:C194(*; "TINBOAT"; "BOAT")
		End if 
		
		OBJECT SET TITLE:C194(*; "Printed_Date"; "Date :"+String:C10(Current date:C33; 7))
		C_TEXT:C284($NTI_i1_s)
		$NTI_i1_s:=[NTI_TunnelInfo:181]NTI_i1_s:6
		C_TEXT:C284($Description_txt)
		
		OBJECT SET TITLE:C194(*; "RouteDirection"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_i8_s:13))
		
		//NTI_i8_s_atxt:=Find in array(NTI_i8_s_atxt;[NTI_TunnelInfo]NTI_i8_s+"@")
		//If (NTI_i8_s_atxt>0)
		//OBJECT SET TITLE(*;"RouteDirection";NTI_i8_s_atxt{NTI_i8_s_atxt})
		//Else 
		//OBJECT SET TITLE(*;"RouteDirection";"None entered")
		//End if 
		OBJECT SET TITLE:C194(*; "RouteType"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_i9_L:14))
		
		//NTI_i9_s_atxt:=Find in array(NTI_i9_s_atxt;String([NTI_TunnelInfo]NTI_i9_L)+"@")
		//If (NTI_i9_s_atxt>0)
		//OBJECT SET TITLE(*;"RouteType";NTI_i9_s_atxt{NTI_i9_s_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"RouteType";"None entered")
		
		//End if 
		
		OBJECT SET TITLE:C194(*; "ServiceInTunnel"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_A8_L:31))
		
		
		//NTI_A8_L_atxt:=Find in array(NTI_A8_L_atxt;String([NTI_TunnelInfo]NTI_A8_L)+"@")
		
		//If (NTI_A8_L_atxt>0)
		//OBJECT SET TITLE(*;"ServiceInTunnel";NTI_A8_L_atxt{NTI_A8_L_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"ServiceInTunnel";"None entered")
		//End if 
		OBJECT SET TITLE:C194(*; "Owner"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_C1_s:32))
		
		//NTI_C1_s_atxt:=Find in array(NTI_C1_s_atxt;[NTI_TunnelInfo]NTI_C1_s+"@")
		//If (NTI_C1_s_atxt>0)
		//OBJECT SET TITLE(*;"Owner";NTI_C1_s_atxt{NTI_C1_s_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"Owner";"None entered")
		
		//End if 
		OBJECT SET TITLE:C194(*; "Operator"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_C2_s:33))
		
		//NTI_C2_s_atxt:=Find in array(NTI_C2_s_atxt;[NTI_TunnelInfo]NTI_C2_s+"@")
		
		//If (NTI_C2_s_atxt>0)
		//OBJECT SET TITLE(*;"Operator";NTI_C2_s_atxt{NTI_C2_s_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"Operator";"None entered")
		
		//End if 
		OBJECT SET TITLE:C194(*; "Direction"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_C3_s:34))
		
		//NTI_C3_s_atxt:=Find in array(NTI_C3_s_atxt;[NTI_TunnelInfo]NTI_C3_s+"@")
		//If (NTI_C3_s_atxt>0)
		//OBJECT SET TITLE(*;"Direction";NTI_C3_s_atxt{NTI_C3_s_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"Direction";"None entered")
		
		//End if 
		OBJECT SET TITLE:C194(*; "Toll"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_C4_s:35))
		
		//NTI_C4_s_atxt:=Find in array(NTI_C4_s_atxt;[NTI_TunnelInfo]NTI_C4_s+"@")
		//If (NTI_C4_s_atxt>0)
		//OBJECT SET TITLE(*;"Toll";NTI_C4_s_atxt{NTI_C4_s_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"Toll";"None entered")
		
		//End if 
		OBJECT SET TITLE:C194(*; "FunctionalClass"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_C7_L:38))
		
		//NTI_C7_L_atxt:=Find in array(NTI_C7_L_atxt;String([NTI_TunnelInfo]NTI_C7_L)+"@")
		//If (NTI_C7_L_atxt>0)
		//OBJECT SET TITLE(*;"FunctionalClass";NTI_C7_L_atxt{NTI_C7_L_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"FunctionalClass";"None entered")
		
		//End if 
		OBJECT SET TITLE:C194(*; "UrbanCode"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_C8_s:39))
		
		//NTI_C8_s_atxt:=Find in array(NTI_C8_s_atxt;[NTI_TunnelInfo]NTI_C8_s+"@")
		//If (NTI_C8_s_atxt>0)
		//OBJECT SET TITLE(*;"UrbanCode";NTI_C8_s_atxt{NTI_C8_s_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"UrbanCode";"None entered")
		
		//End if 
		OBJECT SET TITLE:C194(*; "LoadRatingMethod"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_L1_s:59))
		
		//NTI_L1_s_atxt:=Find in array(NTI_L1_s_atxt;[NTI_TunnelInfo]NTI_L1_s+"@")
		//If (NTI_L1_s_atxt>0)
		//OBJECT SET TITLE(*;"LoadRatingMethod";NTI_L1_s_atxt{NTI_L1_s_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"LoadRatingMethod";"None entered")
		
		//End if 
		OBJECT SET TITLE:C194(*; "TunnelLoadPostingStatus"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_L4_s:62))
		
		//NTI_L4_s_atxt:=Find in array(NTI_L4_s_atxt;[NTI_TunnelInfo]NTI_L4_s+"@")
		//If (NTI_L4_s_atxt>0)
		//OBJECT SET TITLE(*;"TunnelLoadPostingStatus";NTI_L4_s_atxt{NTI_L4_s_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"TunnelLoadPostingStatus";"None entered")
		
		//End if 
		
		OBJECT SET TITLE:C194(*; "TunnelShape"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_S2_L:49))
		
		//NTI_S2_L_atxt:=Find in array(NTI_S2_L_atxt;String([NTI_TunnelInfo]NTI_S2_L)+"@")
		//If (NTI_S2_L_atxt>0)
		//OBJECT SET TITLE(*;"TunnelShape";NTI_S2_L_atxt{NTI_S2_L_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"TunnelShape";"None entered")
		
		//End if 
		OBJECT SET TITLE:C194(*; "PortalShape"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_S3_L:50))
		
		//NTI_S3_L_atxt:=Find in array(NTI_S3_L_atxt;String([NTI_TunnelInfo]NTI_S3_L)+"@")
		//If (NTI_S3_L_atxt>0)
		//OBJECT SET TITLE(*;"PortalShape";NTI_S3_L_atxt{NTI_S3_L_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"PortalShape";"None entered")
		
		//End if 
		OBJECT SET TITLE:C194(*; "GroundCondition"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_S4_L:51))
		
		//NTI_S4_L_atxt:=Find in array(NTI_S4_L_atxt;String([NTI_TunnelInfo]NTI_S4_L)+"@")
		//If (NTI_S4_L_atxt>0)
		//OBJECT SET TITLE(*;"GroundCondition";NTI_S4_L_atxt{NTI_S4_L_atxt})
		
		//Else 
		//OBJECT SET TITLE(*;"GroundCondition";"None entered")
		
		//End if   
		
		OBJECT SET TITLE:C194(*; "Protfromnav"; Tunnel_ReturnDescription(->[NTI_TunnelInfo:181]NTI_N3_s:47))
		
		Case of 
			: ([NTI_TunnelInfo:181]NTI_L10_s:68="")
				OBJECT SET TITLE:C194(*; "Heightrestriction"; "")
			: ([NTI_TunnelInfo:181]NTI_L10_s:68="0")
				OBJECT SET TITLE:C194(*; "Heightrestriction"; "(NO Height restriction)")
			: ([NTI_TunnelInfo:181]NTI_L10_s:68="1")
				OBJECT SET TITLE:C194(*; "Heightrestriction"; "(YES Height restriction)")
		End case 
		
		
		Case of 
			: ([NTI_TunnelInfo:181]NTI_L11_s:69="")
				OBJECT SET TITLE:C194(*; "HazardMeterialrestriction"; "")
			: ([NTI_TunnelInfo:181]NTI_L11_s:69="0")
				OBJECT SET TITLE:C194(*; "HeightHazardMeterialrestrictionrestriction"; "(NO Hazardous Material Restriction)")
			: ([NTI_TunnelInfo:181]NTI_L11_s:69="1")
				OBJECT SET TITLE:C194(*; "HazardMeterialrestriction"; "(YES Hazardous Material Restriction)")
		End case 
		
		Case of 
			: ([NTI_TunnelInfo:181]NTI_L12_s:70="")
				OBJECT SET TITLE:C194(*; "OtherMeterialrestriction"; "")
			: ([NTI_TunnelInfo:181]NTI_L12_s:70="0")
				OBJECT SET TITLE:C194(*; "OtherMeterialrestriction"; "(NO Other Restrictions)")
			: ([NTI_TunnelInfo:181]NTI_L12_s:70="1")
				OBJECT SET TITLE:C194(*; "OtherMeterialrestriction"; "(YES Other Restrictions)")
		End case 
		
		Case of 
			: ([NTI_TunnelInfo:181]NTI_D4_s:56="")
				OBJECT SET TITLE:C194(*; "InDepthInsp"; "")
			: ([NTI_TunnelInfo:181]NTI_D4_s:56="0")
				OBJECT SET TITLE:C194(*; "InDepthInsp"; "(Has not been scheduled)")
			: ([NTI_TunnelInfo:181]NTI_D4_s:56="1")
				OBJECT SET TITLE:C194(*; "InDepthInsp"; "(Has been scheduled)")
		End case 
		
		Case of 
			: ([NTI_TunnelInfo:181]NTI_D5_s:57="")
				OBJECT SET TITLE:C194(*; "DamageInsp"; "")
			: ([NTI_TunnelInfo:181]NTI_D5_s:57="0")
				OBJECT SET TITLE:C194(*; "DamageInsp"; "(Has not been performed)")
			: ([NTI_TunnelInfo:181]NTI_D5_s:57="1")
				OBJECT SET TITLE:C194(*; "DamageInsp"; "(Has been performed)")
		End case 
		
		Case of 
			: ([NTI_TunnelInfo:181]NTI_D6_s:58="")
				OBJECT SET TITLE:C194(*; "SpecialInsp"; "")
			: ([NTI_TunnelInfo:181]NTI_D6_s:58="0")
				OBJECT SET TITLE:C194(*; "SpecialInsp"; "(Has not been scheduled)")
			: ([NTI_TunnelInfo:181]NTI_D6_s:58="1")
				OBJECT SET TITLE:C194(*; "SpecialInsp"; "(Has been scheduled)")
		End case 
		
		Case of 
				
			: ([NTI_TunnelInfo:181]NTI_S4_L:51=0)
				OBJECT SET TITLE:C194(*; "Complex"; "(The tunnel is not complex)")
			: ([NTI_TunnelInfo:181]NTI_S4_L:51=1)
				OBJECT SET TITLE:C194(*; "Complex"; "(The tunnel is complex)")
		End case 
		
		Case of 
			: ([NTI_TunnelInfo:181]NTI_N1_s:45="")
				OBJECT SET TITLE:C194(*; "UnderNavigable"; "")
			: ([NTI_TunnelInfo:181]NTI_N1_s:45="0")
				OBJECT SET TITLE:C194(*; "UnderNavigable"; "(A navigable waterway is not above the tunnel)")
			: ([NTI_TunnelInfo:181]NTI_N1_s:45="1")
				OBJECT SET TITLE:C194(*; "UnderNavigable"; "(A navigable waterway is  above the tunnel)")
		End case 
		
		
		
		//(0  1   ) 
		C_DATE:C307($ZRN_End_d; $ZRN_Insp_d; $ZSM_End_d; $ZSM_Insp_d; $ZOI_End_d; $ZOI_Insp_d; $ZDA_Damage_d; $ZDA_Insp_d)
		$ZRN_End_d:=!9999-12-31!
		$ZSM_End_d:=$ZRN_End_d
		$ZDA_Damage_d:=$ZRN_End_d
		$ZOI_End_d:=$ZRN_End_d
		Begin SQL
			select [TIN_Inspections].[InspCompleteDate],
			[TIN_Inspections].[InspDate]
			from
			[TIN_Inspections]
			where
			[TIN_Inspections].[NTI_i1_S] = :$NTI_i1_s
			and 
			[TIN_Inspections].[InspType] = 'ZRN'
			order by 1 DESC
			LIMIT 1
			
			into
			:$ZRN_End_d,
			:$ZRN_Insp_d;
			
			select [TIN_Inspections].[InspCompleteDate] , 
			[TIN_Inspections].[InspDate]
			from
			[TIN_Inspections]
			where
			[TIN_Inspections].[NTI_i1_S] = :$NTI_i1_s
			and 
			[TIN_Inspections].[InspType] = 'ZSM'
			order by 1 DESC
			LIMIT 1
			into
			:$ZSM_End_d,
			:$ZSM_Insp_d;
			
			select [TIN_Inspections].[InspCompleteDate] , 
			[TIN_Inspections].[InspDate] 
			from
			[TIN_Inspections]
			where
			[TIN_Inspections].[NTI_i1_S] = :$NTI_i1_s
			and 
			[TIN_Inspections].[InspType] = 'ZOI'
			order by 1 DESC
			LIMIT 1
			into
			:$ZOI_End_d,
			:$ZOI_Insp_d;
			
			
			select [TIN_Inspections].[DamageDate_d] , 
			[TIN_Inspections].[InspDate] 
			from
			[TIN_Inspections]
			where
			[TIN_Inspections].[NTI_i1_S] = :$NTI_i1_s
			and 
			[TIN_Inspections].[InspType] = 'ZDA'
			order by 1 DESC
			limit 1
			into
			:$ZDA_Damage_d,
			:$ZDA_Insp_d;
			
		End SQL
		
		//C_DATE($ZRN_End_d;$ZRN_Insp_d;$ZSM_End_d;$ZSM_Insp_d;$ZOI_End_d;$ZOI_Insp_d;$ZDA_End_d;$ZDA_Insp_d)
		
		//$ZRN_End_d:=!9999-12-31!
		//$ZSM_End_d:=$ZRN_End_d
		//$ZDA_End_d:=$ZRN_End_d
		//$ZOI_End_d:=$ZDA_End_d
		QUERY:C277([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]NTI_i1_s:2=[NTI_TunnelInfo:181]NTI_i1_s:6)
		ORDER BY:C49([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]RatingReport_d:3; <)
		If ($ZRN_End_d=!9999-12-31!)
			OBJECT SET TITLE:C194(*; "RoutineEnd"; "N/A")
			OBJECT SET TITLE:C194(*; "RoutineInspDate"; "N/A")
		Else 
			OBJECT SET TITLE:C194(*; "RoutineEnd"; String:C10($ZRN_End_d; 7))
			If ($ZRN_Insp_d#[NTI_TunnelInfo:181]NTI_D2_d:54)
				OBJECT SET TITLE:C194(*; "RoutineInspDate"; String:C10($ZRN_Insp_d; 7)+" *")
			Else 
				OBJECT SET TITLE:C194(*; "RoutineInspDate"; String:C10($ZRN_Insp_d; 7))
			End if 
		End if 
		
		
		If ($ZOI_End_d=!9999-12-31!)
			OBJECT SET TITLE:C194(*; "OverHead"; "N/A")
			OBJECT SET TITLE:C194(*; "OverHeadInspDate"; "N/A")
		Else 
			OBJECT SET TITLE:C194(*; "OverHead"; String:C10($ZOI_End_d; 7))  //mods_2022_03
			If ($ZOI_Insp_d#[NTI_TunnelInfo:181]NTI_Overhead_Actual_d:76)
				OBJECT SET TITLE:C194(*; "OverHeadInspDate"; String:C10($ZOI_Insp_d; 7)+" *")
			Else 
				OBJECT SET TITLE:C194(*; "OverHeadInspDate"; String:C10($ZOI_Insp_d; 7))
			End if 
		End if 
		
		
		
		If ($ZDA_Damage_d=!9999-12-31!)
			OBJECT SET TITLE:C194(*; "DamageDate"; "N/A")
			OBJECT SET TITLE:C194(*; "DamageInspDate"; "N/A")
		Else 
			If ($ZDA_Damage_d#[NTI_TunnelInfo:181]NTI_Damage_d:82)
				OBJECT SET TITLE:C194(*; "DamageDate"; String:C10($ZDA_Damage_d; 7)+" *")
			Else 
				OBJECT SET TITLE:C194(*; "DamageDate"; String:C10($ZDA_Damage_d; 7))
			End if 
			If ($ZDA_Insp_d#[NTI_TunnelInfo:181]NTI_Damage_Actual_d:83)
				OBJECT SET TITLE:C194(*; "DamageInspDate"; String:C10($ZDA_Insp_d; 7)+" *")
			Else 
				OBJECT SET TITLE:C194(*; "DamageInspDate"; String:C10($ZDA_Insp_d; 7))
			End if 
		End if 
		
		If ($ZSM_End_d=!9999-12-31!)
			OBJECT SET TITLE:C194(*; "SpecialMemberInspDate"; "N/A")
			OBJECT SET TITLE:C194(*; "SpecialMemberEnd"; "N/A")
		Else 
			OBJECT SET TITLE:C194(*; "SpecialMemberEnd"; String:C10($ZSM_End_d; 7))
			If ($ZSM_Insp_d#[NTI_TunnelInfo:181]NTI_SpecMemb_Actual_d:79)
				OBJECT SET TITLE:C194(*; "SpecialMemberInspDate"; String:C10($ZSM_Insp_d; 7)+" *")
			Else 
				OBJECT SET TITLE:C194(*; "SpecialMemberInspDate"; String:C10($ZSM_Insp_d; 7))
			End if 
			
		End if 
		
		
End case 
//End [NTI_TunnelInfo].NTIED_Print