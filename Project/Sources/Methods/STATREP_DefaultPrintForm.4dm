//%attributes = {"invisible":true}
// Method: STATREP_DefaultPrintForm
// Description
//  ` Determine the appropriate print form to be used for a bridge status report
// 
// Parameters
// $0 : $FormName_txt
// $1 : $reportType_txt
// $2 : $reportDate_D
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/07/11, 17:54:42
	// ----------------------------------------------------
	
	Mods_2011_03
	
	// Modified by: Costas Manousakis-(Designer)-(5/18/18 16:48:36)
	Mods_2018_05
	//  `for the new SD calc use "P_StatusReport_MDOT_POFA"
End if 
C_TEXT:C284($0; $FormName_txt)
$FormName_txt:=""
C_TEXT:C284($1; $reportType_txt)
C_DATE:C307($2; $reportDate_D)
$reportType_txt:=$1
$reportDate_D:=$2
Case of 
	: ($reportType_txt="@All BRI@") | ($reportType_txt="@Subset of BRI@")
		$FormName_txt:="P_BRIStatusRpt_MDOT_POFA"  //new BRI status report 
		
	: ($reportType_txt="@Legacy@")
		$FormName_txt:="P_StatusReport_HI"  //old one
	: ($reportType_txt="User generated - Legacy@")
		$FormName_txt:="P_StatusReport_HI"
	: ($reportType_txt="User generated - Mass DOT@")
		If ($reportDate_D<!2010-07-01!)
			$FormName_txt:="P_StatusReport_MDOT_5D"  //
		Else 
			$FormName_txt:="P_StatusReport_MDOT"  //
		End if 
	: ($reportType_txt="@Mass DOT - 6 Distr.@")
		$FormName_txt:="P_StatusReport_MDOT"  //default to the new one with 6districts
	: ($reportType_txt="@Mass DOT@")
		$FormName_txt:="P_StatusReport_MDOT_5D"
	Else 
		$FormName_txt:="P_StatusReport_MDOT"  //default to the new one with 6districts
End case 

If (($FormName_txt="P_StatusReport_MDOT") & [Status Report:69]SD_Calc_New_b:265)
	$FormName_txt:="P_StatusReport_MDOT_POFA"
End if 

$0:=$FormName_txt