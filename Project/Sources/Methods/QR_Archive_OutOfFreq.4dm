//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/29/11, 11:53:53
	// ----------------------------------------------------
	// Method: QR_Archive_OutOfFreq
	// Description
	// Find how many months Bridge is out of frequency
	// 
	// Parameters
	// $0 : $OutOfFreq_L - months out of freq
	// $1 : $ArchiveReason_txt
	// $2 : $BIN_txt
	// $3 : $Archivedate_d
	// ----------------------------------------------------
	
	Mods_2011_09
End if 
C_LONGINT:C283($0; $OutOfFreq_L)

$OutOfFreq_L:=-999
C_TEXT:C284($1; $ArchiveReason_txt; $2; $BIN_txt)
C_BOOLEAN:C305($GetOOF_b)

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
		$GetOOF_b:=True:C214
	Else 
		$GetOOF_b:=False:C215
	End if 
	
Else 
	$GetOOF_b:=True:C214
End if 

If ($GetOOF_b)
	C_DATE:C307($I90_d; $i93A_d; $i93C_d; $Closed_d; $ArchDate_d; $LastDate_d)
	C_LONGINT:C283($i91_L)
	$I90_d:=[BridgeMHDNBISArchive:139]Item90:160
	$i93A_d:=[BridgeMHDNBISArchive:139]Item93A:168
	$i93C_d:=[BridgeMHDNBISArchive:139]Item93C:170
	$Closed_d:=[BridgeMHDNBISArchive:139]ClosedIDate:44
	$i91_L:=[BridgeMHDNBISArchive:139]Item91:161
	$ArchDate_d:=[BridgeMHDNBISArchive:139]ArchiveDate_d:224
	$LastDate_d:=!00-00-00!
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
	If ($LastDate_d>!00-00-00!)
		
		If (Add to date:C393($LastDate_d; 0; $i91_L; 0)>$ArchDate_d)
			//still in freq
			$OutOfFreq_L:=0
		Else 
			//find diff
			C_LONGINT:C283($Months_L)
			$Months_L:=1
			While ($OutOfFreq_L<0)
				If (Add to date:C393($LastDate_d; 0; ($i91_L+$Months_L); 0)>$ArchDate_d)
					//Found it
					$OutOfFreq_L:=$Months_L-1
				Else 
					$Months_L:=$Months_L+1
				End if 
				
			End while 
			
		End if 
		
	End if 
	
	
End if 

$0:=$OutOfFreq_L