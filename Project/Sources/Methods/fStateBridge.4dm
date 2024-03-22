//%attributes = {}
If (False:C215)
	//GP: fStateBridge
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//Determine if it is owned by the state and an NBIS bridge
	
	//3/23/01 : Allowed CANA bridges to be lumped with the State bridges
	// Modified by: costasmanousakis-(Designer)-(10/19/09 00:47:00)
	Mods_2009_10("MASSDOT")
	//  `Use the new DOT designation for a State bridge
End if 
C_BOOLEAN:C305($test)
C_TEXT:C284($prefix)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 12

If (Count parameters:C259=1)
	$prefix:=Substring:C12($1; 1; 3)
Else 
	//  $prefix:=Substring([Bridge MHD NBIS]Bridge Key;1;3)
	$prefix:=[Bridge MHD NBIS:1]Item8 Owner:208
End if 
C_BOOLEAN:C305(STATREP_OwnerMethod_b)
//$test:=(($prefix>="000") & ($prefix<="999"))
$test:=(($prefix="MHD") | ($prefix="CAN") | ($prefix="DOT") | (($prefix="MTA") & STATREP_OwnerMethod_b))
$0:=$test  //Return true or false