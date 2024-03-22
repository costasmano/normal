//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: Method: TEST_NetUtilTests
// Description
// 
// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/11, 14:00:25
	// First Release
	Mods_2011_12
End if 

If (False:C215)
	//`  TELNET Tests
	C_TEXT:C284($syscmd_txt; $incmd_txt; $outCmd_txt; $errmsg_txt; $Addr_txt)
	$Addr_txt:=Request:C163("enter SMTP"; "itd-smtp-dmz.state.ma.us")
	$syscmd_txt:="telnet "+$Addr_txt+" 25"
	$incmd_txt:=Char:C90(13)+Char:C90(10)+"HELLO state.ma.us"+Char:C90(13)+Char:C90(10)
	LAUNCH EXTERNAL PROCESS:C811($syscmd_txt; $incmd_txt; $outCmd_txt; $errmsg_txt)
	$incmd_txt:="Input :"+Char:C90(13)+$incmd_txt
	$incmd_txt:=$incmd_txt+"-----"+Char:C90(13)+"Output:"+Char:C90(13)+$outCmd_txt
	$incmd_txt:=$incmd_txt+"-----"+Char:C90(13)+"Error:"+Char:C90(13)+$errmsg_txt
	
	ut_MessageDia($incmd_txt; "Telnet Output")
	
End if 