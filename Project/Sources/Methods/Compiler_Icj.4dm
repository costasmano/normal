//%attributes = {"invisible":true}
// Compiler_ICJ method for Informed Cron4D™
//copyright 2013 Informed Solutions, Inc. All rights reserved.
ARRAY LONGINT:C221(IcJ_ErrorNumbers_al; 0)
ARRAY TEXT:C222(IcJ_InternalCodes_as; 0)  //Command Replaced was o_ARRAY string length was 255
ARRAY TEXT:C222(IcJ_InternalDescriptions_as; 0)  //Command Replaced was o_ARRAY string length was 255
C_BOOLEAN:C305(IcJ_Error_b)
If (Not:C34(Is compiled mode:C492))
	C_LONGINT:C283(IcJ_Launcher; $0)
	C_LONGINT:C283(IcJ_Launcher; $2)
	C_TEXT:C284(IcJ_Launcher; $1)  // was length of 255
	C_TEXT:C284(IcJ_Launcher; $3)  // was length of 255
	C_TEXT:C284(IcJ_Launcher; $4)  // was length of 1
End if 
