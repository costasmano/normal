//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/30/10, 02:11:02
	// ----------------------------------------------------
	// Method: DCM_PrintContractReport
	// Description
	//  `"Print" - export DCM Contract to an excel -xml workbook
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(10/28/10 09:45:34)
	Mods_2010_10
	//  `Added short Message 
	// Modified by: costasmanousakis-(Designer)-(11/9/10 11:44:56)
	Mods_2010_11
	//  `Change logic to use ut_LoadSysParamError method
	// Modified by: costasmanousakis-(Designer)-(3/7/11 09:00:31)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
	
End if 

If (Not:C34(Is record loaded:C669([DCM_Contracts:136])))
	LOAD RECORD:C52([DCM_Contracts:136])
End if 
READ ONLY:C145([DCM_WorkOrders:137])
READ ONLY:C145([DCM_Project:138])
QUERY:C277([DCM_WorkOrders:137]; [DCM_WorkOrders:137]ContractNo:1=[DCM_Contracts:136]ContractNo:1)

C_BLOB:C604($LoadProjRepTempl_blb; $Result_blb)
C_TEXT:C284($LoadProjRepTempl_txt; $fileExtension; $WorkBookHDR_txt; $WorkBookFTR_txt; $WorkBookStyles_txt)
C_TEXT:C284($WOShtHDR_txt; $WOShtFTR_txt; $WOShtBRGList_txt; $WOShtItemList_txt; $WOShtAttachList_txt)
C_TEXT:C284($WOBRGPROJSht_txt; $WOBRGPROJShtProc_txt)
C_TEXT:C284($COShtHDR_txt; $COShtFTR_txt; $COShtWO_txt; $COShtBrg_txt; $COShtItem_txt)
C_TEXT:C284($Process_txt)

If (False:C215)
	$WorkBookHDR_txt:=ut_GetSysParameter("XML_DCMWorkBookHdr")
	$WorkBookStyles_txt:=ut_GetSysParameter("XML_DCMWorkBookSTY")
	$WorkBookFTR_txt:=ut_GetSysParameter("XML_DCMWorkBookFTR")
	
	$COShtHDR_txt:=ut_GetSysParameter("XML_DCMCONTRShtHDR")
	$COShtFTR_txt:=ut_GetSysParameter("XML_DCMCONTRShtFTR")
	$COShtWO_txt:=ut_GetSysParameter("XML_DCMCONTRShtALs")
	$COShtBrg_txt:=ut_GetSysParameter("XML_DCMCONTRShtBRLs")
	$COShtItem_txt:=ut_GetSysParameter("XML_DCMCONTRShtITLs")
	
	$WOShtHDR_txt:=ut_GetSysParameter("XML_DCMWOSheetHDR")
	$WOShtFTR_txt:=ut_GetSysParameter("XML_DCMWOSheetFTR")
	$WOShtBRGList_txt:=ut_GetSysParameter("XML_DCMWOBRGLIST")
	$WOShtItemList_txt:=ut_GetSysParameter("XML_DCMWOBIDITEMS")
	$WOShtAttachList_txt:=ut_GetSysParameter("XML_DCMWOAttchList")
	
	$WOBRGPROJSht_txt:=ut_GetSysParameter("XML_DCMProjReport")
	
