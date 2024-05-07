//%attributes = {"invisible":true}
// Method: CIR_SetReceiveLabels
// Description
// Set the "Inspection Received ()" labels in page 1 of the[Cons Inspection] input form
// based on the inspection type checkboxes.
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/03/06, 13:00:41
	// ----------------------------------------------------
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(2024-04-05 13:29:28)
	Mods_2024_04
	//  `use collections to compile the strings
	//  `account for the new checkboxes for inspection types
	
End if 
C_TEXT:C284(vInspRecvd1)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vInspRecvd2)  // Command Replaced was o_C_STRING length was 50
vInspRecvd1:="Inspection received ()"
vInspRecvd2:="Inspection received ()"
C_TEXT:C284($InspRcvdString1)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284($InspRcvdString2)  // Command Replaced was o_C_STRING length was 10

C_POINTER:C301($init_ptr; $frz_ptr; $damage_ptr)
$init_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE chkinitial")
$frz_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE chkfrz")
$damage_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE chkdamage")

C_COLLECTION:C1488($rcvdstr1_c; $rcvdstr2_c)
$rcvdstr1_c:=New collection:C1472
$rcvdstr2_c:=New collection:C1472
If ($init_ptr->=1)
	
	$rcvdstr1_c.push("I")
End if 

If (chkroutine=1)
	$rcvdstr1_c.push("R")
End if 

If (chkSM=1)
	$rcvdstr1_c.push("SM")
End if 

If (chkFC=1)
	
	$rcvdstr1_c.push("FC")
	
End if 
If ($frz_ptr->=1)
	
	$rcvdstr1_c.push("FZ")
	
End if 

If ($damage_ptr->=1)
	
	$rcvdstr1_c.push("D")
	
End if 

If (chkMec=1)
	OBJECT SET ENTERABLE:C238([Cons Inspection:64]InspRecvd_ME:37; True:C214)
	
	$rcvdstr2_c.push("M")
	
End if 

If (chkElec=1)
	OBJECT SET ENTERABLE:C238([Cons Inspection:64]InspRecvd_ME:37; True:C214)
	
	$rcvdstr2_c.push("E")
	
End if 

If (chkTesting=1)
	
	$rcvdstr2_c.push("T")
	
End if 

vInspRecvd1:="Inspection received ("+$rcvdstr1_c.join(", ")+")"
vInspRecvd2:="Inspection received ("+$rcvdstr2_c.join(", ")+")"
