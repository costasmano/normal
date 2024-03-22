//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_SetPrintOptions
// User name (OS): cjmiller
// Date and time: 05/03/05, 11:28:49
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	// Modified by: costasmanousakis-(Designer)-(1/4/12 13:58:04)
	Mods_2012_01
	//  `Made var $SD_ReportFilePath_txt to global ◊SD_ReportFilePath_txt will be used to open the folder.
End if 

If (<>SD_Detail_l=1)
	SET PRINT OPTION:C733(Orientation option:K47:2; 2)
Else 
	SET PRINT OPTION:C733(Orientation option:K47:2; 1)
End if 

C_TEXT:C284(<>SD_ReportFilePath_txt)
If (<>SD_CreateFile_l=1)
	<>SD_ReportFilePath_txt:=Select folder:C670("Select Folder for report document")
	C_LONGINT:C283($Destination_l)
	C_TEXT:C284($Ext)  // Command Replaced was o_C_STRING length was 3
	If (<>PL_LPlatfrm=3) | ((<>PL_LSysVers\256)#16)
		$Destination_l:=2  //file
		$Ext:="txt"
	Else 
		$Destination_l:=3  //pdf
		$Ext:="pdf"
		
	End if 
	
	If (<>SD_Detail_l=1)
		SET PRINT OPTION:C733(Destination option:K47:7; $Destination_l; <>SD_ReportFilePath_txt+"Detail-"+<>SD_BeginMonth_s+<>SD_BeginYear_s+"-"+<>SD_EndMonth_s+<>SD_EndYear_s+"."+$Ext)
	Else 
		SET PRINT OPTION:C733(Destination option:K47:7; $Destination_l; <>SD_ReportFilePath_txt+"Summary-"+<>SD_BeginMonth_s+<>SD_BeginYear_s+"-"+<>SD_EndMonth_s+<>SD_EndYear_s+"."+$Ext)
	End if 
Else 
	SET PRINT OPTION:C733(Destination option:K47:7; 1)  //to printer
End if 
//End SD_SetPrintOptions