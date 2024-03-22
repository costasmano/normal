//%attributes = {}
//Method: ARCHIVE_CalcStatus
//Description
// Calculate status changes of a record in BridgeMHDNBISArchive table compared with another date
// load data in an object passed as a pointer. Attributes added to the object are :
// "NBI" b, "NHS" b, "SD" b, "Owner" , "InspResp", "Item2", "Item49" (M), "Item52" (m), "Item34" (m), "Item32" (m), "Area" (sqm)
// "NBIState", "NBIArea" (sqft), "NHSState", "NHSArea" (sqft), "SDState", "SDArea" (sqft)
// "NHSSDState", "NHSSDArea" (sqft)
// Parameters
// $1 : $Obj_ptr
// $2 : $BIN_txt
// $3 : $Date_d
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/15/17, 17:20:02
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
	
	C_POINTER:C301(ARCHIVE_CalcStatus; $1)
	C_TEXT:C284(ARCHIVE_CalcStatus; $2)
	C_DATE:C307(ARCHIVE_CalcStatus; $3)
	
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($2; $BIN_txt)
C_DATE:C307($3; $date_d)
C_BOOLEAN:C305($NBI_b; $sd_b; $NHS_b)
C_REAL:C285($Area_r; $item49; $Item52; $item34; $item32; $currArea_r)
C_TEXT:C284($InspResp_txt; $item8own_txt; $item2_txt)
$BIN_txt:=$2
$date_d:=$3

ARCHIVE_GetDataAtDate($1; $BIN_txt; $date_d)

$NBI_b:=OB Get:C1224($1->; "NBI"; Is boolean:K8:9)
$sd_b:=OB Get:C1224($1->; "SD"; Is boolean:K8:9)
$NHS_b:=OB Get:C1224($1->; "NHS"; Is boolean:K8:9)
//convert areas to square feet and round to 2 dec
// 10.7639104
$Area_r:=Round:C94(10.7639104*OB Get:C1224($1->; "Area"; Is real:K8:4); 2)
$currArea_r:=Round:C94(10.7639104*QR_BridgeArea_r([BridgeMHDNBISArchive:139]Item49:92; [BridgeMHDNBISArchive:139]Item52:96; [BridgeMHDNBISArchive:139]Item34:99; [BridgeMHDNBISArchive:139]Item32:97); 2)

//status for various states (NBI - SD - NHS ) is IN | NOT | NEW | OFF
C_TEXT:C284($NBI_txt; $SD_txt; $NHS_txt; $NHSSD_txt)
C_REAL:C285($NBIArea_Change_r; $SDAreaChange_r; $NHSAreaChange_r; $NHSSDAreaChange_r)

//check to see if we are going back in time from current record or forward
C_BOOLEAN:C305($startNBI_b; $EndNBI_b; $startNHS_b; $endNHS_b; $startSD_b; $endSD_b)
C_REAL:C285($startArea_r; $endArea_r)
If ($date_d>[BridgeMHDNBISArchive:139]ArchiveDate_d:224)
	$startNBI_b:=[BridgeMHDNBISArchive:139]FHWARecord:173
	$EndNBI_b:=$NBI_b
	$startNHS_b:=[BridgeMHDNBISArchive:139]Item104:118
	$endNHS_b:=$NHS_b
	$startSD_b:=[BridgeMHDNBISArchive:139]StructDef:102
	$endSD_b:=$Sd_b
	$startArea_r:=$currArea_r
	$endArea_r:=$Area_r
Else 
	$startNBI_b:=$NBI_b
	$EndNBI_b:=[BridgeMHDNBISArchive:139]FHWARecord:173
	$startNHS_b:=$NHS_b
	$endNHS_b:=[BridgeMHDNBISArchive:139]Item104:118
	$startSD_b:=$Sd_b
	$endSD_b:=[BridgeMHDNBISArchive:139]StructDef:102
	$startArea_r:=$Area_r
	$endArea_r:=$currArea_r
End if 

