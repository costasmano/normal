If (False:C215)
	//Object Method: ARCH_RPT_BTN_L 
	
	// Modified by: costasmanousakis-(Designer)-(9/19/11 10:20:54)
	Mods_2011_09
	//Tools drop down menu
	// Modified by: costasmanousakis-(Designer)-(10/25/11 11:21:40)
	Mods_2011_10
	//Added Out of Freq method
	
	ARCHIVE_OutOfFreq
	ARCH_M_MasterList
	ARCH_M_RPC_Report
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(ARCH_RPT_BTN_Code_L)
		ARCH_RPT_BTN_Code_L:=0
		C_TEXT:C284(ARCH_RPT_POPUPMENU_txt)
		ARRAY TEXT:C222(ARCH_RPT_BTNTXT_atxt; 0)
		ARRAY TEXT:C222(ARCH_RPT_COMMAND_atxt; 0)
		ARRAY TEXT:C222(ARCH_RPT_DESCRIPTION_atxt; 0)
		APPEND TO ARRAY:C911(ARCH_RPT_BTNTXT_atxt; "OOF")
		APPEND TO ARRAY:C911(ARCH_RPT_COMMAND_atxt; "ARCHIVE_OutOfFreq")
		APPEND TO ARRAY:C911(ARCH_RPT_DESCRIPTION_atxt; "Check Out of Freq")
		APPEND TO ARRAY:C911(ARCH_RPT_BTNTXT_atxt; "MRPT")
		APPEND TO ARRAY:C911(ARCH_RPT_COMMAND_atxt; "ARCH_M_MasterList")
		APPEND TO ARRAY:C911(ARCH_RPT_DESCRIPTION_atxt; "Master List")
		APPEND TO ARRAY:C911(ARCH_RPT_BTNTXT_atxt; "RPCS")
		APPEND TO ARRAY:C911(ARCH_RPT_COMMAND_atxt; "ARCH_M_RPC_Report")
		APPEND TO ARRAY:C911(ARCH_RPT_DESCRIPTION_atxt; "RPC Reports")
		If (Size of array:C274(ARCH_RPT_DESCRIPTION_atxt)>0)
			ARCH_RPT_POPUPMENU_txt:=ARCH_RPT_DESCRIPTION_atxt{1}
			C_LONGINT:C283($loop_L)
			For ($loop_L; 2; Size of array:C274(ARCH_RPT_DESCRIPTION_atxt))
				ARCH_RPT_POPUPMENU_txt:=ARCH_RPT_POPUPMENU_txt+";"+ARCH_RPT_DESCRIPTION_atxt{$loop_L}
			End for 
		End if 
		
		
	: ((Form event code:C388=On Alternative Click:K2:36) | (Form event code:C388=On Long Click:K2:37) | ((Form event code:C388=On Clicked:K2:4) & (ARCH_RPT_BTN_Code_L=0)))
		C_LONGINT:C283($choise_L)
		$choise_L:=Pop up menu:C542(ARCH_RPT_POPUPMENU_txt)
		ARCH_RPT_BTN_Code_L:=$choise_L
		
		If ((ARCH_RPT_BTN_Code_L>0) & (ARCH_RPT_BTN_Code_L<=Size of array:C274(ARCH_RPT_COMMAND_atxt)))
			OBJECT SET TITLE:C194(Self:C308->; ARCH_RPT_BTNTXT_atxt{ARCH_RPT_BTN_Code_L})
			EXECUTE FORMULA:C63(ARCH_RPT_COMMAND_atxt{ARCH_RPT_BTN_Code_L})
			RegionTitle
			
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If ((ARCH_RPT_BTN_Code_L>0) & (ARCH_RPT_BTN_Code_L<=Size of array:C274(ARCH_RPT_COMMAND_atxt)))
			EXECUTE FORMULA:C63(ARCH_RPT_COMMAND_atxt{ARCH_RPT_BTN_Code_L})
			RegionTitle
			
		End if 
End case 