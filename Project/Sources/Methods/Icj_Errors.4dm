//%attributes = {"invisible":true}
// IcJ_Errors method for Informed Cron4D™
//copyright 2013 Informed Solutions, Inc. All rights reserved.
TRACE:C157
ARRAY LONGINT:C221(IcJ_ErrorNumbers_al; 0)
ARRAY TEXT:C222(IcJ_InternalCodes_as; 0)  //Command Replaced was o_ARRAY string length was 255
ARRAY TEXT:C222(IcJ_InternalDescriptions_as; 0)  //Command Replaced was o_ARRAY string length was 255
GET LAST ERROR STACK:C1015(IcJ_ErrorNumbers_al; IcJ_InternalCodes_as; IcJ_InternalDescriptions_as)
IcJ_Error_b:=True:C214