//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/20/15, 16:50:06
//----------------------------------------------------
//Method: m_DisplayTINs
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/20/15 16:50:08)
	// Modified by: Costas Manousakis-(Designer)-(6/3/16 13:16:38)
	Mods_2016_06
	//  `added call to InitProcessVar
	Mods_2018_06
	//Add new Column (TIN) and allow for sort on [NTI_TunnelInfo];"ListBoxOutput"
	//Modified by: Chuck Miller (6/11/18 12:44:57)
End if 

If (Count parameters:C259=0)
	C_LONGINT:C283($LPid_L)
	$LPid_L:=LSpawnProcess(Current method name:C684; <>LStackSize; "Tunnel Inventory"; True:C214; False:C215; "RUN")
Else 
	C_TEXT:C284($1)
	C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
	vsForward:=<>Forward
	READ ONLY:C145(*)
	READ WRITE:C146([NTI_TunnelInfo:181])
	
	SHORT_MESSAGE("Retrieving data. Please wait…")
	Compiler_LB
	Compiler_NTI
	InitPers
	InitProcessVar
	NTI_FillDropDowns
	NTI_SetUpPermissions
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
	
	NTI_CurrentPage_L:=1
	APPEND TO ARRAY:C911(NTI_Tabs; "(I)Identification")
	APPEND TO ARRAY:C911(NTI_Tabs; "(A)Age & Service")
	APPEND TO ARRAY:C911(NTI_Tabs; "(C)Classification")
	APPEND TO ARRAY:C911(NTI_Tabs; "(G)Geometric Data")
	APPEND TO ARRAY:C911(NTI_Tabs; "(D)Inspection")
	APPEND TO ARRAY:C911(NTI_Tabs; "(L)Load Rating & Posting")
	APPEND TO ARRAY:C911(NTI_Tabs; "(N)Navigation Items")
	APPEND TO ARRAY:C911(NTI_Tabs; "(S)Structure Type & Material")
	
	
	ALL RECORDS:C47([NTI_TunnelInfo:181])
	C_LONGINT:C283($Width_L; $Height_L)
	SET MENU BAR:C67("Blankmenu")
	UpdatWindArray(""; Current process:C322)
	
	ORDER BY:C49([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i1_s:6)
	CLOSE WINDOW:C154
	
	FORM GET PROPERTIES:C674([NTI_TunnelInfo:181]; "ListBoxOutput"; $Width_L; $Height_L)
	ut_OpenNewWindow($Width_L; 700; 2; Plain window:K34:13)
	
	LB_Header2_l:=1
	ORDER BY FORMULA:C300([NTI_TunnelInfo:181]; NTI_SortByFormula(1); >)
	COPY NAMED SELECTION:C331([NTI_TunnelInfo:181]; "NTI_TunnelInfoSet")
	DIALOG:C40([NTI_TunnelInfo:181]; "ListBoxOutput")
	CLEAR NAMED SELECTION:C333("NTI_TunnelInfoSet")
	
	UpdatWindArray(""; Current process:C322)
End if 
//End m_DisplayTINs