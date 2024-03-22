// ----------------------------------------------------
// Form Method: Input
// User name (OS): cjmiller
// Date and time: 01/22/08, 12:03:47
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/7/08 12:58:31)
	Mods_2008_CM_5404  // ("ACCESS")
	// Modified by: costasmanousakis-(Designer)-(12/15/08 09:26:40)
	Mods_2008_CM_5404  // ("MOREPINFO")
	//Added new fields in form 
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		
		C_TEXT:C284(ConsName_txt)
		QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
		If (Records in selection:C76([Conslt_Name:127])=1)
			ConsName_txt:=[Conslt_Name:127]ConsultantName_s:2
		Else 
			ConsName_txt:="Unknown"
		End if 
		
		READ ONLY:C145([PRJ_ProjectFile:117])
		READ ONLY:C145([PRJ_DCPFJoin:135])
		QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]DC_DesignProjectID_l:2=[PRJ_DesignContracts:123]DC_DesignContractID_l:1)
		ARRAY LONGINT:C221($FileIDs_al; 0)
		SELECTION TO ARRAY:C260([PRJ_DCPFJoin:135]PF_FileID_l:3; $FileIDs_al)
		QUERY WITH ARRAY:C644([PRJ_ProjectFile:117]PF_FileID_l:1; $FileIDs_al)
		//QUERY([PRJ_ProjectFile];[PRJ_ProjectFile]DC_OLDDesignContractID_l=[PRJ_DesignContracts]DC_DesignContractID_l)
		ORDER BY:C49([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3)
		ARRAY LONGINT:C221(DCINP_PFFILENo_aL; 0)
		ARRAY LONGINT:C221(DCINP_PFRecID_aL; 0)
		ARRAY DATE:C224(DCINP_PFAdDate_aD; 0)
		ARRAY REAL:C219(DCINP_PFAdCost_aR; 0)
		ARRAY TEXT:C222(DCINP_PFTIP_aS; 0)  //Command Replaced was o_ARRAY string length was 80
		SELECTION TO ARRAY:C260([PRJ_ProjectFile:117]PF_FileID_l:1; DCINP_PFRecID_aL; [PRJ_ProjectFile:117]PF_FileNumber_l:3; DCINP_PFFILENo_aL; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; DCINP_PFAdDate_aD; [PRJ_ProjectFile:117]PF_CostAd_r:9; DCINP_PFAdCost_aR; [PRJ_ProjectFile:117]PF_TIP_s:7; DCINP_PFTIP_aS)
		ARRAY LONGINT:C221($arrPrjFileNos; 0)
		SELECTION TO ARRAY:C260([PRJ_ProjectFile:117]PF_FileID_l:1; $arrPrjFileNos)
		READ ONLY:C145([PRJ_ProjectDetails:115])
		QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]PF_FileID_l:3; $arrPrjFileNos)
		ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5)
		ARRAY LONGINT:C221(DCINP_PRJRecID_aL; 0)
		ARRAY TEXT:C222(DCINP_PRJBRno_aS; 0)  //Command Replaced was o_ARRAY string length was 28
		ARRAY TEXT:C222(DCINP_PRJTown_aS; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY TEXT:C222(DCINP_PRJLastAction_atxt; 0)
		SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; DCINP_PRJRecID_aL; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; DCINP_PRJBRno_aS; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; DCINP_PRJTown_aS; [PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9; DCINP_PRJLastAction_atxt)
		ut_SetStringOrTextFilter(->[PRJ_DesignContracts:123]DC_Description_txt:4)
		ut_SetStringOrTextFilter(->[PRJ_DesignContracts:123]DC_ProgramType_s:9)
		If (Not:C34(User in group:C338(Current user:C182; "Application Admin")))
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET VISIBLE:C603(bDelete; False:C215)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "@"; <>Color_not_editable)
			READ ONLY:C145(Current form table:C627->)
			UNLOAD RECORD:C212(Current form table:C627->)
			LOAD RECORD:C52(Current form table:C627->)
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Unload:K2:2)
		READ WRITE:C146(Current form table:C627->)
		
End case 
//End Form Method: Input