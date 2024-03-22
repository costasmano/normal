//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/06/11, 21:39:18
	// ----------------------------------------------------
	// Method: QR_ArchiveFunction
	// Description
	//  ` Quick report function to be used when the master table is the [BridgeMHDNBISArchive] table
	//  ` communicates with ut_QRARCHIVEFUNCTION using process variables and sempahore "ARCHIVEFUNCTION"
	//  ` will launch ut_QRARCHIVEFUNCTION if it has not started yet.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_09
	
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:16:02)
	Mods_2023_04
	//  `use tickcount parameter in semaphore; remove other IDLE commands
End if 

//Is source process running?
C_LONGINT:C283(is_ut_QRARCHIVEFUNCTION_on; ARCH_FieldNo_L)
is_ut_QRARCHIVEFUNCTION_on:=LProcessID("Archive Function")
If (is_ut_QRARCHIVEFUNCTION_on>0)
	
Else 
	//Launh it
	is_ut_QRARCHIVEFUNCTION_on:=New process:C317("ut_QRARCHIVEFUNCTION"; 0; "Archive Function")
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 10)
		GET PROCESS VARIABLE:C371(is_ut_QRARCHIVEFUNCTION_on; ARCH_FieldNo_L; ARCH_FieldNo_L)
	Until (ARCH_FieldNo_L=-4)
	
End if 

While (Semaphore:C143("ARCHIVEFUNCTION"; 4))
	//DELAY PROCESS(Current process;1)
	IDLE:C311
End while 
C_TEXT:C284($1; ARCH_Reason_txt)
ARCH_Reason_txt:=$1
C_DATE:C307($2; ARCH_Date_d)
ARCH_Date_d:=$2
C_TEXT:C284($3; ARCH_BIN_txt)
ARCH_BIN_txt:=$3
C_TEXT:C284(ARCH_Result_txt; $0)
C_POINTER:C301($4; $Field_p)
$Field_p:=$4
C_LONGINT:C283(ARCH_FieldNo_L)
ARCH_FieldNo_L:=Field:C253($Field_p)

SET PROCESS VARIABLE:C370(is_ut_QRARCHIVEFUNCTION_on; ARCH_Reason_txt; ARCH_Reason_txt; ARCH_Date_d; ARCH_Date_d; ARCH_FieldNo_L; ARCH_FieldNo_L; ARCH_BIN_txt; ARCH_BIN_txt)

Repeat 
	DELAY PROCESS:C323(Current process:C322; 2)
	//IDLE
	GET PROCESS VARIABLE:C371(is_ut_QRARCHIVEFUNCTION_on; ARCH_BIN_txt; ARCH_BIN_txt; ARCH_Result_txt; ARCH_Result_txt)
Until (ARCH_BIN_txt="DONE")

ARCH_FieldNo_L:=-1
ARCH_Reason_txt:=""
ARCH_BIN_txt:=""
SET PROCESS VARIABLE:C370(is_ut_QRARCHIVEFUNCTION_on; ARCH_Reason_txt; ARCH_Reason_txt; ARCH_FieldNo_L; ARCH_FieldNo_L)
Repeat 
	DELAY PROCESS:C323(Current process:C322; 2)
	//IDLE
	GET PROCESS VARIABLE:C371(is_ut_QRARCHIVEFUNCTION_on; ARCH_FieldNo_L; ARCH_FieldNo_L)
Until (ARCH_FieldNo_L=-2)

CLEAR SEMAPHORE:C144("ARCHIVEFUNCTION")
$0:=ARCH_Result_txt