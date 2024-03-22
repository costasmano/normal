//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJNewFiscal
// User name (OS): cjmiller
// Date and time: 03/04/08, 14:22:05
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 15:52:40
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_LONGINT:C283($BegTick; $EndTick)
C_TEXT:C284($Failure_txt; $0)
$Failure_txt:=""
$BegTick:=Tickcount:C458
If (Not:C34(SQL_Direct("sp_RTRV_MMARSTotal")))
	$Failure_txt:=$Failure_txt+", "+"sp_RTRV_MMARSTotal"
End if 
$EndTick:=Tickcount:C458
MMARSTotal_l:=MMARSTotal_l+$EndTick-$BegTick

$BegTick:=Tickcount:C458
If (Not:C34(SQL_Direct("sp_RTRV_MMARSSpent")))
	
	$Failure_txt:=$Failure_txt+", "+"sp_RTRV_MMARSSpent"
End if 
$EndTick:=Tickcount:C458
MMARSSpent_l:=MMARSSpent_l+$EndTick-$BegTick
$BegTick:=Tickcount:C458

If (Not:C34(SQL_Direct("sp_RTRV_EXPSCTotal")))
	
	$Failure_txt:=$Failure_txt+", "+"sp_RTRV_EXPSCTotal"
End if 
$EndTick:=Tickcount:C458
EXPSCTotal_l:=EXPSCTotal_l+$EndTick-$BegTick
$BegTick:=Tickcount:C458

If (Not:C34(SQL_Direct("sp_RTRV_EXPSCSpent")))
	
	$Failure_txt:=$Failure_txt+", "+"sp_RTRV_EXPSCSpent"
End if 
$EndTick:=Tickcount:C458
EXPSCSpent_l:=EXPSCSpent_l+$EndTick-$BegTick

$BegTick:=Tickcount:C458

If (Not:C34(SQL_Direct("sp_RTRV_MMARSAccept")))
	
	$Failure_txt:=$Failure_txt+", "+"sp_RTRV_MMARSAccept"
End if 
$EndTick:=Tickcount:C458
MMARSAccept_l:=MMARSAccept_l+$EndTick-$BegTick
$BegTick:=Tickcount:C458

If (Not:C34(SQL_Direct("sp_RTRV_MMARSPay")))
	
	$Failure_txt:=$Failure_txt+", "+"sp_RTRV_MMARSPay"
End if 
$EndTick:=Tickcount:C458
MMARSPay_l:=MMARSPay_l+$EndTick-$BegTick
$BegTick:=Tickcount:C458

If (Not:C34(SQL_Direct("sp_RTRV_MMARSBFYAMT")))
	
	$Failure_txt:=$Failure_txt+", "+"sp_RTRV_MMARSBFYAMT"
	
End if 
$EndTick:=Tickcount:C458
MMARSBFYAMT_l:=MMARSBFYAMT_l+$EndTick-$BegTick





$0:=Substring:C12($Failure_txt; 2)

//End ut_PRJNewFiscal