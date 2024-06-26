//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/07/11, 15:48:50
	// ----------------------------------------------------
	// Method: ARCH_CurrDistr_s
	// Description
	//  ` get the current district Item 2 of a BIN from the [BridgeMHDNBISArchive] table
	// 
	// Parameters
	// $0 : $I2_txt
	// $1 : $BIN_s (Optional)
	// ----------------------------------------------------
	
	Mods_2011_02
End if 
C_TEXT:C284($0; $I2)

C_TEXT:C284($BIN)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$BIN:=$1
Else 
	$BIN:=[BridgeMHDNBISArchive:139]BIN:3
End if 
$I2:="  "
C_BOOLEAN:C305($ROState_b)
$ROState_b:=Read only state:C362([Bridge MHD NBIS:1])
READ ONLY:C145([Bridge MHD NBIS:1])
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN)
If (Records in selection:C76([Bridge MHD NBIS:1])=1)
	LOAD RECORD:C52([Bridge MHD NBIS:1])
	$I2:=[Bridge MHD NBIS:1]Item2:60
End if 

If ($ROState_b)
Else 
	READ WRITE:C146([Bridge MHD NBIS:1])
End if 
$0:=$I2