//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:57:54
	// ----------------------------------------------------
	// Method: SC_SetScourCategory
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(3/28/2006 10:27:52)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(5/20/08 15:45:44)
	Mods_2008_CM_5403  //include 113=6,D with 113=U
End if 
C_REAL:C285($1; $RiskCost)
C_TEXT:C284($0; $Category)  // Command Replaced was o_C_STRING length was 1
$RiskCost:=$1
Case of 
	: (([Bridge MHD NBIS:1]Item113:151="U") | ([Bridge MHD NBIS:1]Item113:151="6") | ([Bridge MHD NBIS:1]Item113:151="D"))
		$Category:="D"
	: ($RiskCost>SC_CategoryBLimit_r)
		$Category:="A"
	: ($RiskCost>SC_CategoryCLimit_r)
		$Category:="B"
	: ($RiskCost>SC_CategoryDLimit_r)
		$Category:="C"
	Else 
		$Category:="D"
End case 
$0:=$Category
