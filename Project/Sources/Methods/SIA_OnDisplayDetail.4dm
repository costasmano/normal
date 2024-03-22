//%attributes = {"invisible":true}
//Method: SIA_OnDisplayDetail
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 02/23/12, 13:36:29
	//----------------------------------------------------
	Mods_2012_02  //r003
	//Modified by: Charles Miller (2/23/12 13:36:30)
	Mods_2012_03  //r003 `Add code to use list box for Inventory button on 
	//Modified by: Charles Miller (3/29/12 14:14:09)
	// Modified by: Costas Manousakis-(Designer)-(4/11/13 16:38:53)
	Mods_2013_04
	//Tunnel Inspection pg 11
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(8/11/14 12:47:31)
	Mods_2014_08
	//  `for Tunnel inspections (page11) Added inspection type TOV to the INSP_IsInspRoutine_b check 
	// Modified by: Costas Manousakis-(Designer)-(1/6/15 14:29:11)
	Mods_2015_01
	//  `added Tunnel Damage for page=11
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 12:07:52)
	Mods_2015_02
	//  `added Tunnel Other for page=11
	// Modified by: Costas Manousakis-(Designer)-(10/17/16 12:14:31)
	Mods_2016_10
	//  `for inspections columns 2 and 4 need assigning; added case for "FRZ" reports to hide item41 and ratings
	// Modified by: Costas Manousakis-(Designer)-(8/31/17 16:14:11)
	Mods_2017_08
	//  `for routine (RTN/RTA) inspections blank item62 ; for CUL blank 58,59,60
	// Modified by: Costas Manousakis-(Designer)-(5/9/18 13:44:17)
	Mods_2018_05
	//  `new case for Ratings (4)
	// Modified by: Costas Manousakis-(Designer)-(1/29/19 12:40:03)
	Mods_2019_01_bug
	//  `In Ratings tab (4) account for single postings - CallReference #602
	// Modified by: Costas Manousakis-(Designer)-(11/5/19 16:58:33)
	Mods_2019_11
	//  `changes in the Rating reports tab for SU and EV vehicles - use Resources Xbox.png and blankbox.png 
