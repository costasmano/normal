//%attributes = {"invisible":true}
// ----------------------------------------------------
// WRT_CheckLosingFocus
// User name (OS): charlesmiller
// Date and time: 03/27/09, 12:31:10
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 12:31:12
	
	Mods_2021_Delete
End if 
//C_TEXT($AreaName_txt)
//$AreaName_txt:="Area@"
//C_LONGINT($1;$2;$4DWriteArea_l;$FormEvent_l)
//$4DWriteArea_l:=$1
//$FormEvent_l:=$2
//If (Count parameters=3)
//C_TEXT($3)
//$AreaName_txt:=$3
//End if 
//C_LONGINT($TblNo;$FldNo)
//C_TEXT($VarName)
//RESOLVE POINTER(Focus object;$VarName;$TblNo;$FldNo)
//If ($VarName=$AreaName_txt)
//G_ElmtRemarksArea ($4DWriteArea_l;$FormEvent_l)
//End if 
//  //End WRT_CheckLosingFocus