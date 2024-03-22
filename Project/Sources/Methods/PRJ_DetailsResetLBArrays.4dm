//%attributes = {"invisible":true}
//Method: PRJ_DetailsResetLBArrays
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 03/09/21, 16:32:45
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
	
End if 
//
C_TEXT:C284($1; $ProcessName_txt)
$ProcessName_txt:=ut_ReturnProcessName(Current process:C322)

If (v_115_002_L>0)
	Case of 
		: ($1="Delete")
			Case of 
				: ($ProcessName_txt="Project Details")
					DELETE FROM ARRAY:C228(v_115_002_aL; v_115_002_L; 1)
					DELETE FROM ARRAY:C228(PRJ_StructProjMgr_atxt; v_115_002_L; 1)
					DELETE FROM ARRAY:C228(v_115_005_atxt; v_115_002_L; 1)
					DELETE FROM ARRAY:C228(PRJ_ConsName_atxt; v_115_002_L; 1)
				: ($ProcessName_txt="Bridge Program")
					DELETE FROM ARRAY:C228(v_115_002_aL; v_115_002_L; 1)  //Records numbers
					DELETE FROM ARRAY:C228(v_117_014_ad; v_115_002_L; 1)  //PF_Advertised_d
					DELETE FROM ARRAY:C228(v_117_005_ad; v_115_002_L; 1)  //PF_ScheduledAdvertising_d
					DELETE FROM ARRAY:C228(v_115_034_atxt; v_115_002_L; 1)  //PRJ_PrimaryBin_s
					DELETE FROM ARRAY:C228(v_115_005_atxt; v_115_002_L; 1)  //PRJ_BridgeNo_s
					DELETE FROM ARRAY:C228(PRJ_ConsName_atxt; v_115_002_L; 1)  //ConsultantName_s
					DELETE FROM ARRAY:C228(v_116_004_ad; v_115_002_L; 1)  //CP_Awarded_d
					DELETE FROM ARRAY:C228(v_127_005_atxt; v_115_002_L; 1)  //Under Constructions
					DELETE FROM ARRAY:C228(PRJ_RWYOver_atxt; v_115_002_L; 1)  //Roadway Over Item 7
					DELETE FROM ARRAY:C228(PRJ_RWYUnder_atxt; v_115_002_L; 1)  //Roadway under Item 6A
					DELETE FROM ARRAY:C228(v_139_059_atxt; v_115_002_L; 1)  //Item 2 district
					DELETE FROM ARRAY:C228(v_115_006_ab; v_115_002_L; 1)  //used for rating
					
					
			End case 
		Else 
			Case of 
				: ($ProcessName_txt="Project Details")
					PRJ_StructProjMgr_atxt{v_115_002_L}:=PRJ_StructPrjMgr_txt
					v_115_005_atxt{v_115_002_L}:=PRJ_DEBridgeNo_s
					PRJ_ConsName_atxt{v_115_002_L}:=PRJ_ConsultantName_txt
				: ($ProcessName_txt="Bridge Program")
					//v_117_014_ad{v_115_002_L}:=  //PF_Advertised_d
					//v_117_005_ad{v_115_002_L}:=  //PF_ScheduledAdvertising_d
					//v_115_034_atxt{v_115_002_L}:=[PRJ_ProjectDetails]PRJ_PrimaryBin_s  //PRJ_PrimaryBin_s
					v_115_005_atxt{v_115_002_L}:=[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5  //PRJ_BridgeNo_s
					PRJ_ConsName_atxt{v_115_002_L}:=PRJ_ConsultantName_txt  //ConsultantName_s
					//v_116_004_ad{v_115_002_L}:=  //CP_Awarded_d
					//v_127_005_atxt{v_115_002_L}:=  //Under Constructions
					//PRJ_RWYOver_atxt{v_115_002_L}:=  //Roadway Over Item 7
					//PRJ_RWYUnder_atxt{v_115_002_L}:=  //Roadway under Item 6A
					//v_139_059_atxt{v_115_002_L}:=  //Item 2 district
					//v_115_006_ab{v_115_002_L}:=  //used for rating
					
			End case 
			
			
	End case 
End if 
//End PRJ_DetailsResetLBArrays