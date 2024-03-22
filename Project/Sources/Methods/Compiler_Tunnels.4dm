//%attributes = {"invisible":true}
//Method: Compiler_Tunnels
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/12/13, 12:26:02
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(5/6/16 )
	Mods_2016_05
	Mods_2018_02  //Allow for change of tunnel number to allow for T or B as first character of second position
	//Modified by: Chuck Miller (2/20/18 17:14:30)
	//  `
	Mods_2018_05  //Create NTIED_Print report
	//Modified by: Chuck Miller (5/3/18 17:35:22)
	
End if 
//

C_LONGINT:C283(bTunnelSIA; bTunnelInsp)
C_LONGINT:C283(TunnelInspections_LB)
C_TEXT:C284(vChemicalAnchors; vConfinedSpace; vNeedConfinedSpace; vAirMeter; vNeedAirMeter; vEscapeAir; vNeedEscapeAir; vScissorLift; vNeedScissorLift)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vTnlInspProjMgr; Insp_DIE_txt)
ARRAY TEXT:C222(TnlInspPrjMgr_atxt; 0)
ARRAY INTEGER:C220(TnlInspPrjMgrID_aL; 0)
ARRAY TEXT:C222(Insp_DIE_atxt; 0)
ARRAY LONGINT:C221(Insp_DIE_aL; 0)
ARRAY TEXT:C222(Insp_DTIE_atxt; 0)
ARRAY LONGINT:C221(Insp_DTIE_aL; 0)
C_REAL:C285(tItem62a; tItem62b; tItem62c; tItem62d; tItem62e; tItem62f; tItem62g)
C_TEXT:C284(VITEM62A)
C_TEXT:C284(VITEM62APREV)
C_TEXT:C284(VITEM62B)
C_TEXT:C284(VITEM62BPREV)
C_TEXT:C284(VITEM62C)
C_TEXT:C284(VITEM62CPREV)
C_TEXT:C284(VITEM62D)
C_TEXT:C284(VITEM62DPREV)
C_TEXT:C284(VITEM62E)
C_TEXT:C284(VITEM62EPREV)
C_TEXT:C284(VITEM62F)
C_TEXT:C284(VITEM62FPREV)
C_TEXT:C284(VITEM62G)
C_TEXT:C284(VITEM62GPREV)
C_TEXT:C284(VNEEDAIRMETER)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(VNEEDCONFINEDSPACE)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(VNEEDESCAPEAIR)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(VNEEDSCISSORLIFT)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(VSCISSORLIFT)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(NTI_Prefix_txt)

If (False:C215)
	
	C_LONGINT:C283(TNL_SIAInpForm_FM; $1)
	
	C_LONGINT:C283(TNL_InspInpForm_FM; $1)
	
	C_LONGINT:C283(TNL_QAQCEngr_L; $0)
	C_TEXT:C284(TNL_QAQCEngr_L; $1)
	
	C_LONGINT:C283(INSP_TunnelRtnPg1_2_FM; $1)
	
	//TNL_SIA_INSP
	C_TEXT:C284(TNL_SIA_Insp; $1)
	
	//PRINT_TUNNEL_CMTS
	C_LONGINT:C283(Print_Tunnel_Cmts; $0)
	C_BOOLEAN:C305(Print_Tunnel_Cmts; $1)
	C_BOOLEAN:C305(Print_Tunnel_Cmts; $2)
	
	C_POINTER:C301(Tunnel_ReturnDescription; $1)
	C_TEXT:C284(Tunnel_ReturnDescription; $0)
	
End if 

//End Compiler_Tunnels