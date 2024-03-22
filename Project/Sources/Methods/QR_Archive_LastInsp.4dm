//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/26/11, 10:51:45
	// ----------------------------------------------------
	// Method: QR_Archive_LastInsp
	// Description
	//  ` Get the Last inspection date recorded in an Archive BIN record
	// 
	// Parameters
	// $0 : $LastDate_d
	// $1 : $ArchiveReason_txt
	// $2 : $BIN_txt
	// $3 : $Archivedate_d
	// ----------------------------------------------------
	
	Mods_2011_09
End if 
C_DATE:C307($0; $LastDate_d)

$LastDate_d:=!00-00-00!
C_TEXT:C284($1; $ArchiveReason_txt; $2; $BIN_txt)
C_BOOLEAN:C305($GetDate_b)

If (Count parameters:C259>0)
	$ArchiveReason_txt:=$1
	$BIN_txt:=$2
	C_DATE:C307($3)
	QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$ArchiveReason_txt)
	QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]BIN:3=$BIN_txt)
	If (Count parameters:C259>2)
		If ($3#!00-00-00!)
			QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=$3)
		End if 
	End if 
	
	If (Records in selection:C76([BridgeMHDNBISArchive:139])=1)
		$GetDate_b:=True:C214
	Else 
		$LastDate_d:=Add to date:C393($LastDate_d; 1; 1; 1)
		$GetDate_b:=False:C215
	End if 
	
Else 
	$GetDate_b:=True:C214
End if 
If ($GetDate_b)
	C_DATE:C307($I90_d; $i93A_d; $i93C_d; $Closed_d)
	$I90_d:=[BridgeMHDNBISArchive:139]Item90:160
	$i93A_d:=[BridgeMHDNBISArchive:139]Item93A:168
	$i93C_d:=[BridgeMHDNBISArchive:139]Item93C:170
	$Closed_d:=[BridgeMHDNBISArchive:139]ClosedIDate:44
	If ($I90_d>$LastDate_d)
		$LastDate_d:=$I90_d
	End if 
	If ($i93A_d>$LastDate_d)
		$LastDate_d:=$i93A_d
	End if 
	If ($i93C_d>$LastDate_d)
		$LastDate_d:=$i93C_d
	End if 
	If ($Closed_d>$LastDate_d)
		$LastDate_d:=$Closed_d
	End if 
	
End if 

$0:=$LastDate_d