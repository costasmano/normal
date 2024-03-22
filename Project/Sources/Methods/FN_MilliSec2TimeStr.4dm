//%attributes = {"invisible":true}
//Method: FN_MilliSec2TimeStr
//Description
// convert milliseconds to a time string xd xh xm x.xxxs
// Parameters
// $0 : $timestr_txt
// $1 : $DT_L (milliseconds)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/23/17, 14:40:57
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
	
	C_TEXT:C284(FN_MilliSec2TimeStr; $0)
	C_LONGINT:C283(FN_MilliSec2TimeStr; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 09:40:28)
	Mods_2017_10
	//  `round seconds to 1 dec
	// Modified by: Costas Manousakis-(Designer)-(3/15/19 14:46:13)
	Mods_2019_03_bug
	//  `show less detail depending on the length of time
End if 
//

C_TEXT:C284($0)
C_LONGINT:C283($1)

C_TEXT:C284($TimeStr_txt)
$TimeStr_txt:=""
C_LONGINT:C283($Dt_L)
$Dt_L:=$1

C_REAL:C285($deCsec_r)
C_LONGINT:C283($Min_L; $hrs_L; $days_L)

$deCsec_r:=$dt_L/1000
$Min_L:=$deCsec_r\60
$deCsec_r:=$deCsec_r-($Min_L*60)
$hrs_L:=$Min_L\60
$Min_L:=$Min_L-($hrs_L*60)
$days_L:=$hrs_L\24
$hrs_L:=$hrs_L-($days_L*24)
C_TEXT:C284($TimeStr_txt)

Case of 
	: ($days_L>0)
		$TimeStr_txt:=String:C10($days_L; "###,###,###d ;;")+String:C10($hrs_L; "##h ;;")+String:C10($Min_L; "##m ;;")
	: ($hrs_L>0)
		$TimeStr_txt:=String:C10($hrs_L; "##h ;;")+String:C10($Min_L; "##m ;;")
	: ($Min_L>0)
		$TimeStr_txt:=String:C10($Min_L; "##m ;;")+String:C10(Round:C94(Round:C94($deCsec_r; 0); 1); "##s;;")
	Else 
		$TimeStr_txt:=String:C10($days_L; "###,###,###d ;;")+String:C10($hrs_L; "##h ;;")+String:C10($Min_L; "##m ;;")+String:C10(Round:C94($deCsec_r; 1); "###.###s;;")
		
End case 

$0:=$TimeStr_txt
//End FN_MilliSec2TimeStr