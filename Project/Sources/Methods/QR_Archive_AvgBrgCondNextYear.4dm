//%attributes = {"shared":true}
//Method: QR_Archive_AvgBrgCondNextYear
//Description
//  `return the average bridge condition from the next year; -1 if an error or invalid values
// Parameters
// $0 : $avgCond 
// $1 : $ARCHIVEREAson_txt (optional - if non-blank passed must pass $2 $3) 
// $2 : $archiveDate_txt  (optional)
// $3 : $BIN_txt (optional)
// $4 : $YearDiff_L (optional)

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/7/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_12
End if 
//
C_REAL:C285($0; $avgCond)
$avgCond:=-1
C_TEXT:C284(QRCustMyYear_txt; QRCustom_MyBIN_txt)
QRCustMyYear_txt:=[BridgeMHDNBISArchive:139]ArchiveReason_s:223
QRCustom_MyBIN_txt:=[BridgeMHDNBISArchive:139]BIN:3

If (Count parameters:C259>0)
	//if one param is passed - need all 1,2,3
	C_TEXT:C284($1; $2; $3)
	//use SQL to get the values
	If ($1#"")
		QRCustMyYear_txt:=$1
		QRcust2_txt:=$2
		QRCustom_MyBIN_txt:=$3
	End if 
	
End if 
C_LONGINT:C283($YearDiff_L)
$YearDiff_L:=1
If (Count parameters:C259>3)
	C_LONGINT:C283($4)
	$YearDiff_L:=$4
End if 

C_LONGINT:C283($MyYear_L)
C_TEXT:C284(QRCust_Item58_txt; QRCust_Item59_txt; QRCust_Item60_txt; QRCust_Item62_txt; QRCust6_txt)

QRCust_Item58_txt:=""
QRCust_Item59_txt:=""
QRCust_Item60_txt:=""
QRCust_Item62_txt:=""
QRCust6_txt:=""

$MyYear_L:=Num:C11(Substring:C12(QRCustMyYear_txt; Length:C16("NBI TAPE ")+1))
QRcust1_txt:="NBI TAPE "+String:C10($MyYear_L+$YearDiff_L)

Begin SQL
	select [BridgeMHDNBISArchive].Item58 , [BridgeMHDNBISArchive].Item59 , [BridgeMHDNBISArchive].Item60 , [BridgeMHDNBISArchive].Item62 , [BridgeMHDNBISArchive].BIN
	from [BridgeMHDNBISArchive]
	where
	[BridgeMHDNBISArchive].ArchiveReason_s = :QRcust1_txt AND
	[BridgeMHDNBISArchive].BIN = :QRCustom_MyBIN_txt 
	into :QRCust_Item58_txt, :QRCust_Item59_txt, :QRCust_Item60_txt, :QRCust_Item62_txt, :QRCust6_txt
End SQL

If (QRCust6_txt=QRCustom_MyBIN_txt)
	C_LONGINT:C283($NumValidItems_L)
	$NumValidItems_L:=fn_BridgeConditionAvg(->$avgCond; QRCust_Item58_txt; QRCust_Item59_txt; QRCust_Item60_txt; QRCust_Item62_txt)
	
	If ($NumValidItems_L<1)
		$avgCond:=-1
	End if 
	
End if 

$0:=$avgCond
//End QR_Archive_AvgBrgCondNextYear