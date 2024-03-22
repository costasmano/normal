//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/03/06, 13:00:41
	// ----------------------------------------------------
	// Method: CIR_SetReceiveLabels
	// Description
	// Set the "Inspection Received ()" labels in page 1 of the[Cons Inspection] input form
	// based on the inspection type checkboxes.
	// Parameters
	// ----------------------------------------------------
	
End if 
C_TEXT:C284(vInspRecvd1)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vInspRecvd2)  // Command Replaced was o_C_STRING length was 50
vInspRecvd1:="Inspection received ()"
vInspRecvd2:="Inspection received ()"
C_TEXT:C284($InspRcvdString1)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284($InspRcvdString2)  // Command Replaced was o_C_STRING length was 10

If (chkRoutine=1)
	$InspRcvdString1:="R"
End if 

If (chkSM=1)
	If (Length:C16($InspRcvdString1)>0)
		$InspRcvdString1:=$InspRcvdString1+", SM"
	Else 
		$InspRcvdString1:="SM"
	End if 
End if 

If (chkFC=1)
	If (Length:C16($InspRcvdString1)>0)
		$InspRcvdString1:=$InspRcvdString1+", FC"
	Else 
		$InspRcvdString1:="FC"
	End if 
End if 

If (chkMec=1)
	OBJECT SET ENTERABLE:C238([Cons Inspection:64]InspRecvd_ME:37; True:C214)
	If (Length:C16($InspRcvdString2)>0)
		$InspRcvdString2:=$InspRcvdString2+", M"
	Else 
		$InspRcvdString2:="M"
	End if 
End if 

If (chkElec=1)
	OBJECT SET ENTERABLE:C238([Cons Inspection:64]InspRecvd_ME:37; True:C214)
	If (Length:C16($InspRcvdString2)>0)
		$InspRcvdString2:=$InspRcvdString2+", E"
	Else 
		$InspRcvdString2:="E"
	End if 
End if 

If (chkTesting=1)
	If (Length:C16($InspRcvdString2)>0)
		$InspRcvdString2:=$InspRcvdString2+", T"
	Else 
		$InspRcvdString2:="T"
	End if 
End if 

vInspRecvd1:="Inspection received ("+$InspRcvdString1+")"
vInspRecvd2:="Inspection received ("+$InspRcvdString2+")"
