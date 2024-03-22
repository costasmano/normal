//%attributes = {"invisible":true}
//Method: LSS_ErrorMethod
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): Chuck Miller
	//Date and time: 06/21/17, 12:42:35
	//----------------------------------------------------
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 12:42:37)
	// Modified by: Costas Manousakis-(Designer)-(2022-05-02 16:55:36)
	Mods_2022_05
	//  `Use system parameter LSS_ErrorFooter for the text to append at the end of the message.
	// Modified by: Costas Manousakis-(Designer)-(2023-06-15 13:43:16)
	Mods_2023_06_bug
	//  `Added Error method, line number and Error formula to the message
End if 

ARRAY LONGINT:C221($lssErrorNumbers_al; 0)
ARRAY TEXT:C222($lss_InternalCodes_atxt; 0)
ARRAY TEXT:C222($lss_InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015($lssErrorNumbers_al; $lss_InternalCodes_atxt; $lss_InternalDescriptions_atxt)
C_TEXT:C284($Message_txt)
C_LONGINT:C283($Loop_L)
$Message_txt:="The following errors occured in method "+Error method+" at line number "+String:C10(Error line)+"."+Char:C90(Carriage return:K15:38)

If (Error formula#"")
	$Message_txt:=$Message_txt+"Code :\n"+Error formula+"\n"
End if 

For ($Loop_L; 1; Size of array:C274($lssErrorNumbers_al))
	$Message_txt:=$Message_txt+$lss_InternalDescriptions_atxt{$Loop_L}+" - Error code :"+String:C10($lssErrorNumbers_al{$Loop_L})+Char:C90(Carriage return:K15:38)
End for 
$Message_txt:=$Message_txt+"Any changes made after the last Save action will be lost."+Char:C90(Carriage return:K15:38)

$Message_txt:=$Message_txt+ut_GetSysParameter("LSS_ErrorFooter"; \
"Please copy the contents of this message and email to costas.manousakis@dot.state.ma.us")
LSS_DuplicateRecordError_B:=False:C215
LSS_Error_B:=True:C214

If (Find in array:C230($lssErrorNumbers_al; -9998)>0)
	LSS_DuplicateRecordError_B:=True:C214
End if 
ut_BigAlert($Message_txt)

//End LSS_ErrorMethod

