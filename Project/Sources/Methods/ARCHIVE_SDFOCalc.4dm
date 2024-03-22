//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: ARCHIVE_SDFOCalc
// Description
//  ` Calculate the SD status of the current [BridgeMHDNBISArchive] record - can 
// 
// Parameters
// $1 : $NewSD_ptr : ptr to boolean var/field for the SD status
// $2 : $NewFO_ptr : ptr to boolean var/field for the FO status
// $3 : $Table_ptr : ptr to table to use
// $4 : $AASHTO_Limit_r : limit of AASHTO value (optional - default = 80)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/20/11, 10:01:35
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(2/2/15 15:38:42)
	Mods_2015_02
	//  `Added var $BaseYear_i to use the year of the archive date not the current date
End if 
C_POINTER:C301($1; $NewSD_ptr; $2; $NewFO_ptr; $3; $Table_ptr)
$NewSD_ptr:=$1
$NewFO_ptr:=$2
$Table_ptr:=$3
C_REAL:C285($AASHTO_Limit_r)
$AASHTO_Limit_r:=80
If (Count parameters:C259>3)
	C_REAL:C285($4)
	$AASHTO_Limit_r:=$4
End if 

C_TEXT:C284($Item5)  // Command Replaced was o_C_STRING length was 9
C_REAL:C285($Item49; $AASHTO_r)
C_BOOLEAN:C305($Item112; $FHWARec_B)
C_TEXT:C284($Item42)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($Item27; $Item106; $BaseYear_i)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($Item42; $Item58; $Item59; $Item60; $Item62; $Item67; $Item71; $Item43b; $Item68; $Item69; $Item72)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item43)  // Command Replaced was o_C_STRING length was 3

C_BOOLEAN:C305($newSD_B; $newFO_B)
$newSD_B:=False:C215
$newFO_B:=False:C215
Case of 
	: (Table:C252($Table_ptr)=Table:C252(->[Bridge MHD NBIS:1]))
		$Item42:=[Bridge MHD NBIS:1]Item42:85
		$Item43:=[Bridge MHD NBIS:1]Item43:75
		$Item58:=[Bridge MHD NBIS:1]Item58:130
		$Item59:=[Bridge MHD NBIS:1]Item59:131
		$Item60:=[Bridge MHD NBIS:1]Item60:132
		$Item62:=[Bridge MHD NBIS:1]Item62:134
		$Item67:=[Bridge MHD NBIS:1]Item67:142
		$Item71:=[Bridge MHD NBIS:1]Item71:145
		$Item42:=[Bridge MHD NBIS:1]Item42:85
		$Item67:=[Bridge MHD NBIS:1]Item67:142
		$Item68:=[Bridge MHD NBIS:1]Item68:143
		$Item69:=[Bridge MHD NBIS:1]Item69:144
		$Item71:=[Bridge MHD NBIS:1]Item71:145
		$Item72:=[Bridge MHD NBIS:1]Item72:146
		$Item5:=[Bridge MHD NBIS:1]Item5:59
		$Item49:=[Bridge MHD NBIS:1]Item49:93
		$Item112:=[Bridge MHD NBIS:1]Item112:118
		$Item42:=[Bridge MHD NBIS:1]Item42:85
		$Item27:=[Bridge MHD NBIS:1]Item27:83
		$Item106:=[Bridge MHD NBIS:1]Item106:84
		$FHWARec_B:=[Bridge MHD NBIS:1]FHWARecord:174
		$AASHTO_r:=[Bridge MHD NBIS:1]AASHTO:5
		$BaseYear_i:=Year of:C25(Current date:C33(*))
		
	: (Table:C252($Table_ptr)=Table:C252(->[BridgeMHDNBISArchive:139]))
		$Item42:=[BridgeMHDNBISArchive:139]Item42:84
		$Item43:=[BridgeMHDNBISArchive:139]Item43:74
		$Item58:=[BridgeMHDNBISArchive:139]Item58:129
		$Item59:=[BridgeMHDNBISArchive:139]Item59:130
		$Item60:=[BridgeMHDNBISArchive:139]Item60:131
		$Item62:=[BridgeMHDNBISArchive:139]Item62:133
		$Item67:=[BridgeMHDNBISArchive:139]Item67:141
		$Item71:=[BridgeMHDNBISArchive:139]Item71:144
		$Item42:=[BridgeMHDNBISArchive:139]Item42:84
		$Item67:=[BridgeMHDNBISArchive:139]Item67:141
		$Item68:=[BridgeMHDNBISArchive:139]Item68:142
		$Item69:=[BridgeMHDNBISArchive:139]Item69:143
		$Item71:=[BridgeMHDNBISArchive:139]Item71:144
		$Item72:=[BridgeMHDNBISArchive:139]Item72:145
		$Item5:=[BridgeMHDNBISArchive:139]Item5:58
		$Item49:=[BridgeMHDNBISArchive:139]Item49:92
		$Item112:=[BridgeMHDNBISArchive:139]Item112:117
		$Item42:=[BridgeMHDNBISArchive:139]Item42:84
		$Item27:=[BridgeMHDNBISArchive:139]Item27:82
		$Item106:=[BridgeMHDNBISArchive:139]Item106:83
		$FHWARec_B:=[BridgeMHDNBISArchive:139]FHWARecord:173
		$AASHTO_r:=[BridgeMHDNBISArchive:139]AASHTO:5
		$BaseYear_i:=Year of:C25([BridgeMHDNBISArchive:139]ArchiveDate_d:224)
		
End case 

If ($FHWARec_B)
	If ($AASHTO_r<$AASHTO_Limit_r)
		$newSD_B:=(bDeficient($Item42; $Item43; $Item58; $Item59; $Item60; $Item62; $Item67; $Item71) & bFuncObsCheck($Item5; $Item49; $Item112; $Item42; $Item27; $Item106; $BaseYear_i))
		If ($newSD_B=False:C215)
			$newFO_B:=(bObsolete($Item42; $Item67; $Item68; $Item69; $Item71; $Item72) & bFuncObsCheck($Item5; $Item49; $Item112; $Item42; $Item27; $Item106; $BaseYear_i))
		End if 
	End if 
End if 
If (Type:C295($NewSD_ptr->)=Is boolean:K8:9)
	$NewSD_ptr->:=$newSD_B
End if 

If (Type:C295($NewFO_ptr->)=Is boolean:K8:9)
	$NewFO_ptr->:=$newFO_B
End if 