//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/06/10, 22:44:06
	// ----------------------------------------------------
	// Method: DCM_PrintWorkOrder
	// Description
	//  `"Print" - export work order to an excel -xml workbook
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(10/28/10 09:46:02)
	Mods_2010_10
	//  `Added Short message
	// Modified by: costasmanousakis-(Designer)-(11/9/10 11:49:17)
	Mods_2010_11
	//  `Change logic to use ut_LoadSysParamError method
	// Modified by: costasmanousakis-(Designer)-(3/7/11 09:00:31)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
	
End if 

C_BLOB:C604($LoadProjRepTempl_blb; $Result_blb)
C_TEXT:C284($LoadProjRepTempl_txt; $fileExtension; $WorkBookHDR_txt; $WorkBookFTR_txt; $WorkBookStyles_txt)
C_TEXT:C284($WOShtHDR_txt; $WOShtFTR_txt; $WOShtBRGList_txt; $WOShtItemList_txt; $WOShtAttachList_txt)
C_TEXT:C284($WOBRGPROJSht_txt; $WOBRGPROJShtProc_txt)

$WOShtHDR_txt:=ut_GetSysParameter("XML_DCMWOSheetHDR")
$WOShtFTR_txt:=ut_GetSysParameter("XML_DCMWOSheetFTR")
$WOShtBRGList_txt:=ut_GetSysParameter("XML_DCMWOBRGLIST")
$WOShtItemList_txt:=ut_GetSysParameter("XML_DCMWOBIDITEMS")
$WOShtAttachList_txt:=ut_GetSysParameter("XML_DCMWOAttchList")
$WOBRGPROJSht_txt:=ut_GetSysParameter("XML_DCMProjReport")
$WorkBookHDR_txt:=ut_GetSysParameter("XML_DCMWorkBookHdr")
$WorkBookStyles_txt:=ut_GetSysParameter("XML_DCMWorkBookSTY")
$WorkBookFTR_txt:=ut_GetSysParameter("XML_DCMWorkBookFTR")
Case of 
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOSheetHDR"; ->$WOShtHDR_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOSheetFTR"; ->$WOShtFTR_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOBRGLIST"; ->$WOShtBRGList_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOBIDITEMS"; ->$WOShtItemList_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOAttchList"; ->$WOShtAttachList_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMProjReport"; ->$WOBRGPROJSht_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWorkBookHdr"; ->$WorkBookHDR_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWorkBookSTY"; ->$WorkBookStyles_txt)))
	: (Not:C34(ut_LoadSysParamError("XML_DCMWorkBookFTR"; ->$WorkBookFTR_txt)))
	Else 
		If ($WOShtHDR_txt#"")
			SHORT_MESSAGE("Generating Work Order Excel Report...")
			TEXT TO BLOB:C554($WorkBookHDR_txt; $Result_blb; Mac text without length:K22:10)
			TEXT TO BLOB:C554($WorkBookStyles_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($WOShtHDR_txt; $WOShtHDR_txt)
			TEXT TO BLOB:C554($WOShtHDR_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($WOShtBRGList_txt; $WOShtBRGList_txt)
			TEXT TO BLOB:C554($WOShtBRGList_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($WOShtAttachList_txt; $WOShtAttachList_txt)
			TEXT TO BLOB:C554($WOShtAttachList_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($WOShtItemList_txt; $WOShtItemList_txt)
			TEXT TO BLOB:C554($WOShtItemList_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($WOShtFTR_txt; $WOShtFTR_txt)
			TEXT TO BLOB:C554($WOShtFTR_txt; $Result_blb; Mac text without length:K22:10; *)
			
			READ ONLY:C145([DCM_Project:138])
			FIRST RECORD:C50([DCM_Project:138])
			While (Not:C34(End selection:C36([DCM_Project:138])))
				DCM_P_Input_FM(On Load:K2:1)
				PROCESS 4D TAGS:C816($WOBRGPROJSht_txt; $WOBRGPROJShtProc_txt)
				TEXT TO BLOB:C554($WOBRGPROJShtProc_txt; $Result_blb; Mac text without length:K22:10; *)
				NEXT RECORD:C51([DCM_Project:138])
			End while 
			
			READ WRITE:C146([DCM_Project:138])
			
			TEXT TO BLOB:C554($WorkBookFTR_txt; $Result_blb; Mac text without length:K22:10; *)
			CLOSE WINDOW:C154
			SET TEXT TO PASTEBOARD:C523(([DCM_Contracts:136]ContractNo:1+"-"+String:C10([DCM_WorkOrders:137]AssignNo:2)))
			$LoadProjRepTempl_txt:=ut_CreateMSOfficeDoc(".XLS"; ".XML")
			If ($LoadProjRepTempl_txt#"")
				BLOB TO DOCUMENT:C526($LoadProjRepTempl_txt; $Result_blb)
				ut_OpenDocument($LoadProjRepTempl_txt)
				
			End if 
			
		End if 
		
End case 
$WOShtHDR_txt:=""
$WOShtFTR_txt:=""
$WOShtBRGList_txt:=""
$WOShtItemList_txt:=""
$WOShtAttachList_txt:=""
$WOBRGPROJSht_txt:=""
$WorkBookHDR_txt:=""
$WorkBookFTR_txt:=""
$WOBRGPROJShtProc_txt:=""
SET BLOB SIZE:C606($Result_blb; 0)