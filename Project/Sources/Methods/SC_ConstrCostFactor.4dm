//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:56:23
	// ----------------------------------------------------
	// Method: SC_ConstrCostFactor
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $ConstrFactor)
C_BOOLEAN:C305($InterState)
$InterState:=SC_InterState_Arterial
Case of 
	: ([Bridge MHD NBIS:1]Item29:88<100)
		$ConstrFactor:=1
	: ([Bridge MHD NBIS:1]Item29:88<500)
		$ConstrFactor:=1.1
	: ([Bridge MHD NBIS:1]Item29:88<1000)
		$ConstrFactor:=1.25
	: ([Bridge MHD NBIS:1]Item29:88<5000)
		$ConstrFactor:=1.5
	: (([Bridge MHD NBIS:1]Item29:88>=5000) & Not:C34($InterState))
		$ConstrFactor:=1.5
	: ([Bridge MHD NBIS:1]Item29:88<25000)
		$ConstrFactor:=1.75
	Else 
		$ConstrFactor:=2
End case 
$0:=$ConstrFactor
