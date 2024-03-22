//%attributes = {"invisible":true}
//Method: INSP_PrintInspType
//Description
// Print current inspection according to its type. [Inspections] record must be loaded and checked before
// calling this method.
// Extracted code from INSP_PrintInspBtn_OM
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/09/17, 14:48:10
	// ----------------------------------------------------
	//Created : 
	Mods_2017_03
End if 
//
C_BOOLEAN:C305(INSP_CreatePDFsofApproved_B)
INSP_CreatePDFsofApproved_B:=False:C215
G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
INSP_BuildTmMbrArea
Case of 
	: ([Inspections:27]Insp Type:6="DV@")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			Print_Dive_F
		End if 
	: (([Inspections:27]Insp Type:6="RT@"))
		If ([Inspections:27]InspRtnSpcMemFlag:209)
			CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" & Spec. Memb. Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		Else 
			CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated: "+String:C10([Inspections:27]Insp Date:78); "Print")
		End if 
		If (OK=1)
			PRINT_ROUTINE_F
		End if 
		
	: ([Inspections:27]Insp Type:6="CUL")
		If ([Inspections:27]InspRtnSpcMemFlag:209)
			CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" & Spec. Memb. Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		Else 
			CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		End if 
		If (OK=1)
			PRINT_CULVERT_F
		End if 
	: ([Inspections:27]Insp Type:6="CMI") | ([Inspections:27]Insp Type:6="FCR") | ([Inspections:27]Insp Type:6="OTH")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			PRINT_Critical
		End if 
	: ([Inspections:27]Insp Type:6="DAM")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			PRINT_Damage
		End if 
		
	: ([Inspections:27]Insp Type:6="FRZ")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			PRINT_FREEZE_F
		End if 
	: ([Inspections:27]Insp Type:6="CLD")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			PRINT_Closed
		End if 
		
	: ([Inspections:27]Insp Type:6="PON")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			PRINT_PONTIS_F
		End if 
	: ([Inspections:27]Insp Type:6="PED")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
			PRINT_ROUTINE_F
		End if 
	: ([Inspections:27]Insp Type:6="RRR")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
			PRINT_ROUTINE_F
		End if 
	: ([Inspections:27]Insp Type:6="PED")  //Pedestrian bridge
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
			PRINT_ROUTINE_F
		End if 
	: ([Inspections:27]Insp Type:6="RRA")  //Rail routine arch
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
			PRINT_ROUTINE_F
		End if 
	: ([Inspections:27]Insp Type:6="RRC")  //Rail routine culvert
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
			PRINT_CULVERT_F
		End if 
	: ([Inspections:27]Insp Type:6="RRS") | ([Inspections:27]Insp Type:6="RRF") | ([Inspections:27]Insp Type:6="RRO")  //Rail special, fract crit, other
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport([Inspections:27]BaseType_s:215)
			PRINT_Critical
		End if 
	: ([Inspections:27]Insp Type:6="RRD")  //Rail damage
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport([Inspections:27]BaseType_s:215)
			PRINT_Damage
		End if 
	: ([Inspections:27]Insp Type:6="TAL")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
			QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
			NTI_INIT
			PRINT_TunnelAllItems_F
		End if 
	: ([Inspections:27]Insp Type:6="TOV")
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
			QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
			NTI_INIT
			PRINT_TunnelAllItems_F
		End if 
	: (([Inspections:27]Insp Type:6="TSP") | ([Inspections:27]Insp Type:6="TDA") | ([Inspections:27]Insp Type:6="TOT"))
		CONFIRM:C162("Printing "+[Inspection Type:31]Description:2+" Inspection for BIN : "+[Inspections:27]BIN:1+" dated : "+String:C10([Inspections:27]Insp Date:78); "Print")
		If (OK=1)
			INSP_LoadElmLabelsforReport("TAL")
			QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
			NTI_INIT
			PRINT_Critical
		End if 
		
	Else 
		ALERT:C41("Don't know how to print "+[Inspection Type:31]Description:2+" ("+[Inspections:27]Insp Type:6+") Inspections!")
End case 

//End INSP_PrintInspType