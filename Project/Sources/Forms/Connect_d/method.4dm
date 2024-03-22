
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/02/14, 13:54:01
//----------------------------------------------------
//Method: "Connect_d"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2022-11-21 17:56:41)
	Mods_2022_11
	//  `changed IP address retrieve from system parameter CLONE_SERVERIP default "146.243.128.4:19812"
End if 
If (Form event code:C388=On Load:K2:1)
	OBJECT SET FONT:C164(Password_txt; "%Password")
	clone_IPAddress_txt:=ut_GetSysParameter("CLONE_SERVERIP"; "146.243.128.4:19812"; "VALUE")
End if 
//End Connect_d

