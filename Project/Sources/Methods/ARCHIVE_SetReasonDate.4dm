//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/03/10, 17:58:31
	// ----------------------------------------------------
	// Method: ARCHIVE_SetReasonDATE
	// Description
	//  ` Set the reason and date...
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_11
End if 
C_TEXT:C284($Reason; $Date_txt)
C_DATE:C307($Date_d)
$Reason:=Request:C163("Reason for Archive"; "MONTHLYARCHIVE")
$Date_txt:=Request:C163("Date"; String:C10(Current date:C33(*)))
$Date_d:=Date:C102($Date_txt)
APPLY TO SELECTION:C70([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223:=$Reason)
APPLY TO SELECTION:C70([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveDate_d:224:=$Date_d)
