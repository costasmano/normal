//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:57:05
	// ----------------------------------------------------
	// Method: SC_Fatalities
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $Fatalities_r)
C_BOOLEAN:C305($InterState)
$InterState:=SC_InterState_Arterial
Case of 
	: ([Bridge MHD NBIS:1]Item29:88<100)
		$Fatalities_r:=0
	: ([Bridge MHD NBIS:1]Item29:88<500)
		$Fatalities_r:=1
	: ([Bridge MHD NBIS:1]Item29:88<5000)
		$Fatalities_r:=2
	Else 
		If (Not:C34($InterState))
			$Fatalities_r:=5
		Else 
			If ([Bridge MHD NBIS:1]Item29:88<=25000)
				$Fatalities_r:=10
			Else 
				$Fatalities_r:=12
			End if 
		End if 
End case 
SC_WriteSingleDataCol(f_Boolean2String($InterState; "YN"); "String")

If (([Bridge MHD NBIS:1]Item41:141="K") & Not:C34([Bridge MHD NBIS:1]Acrow Panel:28))
	//If bridge is closed and there is not acrow panel on it there are no fatalities
	$Fatalities_r:=0
End if 

SC_WriteSingleDataCol(String:C10($Fatalities_r))

$0:=$Fatalities_r
