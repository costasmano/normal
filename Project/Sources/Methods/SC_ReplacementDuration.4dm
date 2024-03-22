//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:57:40
	// ----------------------------------------------------
	// Method: SC_ReplacementDuration
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $Duration)
Case of 
	: ([Bridge MHD NBIS:1]Item29:88<100)
		$Duration:=3
	: ([Bridge MHD NBIS:1]Item29:88<500)
		$Duration:=2
	: ([Bridge MHD NBIS:1]Item29:88<1000)
		$Duration:=1.5
	: ([Bridge MHD NBIS:1]Item29:88<5000)
		$Duration:=1
	: ([Bridge MHD NBIS:1]Item29:88<25000)
		$Duration:=0.75
	Else 
		$Duration:=0.5
End case 
SC_WriteSingleDataCol(String:C10($Duration))

$0:=$Duration