//Method: [Cons Inspection];"View Cslt_Insp_LB"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/09/20, 13:05:54
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 14:47:59)
	Mods_2021_10
	//  `made LB focusable / hide focus rect - enable on resize event on form -on resize redraw the LB 
	// Modified by: Costas Manousakis-(Designer)-(2021-10-14T00:00:00 11:51:40)
	Mods_2021_10
	//  `assign var LB_Detail1_txt for all users
End if 

C_TEXT:C284(vInspType; $sInspType)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(vInspMonth; vFullAssignNo)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284(vAssignStatus; vInspProgress_s)  // Command Replaced was o_C_STRING length was 20

Case of 
	: (Form event code:C388=On Load:K2:1)
		UNLOAD RECORD:C212(Current form table:C627->)
		
	: (Form event code:C388=On Display Detail:K2:22)
		$sInspType:=[Cons Inspection:64]InspType:33
		If (Length:C16($sInspType)>30)
			$sInspType:=Replace string:C233($sInspType; "Fracture Critical"; "FC")
			$sInspType:=Replace string:C233($sInspType; "Special Member"; "SM")
			$sInspType:=Replace string:C233($sInspType; "Mechanical"; "Mech")
			$sInspType:=Replace string:C233($sInspType; "Electrical"; "Elec")
		End if 
		vInspType:=$sInspType
		vInspProgress_s:=""
		
		If ((Month of:C24([Cons Inspection:64]InspMonth:34)=0) | (Year of:C25([Cons Inspection:64]InspMonth:34)=0))
			vInspMonth:=""
		Else 
			C_TEXT:C284($InspMo_S; $InspYear_S)  // Command Replaced was o_C_STRING length was 4
			$InspMo_S:=String:C10(Month of:C24([Cons Inspection:64]InspMonth:34))
			$InspYear_S:=String:C10(Year of:C25([Cons Inspection:64]InspMonth:34))
			vInspMonth:=$InspMo_S+"/"+$InspYear_S
			vInspProgress_s:=QR_ConsInspElecSubm
		End if 
		
		
		If ([Cons Inspection:64]AssignStatus:24="Insp. Notification Received")
			vAssignStatus:="Notifctn Recvd"
		Else 
			vAssignStatus:=[Cons Inspection:64]AssignStatus:24
		End if 
		vFullAssignNo:=String:C10([Cons Inspection:64]AssignConNumber:6)
		If (Replace string:C233([Cons Inspection:64]AssignPhase:38; " "; "")#"")
			vFullAssignNo:=vFullAssignNo+"-"+Replace string:C233([Cons Inspection:64]AssignPhase:38; " "; "")
		End if 
		
		LB_Detail1_txt:=[Cons Inspection:64]ConContractNo:7+" "+vFullAssignNo
		
	: (Form event code:C388=On Open Detail:K2:23)
		READ ONLY:C145([Bridge MHD NBIS:1])
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Resize:K2:27)
		C_POINTER:C301($Lb_ptr)
		$Lb_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "List box")
		REDRAW:C174($Lb_ptr->)
		
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
End case 
//End [Cons Inspection].View Cslt_Insp_LB