//%attributes = {"invisible":true}
//Method: Bridge_CopyBinRequest
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/25/19, 15:09:53
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//

C_TEXT:C284($Volume_txt; $MountStatus_txt; $Path_txt; $ServerIP_txt; $VolumeTo_txt)
If (Folder separator:K24:12=":")
	$VolumeTo_txt:=ut_GetSysParameter("M_SharedData"; "MHD-SHARED.massdot.trans.internal/shareddata")
Else 
	$VolumeTo_txt:=ut_GetSysParameter("W_SharedData"; "MHD-Shared.massdot.trans.internal\\SharedData")
End if 
If (Folder separator:K24:12=":")
	
	$Volume_txt:=ut_ReturnMountIfMounted("shareddata")
Else 
	$Volume_txt:=ut_ReturnMountIfMounted("MHD-Shared\\shareddata")
End if 
$MountStatus_txt:="Success"
C_TEXT:C284($VolumeToCheck_txt)

If ($Volume_txt="Not Mounted!")
	If (Folder separator:K24:12=":")
		$MountStatus_txt:=ut_MountVolume($VolumeTo_txt; ""; "")
		$VolumeToCheck_txt:="shareddata"
	Else 
		$MountStatus_txt:=ut_MountVolume($VolumeTo_txt; ""; ""; "S")
		$VolumeToCheck_txt:="MHD-Shared\\shareddata"
	End if 
	$Volume_txt:=ut_ReturnMountIfMounted($VolumeToCheck_txt)
	
End if 
If ($MountStatus_txt="Success") & ($Volume_txt#"Not Mounted!")
	
	C_LONGINT:C283($Width_l; $Height_L)
	FORM GET PROPERTIES:C674("BinRequestDisplayandMove"; $Width_l; $Height_L)
	
	ut_OpenNewWindow(670; $Height_L; 0; Plain form window:K39:10; "Move/Copy BIN Request"; "ut_CloseCancel")
	DIALOG:C40("BinRequestDisplayandMove")
	
Else 
	
	ALERT:C41($MountStatus_txt)
End if 

//End Bridge_CopyBinRequest