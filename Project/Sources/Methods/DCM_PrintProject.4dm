//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/05/10, 18:35:16
	// ----------------------------------------------------
	// Method: DCM_PrintProject
	// Description
	//  `"Print" - export DCM Bridge Project to an excel -xml workbook
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(11/9/10 11:48:04)
	Mods_2010_11
	//  `Change logic to use ut_LoadSysParamError method
	// Modified by: costasmanousakis-(Designer)-(3/7/11 09:00:31)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
End if 
C_BLOB:C604($LoadProjRepTempl_blb; $Result_blb)
C_TEXT:C284($LoadProjRepTempl_txt; $WorkBookHDR_txt; $WorkBookFTR_txt; $FileNameInClip_txt; $WorkBookStyles_txt)
If (False:C215)
	$LoadProjRepTempl_txt:=ut_GetSysParameter("XML_DCMProjReport")
	$WorkBookHDR_txt:=ut_GetSysParameter("XML_DCMWorkBookHdr")
	$WorkBookStyles_txt:=ut_GetSysParameter("XML_DCMWorkBookSTY")
	$WorkBookFTR_txt:=ut_GetSysParameter("XML_DCMWorkBookFTR")
End if 
Case of 
	: (Not:C34(ut_LoadSysParamError("XML_DCMProjReport"; ->$LoadProjRepTempl_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWorkBookHdr"; ->$WorkBookHDR_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWorkBookSTY"; ->$WorkBookStyles_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWorkBookFTR"; ->$WorkBookFTR_txt)))
		
	Else 
		
		If (($LoadProjRepTempl_txt#"") & ($WorkBookHDR_txt#"") & ($WorkBookFTR_txt#""))
			TEXT TO BLOB:C554($WorkBookHDR_txt; $Result_blb; Mac text without length:K22:10)
			TEXT TO BLOB:C554($WorkBookStyles_txt; $Result_blb; Mac text without length:K22:10; *)
			TEXT TO BLOB:C554($LoadProjRepTempl_txt; $Result_blb; Mac text without length:K22:10; *)
			TEXT TO BLOB:C554($WorkBookFTR_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($Result_blb; $Result_blb)
			$FileNameInClip_txt:=[DCM_Project:138]BridgeNo:4+"-"+[DCM_Project:138]BIN:5+"-"+[DCM_Contracts:136]ContractNo:1+"-"+String:C10([DCM_WorkOrders:137]AssignNo:2)
			SET TEXT TO PASTEBOARD:C523($FileNameInClip_txt)
			$LoadProjRepTempl_txt:=ut_CreateMSOfficeDoc(".XLS"; ".XML")
			If ($LoadProjRepTempl_txt#"")
				BLOB TO DOCUMENT:C526($LoadProjRepTempl_txt; $Result_blb)
				ut_OpenDocument($LoadProjRepTempl_txt)
			End if 
			
		End if 
End case 