//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/05/08, 15:49:15
	// ----------------------------------------------------
	// Method: DEFELMTSRC_Export
	// Description
	// Control method to export ElementsSafety records from the search for deficient elements
	// 
	// Parameters
	// $0 : $RetCode_L
	// $1 : $Task : text
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DEFELMTEXPORT")
End if 
C_LONGINT:C283($0; $RetCode_L)

C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
$RetCode_L:=0
Case of 
	: ($Task_txt="INIT")
		//initialize variables to be used
		C_TEXT:C284(DEFELM_HDR_txt; DEFELM_Line_txt; DEFELM_LineHeader_txt)
		C_TIME:C306(DEFELM_ExpFile_T)
	: ($Task_txt="OpenExportFile")
		DEFELM_ExpFile_T:=Create document:C266(""; "TEXT")
		$RetCode_L:=OK
		
	: ($Task_txt="BuildHeader")
		DEFELM_HDR_txt:="BIN: "+<>sTAB+"BDEPT: "+<>sTAB+"Item 8: "+<>sTAB+"Town: "+<>sTAB+"District: "+<>sTAB+"Item 7: "+<>sTAB+"Item 6A: "
		
	: ($Task_txt="BuildLineHeder")
		DEFELM_LineHeader_txt:=[Bridge MHD NBIS:1]BIN:3+<>sTAB+[Bridge MHD NBIS:1]BDEPT:1+<>sTAB+[Bridge MHD NBIS:1]Item8:206+<>sTAB+[Bridge MHD NBIS:1]Town Name:175
		DEFELM_LineHeader_txt:=DEFELM_LineHeader_txt+<>sTAB+[Bridge MHD NBIS:1]Item2:60+<>sTAB+[Bridge MHD NBIS:1]Item7:65
		DEFELM_LineHeader_txt:=DEFELM_LineHeader_txt+<>sTAB+[Bridge MHD NBIS:1]Item6A:63
		
	: ($Task_txt="ExportHeader")
		SEND PACKET:C103(DEFELM_ExpFile_T; DEFELM_HDR_txt)
		$RetCode_L:=OK
	: ($Task_txt="ExportElmtLine")
		SEND PACKET:C103(DEFELM_ExpFile_T; DEFELM_Line_txt)
		$RetCode_L:=OK
	: ($Task_txt="CloseExportFile")
		DEFELM_HDR_txt:=""
		DEFELM_Line_txt:=""
		CLOSE DOCUMENT:C267(DEFELM_ExpFile_T)
	Else 
		ALERT:C41("Error : Unknown Task "+$Task_txt+" given to "+Current method name:C684+"!")
End case 

$0:=$RetCode_L