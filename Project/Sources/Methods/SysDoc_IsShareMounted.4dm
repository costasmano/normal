//%attributes = {"invisible":true}
//Method: SysDoc_IsShareMounted
//Description
// find if a share is mounted and return an object with info
// uses info provided from SysDoc_GetMountedShares
// Parameters
// $0 : $shareinfo_o
// $1 : $share
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Oct 5, 2022, 14:20:46
	Mods_2022_10
	// ----------------------------------------------------
	C_OBJECT:C1216(SysDoc_IsShareMounted; $0)
	C_TEXT:C284(SysDoc_IsShareMounted; $1)
End if 
//
C_OBJECT:C1216($0; $mountedShare_o)
C_TEXT:C284($1; $share)
$share:=$1
//remove last char if last char is a /
If (Substring:C12($share; Length:C16($share))="/")
	$share:=Substring:C12($share; 1; (Length:C16($share)-1))
End if 
If (Is Windows:C1573)
	//change share to use \ for windows
	$share:=Replace string:C233($share; "/"; "\\")
	//add the two \\ in front
	$share:="\\\\"+$share
End if 
C_COLLECTION:C1488($shares_c)
$shares_c:=SysDoc_GetMountedShares
$mountedShare_o:=$shares_c.find("SysDoc_FindShare"; $share)
If (OB Is defined:C1231($mountedShare_o; "VolumeName"))
	$mountedShare_o.mounted:=True:C214
Else 
	OB SET:C1220($mountedShare_o; "mounted"; False:C215)
	
End if 
$0:=$mountedShare_o

//End SysDoc_IsShareMounted   