Case of 
	: ($startNBI_b & $endNBI_b)  //IN
		$NBI_txt:="IN"
		$NBIArea_Change_r:=$endArea_r-$startArea_r
		
		If ($NBIArea_Change_r#0)
			$NBI_txt:="IN-AreaChange"
		End if 
		
		Case of 
			: ($startNHS_b & $endNHS_b)  //IN
				$NHS_txt:="IN"
				$NHSAreaChange_r:=$endArea_r-$startArea_r
				
				If ($NHSAreaChange_r#0)
					$NHS_txt:="IN-AreaChange"
				End if 
				
			: (Not:C34($startNHS_b) & Not:C34($endNHS_b))  //NOT
				$NHS_txt:="NOT"
			: (Not:C34($startNHS_b) & $endNHS_b)  //New
				$NHS_txt:="NEW"
				$NHSAreaChange_r:=$endArea_r
			: ($startNHS_b & Not:C34($endNHS_b))  //Off
				$NHS_txt:="OFF"
				$NHSAreaChange_r:=-$startArea_r
		End case 
		
	: (Not:C34($startNBI_b) & Not:C34($endNBI_b))  //NOT
		$NBI_txt:="NOT"
		$NHS_txt:="NOT"  // also not on the NHS counts
		//should automatically be not SD
		
	: (Not:C34($startNBI_b) & $endNBI_b)  //New
		$NBI_txt:="NEW"
		$NBIArea_Change_r:=$endArea_r
		//add to NHS if new NHS
		
		If ($endNHS_b)
			$NHS_txt:="NEW"
			$NHSAreaChange_r:=$endArea_r
		Else 
			$NHS_txt:="NOT"
		End if 
		
	: ($startNBI_b & Not:C34($endNBI_b))  //Off
		$NBI_txt:="OFF"
		$NBIArea_Change_r:=-$startArea_r
		//it also gets removed from NHS 
		
		If ($startNHS_b)
			$NHS_txt:="OFF"
			$NHSAreaChange_r:=-$startArea_r
		Else 
			$NHS_txt:="NOT"
		End if 
		
End case 

Case of 
	: ($startSD_b & $endSD_b)  //IN
		$SD_txt:="IN"
		$SDAreaChange_r:=$endArea_r-$startArea_r
		
		If ($SDAreaChange_r#0)
			$SD_txt:="IN-AreaChange"
		End if 
		
	: (Not:C34($startSD_b) & Not:C34($endSD_b))  //NOT
		$SD_txt:="NOT"
	: (Not:C34($startSD_b) & $endSD_b)  //New
		$SD_txt:="NEW"
		$SDAreaChange_r:=$endArea_r
	: ($startSD_b & Not:C34($endSD_b))  //Off
		$SD_txt:="OFF"
		$SDAreaChange_r:=-$startArea_r
End case 

C_BOOLEAN:C305($NHSSD_0_b; $NHSSD_1_b)
$NHSSD_0_b:=$startNHS_b & $startSD_b
$NHSSD_1_b:=$endNHS_b & $endSD_b

Case of 
	: ($NHSSD_0_b & $NHSSD_1_b)  //IN
		$NHSSD_txt:="IN"
		$NHSSDAreaChange_r:=$endArea_r-$startArea_r
		
		If ($NHSSDAreaChange_r#0)
			$NHSSD_txt:="IN-AreaChange"
		End if 
		
	: (Not:C34($NHSSD_0_b) & Not:C34($NHSSD_1_b))  //NOT
		$NHSSD_txt:="NOT"
	: (Not:C34($NHSSD_0_b) & $NHSSD_1_b)  //New
		$NHSSD_txt:="NEW"
		$NHSSDAreaChange_r:=$endArea_r
	: ($NHSSD_0_b & Not:C34($NHSSD_1_b))  //Off
		$NHSSD_txt:="OFF"
		$NHSSDAreaChange_r:=-$startArea_r
End case 


//add data to object
OB SET:C1220($1->; "NBIState"; $NBI_txt; "NBIArea"; $NBIArea_Change_r; "NHSState"; $NHS_txt; "NHSArea"; $NHSAreaChange_r; "SDState"; $SD_txt; "SDArea"; $SDAreaChange_r)
OB SET:C1220($1->; "NHSSDState"; $NHSSD_txt; "NHSSDArea"; $NHSSDAreaChange_r)

//End ARCHIVE_CalcStatus