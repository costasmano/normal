If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2022-12-28 16:27:37)
	Mods_2022_12_bug
	//  `fixed buttons; listbox configurations; added option in Quick report button to run quick report to excel.
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(ARCH_OUT_WINTITLE_TXT)
		C_POINTER:C301(pFIle)
		pFIle:=->[BridgeMHDNBISArchive:139]
		C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
		MainTitle:="[BridgeMHDNBISArchive] :"
		RegionTitle
		
		ARRAY TEXT:C222(ArchiveReason_atxt; 0)
		ARRAY DATE:C224(ArchiveDate_ad; 0)
		
		DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveReason_s:223; ArchiveReason_atxt)
		OBJECT SET VISIBLE:C603(*; "ArchiveDate_ad"; False:C215)
		
	: (Form event code:C388=On Validate:K2:3)
	: (Form event code:C388=On Unload:K2:2)
		ARRAY TEXT:C222(ArchiveReason_atxt; 0)
		ARRAY DATE:C224(ArchiveDate_ad; 0)
		
End case 
