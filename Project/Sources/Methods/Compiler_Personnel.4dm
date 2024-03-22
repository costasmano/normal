//%attributes = {"invisible":true}
//Method: Compiler_Personnel
//Description
// for methods / vars accessing the personnel table
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/11/17, 17:40:09
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
	Mods_2018_04  //add groups person is member of
End if 
//
C_TEXT:C284(vDBEEmail; vDBEActing_txt; vDBEname; vDBEphone; vDBEsuffix; vDBEinitial; vDBECellPhone_txt; vDBE_FILastName_txt)
C_TEXT:C284(vAreaBIEname)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vAreaBIEinitial)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(AreaBIEDistricts_txt)
C_TEXT:C284(vBIEname)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vBIEsuffix; vBIEphone; vBIEinitial; vBIEActing)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vBIEEmail_txt; vBIE_FILastName_txt)
C_TEXT:C284(vBridgeEngineer)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vBEname; $vBEsuffix; vBEinitial; vBEActing)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vBEphone_txt; vBEEmail_txt; vBE_FILastName_txt)
C_TEXT:C284(vChiefEngineer)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vCEname; vCEsuffix; vCEinitial; vCEActing)  // Command Replaced was o_C_STRING length was 70
C_TEXT:C284(vCEphone_txt; vCEEmail_txt; vCE_FILastName_txt)
C_TEXT:C284(vDBIEinitial)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284(vDBIEphone; vDBIEsuffix)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vDBIEname)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vDBIEEmail; vDBIEActing_txt; vDBIE_FILastName_txt)
C_TEXT:C284(vDHDnitial)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284(vDHDphone; vDHDsuffix; vDistrictLocation)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vDHDname; vDistrAddress_txt; vDistrTel_txt; vDistrictNo_txt; vDHDActing_txt; vDHDEmail_txt; vDHD_FILastName_txt)
C_TEXT:C284(vUOEinitial)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284(vUOEphone; vUOEsuffix)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vUOEname)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vUOEEmail; vUOEActing)
C_TEXT:C284(vROEngineer; vROEngrName; $vEOEngrsuffix; vROEngrInitials; vROEngrActing; vROEngrEmail; vROEngrPhone)
C_TEXT:C284(vDBEEmail; vDBEActing_txt; vDBEname; vDBEphone; vDBEsuffix; vDBEinitial; vDBECellPhone_txt; vDBE_FILastName_txt)
C_LONGINT:C283(MAKEACTING_L)
C_LONGINT:C283(MAKEPRIMARY_L)
If (False:C215)
	//GRP_GETGROUPMEMBINFO
	C_LONGINT:C283(GRP_GetGroupMembInfo; $0)
	C_TEXT:C284(GRP_GetGroupMembInfo; $1)
	C_POINTER:C301(GRP_GetGroupMembInfo; $2)
	C_POINTER:C301(GRP_GetGroupMembInfo; $3)
	C_POINTER:C301(GRP_GetGroupMembInfo; $4)
	C_POINTER:C301(GRP_GetGroupMembInfo; $5)
	C_POINTER:C301(GRP_GetGroupMembInfo; $6)
	C_POINTER:C301(GRP_GetGroupMembInfo; $7)
	C_POINTER:C301(GRP_GetGroupMembInfo; $8)
	C_POINTER:C301(GRP_GetGroupMembInfo; $9)
	C_TEXT:C284(GetDBEInfo; $1)  // was length of 1
	C_TEXT:C284(GetAreaBIEinfo; $1)  // was length of 1
	C_POINTER:C301(GetDBIEccInfo; $1)
	C_TEXT:C284(GetDBIEinfo; $1)  // was length of 1
	C_TEXT:C284(GetDHDinfo; $1)  // was length of 1
	C_TEXT:C284(F_GetUserInitial; $0)  // was length of 5
	C_TEXT:C284(F_GetUserInitial; $1)  // was length of 100
	C_TEXT:C284(GetDistrictAddress; $1)  // was length of 2
	C_TEXT:C284(FN_LastNameFirst; $0)
	C_TEXT:C284(FN_LastNameFirst; $1)
	C_POINTER:C301(PERS_GetInfo; ${-1})
	C_LONGINT:C283(PERS_GetInfo; $1)
	C_TEXT:C284(PERS_GetInfo; $2)
	C_POINTER:C301(PERS_GetInfo; $3)
	C_TEXT:C284(PERS_GetInfo; $4)
	C_POINTER:C301(PERS_GetInfo; $5)
	C_TEXT:C284(PERS_GetInfo; $6)
	C_POINTER:C301(PERS_GetInfo; $7)
	C_TEXT:C284(PERS_GetInfo; $8)
	C_POINTER:C301(PERS_GetInfo; $9)
	C_TEXT:C284(PERS_GetInfo; $10)
	C_POINTER:C301(PERS_GetInfo; $11)
	C_TEXT:C284(PERS_GetInfo; $12)
	C_POINTER:C301(PERS_GetInfo; $13)
	C_TEXT:C284(PERS_GetInfo; $14)
	C_POINTER:C301(PERS_GetInfo; $15)
	C_LONGINT:C283(GRP_GetGroupRepID; $0)
	C_TEXT:C284(GRP_GetGroupRepID; $1)
	C_LONGINT:C283(PERS_GetMyInfo; $1)
	C_TEXT:C284(PERS_EditGroups; $1)
	C_TEXT:C284(GRP_Primary_Acting; $1)
	C_TEXT:C284(GRP_EditGroup; $1)
	C_BOOLEAN:C305(GRP_EditGroup; $2)
	C_LONGINT:C283(GRP_UserInGroup; $0)
	C_TEXT:C284(GRP_UserInGroup; $1)
	C_LONGINT:C283(GRP_UserInGroup; $2)
	C_LONGINT:C283(GRP_UserInGroupList; $0)
	C_POINTER:C301(GRP_UserInGroupList; $1)
	C_LONGINT:C283(GRP_UserInGroupList; $2)  //Command Replaced was o_C_INTEGER
	C_TEXT:C284(Pers_Get4DUName; $0)
	C_LONGINT:C283(Pers_Get4DUName; $1)
	C_TEXT:C284(Pers_GetNames; $0)
	C_POINTER:C301(Pers_GetNames; $1)
	C_LONGINT:C283(GRP_4DUIDinGroup; $0)
	C_LONGINT:C283(GRP_4DUIDinGroup; $1)
	C_TEXT:C284(GRP_4DUIDinGroup; $2)
	C_TEXT:C284(GRP_GetMembersOfGrps; ${4})
	C_POINTER:C301(GRP_GetMembersOfGrps; $1)
	C_POINTER:C301(GRP_GetMembersOfGrps; $2)
	C_TEXT:C284(GRP_GetMembersOfGrps; $3)
	
	C_OBJECT:C1216(PERS_ConvertStatsToObj; $0)
	C_TEXT:C284(PERS_ConvertStatsToObj; $1)
	
	C_OBJECT:C1216(GRP_GetPersonGroups; $1)
	
	C_DATE:C307(PERS_GetLastLoginDate; $0)
	C_LONGINT:C283(PERS_GetLastLoginDate; $1)
	
	C_TEXT:C284(PERS_GetName; $0)
	C_LONGINT:C283(PERS_GetName; $1)
	C_TEXT:C284(PERS_GetName; $2)
	
	C_COLLECTION:C1488(PERS_ExpandGroups; $1)  //collection  of PERS_Group IDs
	
	C_LONGINT:C283(PERS_ManagePersonGrps; $1)
	
	C_COLLECTION:C1488(UseCselected; OmitCselected)
End if 
ARRAY TEXT:C222(4DGroups_atxt; 0)
ARRAY TEXT:C222(4DPersonnelGroups_atxt; 0)
//End Compiler_Personnel
