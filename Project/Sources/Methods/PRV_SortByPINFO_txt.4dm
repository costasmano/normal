//%attributes = {"invisible":true}
//Method: PRV_SortByPINFO_txt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/23/13, 13:56:57
	// ----------------------------------------------------
	//Created : 
	Mods_2013_09
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
	
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($DoRelatePINFO_b)
$DoRelatePINFO_b:=True:C214
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	$DoRelatePINFO_b:=$2
End if 

If ($DoRelatePINFO_b)
	PRV_Variables("RELATEPINFO")
End if 

Case of 
	: ($1="PROJDESC")
		$0:=PRV_ProjDescr_txt
		
	: ($1="PROJMGR")
		$0:=PRV_ProjMgr_txt
		
	: ($1="PROJCONS")
		Case of 
			: ([Contract_Assignment_Maintenance:101]DesignerDesignation_s:76="District In-House@")
				$0:="District In-House"+" "+[Contract_Assignment_Maintenance:101]DistrictPM_s:77
			: ([Contract_Assignment_Maintenance:101]DesignerDesignation_s:76="Boston In-House@")
				$0:="Boston In-House"
			Else 
				$0:=PRV_Consultant_txt  //or Distr in-house +PM , or Boston in-house"
		End case 
		
	: ($1="PROJONOFF")
		$0:=PRV_OnOff_txt
		
	: ($1="PRESREVIEWER")
		C_TEXT:C284($phone_txt; $fullName_txt)
		$fullName_txt:=""
		PERS_GetInfo([Contract_Assignment_Maintenance:101]ProjectManagerID_L:39; "FULLNAME"; ->$fullName_txt; "PHONE"; ->$phone_txt)
		If ($phone_txt#"")
			$fullName_txt:=$fullName_txt+" ("+$phone_txt+")"
		End if 
		$0:=$fullName_txt
		
End case 

//End PRV_SortByPINFO_txt