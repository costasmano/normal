//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): MillerC
// Date and time: 05/28/09, 16:01:17
// ----------------------------------------------------
// Method: PM_DisplayRecords
// Description
// 
//
// Parameters
// ----------------------------------------------------
READ ONLY:C145(*)
FORM SET INPUT:C55([Pontis_Metrics:41]; "User.i")
FORM SET OUTPUT:C54([Pontis_Metrics:41]; "User.o")

ALL RECORDS:C47([Pontis_Metrics:41])
DISPLAY SELECTION:C59([Pontis_Metrics:41]; *)