//%attributes = {"invisible":true}
//Method: GetDBEInfo
//Description
//  ` get info for district bridge engineer
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/16/12, 09:16:40
	// ----------------------------------------------------
	//Created : 
	Mods_2012_03
	// Modified by: Costas Manousakis-(Designer)-(4/18/12 )
	Mods_2012_04
	//  `Added Cell phone
	// Modified by: Costas Manousakis-(Designer)-(1/12/17 09:22:59)
	Mods_2017_01
	//  `added vDBE_FILastName_txt
End if 
//
C_TEXT:C284($1; $sDistrict)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vDBEEmail; vDBEActing_txt; vDBEname; vDBEphone; vDBEsuffix; vDBEinitial; vDBECellPhone_txt; vDBE_FILastName_txt)
$sDistrict:=$1
vDBEname:=""
vDBEinitial:=""
vDBEsuffix:=""
vDBEEmail:=""
vDBEphone:=""
vDBECellPhone_txt:=""
vDBE_FILastName_txt:=""
GetDistrictAddress($sDistrict)  //get address from the district sending out the letter 

C_LONGINT:C283($PersID_L)
$PersID_L:=GRP_GetGroupMembInfo(("District Bridge Engineer "+$sDistrict); ->vDBEname; ->vDBEinitial; ->vDBEsuffix; ->vDBEphone; ->vDBEEmail; ->vDBEActing_txt; ->vDBECellPhone_txt; ->vDBE_FILastName_txt)
//End GetDBEInfo