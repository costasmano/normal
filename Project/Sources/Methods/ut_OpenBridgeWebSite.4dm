//%attributes = {"invisible":true}
//Method: ut_OpenBridgeWebSite
//Description
//  ` open the browser in the Bridge Web page maps. Used in Menu "Tools" ; MenuBar #1 and #2
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/31/12, 09:21:49
	// ----------------------------------------------------
	//Created : 
	Mods_2012_01
	// Modified by: Costas Manousakis-(Designer)-(4/3/17 17:37:39)
	Mods_2017_04
	//  `instead of NET_PING use LEP command for MacOS 
	// Modified by: Costas Manousakis-(Designer)-(4/8/19 11:59:37)
	Mods_2019_04
	//  `use system parameter MADOT_WEBSITE for the web site address
End if 
//
C_LONGINT:C283($Res; $alive_L)
C_TEXT:C284($Historysite_txt)
$Historysite_txt:="mhdbms.massdot.trans.internal"
$Historysite_txt:=ut_GetSysParameter("MADOT_WEBSITE"; $Historysite_txt)
If (<>WindowsPL_b)
	C_TEXT:C284($in; $out)
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	LAUNCH EXTERNAL PROCESS:C811("ping -n 2 "+$Historysite_txt; $in; $out)
	$alive_L:=Position:C15("could not find host"; $out)
	If ($alive_L>0)
		$Res:=-1
		$alive_L:=0
	Else 
		$Res:=0
		$alive_L:=1
	End if 
	
Else 
	//$Res:=IT_GetTimeOut ($alive_L)
	//$Res:=NET_Ping ($Historysite_txt;56*"a";$alive_L;0)
	C_TEXT:C284($in; $out; $err)
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	LAUNCH EXTERNAL PROCESS:C811("ping -c 2 "+$Historysite_txt; $in; $out; $err)
	$alive_L:=Position:C15("Request timeout for icmp_seq"; $out)  //timeout - this when site is in IPv4 form
	If (($err#"") | ($alive_L>0))
		$Res:=-1
		$alive_L:=0
	Else 
		$Res:=0
		$alive_L:=1
	End if 
	
End if 

If (($alive_L=1) & ($Res=0))
	C_LONGINT:C283($Version4D_L)
	$Version4D_L:=Num:C11(Substring:C12(Application version:C493; 1; 2))
	If ($Version4D_L>8)
		OPEN URL:C673("http://"+$Historysite_txt)
	Else 
		OPEN URL:C673("http://"+$Historysite_txt; *)
	End if 
Else 
	ALERT:C41("The Bridge Web site cannot be found on the current network! The site is only ava"+"ilable inside the MA DOT network!")
End if 
//End ut_OpenBridgeWebSite