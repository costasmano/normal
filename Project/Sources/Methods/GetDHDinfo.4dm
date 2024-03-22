//%attributes = {"invisible":true}
//GetDHDinfo 
// fill variables vDHDnitial vDHDphone;vDHDsuffix;vDistrictLocation vDHDname;vDistrAddress_txt;vDistrTel_txt;vDistrictNo_txt;vDHDActing_txt;vDHDEmail_txt;vDHD_FILastName_txt
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/29/2006 16:06:19)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(2/27/2007 11:18:29)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(12/8/08 22:05:18)
	Mods_2008_CM_5404
	//Added vDistrictNo_txt variable
	// Modified by: costasmanousakis-(Designer)-(8/23/10 12:06:47)
	Mods_2010_08
	//  `Added District 6
	// Modified by: Costas Manousakis-(Designer)-(4/10/12 13:09:40)
	Mods_2012_04
	//  `Use method GRP_GetGroupMembInfo
	// Modified by: Costas Manousakis-(Designer)-(1/12/17 09:23:24)
	Mods_2017_01
	//  `added vDHD_FILastName_txt
End if 

C_TEXT:C284($1; $sDistrict)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vDHDnitial)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284(vDHDphone; vDHDsuffix; vDistrictLocation)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vDHDname; vDistrAddress_txt; vDistrTel_txt; vDistrictNo_txt; vDHDActing_txt; vDHDEmail_txt; vDHD_FILastName_txt)
C_TEXT:C284($dummy_txt)
$sDistrict:=$1
vDHDname:=""
vDHDinitial:=""
vDHDsuffix:=""
vDHDphone:=""
vDHDActing_txt:=""
vDHD_FILastName_txt:=""
vDistrAddress_txt:="ENTER_DISTR_ADDRESS"
vDistrTel_txt:="ENTER_DISTR_PHONE"
Case of 
	: ($sDistrict="1")
		vDistrictLocation:="Lenox"
		vDistrictNo_txt:="One"
		
	: ($sDistrict="2")
		vDistrictLocation:="Northampton"
		vDistrictNo_txt:="Two"
		
	: ($sDistrict="3")
		vDistrictLocation:="Worcester"
		vDistrictNo_txt:="Three"
		
	: ($sDistrict="4")
		vDistrictLocation:="Arlington"
		vDistrictNo_txt:="Four"
		
	: ($sDistrict="5")
		vDistrictLocation:="Taunton"
		vDistrictNo_txt:="Five"
		
	: ($sDistrict="6")
		vDistrictLocation:="Chelsea"
		vDistrictNo_txt:="Six"
		
	Else 
		vDistrictLocation:="?????"
		vDistrictNo_txt:="???"
		
End case 

C_LONGINT:C283($PersID_L)
$PersID_L:=GRP_GetGroupMembInfo(("DHD_D"+$sDistrict); ->vDHDname; ->vDHDinitial; ->vDHDsuffix; ->vDHDphone; ->vDHDEmail_txt; ->vDHDActing_txt; ->$dummy_txt; ->vDHD_FILastName_txt)
C_BOOLEAN:C305($ReadOnly_b)
$ReadOnly_b:=Read only state:C362([Town Address:78])
READ ONLY:C145([Town Address:78])
QUERY:C277([Town Address:78]; [Town Address:78]OfficialTownName:4="District "+$sDistrict)
If (Records in selection:C76([Town Address:78])>0)
	FIRST RECORD:C50([Town Address:78])
	vDistrAddress_txt:=[Town Address:78]Street:5+", "+[Town Address:78]TownName:2+", MA "+[Town Address:78]Zip:7
	vDistrTel_txt:=[Town Address:78]ContactPhone:13
	vDistrictLocation:=[Town Address:78]TownName:2
End if 
If (Not:C34($ReadOnly_b))
	READ WRITE:C146([Town Address:78])
End if 