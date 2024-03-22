//%attributes = {"invisible":true}
// Method: GetDistrictAddress
// Description
// get town information for letter footer defines variables
//  vDistrictAddress_TXT;vDistrictTEL_TXT;vDistrictFAX_TXT
// 
// Parameters
// $1 : $Distr_optional or uses variable vDistrict
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): bridgesection
	// Date and time: 10/08/09, 09:36:06
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(12/13/10 12:27:24)
	Mods_2010_12
	//  `Added optional parameter $1 for the district
	Mods_2011_06  //r002 CJ Miller`06/03/11, 16:11:27      `Make vDistrict alpha 2
End if 
C_TEXT:C284(vDistrictAddress_TXT; vDistrictTEL_TXT; vDistrictFAX_TXT)
C_TEXT:C284(vDistrict)  // Command Replaced was o_C_STRING length was 2
If (Count parameters:C259>0)
	C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 2
	vDistrict:=$1
End if 

QUERY:C277([Town Address:78]; [Town Address:78]OfficialTownName:4="District "+vdistrict)
Vdistrictaddress_txt:=([Town Address:78]Street:5+", "+[Town Address:78]TownName:2+", "+[Town Address:78]State:6+" "+[Town Address:78]Zip:7)
vdistrictTel_txt:=([Town Address:78]ContactPhone:13)
vdistrictFax_txt:=([Town Address:78]ContactFax:14)