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
	
	// Modified by: Costas Manousakis-(Designer)-(2024-04-05 13:34:38)
	Mods_2024_04
	//  `use collection to combine the types
	//  `account for the new checkboxes for inspection types
	
End if 

C_TEXT:C284($sRoutine; $sSM; $sFC; $sMec; $sElec; $sTesting)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($sTemp)  // Command Replaced was o_C_STRING length was 100
C_POINTER:C301($init_ptr; $frz_ptr; $damage_ptr)
$init_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE chkinitial")
$frz_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE chkfrz")
$damage_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE chkdamage")

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		[Cons Inspection:64]InspType:33:=""
		C_COLLECTION:C1488($insptype_c)
		$insptype_c:=New collection:C1472
		If ($init_ptr->=1)
			$insptype_c.push("Initial")
		End if 
		If (chkRoutine=1)
			$insptype_c.push("Routine")
		End if 
		
		If (chkSM=1)
			$insptype_c.push("Special Member")
			
		End if 
		
		If (chkFC=1)
			$insptype_c.push("Fracture Critical")
			
		End if 
		
		If ($frz_ptr->=1)
			$insptype_c.push("Freeze Thaw")
		End if 
		If ($damage_ptr->=1)
			$insptype_c.push("Damage")
		End if 
		
		If (chkMec=1)
			$insptype_c.push("Mechanical")
		End if 
		
		If (chkElec=1)
			$insptype_c.push("Electrical")
		End if 
		
		If (chkTesting=1)
			$insptype_c.push("Testing")
		End if 
		
		CIR_SetReceiveLabels
		
		[Cons Inspection:64]InspType:33:=$insptype_c.join(", ")
		PushChange(1; ->[Cons Inspection:64]InspType:33)
End case 