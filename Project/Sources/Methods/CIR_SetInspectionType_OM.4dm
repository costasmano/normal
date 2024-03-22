//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/03/06, 12:29:41
	// ----------------------------------------------------
	// Method: CIR_SetInspectionType_OM
	// Description
	// Set the inspection type of a record in [Cons Inspection] table.
	// Called from objects in [Cons Inspection];"Cslt Insp In" input form.
	
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 

C_TEXT:C284($sRoutine; $sSM; $sFC; $sMec; $sElec; $sTesting)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($sTemp)  // Command Replaced was o_C_STRING length was 100

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		[Cons Inspection:64]InspType:33:=""
		If (chkRoutine=1)
			$sRoutine:="Routine, "
		Else 
			$sRoutine:=""
		End if 
		
		If (chkSM=1)
			$sSM:="Special Member, "
		Else 
			$sSM:=""
		End if 
		
		If (chkFC=1)
			$sFC:="Fracture Critical, "
		Else 
			$sFC:=""
		End if 
		
		If (chkMec=1)
			$sMec:="Mechanical, "
		Else 
			$sMec:=""
		End if 
		
		If (chkElec=1)
			$sElec:="Electrical, "
		Else 
			$sElec:=""
		End if 
		
		If (chkTesting=1)
			$sTesting:="Testing"
		Else 
			$sTesting:=""
		End if 
		
		CIR_SetReceiveLabels
		
		$sTemp:=$sRoutine+$sSM+$sFC+$sMec+$sElec+$sTesting
		If (Substring:C12($sTemp; Length:C16($sTemp)-1; 2)=", ")
			$sTemp:=Substring:C12($sTemp; 1; Length:C16($sTemp)-2)
		End if 
		
		[Cons Inspection:64]InspType:33:=$sTemp
		PushChange(1; ->[Cons Inspection:64]InspType:33)
End case 