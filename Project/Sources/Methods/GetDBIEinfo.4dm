//%attributes = {"invisible":true}
//GetDBIEinfo 
// fill variables vDBIEinitial vDBIEphone;vDBIEsuffix vDBIEname vDBIEEmail;vDBIEActing_txt;vDBIE_FILastName_txt
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/29/2006 16:03:24)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(8/7/08 16:34:04)
	Mods_2008_CM_5404
	//  `Get the DBIE phone from the personnel record as a check;
	//  `Set the personnel table on read only
	// Modified by: costasmanousakis-(Designer)-(8/23/10 12:14:22)
	Mods_2010_08
	//  `Added District 6
	// Modified by: costasmanousakis-(Designer)-(12/13/10 12:26:51)
	Mods_2010_12
	//  `Call GetDistrictAddress with the optional parameter
	// Modified by: costasmanousakis-(Designer)-(9/26/11 15:30:35)
	Mods_2011_09
	//  `Use GRP_GetGroupMembInfo to determine the DBIE info
	// Modified by: Costas Manousakis-(Designer)-(1/12/17 09:27:14)
	Mods_2017_01
	//  `added vDBIE_FILastName_txt
End if 

C_TEXT:C284($1; $sDistrict)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($sDivisionNo; vDBIEinitial)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284(vDBIEphone; vDBIEsuffix)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vDBIEname)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vDBIEEmail; vDBIEActing_txt; vDBIE_FILastName_txt)
C_TEXT:C284($dummy_txt)
$sDistrict:=$1
vDBIEname:=""
vDBIEinitial:=""
vDBIEsuffix:=""
vDBIEEmail:=""
vDBIE_FILastName_txt:=""
GetDistrictAddress($sDistrict)  //get address from the district sendinf out the letter 

Case of 
	: ($sDistrict="1")
		$sDivisionNo:="0441"
		vDBIEphone:=aDBIEphone{1}
		
	: ($sDistrict="2")
		$sDivisionNo:="0442"
		vDBIEphone:=aDBIEphone{2}
		
	: ($sDistrict="3")
		$sDivisionNo:="0443"
		vDBIEphone:=aDBIEphone{3}
		
	: ($sDistrict="4")
		$sDivisionNo:="0444"
		vDBIEphone:=aDBIEphone{4}
		
	: ($sDistrict="5")
		$sDivisionNo:="0445"
		vDBIEphone:=aDBIEphone{5}
		
	: ($sDistrict="6")
		$sDivisionNo:="0446"
		vDBIEphone:="DBIE_Phone_Number"
		
	Else 
		$sDivisionNo:="0441"
		vDBIEphone:="DBIE_Phone_Number"
End case 
READ ONLY:C145([Personnel:42])
//` Job Code = 1 refers to District Bridge Inspection Engineer
QUERY:C277([Personnel:42]; [Personnel:42]Division No:7=$sDivisionNo; *)
QUERY:C277([Personnel:42];  & ; [Personnel:42]Job Code:8=1)

If (Records in selection:C76([Personnel:42])>0)
	FIRST RECORD:C50([Personnel:42])
	If ([Personnel:42]Middle Name:4="")
		vDBIEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		vDBIEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
		vDBIEsuffix:=[Personnel:42]Suffix:6
	Else 
		vDBIEname:=[Personnel:42]First Name:3+" "+Replace string:C233([Personnel:42]Middle Name:4; " "; "")+" "+[Personnel:42]Last Name:5
		vDBIEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
		vDBIEsuffix:=[Personnel:42]Suffix:6
	End if 
	vDBIEphone:=[Personnel:42]Phone_s:13  //Get the DBIE phone from the personnel record as a check
	vDBIEEmail:=[Personnel:42]EmailAddress_s:14
End if 

READ WRITE:C146([Personnel:42])

C_LONGINT:C283($PersID_L)
$PersID_L:=GRP_GetGroupMembInfo(("DistrictBIE"+$sDistrict); ->vDBIEname; ->vDBIEinitial; ->vDBIEsuffix; ->vDBIEphone; ->vDBIEEmail; ->vDBIEActing_txt; ->$dummy_txt; ->vDBIE_FILastName_txt)