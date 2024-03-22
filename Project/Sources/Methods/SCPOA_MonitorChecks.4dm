//%attributes = {"invisible":true}
// Method: SCPOA_MonitorChecks
// Description
// Handle the Flood monitor check marks in the summary
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/28/09, 19:34:39
	// ----------------------------------------------------
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_11  //Copied to Server on : 11/30/09, 15:00:43
	// Modified by: costasmanousakis-(Designer)-(12/6/09 15:04:51)
	Mods_2009_12
	// Modified by: costasmanousakis-(Designer)-(3/30/11 12:11:48)
	Mods_2011_05
	//SCPOA Mods 2
	// Modified by: Costas Manousakis-(Designer)-(10/6/14 18:05:23)
	Mods_2014_10_bug
	//  `General POA modifications Oct 2014
	// Modified by: Costas Manousakis-(Designer)-(4/10/15 15:22:48)
	Mods_2015_04_bug
	//  `changed dependecies of variables for SCPOA_Inst_Monit_L
	//  `removed dependency for SCPOA_Inst_WaterSurf_L
End if 
If (SCPOA_IncrInspPrg_L=1)
	SCPOA_SummRegIncrY_L:=1
	SCPOA_SummRegIncrN_L:=0
Else 
	SCPOA_SummRegIncrY_L:=0
	SCPOA_SummRegIncrN_L:=1
End if 

SCPOA_Summ_IncInspF_L:=SCPOA_SummRegIncrY_L

//If (SCPOA_UWIncrInspPrg_L=1)
//SCPOA_SummUWIncrY_L:=1
//SCPOA_SummUWIncrN_L:=0
//Else 
//SCPOA_SummUWIncrY_L:=0
//SCPOA_SummUWIncrN_L:=1
//End if 
//
//If (((SCPOA_UWIncrInspPrgFreq_L<SCPOA_UWInspPrgFreq_L) & (SCPOA_UWIncrInspPrgFreq_L>0)) | ((SCPOA_UWInspPrgFreq_L=0) & (SCPOA_UWIncrInspPrgFreq_L>0)))
//SCPOA_SummUWIncrY_L:=1
//SCPOA_SummUWIncrN_L:=0
//Else 
//SCPOA_SummUWIncrY_L:=0
//SCPOA_SummUWIncrN_L:=1
//End if 


If (SCPOA_UWInspPrgFreq_L>0)
	SCPOA_UWInspPrg_L:=1
Else 
	SCPOA_UWInspPrg_L:=0
End if 

If (SCPOA_UWIncrInspPrgFreq_L>0)
	SCPOA_UWIncrInspPrg_L:=1
Else 
	SCPOA_UWIncrInspPrg_L:=0
End if 

SCPOA_SummUWIncrY_L:=0
SCPOA_SummUWIncrN_L:=0

Case of 
	: ((SCPOA_UWIncrInspPrgFreq_L=0) & (SCPOA_UWInspPrgFreq_L=0))
		SCPOA_SummUWIncrN_L:=1
	: (SCPOA_UWIncrInspPrgFreq_L#SCPOA_UWInspPrgFreq_L)
		SCPOA_SummUWIncrY_L:=1
	: (SCPOA_UWIncrInspPrgFreq_L=SCPOA_UWInspPrgFreq_L)
		SCPOA_SummUWIncrN_L:=1
End case 

SCPOA_Summ_IncUWF_L:=SCPOA_SummUWIncrY_L

If ([ScourPOA:132]ChannelInspCurr:31>0)
	SCPOA_ChannelFreqCur_L:=1
Else 
	SCPOA_ChannelFreqCur_L:=0
End if 
If ([ScourPOA:132]ChannelInspRec:32>0)
	SCPOA_ChannelFreqRec_L:=1
Else 
	SCPOA_ChannelFreqRec_L:=0
End if 
//
//If (False)
//If (([ScourPOA]ChannelInspRec<[ScourPOA]ChannelInspCurr) & ([ScourPOA]ChannelInspRec>0)) | (([ScourPOA]ChannelInspRec>0) & ([ScourPOA]ChannelInspCurr=0))
//SCPOA_SummChannelIncrY_L:=1
//SCPOA_SummChannelIncrN_L:=0
//Else 
//SCPOA_SummChannelIncrY_L:=0
//SCPOA_SummChannelIncrN_L:=1
//End if 
//
//End if 

SCPOA_SummChannelIncrY_L:=0
SCPOA_SummChannelIncrN_L:=0

Case of 
	: (([ScourPOA:132]ChannelInspRec:32=0) & ([ScourPOA:132]ChannelInspCurr:31=0))
		SCPOA_SummChannelIncrN_L:=1
	: ([ScourPOA:132]ChannelInspRec:32#[ScourPOA:132]ChannelInspCurr:31)
		SCPOA_SummChannelIncrY_L:=1
	: ([ScourPOA:132]ChannelInspRec:32=[ScourPOA:132]ChannelInspCurr:31)
		SCPOA_SummChannelIncrN_L:=1
End case 

SCPOA_Summ_IncChan_L:=SCPOA_SummChannelIncrY_L

SCPOA_SummIMPLFixMonY_L:=0

If (SCPOA_FixMonitDev_L=1)
	SCPOA_SummIMPLFixMonY_L:=1
Else 
	SCPOA_SummFixMonN_L:=1
End if 

SCPOA_SummFixMonY_L:=0
SCPOA_SummFixMonN_L:=0
SCPOA_Inst_MonitDev_L:=0
If (SCPOA_RecFixMonitDev_L=1)
	SCPOA_SummFixMonY_L:=1
	SCPOA_Inst_MonitDev_L:=1
Else 
	SCPOA_SummFixMonN_L:=1
End if 

SCPOA_Summ_FixMonitDev_L:=SCPOA_SummFixMonY_L

If (SCPOA_OtherMonitDev_L=1)
	SCPOA_SummFldMonY_L:=1
	SCPOA_SummFldMonN_L:=0
Else 
	SCPOA_SummFldMonY_L:=0
	SCPOA_SummFldMonN_L:=1
End if 
SCPOA_Summ_FloodMon_L:=SCPOA_SummFldMonY_L


SCPOA_Inst_Monit_L:=0  //
If ((SCPOA_OtherMonitDev_L=1) | (SCPOA_RecFixMonitDev_L=1) | (SCPOA_FixMonitDev_L=1))
	SCPOA_Inst_Monit_L:=1
End if 

If (SCPOA_PostFlood_L=1)
	SCPOA_SummPFldMonY_L:=1
	SCPOA_SummPFldMonN_L:=0
Else 
	SCPOA_SummPFldMonY_L:=0
	SCPOA_SummPFldMonN_L:=1
End if 
SCPOA_Summ_PostFlood_L:=SCPOA_SummPFldMonY_L
If (SCPOA_ChannelFreqRec_L=1)
	SCPOA_SummRegIncrY_L:=1
	SCPOA_SummRegIncrN_L:=0
Else 
	SCPOA_SummRegIncrY_L:=0
	SCPOA_SummRegIncrN_L:=1
End if 
SCPOA_Summ_IncChan_L:=SCPOA_SummRegIncrY_L