End if 
Case of 
	: (Not:C34(ut_LoadSysParamError("XML_DCMWorkBookHdr"; ->$WorkBookHDR_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMWorkBookSTY"; ->$WorkBookStyles_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMWorkBookFTR"; ->$WorkBookFTR_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMCONTRShtHDR"; ->$COShtHDR_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMCONTRShtFTR"; ->$COShtFTR_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMCONTRShtALs"; ->$COShtWO_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMCONTRShtBRLs"; ->$COShtBrg_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMCONTRShtITLs"; ->$COShtItem_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOSheetHDR"; ->$WOShtHDR_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOSheetFTR"; ->$WOShtFTR_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOBRGLIST"; ->$WOShtBRGList_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOBIDITEMS"; ->$WOShtItemList_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMWOAttchList"; ->$WOShtAttachList_txt)))
		
	: (Not:C34(ut_LoadSysParamError("XML_DCMProjReport"; ->$WOBRGPROJSht_txt)))
		
	Else 
		If ($WOShtHDR_txt#"")
			SHORT_MESSAGE("Generating Contract Excel Report...")
			TEXT TO BLOB:C554($WorkBookHDR_txt; $Result_blb; Mac text without length:K22:10)
			TEXT TO BLOB:C554($WorkBookStyles_txt; $Result_blb; Mac text without length:K22:10; *)
			
			PROCESS 4D TAGS:C816($COShtHDR_txt; $Process_txt)
			TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($COShtWO_txt; $Process_txt)
			TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($COShtBrg_txt; $Process_txt)
			TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($COShtItem_txt; $Process_txt)
			TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
			PROCESS 4D TAGS:C816($COShtFTR_txt; $Process_txt)
			TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
			
			COPY NAMED SELECTION:C331([DCM_WorkOrders:137]; "ContrWOPrePrint")
			COPY NAMED SELECTION:C331([DCM_Project:138]; "ContrBRGPrePrint")
			READ ONLY:C145([DCM_WorkOrders:137])
			FIRST RECORD:C50([DCM_WorkOrders:137])
			
			While (Not:C34(End selection:C36([DCM_WorkOrders:137])))
				DCM_ControlWOBlobs("INIT")
				RELATE MANY:C262([DCM_WorkOrders:137])
				ORDER BY:C49([DCM_Project:138]; [DCM_Project:138]BIN:5)
				DCM_WO_PrjLB_Control("INIT")
				DCM_WO_PrjLB_Control("LOAD")
				Case of 
					: ([DCM_WorkOrders:137]ABPFlag_L:38=1)
						DCM_ABPStatus_txt:="Accelerated Bridge"
					: ([DCM_WorkOrders:137]ABPFlag_L:38=2)
						DCM_ABPStatus_txt:="Potential Accelerated Bridge"
					Else 
						DCM_ABPStatus_txt:="Non ABP"
				End case 
				
				PROCESS 4D TAGS:C816($WOShtHDR_txt; $Process_txt)
				TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
				PROCESS 4D TAGS:C816($WOShtBRGList_txt; $Process_txt)
				TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
				PROCESS 4D TAGS:C816($WOShtAttachList_txt; $Process_txt)
				TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
				PROCESS 4D TAGS:C816($WOShtItemList_txt; $Process_txt)
				TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
				PROCESS 4D TAGS:C816($WOShtFTR_txt; $Process_txt)
				TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
				
				READ ONLY:C145([DCM_Project:138])
				FIRST RECORD:C50([DCM_Project:138])
				While (Not:C34(End selection:C36([DCM_Project:138])))
					DCM_P_Input_FM(On Load:K2:1)
					PROCESS 4D TAGS:C816($WOBRGPROJSht_txt; $Process_txt)
					TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
					NEXT RECORD:C51([DCM_Project:138])
				End while 
				
				READ WRITE:C146([DCM_Project:138])
				
				NEXT RECORD:C51([DCM_WorkOrders:137])
				
			End while 
			
			USE NAMED SELECTION:C332("ContrWOPrePrint")
			USE NAMED SELECTION:C332("ContrBRGPrePrint")
			CLEAR NAMED SELECTION:C333("ContrWOPrePrint")
			CLEAR NAMED SELECTION:C333("ContrBRGPrePrint")
			
			TEXT TO BLOB:C554($WorkBookFTR_txt; $Result_blb; Mac text without length:K22:10; *)
			SET TEXT TO PASTEBOARD:C523([DCM_Contracts:136]ContractNo:1)
			CLOSE WINDOW:C154
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

If (False:C215)
	C_TEXT:C284(DCMRptDateTime_txt)
	DCMRptDateTime_txt:=String:C10(Current date:C33(*); Internal date short:K1:7)+" - "+String:C10(Current time:C178(*); HH MM:K7:2)
	C_REAL:C285($printHt; $printable_ht; $printable_wt)
	//PRINT SETTINGS
	C_LONGINT:C283(vCMRptPage)
	If (OK=1)
		G_PrintOptions(2; " "; 100)  //make sure landscape at 100 %
		READ ONLY:C145([DCM_WorkOrders:137])
		READ ONLY:C145([DCM_Project:138])
		QUERY:C277([DCM_WorkOrders:137]; [DCM_WorkOrders:137]ContractNo:1=[DCM_Contracts:136]ContractNo:1)
		vCMRptPage:=0
		GET PRINTABLE AREA:C703($printable_ht; $printable_wt)
		$printHt:=Print form:C5([DCM_Contracts:136]; "PrintDetail"; Form header:K43:3)
		$printHt:=$printHt+Print form:C5([DCM_Contracts:136]; "PrintDetail")  //print the detail
		If (Records in selection:C76([DCM_WorkOrders:137])>0)
			$printHt:=$printHt+Print form:C5([DCM_WorkOrders:137]; "PrintDetail"; Form header:K43:3)
			FIRST RECORD:C50([DCM_WorkOrders:137])
			While (Not:C34(End selection:C36([DCM_WorkOrders:137])))
				If (($printable_ht-$printHt)<73)
					PAGE BREAK:C6(>)
					$printHt:=Print form:C5([DCM_Contracts:136]; "PrintDetail"; Form header1:K43:4)
					$printHt:=$printHt+Print form:C5([DCM_WorkOrders:137]; "PrintDetail"; Form header:K43:3)
				End if 
				
				$printHt:=$printHt+Print form:C5([DCM_WorkOrders:137]; "PrintDetail"; Form header1:K43:4)
				
				QUERY:C277([DCM_Project:138]; [DCM_Project:138]AssignID:13=[DCM_WorkOrders:137]AssignID:3)
				If (Records in selection:C76([DCM_Project:138])>0)
					ORDER BY:C49([DCM_Project:138]; [DCM_Project:138]BridgeNo:4; >; [DCM_Project:138]BIN:5)
					$printHt:=$printHt+Print form:C5([DCM_Project:138]; "PrintDetail"; Form header:K43:3)
					
					FIRST RECORD:C50([DCM_Project:138])
					While (Not:C34(End selection:C36([DCM_Project:138])))
						If (($printable_ht-$printHt)<73)
							PAGE BREAK:C6(>)
							$printHt:=Print form:C5([DCM_Contracts:136]; "PrintDetail"; Form header1:K43:4)
							$printHt:=$printHt+Print form:C5([DCM_WorkOrders:137]; "PrintDetail"; Form header:K43:3)
						End if 
						
						$printHt:=$printHt+Print form:C5([DCM_Project:138]; "PrintDetail")
						
						NEXT RECORD:C51([DCM_Project:138])
					End while 
					
				End if 
				
				NEXT RECORD:C51([DCM_WorkOrders:137])
			End while 
			
		End if 
		
		PAGE BREAK:C6
		
		READ WRITE:C146([DCM_WorkOrders:137])
		READ WRITE:C146([DCM_Project:138])
	End if 
End if 