//%attributes = {"invisible":true}
//Method: NTI_GroupSuffix
//Description
// set the suffix to be used in searching in personnel groups
// Parameters
// $0 : $Suffix_txt
// $1 : $InspRespField_txt
// $2 : $DistrField_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/11/17, 14:45:55
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
	
	C_TEXT:C284(NTI_GroupSuffix; $0)
	C_TEXT:C284(NTI_GroupSuffix; $1)
	C_TEXT:C284(NTI_GroupSuffix; $2)
	
End if 
//
C_TEXT:C284($0; $1; $2)
C_TEXT:C284($Suffix_txt; $InspRespField_txt; $DistrField_txt)
If (Count parameters:C259>0)
	$InspRespField_txt:=$1
Else 
	$InspRespField_txt:=[NTI_TunnelInfo:181]NTI_InspResp:73
End if 
If (Count parameters:C259>1)
	$DistrField_txt:=$2
Else 
	$DistrField_txt:=[NTI_TunnelInfo:181]NTI_i6_s:11
End if 
Case of 
	: ($InspRespField_txt="DIST@")
		//one of the districts
		$Suffix_txt:=Replace string:C233($InspRespField_txt; "IST"; "")
	: ($InspRespField_txt#"")
		$Suffix_txt:=$InspRespField_txt
	Else 
		$Suffix_txt:="D"+Substring:C12($DistrField_txt; 2)
		
End case 

$0:=$Suffix_txt
//End NTI_GroupSuffix