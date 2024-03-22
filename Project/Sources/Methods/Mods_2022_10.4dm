//%attributes = {"invisible":true}
//Method: Mods_2022_10
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	// ----------------------------------------------------
	
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2022-10-05)
//Method: SysDoc_FindShare
//Description
// method used to find a share from a collection of mounted shares
// ex  $mountedShare_o:=$shares_c.find("SysDoc_FindShare";$share)
// Parameters
// $1 : $object
// $2 : $Sharename to look for

//Method: SysDoc_GetAvailDriveLetter
//Description
// return the last available drive letter for windows excluding the ":" -Windows only
// Parameters
// $0 : $driveLetter

//Method: SysDoc_GetMountedShares
//Description
// Get the currently mounted shares with share name and corresponding Volume name
// uses output from mount command on MacOS or Net Use on Windows
// Parameters
// $0 : $MountedShares_c : collection of objects 
//    .Username - applicable only on macOS
//    .ShareName - share name
//    .VolumeName - volume name or drive letter on windows

//Method: SysDoc_IsShareMounted
//Description
// find if a share is mounted and return an object with info
// uses info provided from SysDoc_GetMountedShares
// Parameters
// $0 : $shareinfo_o
// $1 : $share

// ut_isSharedFolderMounted
//  `use new methods  SysDoc_IsShareMounted, SysDoc_GetAvailDriveLetter. 
// ut_MountVolume
//  `volume list might not be accurate when shares on different servers have same name
//  `use SysDoc_IsShareMounted instead

//**********`Modified by: Costas Manousakis-(Designer)-(2022-10-19)
// [Dialogs];"About"
//  `added the data file path

//**********`Modified by: Costas Manousakis-(Designer)-(2022-10-21)
//Method: USR_AddGroupMemberships
//Description
// add to a groupmembership array groups that a group belongs to 
// Parameters
// $1 : $grpsArray_ptr
// $2 : $groupNum_L
// ----------------------------------------------------
//Method: USR_GetUserGroupMemberships
//Description
// get all group memberships for a user
// Parameters
// $0 : $memberships_c : collection with membership info
// $1 : $UserID_L
// ----------------------------------------------------

// [Standard Photos];"Standard Photos".Button
//  `show all picture types found not only the first one

//End Mods_2022_10   