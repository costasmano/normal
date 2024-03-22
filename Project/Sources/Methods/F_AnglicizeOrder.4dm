//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/29/07, 13:29:38
	// ----------------------------------------------------
	// Method: F_AnglicizeOrder
	// Description
	// 
	// 
	// Parameters
	// $1  : $order_L (long)
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 
C_LONGINT:C283($1; $order_L)
C_TEXT:C284($0; $Res_txt)
$order_L:=$1
$Res_txt:=""
Case of 
	: ($order_L=1)
		$Res_txt:="first"
	: ($order_L=2)
		$Res_txt:="second"
	: ($order_L=3)
		$Res_txt:="third"
	: ($order_L=4)
		$Res_txt:="fourth"
	: ($order_L=5)
		$Res_txt:="fifth"
	: ($order_L=6)
		$Res_txt:="sixth"
	: ($order_L=7)
		$Res_txt:="seventh"
	: ($order_L=8)
		$Res_txt:="eighth"
	: ($order_L=9)
		$Res_txt:="ninth"
	: ($order_L=10)
		$Res_txt:="tenth"
	: ($order_L=11)
		$Res_txt:="eleventh"
	: ($order_L=12)
		$Res_txt:="twelfth"
	: ($order_L=13)
		$Res_txt:="thirteenth"
	: ($order_L=14)
		$Res_txt:="fourteenth"
	: ($order_L=15)
		$Res_txt:="fifteenth"
	: ($order_L=16)
		$Res_txt:="sixteenth"
	: ($order_L=17)
		$Res_txt:="seventeenth"
	: ($order_L=18)
		$Res_txt:="eighteenth"
	: ($order_L=19)
		$Res_txt:="nineteenth"
	: ($order_L=20)
		$Res_txt:="twentieth"
		
End case 
$0:=$Res_txt