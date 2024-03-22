//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/27/05, 15:31:13
	// ----------------------------------------------------
	// Method: HI_InitBMSElmtArrays
	// Description
	// Load process arrays for BMS Elements in memory
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
ALL RECORDS:C47([BMS Elements:47])
ARRAY INTEGER:C220(ar_BMSELID_L; 0)
ARRAY TEXT:C222(ar_BMSELNAME_S; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY INTEGER:C220(ar_BMSELNoCS_L; 0)
SELECTION TO ARRAY:C260([BMS Elements:47]Element ID:1; ar_BMSELID_L; [BMS Elements:47]Element Name:3; ar_BMSELNAME_S; [BMS Categories:49]Num of CSs:7; ar_BMSELNoCS_L)
REDUCE SELECTION:C351([BMS Elements:47]; 0)