End if 
Case of 
	: (FORM Get current page:C276=2)
		If ((Month of:C24([Cons Inspection:64]InspMonth:34)=0) | (Year of:C25([Cons Inspection:64]InspMonth:34)=0))
			LB_Detail1_txt:=""
		Else 
			LB_Detail1_txt:=String:C10(Month of:C24([Cons Inspection:64]InspMonth:34))+"/"+String:C10(Year of:C25([Cons Inspection:64]InspMonth:34))
		End if 
		
		If ([Cons Inspection:64]AssignStatus:24="Insp. Notification Received")
			LB_Detail7_txt:="Notifctn Recvd"
		Else 
			LB_Detail7_txt:=[Cons Inspection:64]AssignStatus:24
		End if 
		
	: (FORM Get current page:C276=4)  // Ratings
		LB_Detail3_txt:=""
		Case of 
			: ([RatingReports:65]PostingWaived:26)
				LB_Detail3_txt:="Waived"
			: ([RatingReports:65]BridgeClosed:25)
				LB_Detail3_txt:="Closed"
			: ([RatingReports:65]NoPosting:24) | (([RatingReports:65]RecPost3:15+[RatingReports:65]RecPost3S2:16+[RatingReports:65]RecPostingH:14+[RatingReports:65]RecSinglePosting_L:39)=0)
				LB_Detail3_txt:="Legal"
				
			: ([RatingReports:65]RemainPosted:34) & (([RatingReports:65]RecPost3:15+[RatingReports:65]RecPost3S2:16+[RatingReports:65]RecPostingH:14+[RatingReports:65]RecSinglePosting_L:39)>0)
				
				LB_Detail3_txt:="Remain Posted"
				
			: (([RatingReports:65]RecPost3:15+[RatingReports:65]RecPost3S2:16+[RatingReports:65]RecPostingH:14+[RatingReports:65]RecSinglePosting_L:39)>0)
				
				LB_Detail3_txt:="Posted"
				
		End case 
		If ([RatingReports:65]WithRestrictions_b:37)
			LB_Detail3_txt:=LB_Detail3_txt+" w/Restr."
		End if 
		If ([RatingReports:65]WithPedestrianAccess_b:38)
			LB_Detail3_txt:=LB_Detail3_txt+" w/Ped.Acc."
			
		End if 
		ut_FitPrintFormObject(->LB_Detail3_txt; 12; 9)
		C_TEXT:C284($rtgFormat_txt)
		$rtgFormat_txt:="###,##0.0;-"
		LB_Detail5_txt:="Inv.\rOper."
		LB_Detail6_txt:=String:C10([RatingReports:65]InvH20:6; $rtgFormat_txt)+"\r"+String:C10([RatingReports:65]OprH20:10; $rtgFormat_txt)
		LB_Detail7_txt:=String:C10([RatingReports:65]InvType3:7; $rtgFormat_txt)+"\r"+String:C10([RatingReports:65]OprType3:11; $rtgFormat_txt)
		LB_Detail8_txt:=String:C10([RatingReports:65]Inv3S2:8; $rtgFormat_txt)+"\r"+String:C10([RatingReports:65]Opr3S2:12; $rtgFormat_txt)
		LB_Detail9_txt:=String:C10([RatingReports:65]InvHS2044:9; $rtgFormat_txt)+"\r"+String:C10([RatingReports:65]OprHS2044:13; $rtgFormat_txt)
		
		READ ONLY:C145([RatingVehicleTypes:190])
		ARRAY TEXT:C222($VehCodes_atxt; 0)
		ARRAY LONGINT:C221($VehIds_aL; 0)
		ARRAY BOOLEAN:C223($inv_ab; 0)
		ARRAY BOOLEAN:C223($oper_ab; 0)
		
		ALL RECORDS:C47([RatingVehicleTypes:190])
		SELECTION TO ARRAY:C260([RatingVehicleTypes:190]VehicleName_s:2; $VehCodes_atxt; [RatingVehicleTypes:190]VehicleID:1; $VehIds_aL; \
			[RatingVehicleTypes:190]InvRating:5; $inv_ab; [RatingVehicleTypes:190]OperRating:6; $oper_ab)
		
		If (Size of array:C274($VehCodes_atxt)>0)
			
			C_LONGINT:C283($RatingID_L)
			ARRAY REAL:C219($InvRtg_ar; 0)
			ARRAY REAL:C219($OprRtg_ar; 0)
			ARRAY TEXT:C222($VehName_atxt; 0)
			$RatingID_L:=[RatingReports:65]RatingID:21
			Begin SQL
				select
				[RatingReportVehicles].[InvRating],
				[RatingReportVehicles].[OperRating],
				[RatingVehicleTypes].[VehicleName_s]
				from 
				[RatingReportVehicles], [RatingVehicleTypes]
				where 
				[RatingReportVehicles].[RatingID] = :$RatingID_L
				and 
				[RatingVehicleTypes].[VehicleID] = [RatingReportVehicles].[VehicleID]
				into
				:$InvRtg_ar,
				:$OprRtg_ar,
				:$VehName_atxt ;
			End SQL
			ARRAY POINTER:C280($LBVars_aptr; 0)
			ARRAY TEXT:C222($VehNames_atxt; 0)
			APPEND TO ARRAY:C911($LBVars_aptr; ->LB_Detail10_txt)
			APPEND TO ARRAY:C911($VehNames_atxt; "SU4")
			APPEND TO ARRAY:C911($LBVars_aptr; ->LB_Detail11_txt)
			APPEND TO ARRAY:C911($VehNames_atxt; "SU5")
			APPEND TO ARRAY:C911($LBVars_aptr; ->LB_Detail12_txt)
			APPEND TO ARRAY:C911($VehNames_atxt; "SU6")
			APPEND TO ARRAY:C911($LBVars_aptr; ->LB_Detail13_txt)
			APPEND TO ARRAY:C911($VehNames_atxt; "SU7")
			APPEND TO ARRAY:C911($LBVars_aptr; ->LB_Detail14_txt)
			APPEND TO ARRAY:C911($VehNames_atxt; "EV2")
			APPEND TO ARRAY:C911($LBVars_aptr; ->LB_Detail15_txt)
			APPEND TO ARRAY:C911($VehNames_atxt; "EV3")
			
			C_LONGINT:C283($indx_L; $Veh_L)
			
			For ($Veh_L; 1; Size of array:C274($LBVars_aptr))
				$indx_L:=Find in array:C230($VehName_atxt; $VehNames_atxt{$Veh_L})
				
				If ($indx_L>0)
					$LBVars_aptr{$Veh_L}->:=String:C10($InvRtg_ar{$indx_L}; $rtgFormat_txt)+"\r"+String:C10($OprRtg_ar{$indx_L}; $rtgFormat_txt)
				Else 
					$indx_L:=Find in array:C230($VehCodes_atxt; $VehNames_atxt{$Veh_L})
					$LBVars_aptr{$Veh_L}->:=String:C10(Choose:C955($inv_ab{$indx_L}; 0; -1); $rtgFormat_txt)+"\r"+String:C10(Choose:C955($oper_ab{$indx_L}; 0; -1); $rtgFormat_txt)
					
				End if 
				
			End for 
		Else 
			
		End if 
		
		If ([RatingReports:65]ScannedStored:40)
			READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"xbox.png"; LB_Detail4_pct)
		Else 
			READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"blankbox.png"; LB_Detail4_pct)
		End if 
		
	: (FORM Get current page:C276=7)  //Inspections
		LB_Detail1_txt:=[Inspection Type:31]Description:2
		QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
		C_BOOLEAN:C305($vbCombined)
		Case of 
			: (INSP_IsInspRoutine_b)
				
				If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
					$vbCombined:=[Inspections:27]InspRtnSpcMemFlag:209
				Else 
					$vbCombined:=(G_Insp_CountSpMs>0)
				End if 
			: (([Inspections:27]Insp Type:6="RRR") | ([Inspections:27]Insp Type:6="RRA") | ([Inspections:27]Insp Type:6="RRC"))
				
				$vbCombined:=(G_Insp_CountSpMs>0)
				LB_Detail1_txt:=Replace string:C233(LB_Detail1_txt; "RailRoad/Transit"; "R/T")
				
		End case 
		If ($vbCombined)
			LB_Detail1_txt:=LB_Detail1_txt+" & Spec.Mem."
		End if 
		
		Case of 
			: ([Inspections:27]InspReviewed:12=0)
				LB_Detail10_pct:=LB_Detail10_pct*0
			: ([Inspections:27]InspReviewed:12=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail10_pct)
			: ([Inspections:27]InspReviewed:12=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail10_pct)
				
		End case 
		
		Case of 
			: ([Inspections:27]InspApproved:167=0)
				LB_Detail11_pct:=LB_Detail11_pct*0
			: ([Inspections:27]InspApproved:167=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail11_pct)
			: ([Inspections:27]InspApproved:167=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail11_pct)
				
		End case 
		
		LB_Detail2_txt:=[Inspections:27]Item 41:77
		LB_Detail3_txt:=[Inspections:27]Item 58:79
		LB_Detail4_txt:=[Inspections:27]Item 59:80
		//vsInc_Insp_I59:=[Inspections]Item 59
		//
		If ([Inspections:27]Insp Type:6="DV@")
			LB_Detail5_txt:=[Inspections:27]Item 60 UW:66
			LB_Detail6_txt:=[Inspections:27]Item 61 UW:72
			LB_Detail7_txt:=[Inspections:27]Item 62 UW:165
		Else 
			LB_Detail5_txt:=[Inspections:27]Item 60:81
			LB_Detail6_txt:=[Inspections:27]Item 61:82
			LB_Detail7_txt:=[Inspections:27]Item 62:113
		End if 
		Case of 
			: ([Inspections:27]Insp Type:6="FCR")
				LB_Detail3_txt:=""
				LB_Detail6_txt:=""
				LB_Detail7_txt:=""
			: ([Inspections:27]Insp Type:6="CMI")
				LB_Detail6_txt:=""
			: ([Inspections:27]Insp Type:6="FRZ")
				LB_Detail2_txt:=""
				LB_Detail3_txt:=""
				LB_Detail4_txt:=""
				LB_Detail5_txt:=""
				LB_Detail6_txt:=""
				LB_Detail7_txt:=""
			: ([Inspections:27]Insp Type:6="RT@")
				LB_Detail7_txt:=""
			: ([Inspections:27]Insp Type:6="CUL")
				LB_Detail3_txt:=""
				LB_Detail4_txt:=""
				LB_Detail5_txt:=""
				
		End case 
		
		If ([Inspections:27]InspComplete:168)
			GET PICTURE FROM LIBRARY:C565("Mark_on"; LB_Detail9_pct)
		Else 
			GET PICTURE FROM LIBRARY:C565("Mark_Off"; LB_Detail9_pct)
		End if 
		
	: (FORM Get current page:C276=8)  //Inventory photos
		
		Case of 
			: ([InventoryPhotoInsp:112]Approved_I:6=0)
				LB_Detail3_pct:=LB_Detail3_pct*0
			: ([InventoryPhotoInsp:112]Approved_I:6=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail3_pct)
			: ([InventoryPhotoInsp:112]Approved_I:6=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail3_pct)
				
		End case 
		
		If ([InventoryPhotoInsp:112]Complete_B:9)
			GET PICTURE FROM LIBRARY:C565("Mark_on"; LB_Detail2_pct)
		Else 
			GET PICTURE FROM LIBRARY:C565("Mark_Off"; LB_Detail2_pct)
		End if 
		
	: (FORM Get current page:C276=11)  //Tunnel inspections
		LB_Detail1_txt:=[Inspection Type:31]Description:2
		QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
		QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
		C_BOOLEAN:C305($vbCombined)
		If (INSP_IsInspRoutine_b | ([Inspections:27]Insp Type:6="TOV"))
			
			If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
				$vbCombined:=[Inspections:27]InspRtnSpcMemFlag:209
			Else 
				$vbCombined:=(G_Insp_CountSpMs>0)
			End if 
		End if 
		If ($vbCombined)
			LB_Detail1_txt:=LB_Detail1_txt+" & Spec.Mem."
		End if 
		
		Case of 
			: ([Inspections:27]InspReviewed:12=0)
				LB_Detail12_pct:=LB_Detail12_pct*0
			: ([Inspections:27]InspReviewed:12=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail12_pct)
			: ([Inspections:27]InspReviewed:12=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail12_pct)
				
		End case 
		
		Case of 
			: ([Inspections:27]InspApproved:167=0)
				LB_Detail13_pct:=LB_Detail13_pct*0
			: ([Inspections:27]InspApproved:167=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; LB_Detail13_pct)
			: ([Inspections:27]InspApproved:167=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; LB_Detail13_pct)
				
		End case 
		
		//vsInc_Insp_I59:=[Inspections]Item 59
		//
		
		Case of 
			: ([Inspections:27]Insp Type:6="TAL")
				LB_Detail3_txt:=[TunnelInspection:152]Structural_Rtg_s:3
				LB_Detail4_txt:=[TunnelInspection:152]Roadway_Rtg_s:4
				LB_Detail5_txt:=[TunnelInspection:152]Ceiling_Rtg_s:5
				LB_Detail6_txt:=[TunnelInspection:152]SupplyAirDuct_Rtg_s:6
				LB_Detail7_txt:=[TunnelInspection:152]CrossPassage_Rtg_s:7
				LB_Detail8_txt:=[TunnelInspection:152]Egress_Rtg_s:8
				LB_Detail9_txt:=[TunnelInspection:152]UtilityRoom_Rtg_s:9
			: ([Inspections:27]Insp Type:6="TOV")
				LB_Detail3_txt:=""
				LB_Detail4_txt:=""
				LB_Detail5_txt:=[TunnelInspection:152]Ceiling_Rtg_s:5
				LB_Detail6_txt:=""
				LB_Detail7_txt:=""
				LB_Detail8_txt:=""
				LB_Detail9_txt:=""
			: ([Inspections:27]Insp Type:6="TSP")
				LB_Detail3_txt:=[TunnelInspection:152]Structural_Rtg_s:3
				LB_Detail4_txt:=[TunnelInspection:152]Roadway_Rtg_s:4
				LB_Detail5_txt:=[TunnelInspection:152]Ceiling_Rtg_s:5
				LB_Detail6_txt:=[TunnelInspection:152]SupplyAirDuct_Rtg_s:6
				LB_Detail7_txt:=[TunnelInspection:152]CrossPassage_Rtg_s:7
				LB_Detail8_txt:=[TunnelInspection:152]Egress_Rtg_s:8
				LB_Detail9_txt:=[TunnelInspection:152]UtilityRoom_Rtg_s:9
			: ([Inspections:27]Insp Type:6="TDA")
				LB_Detail3_txt:=[TunnelInspection:152]Structural_Rtg_s:3
				LB_Detail4_txt:=[TunnelInspection:152]Roadway_Rtg_s:4
				LB_Detail5_txt:=[TunnelInspection:152]Ceiling_Rtg_s:5
				LB_Detail6_txt:=[TunnelInspection:152]SupplyAirDuct_Rtg_s:6
				LB_Detail7_txt:=[TunnelInspection:152]CrossPassage_Rtg_s:7
				LB_Detail8_txt:=[TunnelInspection:152]Egress_Rtg_s:8
				LB_Detail9_txt:=[TunnelInspection:152]UtilityRoom_Rtg_s:9
			: ([Inspections:27]Insp Type:6="TOT")
				LB_Detail3_txt:=[TunnelInspection:152]Structural_Rtg_s:3
				LB_Detail4_txt:=[TunnelInspection:152]Roadway_Rtg_s:4
				LB_Detail5_txt:=[TunnelInspection:152]Ceiling_Rtg_s:5
				LB_Detail6_txt:=[TunnelInspection:152]SupplyAirDuct_Rtg_s:6
				LB_Detail7_txt:=[TunnelInspection:152]CrossPassage_Rtg_s:7
				LB_Detail8_txt:=[TunnelInspection:152]Egress_Rtg_s:8
				LB_Detail9_txt:=[TunnelInspection:152]UtilityRoom_Rtg_s:9
				
		End case 
		
		If ([Inspections:27]InspComplete:168)
			GET PICTURE FROM LIBRARY:C565("Mark_on"; LB_Detail11_pct)
		Else 
			GET PICTURE FROM LIBRARY:C565("Mark_Off"; LB_Detail11_pct)
		End if 
	Else 
		
End case 
//End SIA_OnDisplayDetail