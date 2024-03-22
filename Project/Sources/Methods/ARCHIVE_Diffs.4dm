//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/19/11, 08:26:37
	// ----------------------------------------------------
	// Method: ARCHIVE_Diffs
	// Description
	// Find arrays of BINs added and removed between a starting and an ending
	// monthly date form the [BridgeMHDNBISArchive] table
	// ***** DESIGN IN PROGRESS *****
	
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_09
End if 
QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=!2010-07-01!; *)
QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveReason_s:223="Monthly@")
QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]FHWARecord:173=True:C214)
ARRAY TEXT:C222($NBIBINSStart_as; 0)  //Command Replaced was o_ARRAY string length was 3
SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]BIN:3; $NBIBINSStart_as)
QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=!2010-10-01!; *)
QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveReason_s:223="Monthly@")
QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]FHWARecord:173=True:C214)
ARRAY TEXT:C222($NBIBINSEND_as; 0)  //Command Replaced was o_ARRAY string length was 3
SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]BIN:3; $NBIBINSEND_as)
ARRAY TEXT:C222($NBIBINSRemoved_as; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($NBIBINSAdded_as; 0)  //Command Replaced was o_ARRAY string length was 3

C_LONGINT:C283($loop_L; $Found_L)
For ($loop_L; 1; Size of array:C274($NBIBINSStart_as))
	$Found_L:=Find in array:C230($NBIBINSEND_as; $NBIBINSStart_as{$loop_L})
	If ($Found_L>0)
	Else 
		APPEND TO ARRAY:C911($NBIBINSRemoved_as; $NBIBINSStart_as{$loop_L})
	End if 
End for 

For ($loop_L; 1; Size of array:C274($NBIBINSEND_as))
	$Found_L:=Find in array:C230($NBIBINSStart_as; $NBIBINSEND_as{$loop_L})
	If ($Found_L>0)
	Else 
		APPEND TO ARRAY:C911($NBIBINSAdded_as; $NBIBINSEND_as{$loop_L})
	End if 
End for 
