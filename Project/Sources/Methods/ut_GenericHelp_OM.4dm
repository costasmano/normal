//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/29/11, 14:35:00
	// ----------------------------------------------------
	// Method: Method: ut_GenericHelp_OM
	// Description
	// handle the generic help message
	// must be called from the object method. the object and the form should
	// have the on mouse enter, mouse leave evens activated.
	// 
	// Parameters
	// $1 : $Hlpmsg_txt
	// ----------------------------------------------------
	
	Mods_2011_08
End if 
C_TEXT:C284($1; $Hlpmsg_txt)
C_TEXT:C284(vGenericHlpMsgVar1_S; GenericHlpMsgVar1_old_S)
Case of 
	: (Form event code:C388=On Mouse Enter:K2:33)
		C_TEXT:C284(vGenericHlpMsgVar1_S; GenericHlpMsgVar1_old_S)
		GenericHlpMsgVar1_old_S:=vGenericHlpMsgVar1_S
		If ($1="")
			vGenericHlpMsgVar1_S:=""
		Else 
			vGenericHlpMsgVar1_S:=$1
		End if 
	: (Form event code:C388=On Mouse Leave:K2:34)
		C_TEXT:C284(vGenericHlpMsgVar1_S; GenericHlpMsgVar1_old_S)
		If (GenericHlpMsgVar1_old_S#"")
			vGenericHlpMsgVar1_S:=GenericHlpMsgVar1_old_S
		End if 
		
End case 