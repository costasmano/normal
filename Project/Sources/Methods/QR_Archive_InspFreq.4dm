//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/13/11, 14:08:47
	// ----------------------------------------------------
	// Method: QR_Archive_InspFreq
	// Description
	//  ` Calculate the inspection frequency from the Archive tables based on start year, end year, bin
	// 
	//Parameters
	// $0 :$Freq_L
	// $1 :$StartYr_L
	// $2 :$EndYr_L
	// $3 :$BIN_txt
	// ----------------------------------------------------
	
	Mods_2011_09
	// Modified by: costasmanousakis-(Designer)-(9/23/11 15:36:31)
	Mods_2011_09
	//  `account for Item 91 found on the first set of data
End if 
C_LONGINT:C283($0; $Freq_L)
C_LONGINT:C283($1; $StartYr_L; $2; $EndYr_L)
$StartYr_L:=$1
$EndYr_L:=$2
C_TEXT:C284($3; $BIN_txt)
$BIN_txt:=$3
$Freq_L:=9999
C_LONGINT:C283($YearLoop_L; $StartI91_L)
C_DATE:C307($StartDate_D; $EndDate_d)
Case of 
	: ($StartYr_L-$EndYr_L>0)
		
		For ($YearLoop_L; $StartYr_L; $EndYr_L; -1)
			QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=("@"+String:C10($YearLoop_L)); *)
			QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]BIN:3=$BIN_txt)
			If (Records in selection:C76([BridgeMHDNBISArchive:139])=1)
				If ($StartDate_D=!00-00-00!)
					$StartDate_D:=[BridgeMHDNBISArchive:139]Item90:160
					$StartI91_L:=[BridgeMHDNBISArchive:139]Item91:161
				Else 
					
					If ($EndDate_d=!00-00-00!)
						
						If ([BridgeMHDNBISArchive:139]Item90:160#!00-00-00!)
							If ([BridgeMHDNBISArchive:139]Item90:160=$StartDate_D)
							Else 
								$EndDate_d:=[BridgeMHDNBISArchive:139]Item90:160
								$YearLoop_L:=$EndYr_L-1
							End if 
							
						End if 
					Else 
						
					End if 
					
				End if 
				
			Else 
				
			End if 
			
		End for 
		
End case 
If ($StartDate_D#!00-00-00!)
	C_LONGINT:C283($I90startYr_L; $I90startMo_L; $I90endYr_L; $I90endMo_L)
	$I90startYr_L:=Year of:C25($StartDate_D)
	$I90startMo_L:=Month of:C24($StartDate_D)
	C_LONGINT:C283($FirstFreq_L)
	$FirstFreq_L:=($StartYr_L*12)+4-(($I90startYr_L*12)+$I90startMo_L)  //Assume April submission
	If ($FirstFreq_L<$StartI91_L)
		$FirstFreq_L:=$StartI91_L
	End if 
	
	If ($EndDate_d#!00-00-00!)
		$I90endYr_L:=Year of:C25($EndDate_d)
		$I90endMo_L:=Month of:C24($EndDate_d)
		$Freq_L:=($I90startYr_L*12)+$I90startMo_L-(($I90endYr_L*12)+$I90endMo_L)
	End if 
	If ($Freq_L=9999)
		$Freq_L:=$FirstFreq_L
	Else 
		If ($Freq_L<$FirstFreq_L)
			$Freq_L:=$FirstFreq_L
		End if 
		
	End if 
	
End if 

$0:=$Freq_L