If (False:C215)
	
	//Object Method: [BridgeMHDNBISArchive].Output.ARCH_TOOL_BTN_L 
	// Modified by: costasmanousakis-(Designer)-(9/19/11 10:20:54)
	Mods_2011_09
	//Tools drop down menu
	// Modified by: costasmanousakis-(Designer)-(10/25/11 11:21:40)
	Mods_2011_10
	//  `Added Out of Freq method
	// Modified by: Costas Manousakis-(Designer)-(4/17/12 )
	Mods_2012_04
	//  `added export of nbi tape to tab delim
	// Modified by: Costas Manousakis-(Designer)-(9/10/12 10:57:54)
	Mods_2012_09
	//  `Added query by formula and query selection by formula
	// Modified by: Costas Manousakis-(Designer)-(4/4/14 16:56:32)
	Mods_2014_04
	//  `Added ability to get the tools arrays from the parameters table
	
	ARCHIVE_ExportNBI
	ARCHIVE_ExportNBItabDelim
	ut_ImportDBFToArchive
	ut_GenCondRepFromArchive
	ARCHIVE_UpdateSDFO
	ut_ImportFHWADataToArchive
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(ARCH_TOOL_BTN_Code_L)
		ARCH_TOOL_BTN_Code_L:=0
		C_TEXT:C284(ARCH_TOOL_POPUPMENU_txt)
		ARRAY TEXT:C222(ARCH_TOOL_BTNTXT_atxt; 0)
		ARRAY TEXT:C222(ARCH_TOOL_COMMAND_atxt; 0)
		ARRAY TEXT:C222(ARCH_TOOL_DESCRIPTION_atxt; 0)
		C_TEXT:C284($paramData_txt)
		$paramData_txt:=ut_GetSysParameter("ARCH_TOOL_BTNTXT")
		ut_TextToArray($paramData_txt; ->ARCH_TOOL_BTNTXT_atxt; Char:C90(13))
		$paramData_txt:=ut_GetSysParameter("ARCH_TOOL_COMMAND")
		ut_TextToArray($paramData_txt; ->ARCH_TOOL_COMMAND_atxt; Char:C90(13))
		$paramData_txt:=ut_GetSysParameter("ARCH_TOOL_DESCRIPTIO")
		ut_TextToArray($paramData_txt; ->ARCH_TOOL_DESCRIPTION_atxt; Char:C90(13))
		C_BOOLEAN:C305($GoAhead_B)
		$GoAhead_B:=(Size of array:C274(ARCH_TOOL_BTNTXT_atxt)=Size of array:C274(ARCH_TOOL_COMMAND_atxt))
		$GoAhead_B:=$GoAhead_B & (Size of array:C274(ARCH_TOOL_BTNTXT_atxt)=Size of array:C274(ARCH_TOOL_DESCRIPTION_atxt))
		$GoAhead_B:=$GoAhead_B & (Size of array:C274(ARCH_TOOL_BTNTXT_atxt)>0)
		If ($GoAhead_B)
		Else 
			APPEND TO ARRAY:C911(ARCH_TOOL_BTNTXT_atxt; "EXP")
			APPEND TO ARRAY:C911(ARCH_TOOL_COMMAND_atxt; "ARCHIVE_ExportNBI")
			APPEND TO ARRAY:C911(ARCH_TOOL_DESCRIPTION_atxt; "Export NBI tape")
			
			APPEND TO ARRAY:C911(ARCH_TOOL_BTNTXT_atxt; "EXC")
			APPEND TO ARRAY:C911(ARCH_TOOL_COMMAND_atxt; "ARCHIVE_ExportNBItabDelim")
			APPEND TO ARRAY:C911(ARCH_TOOL_DESCRIPTION_atxt; "Export NBI tape to tab delim")
			
			APPEND TO ARRAY:C911(ARCH_TOOL_BTNTXT_atxt; "IMP")
			APPEND TO ARRAY:C911(ARCH_TOOL_COMMAND_atxt; "ut_ImportDBFToArchive")
			APPEND TO ARRAY:C911(ARCH_TOOL_DESCRIPTION_atxt; "Import from DBFs, Text")
			
			APPEND TO ARRAY:C911(ARCH_TOOL_BTNTXT_atxt; "RPT")
			APPEND TO ARRAY:C911(ARCH_TOOL_COMMAND_atxt; "ut_GenCondRepFromArchive")
			APPEND TO ARRAY:C911(ARCH_TOOL_DESCRIPTION_atxt; "Generate Status Report")
			
			APPEND TO ARRAY:C911(ARCH_TOOL_BTNTXT_atxt; "UPD")
			APPEND TO ARRAY:C911(ARCH_TOOL_COMMAND_atxt; "ARCHIVE_UpdateSDFO")
			APPEND TO ARRAY:C911(ARCH_TOOL_DESCRIPTION_atxt; "Update SD-FO")
			
			APPEND TO ARRAY:C911(ARCH_TOOL_BTNTXT_atxt; "IMP2")
			APPEND TO ARRAY:C911(ARCH_TOOL_COMMAND_atxt; "ut_ImportFHWADataToArchive")
			APPEND TO ARRAY:C911(ARCH_TOOL_DESCRIPTION_atxt; "Import FHWA tape")
			
			APPEND TO ARRAY:C911(ARCH_TOOL_BTNTXT_atxt; "QBF")
			APPEND TO ARRAY:C911(ARCH_TOOL_COMMAND_atxt; "QUERY BY FORMULA([BridgeMHDNBISArchive])")
			APPEND TO ARRAY:C911(ARCH_TOOL_DESCRIPTION_atxt; "QUERY BY FORMULA")
			
			APPEND TO ARRAY:C911(ARCH_TOOL_BTNTXT_atxt; "QSBF")
			APPEND TO ARRAY:C911(ARCH_TOOL_COMMAND_atxt; "QUERY SELECTION BY FORMULA([BridgeMHDNBISArchive])")
			APPEND TO ARRAY:C911(ARCH_TOOL_DESCRIPTION_atxt; "QUERY SELECTION BY FORMULA")
		End if 
		
		If (Size of array:C274(ARCH_TOOL_DESCRIPTION_atxt)>0)
			ARCH_TOOL_POPUPMENU_txt:=ARCH_TOOL_DESCRIPTION_atxt{1}
			C_LONGINT:C283($loop_L)
			For ($loop_L; 2; Size of array:C274(ARCH_TOOL_DESCRIPTION_atxt))
				ARCH_TOOL_POPUPMENU_txt:=ARCH_TOOL_POPUPMENU_txt+";"+ARCH_TOOL_DESCRIPTION_atxt{$loop_L}
			End for 
		End if 
		
	: ((Form event code:C388=On Alternative Click:K2:36) | (Form event code:C388=On Long Click:K2:37) | ((Form event code:C388=On Clicked:K2:4) & (ARCH_TOOL_BTN_Code_L=0)))
		C_LONGINT:C283($choise_L)
		$choise_L:=Pop up menu:C542(ARCH_TOOL_POPUPMENU_txt)
		ARCH_TOOL_BTN_Code_L:=$choise_L
		
		If ((ARCH_TOOL_BTN_Code_L>0) & (ARCH_TOOL_BTN_Code_L<=Size of array:C274(ARCH_TOOL_COMMAND_atxt)))
			OBJECT SET TITLE:C194(Self:C308->; ARCH_TOOL_BTNTXT_atxt{ARCH_TOOL_BTN_Code_L})
			EXECUTE FORMULA:C63(ARCH_TOOL_COMMAND_atxt{ARCH_TOOL_BTN_Code_L})
			RegionTitle
			
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If ((ARCH_TOOL_BTN_Code_L>0) & (ARCH_TOOL_BTN_Code_L<=Size of array:C274(ARCH_TOOL_COMMAND_atxt)))
			EXECUTE FORMULA:C63(ARCH_TOOL_COMMAND_atxt{ARCH_TOOL_BTN_Code_L})
			RegionTitle
			
		End if 
		
End case 