//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:56:37
	// ----------------------------------------------------
	// Method: SC_ContinuityF
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $SC_ContinuityF)
C_TEXT:C284($Item43A)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Item43B)  // Command Replaced was o_C_STRING length was 2
$Item43A:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)
$Item43B:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
$SC_ContinuityF:=1
Case of 
	: (Not:C34(bIsNumeric([Bridge MHD NBIS:1]Item43:75)))
		$SC_ContinuityF:=1
	: (Position:C15($Item43A; "246")>0)
		Case of 
			: ([Bridge MHD NBIS:1]Item48:92<20)
				$SC_ContinuityF:=0.8
			: ([Bridge MHD NBIS:1]Item48:92<=30)
				$SC_ContinuityF:=0.9
		End case 
		
	Else 
		If (($Item43B="07") | ($Item43B="11") | ($Item43B="12"))
			If ([Bridge MHD NBIS:1]Item48:92<=30)
				$SC_ContinuityF:=0.67
			End if 
		End if 
End case 
$0:=$SC_ContinuityF