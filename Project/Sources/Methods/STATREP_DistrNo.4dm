//%attributes = {"invisible":true}
// Method: STATREP_DistrNo
// Description
// Get the district number based either on Item 2 or BDEPT
// 
// Parameters
// $0 : $Distr_i 
// $1 : $Item2_txt
// $2 : $Item8_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/19/09, 20:38:19
	// ----------------------------------------------------
	
	Mods_2009_10("MASSDOT")
	// Modified by: costasmanousakis-(Designer)-(6/16/10 11:19:56)
	Mods_2010_06
	//  `Use the array ◊D6Towns_atxt to check if it is Distr 6.
	// Modified by: costasmanousakis-(Designer)-(8/4/10 16:57:45)
	Mods_2010_08
	//  `changed STATREP_DistrictMethod_b to STATREP_DistrictMethod_L
	//  `0 : false - previous default - uses 1st param Item2
	//  `1 : true - previous uses BDEPT and D6Towns array
	//  `2 : use BDEPT and get info from the [Town Data]District field
	//  `3 : use BDEPT and get info from the [Town Data]OldDistrictNo3 field. If it is blank use [Town Data]District
	// Modified by: costasmanousakis-(Designer)-(7/1/11 14:14:46)
	Mods_2011_06
	//  `Added option 4 to move somerville back to d6 for comparison purposes
	
End if 
C_LONGINT:C283($0; $Distr_i)  //Command Replaced was o_C_INTEGER
$Distr_i:=0
C_TEXT:C284($1; $2; $Item2_txt; $Item8_txt; $BdeptPrefix_txt; $TwnDis_txt)
$Item2_txt:=$1
$Item8_txt:=$2
$BdeptPrefix_txt:=Substring:C12($Item8_txt; 1; 3)
C_LONGINT:C283($TwnLoc_L)
C_LONGINT:C283(STATREP_DistrictMethod_L)
$TwnLoc_L:=Find in array:C230(<>aBDEPT; $BdeptPrefix_txt)
Case of 
	: (STATREP_DistrictMethod_L=0)
		$Distr_i:=Num:C11($Item2_txt)
		
	: (STATREP_DistrictMethod_L=1)
		$Distr_i:=Num:C11(<>aDistrict{$TwnLoc_L})
		If (Find in array:C230(<>D6Towns_atxt; <>aTownName{$TwnLoc_L})>0)
			$Distr_i:=6
		Else 
			
		End if 
		
	: (STATREP_DistrictMethod_L=2)  //It is the new 6 District arrangement
		$Distr_i:=Num:C11(<>aDistrict{$TwnLoc_L})
		
	: (STATREP_DistrictMethod_L=3)  //Get the OldDistrictNo3 info - back to 5 Districts
		$Distr_i:=Num:C11(<>aOldDist3{$TwnLoc_L})
		If ($Distr_i=0)
			$Distr_i:=Num:C11(<>aDistrict{$TwnLoc_L})
		End if 
		
	: (STATREP_DistrictMethod_L=4)  //For After Somerville went back to District 4
		$Distr_i:=Num:C11(<>aDistrict{$TwnLoc_L})
		If ($BdeptPrefix_txt="S17")  //Move Somerville back to D6
			$Distr_i:=6
		End if 
		
End case 

$0:=$Distr_i