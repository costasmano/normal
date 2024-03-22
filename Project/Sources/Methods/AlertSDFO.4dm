//%attributes = {"invisible":true}
//procedure: AlertSDFO
//by: Albert Leung
//purpose: display an alert dialog telling user whether bridge is SD or FO
//date: 2/19/99
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(5/23/18 13:04:00)
	Mods_2018_05
	//  `changes to use the new  FHWA definition of SD = POOR + some code clean up
	
End if 

C_TEXT:C284($sd; $fo; $message; $BrgCond_txt; $Items)  // old C_STRING length 255
C_BOOLEAN:C305($chk_sd; $chk_fo)

If (SIA_NewBridgeStatCalc)
	$BrgCond_txt:=SIA_BridgeCondRating
	C_DATE:C307($Cutoff_Date_d)
	$Cutoff_Date_d:=Date:C102(ut_GetSysParameter("NewBridgeCondStatus"; ""; "Value"))
	
	$message:="As of "+String:C10($Cutoff_Date_d; Internal date long:K1:5)+" based on FHWA Rule 23 CFR 490,  SD is defined as Poor Condition. "+\
		"Poor condition is when lowest rating of Items 58, 59, 60, or 62 is 0, 1, 2, 3, or 4.  Fair condition is 5, or 6.  Good condition is 7, 8, or 9.  FO is not applicable."
	
	Case of 
		: ($BrgCond_txt="Good@")
			$message:=$message+<>sCR+"This Bridge is in Good Condition"
			
		: ($BrgCond_txt="Fair@")
			$message:=$message+<>sCR+"This Bridge is in Fair Condition due to Item(s) "+Replace string:C233($BrgCond_txt; "Fair -"; "")+\
				" being 5 or 6."
			
		: ($BrgCond_txt="Poor@")
			$message:=$message+<>sCR+"This Bridge is in Poor (SD) Condition due to Item(s) "+Replace string:C233($BrgCond_txt; "Poor -"; "")+\
				" being 0, 1, 2, 3, or 4."
			
	End case 
	
Else 
	//Check these once
	$chk_sd:=(bDeficient & bFuncObsCheck & ([Bridge MHD NBIS:1]AASHTO:5<80))
	$chk_fo:=(bObsolete & bFuncObsCheck & ([Bridge MHD NBIS:1]AASHTO:5<80))
	If ($chk_sd=True:C214)
		$sd:="This bridge is structurally deficient!  "+<>sCR
	Else 
		$sd:="This bridge is not structurally deficient!  "+<>sCR
	End if 
	If ($chk_fo=True:C214)
		$fo:="This bridge is functionally obsolete!  "+<>sCR
	Else 
		$fo:="This bridge is not functionally obsolete!  "+<>sCR
	End if 
	$message:=$sd+$fo
End if 

ALERT:C41($message)