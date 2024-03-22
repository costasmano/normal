//%attributes = {"invisible":true}
//Method: Compiler_RatingRequests
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 12:06:50
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_POINTER:C301(LB_Table_ptr)
C_TEXT:C284(LB_ListboxName_txt; LB_HiliteSetName_txt; LB_SelectionName_txt; LB_WindowTitle_txt)
ARRAY TEXT:C222(LB_ListBoxNames_atxt; 0)
ARRAY TEXT:C222(LB_WindowTitles_atxt; 0)
ARRAY TEXT:C222(LB_InputForms_atxt; 0)
ARRAY LONGINT:C221(LB_ListBoxKeyFldNum_aL; 0)
ARRAY TEXT:C222(RtgReq_AEAction_cb; 0)
ARRAY TEXT:C222(RtgReq_Prio_cb; 0)
ARRAY TEXT:C222(RtgReq_BIEAction_cb; 0)
ARRAY TEXT:C222(RtgReq_StEAction_cb; 0)
ARRAY TEXT:C222(RtgReq_Status_cb; 0)
ARRAY LONGINT:C221(RtgReq_Contracts_cb; 0)
ARRAY INTEGER:C220(RtgReq_ContrAssign_cb; 0)
C_LONGINT:C283(RtgReq_LB; AddtlReq_LB; RtgReqIncl_LB)
C_LONGINT:C283(vRecPostingH; vRecPost3; vRecPost3S2; vREcPostSingle)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(RtgRequestBtn)
If (False:C215)
	C_LONGINT:C283(LB_Tasks; $0)
	C_TEXT:C284(LB_Tasks; $1)
	C_TEXT:C284(LB_Tasks; $2)
	C_TEXT:C284(LB_Tasks; $3)
	C_TEXT:C284(LB_Tasks; $4)
	C_POINTER:C301(LB_Tasks; $5)
	C_LONGINT:C283(RtgReq_LB_OM; $0)
	C_LONGINT:C283(RtgReq_LB_OM; $1)
	C_LONGINT:C283(RtgReq_Output_FM; $1)
	C_LONGINT:C283(RtgReq_Input_FM; $1)
	C_LONGINT:C283(RtgReq_AdtlLB_OM; $1)
	C_LONGINT:C283(RtgReq_AdtlInp_FM; $1)
	C_TEXT:C284(RtgReq_DisplayList; $1)
	C_BOOLEAN:C305(RtgReq_Edit_b; $0)
	C_POINTER:C301(RtgReq_ComboMenu_OM; $1)
	C_POINTER:C301(RtgReq_ComboMenu_OM; $2)
	C_POINTER:C301(RtgReq_ComboMenu_OM; $3)
	C_TEXT:C284(RtgReq_Utility; $1)
	C_TEXT:C284(RtgReq_GetBridgeInfo; $0)  // was length of 80
	C_TEXT:C284(RtgReq_GetBridgeInfo; $1)  // was length of 3
	C_POINTER:C301(RtgReq_GetBridgeInfo; $2)
	C_LONGINT:C283(RtgReq_SortByPriority; $0)
	C_TEXT:C284(RatRep_SetUpPosting; $1)
End if 
//End Compiler_RatingRequests
