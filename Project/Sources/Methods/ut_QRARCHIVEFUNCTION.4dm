//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/06/11, 22:10:41
	// ----------------------------------------------------
	// Method: ut_QRARCHIVEFUNCTION
	// Description
	//  ` Method to get info from the [BridgeMHDNBISArchive] table and passing it to a calling 
	//  ` process using interprocess communication
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_09
End if 
C_TEXT:C284(ARCH_Reason_txt; ARCH_BIN_txt; ARCH_Result_txt)
C_DATE:C307(ARCH_Date_d)
C_LONGINT:C283(ARCH_FieldNo_L)
TRACE:C157
ARCH_Result_txt:=""
ARCH_Reason_txt:=""
ARCH_BIN_txt:=""
ARCH_Date_d:=!00-00-00!
ARCH_FieldNo_L:=-4  // we are ready!!!
While (Not:C34(<>fQuit))
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 2)
		IDLE:C311
	Until ((ARCH_FieldNo_L>0) & (ARCH_Reason_txt#"") & (ARCH_BIN_txt#""))
	
	C_POINTER:C301($Field_ptr)
	$Field_ptr:=Field:C253(Table:C252(->[BridgeMHDNBISArchive:139]); ARCH_FieldNo_L)
	ARCH_Result_txt:=QR_SearchArchive(ARCH_Reason_txt; ARCH_Date_d; ARCH_BIN_txt; $Field_ptr)
	ARCH_BIN_txt:="DONE"
	ARCH_Reason_txt:=""
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 2)
		IDLE:C311
	Until (ARCH_FieldNo_L<0)
	
	ARCH_FieldNo_L:=-2
	
End while 