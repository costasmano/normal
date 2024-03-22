//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/09/10, 21:44:09
	// ----------------------------------------------------
	// Method: DCM_ContrProjControl
	// Description
	//  ` Initialize and load arrays used in the DCM project input screen
	// 
	// Parameters
	// $1 : "INIT" | "LOAD" | "RELATE"
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(12/13/10 09:25:27)
	Mods_2010_12
	//  `Bug Fixes
	// Modified by: costasmanousakis-(Designer)-(4/11/11 11:22:08)
	Mods_2011_04
	//  `Fix declaration of DCM_CO_BR_Brno_atxt 
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_TEXT:C284($1)
Case of 
	: ($1="INIT")
		C_LONGINT:C283($2)
		ARRAY LONGINT:C221(DCM_CO_BR_WO_al; $2)
		ARRAY TEXT:C222(DCM_CO_BR_BIN_atxt; $2)
		ARRAY TEXT:C222(DCM_CO_BR_Brno_atxt; $2)
		ARRAY TEXT:C222(DCM_CO_BR_Type_atxt; $2)
		ARRAY BOOLEAN:C223(DCM_CO_BR_SD_ab; $2)
		ARRAY TEXT:C222(DCM_CO_BR_SD_atxt; $2)
		ARRAY TEXT:C222(DCM_CO_BR_Town_atxt; $2)
		ARRAY TEXT:C222(DCM_CO_BR_Loc_atxt; $2)
		ARRAY REAL:C219(DCM_CO_BR_Ecost_ar; $2)
		ARRAY REAL:C219(DCM_CO_BR_CCost_ar; $2)
		ARRAY REAL:C219(DCM_CO_BR_FCost_ar; $2)
		C_POINTER:C301(DCM_AssgnNo_ptr; DCM_BRBIN_ptr; DCM_BRBNO_ptr; DCM_BRTyp_ptr; DCM_BRSD_ptr; DCM_BRTw_ptr; DCM_BRLoc_ptr; DCM_BREC_ptr; DCM_BRCC_ptr; DCM_BRFC_ptr)
		DCM_AssgnNo_ptr:=->[DCM_WorkOrders:137]AssignNo:2
		DCM_BRBIN_ptr:=->[DCM_Project:138]BIN:5
		DCM_BRBNO_ptr:=->[DCM_Project:138]BridgeNo:4
		DCM_BRTyp_ptr:=->[DCM_Project:138]Project Type:3
		DCM_BRSD_ptr:=->[DCM_Project:138]SDInfluence:15
		DCM_BRTw_ptr:=->[DCM_Project:138]Town:7
		DCM_BRLoc_ptr:=->[DCM_Project:138]Location:6
		DCM_BREC_ptr:=->[DCM_Project:138]EstCost:10
		DCM_BRCC_ptr:=->[DCM_Project:138]CurrCost:12
		DCM_BRFC_ptr:=->[DCM_Project:138]FinalCost:11
	: ($1="LOAD")
		SELECTION TO ARRAY:C260(DCM_BRBIN_ptr->; DCM_CO_BR_BIN_atxt; DCM_AssgnNo_ptr->; DCM_CO_BR_WO_al; DCM_BRBNO_ptr->; DCM_CO_BR_Brno_atxt; DCM_BRTyp_ptr->; DCM_CO_BR_Type_atxt; DCM_BRSD_ptr->; DCM_CO_BR_SD_ab; DCM_BRTw_ptr->; DCM_CO_BR_Town_atxt; DCM_BRLoc_ptr->; DCM_CO_BR_Loc_atxt; DCM_BREC_ptr->; DCM_CO_BR_Ecost_ar; DCM_BRCC_ptr->; DCM_CO_BR_CCost_ar; DCM_BRFC_ptr->; DCM_CO_BR_FCost_ar)
		C_LONGINT:C283($NumWOs_L)
		$NumWOs_L:=Records in selection:C76([DCM_Project:138])
		C_LONGINT:C283($i)
		For ($i; 1; $NumWOs_L)
			DCM_CO_BR_SD_atxt{$i}:=f_Boolean2String(DCM_CO_BR_SD_ab{$i}; "YN")
		End for 
		LISTBOX SELECT ROW:C912(DCM_CO_BR_LB; 0; lk remove from selection:K53:3)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(DCM_CO_BR_LB))
			DCM_CO_BR_LB{$loop_L}:=False:C215
		End for 
		
	: ($1="RELATE")
		DCM_SetupRelated(3)
		
End case 