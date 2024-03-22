//%attributes = {"invisible":true}
// Method: STATREP_ReportType
// Description
//  ` Return the report type of the current Status report
// 
// Parameters
// $0 : $ReportType_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/22/10, 08:16:33
	// ----------------------------------------------------
	
	Mods_2010_04
	// Modified by: costasmanousakis-(Designer)-(6/16/10 11:43:52)
	Mods_2010_06
	//  `Added the D6 report type
	// Modified by: Costas Manousakis-(Designer)-(5/18/18 16:45:49)
	Mods_2018_05
	//  `use fields in status report instead of comment field
	// Modified by: Costas Manousakis-(Designer)-(9/4/19 17:26:05)
	Mods_2019_09
	//  `adjust for the new 100, 200, 300, etc codes
End if 
C_TEXT:C284($0; $ReportType_txt)
Case of 
	: ((Position:C15("Legacy Owner Report Generated"; [Status Report:69]Comments:135)>0) & ([Status Report:69]Owner:2="Designer") & ([Status Report:69]Date_Created:1>=!2009-11-01!))
		$ReportType_txt:="Legacy"
	: ((Position:C15("Transition to 6 District "; [Status Report:69]Comments:135)>0) & ([Status Report:69]Owner:2="Designer") & ([Status Report:69]Date_Created:1>=!2009-11-01!))
		$ReportType_txt:="Mass DOT - 6 Distr."
	: ((Position:C15("Report Generated By Server"; [Status Report:69]Comments:135)>0) & ([Status Report:69]Owner:2="Designer") & ([Status Report:69]Date_Created:1<!2009-11-01!))
		$ReportType_txt:="Legacy"
	: ((Position:C15("Report Generated By Server"; [Status Report:69]Comments:135)>0) & ([Status Report:69]Owner:2="Designer") & ([Status Report:69]Date_Created:1>=!2009-11-01!))
		$ReportType_txt:="Mass DOT"
		
	Else 
		If ([Status Report:69]Date_Created:1>=!2009-11-01!)
			$ReportType_txt:="User generated - Mass DOT"
		Else 
			$ReportType_txt:="User generated - Legacy"
		End if 
		
End case 

$ReportType_txt:=""
C_LONGINT:C283($Method_L; $Category_L)
$Method_L:=[Status Report:69]DistrictMethod_L:267%100
$Category_L:=[Status Report:69]DistrictMethod_L:267\100
Case of 
	: ([Status Report:69]UseLegacyOwner_b:266 & ($Method_L=3))
		$ReportType_txt:=$ReportType_txt+"Legacy Owner - 5 Distr."
	: (Not:C34([Status Report:69]UseLegacyOwner_b:266) & ($Method_L=3))
		$ReportType_txt:=$ReportType_txt+"MADOT - Original 5 Distr."
	: (Not:C34([Status Report:69]UseLegacyOwner_b:266) & ($Method_L=2))
		$ReportType_txt:=$ReportType_txt+"MADOT - 6 Distr."
	: (Not:C34([Status Report:69]UseLegacyOwner_b:266) & ($Method_L=4))
		$ReportType_txt:=$ReportType_txt+"MADOT - 6 Distr. (Somerville in D6)"
		
End case 

$ReportType_txt:=$ReportType_txt+" "+STATREP_BridgesSelected($Category_L)

$ReportType_txt:=$ReportType_txt+Choose:C955([Status Report:69]SD_Calc_New_b:265; " - New SD Calc"; " - Old SD Calc")

$0:=$ReportType_txt