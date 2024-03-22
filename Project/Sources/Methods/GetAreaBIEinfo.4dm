//%attributes = {"invisible":true}
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 14:42:56)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(8/29/2006 12:43:24)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(9/26/11 15:29:27)
	Mods_2011_09
	//  `Generate new variable AreaBIEDistricts_txt, use GRP_GetGroupMembInfo to determine Area Engineer info
End if 

C_TEXT:C284($1; $sDistrict)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vAreaBIEname)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vAreaBIEinitial)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(AreaBIEDistricts_txt)

$sDistrict:=$1
AreaBIEDistricts_txt:=""
//` In the future, change code to retrieve value from Personnel table
//` as of 11/2003, no way to distinguish between two different area BIEs

If (($sDistrict="1") | ($sDistrict="2") | ($sDistrict="5"))
	vAreaBIEname:="Bruce J. Sylvia"
	vAreaBIEinitial:="BJS"
Else 
	vAreaBIEname:="Gregory Krikoris, P.E."
	vAreaBIEinitial:="GK"
End if 
READ ONLY:C145([Personnel:42])
READ ONLY:C145([PERS_GroupMembers:110])
READ ONLY:C145([PERS_Groups:109])
C_LONGINT:C283($Pers_ID_L)
C_TEXT:C284($Suffix_txt)
$Pers_ID_L:=GRP_GetGroupMembInfo(("AreaEngineer D"+$sDistrict); ->vAreaBIEname; ->vAreaBIEinitial; ->$Suffix_txt)
vAreaBIEname:=vAreaBIEname+$Suffix_txt
If ($Pers_ID_L>0)
	ARRAY TEXT:C222($myDistricts_aTXT; 0)
	QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="AreaEngineer D@")
	ORDER BY:C49([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2)
	FIRST RECORD:C50([PERS_Groups:109])
	While (Not:C34(End selection:C36([PERS_Groups:109])))
		QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1; *)
		QUERY:C277([PERS_GroupMembers:110];  & ; [PERS_GroupMembers:110]PersonID_I:2=$Pers_ID_L)
		Case of 
			: ([PERS_Groups:109]PERS_Primary:4=$Pers_ID_L)
				APPEND TO ARRAY:C911($myDistricts_aTXT; Replace string:C233([PERS_Groups:109]PERS_GroupName_s:2; "AreaEngineer D"; ""))
			: (Records in selection:C76([PERS_GroupMembers:110])=1)
				APPEND TO ARRAY:C911($myDistricts_aTXT; Replace string:C233([PERS_Groups:109]PERS_GroupName_s:2; "AreaEngineer D"; ""))
		End case 
		
		NEXT RECORD:C51([PERS_Groups:109])
	End while 
	
End if 
Case of 
	: (Size of array:C274($myDistricts_aTXT)=1)
		AreaBIEDistricts_txt:=$myDistricts_aTXT{1}
	: (Size of array:C274($myDistricts_aTXT)=2)
		AreaBIEDistricts_txt:=$myDistricts_aTXT{1}+" & "+$myDistricts_aTXT{2}
	: (Size of array:C274($myDistricts_aTXT)>2)
		AreaBIEDistricts_txt:=$myDistricts_aTXT{1}
		C_LONGINT:C283($loop_L)
		For ($loop_L; 2; (Size of array:C274($myDistricts_aTXT)-1))
			AreaBIEDistricts_txt:=AreaBIEDistricts_txt+", "+$myDistricts_aTXT{$loop_L}
		End for 
		AreaBIEDistricts_txt:=AreaBIEDistricts_txt+" & "+$myDistricts_aTXT{Size of array:C274($myDistricts_aTXT)}
		
End case 