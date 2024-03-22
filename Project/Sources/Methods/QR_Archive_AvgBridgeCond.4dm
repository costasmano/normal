//%attributes = {"shared":true}
//Method: QR_Archive_AvgBridgeCond
//Description
//  `return the average bridge condition ; -1 if an error or invalid values
// Parameters
// $0 : (real)
// $1 : $reason_txt
// $2 : $reasonDate_txt
// $3 : $Bin_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
End if 
//
C_REAL:C285($0; $avgCond)
$avgCond:=-1

C_TEXT:C284(QRCust_Item58_txt; QRCust_Item59_txt; QRCust_Item60_txt; QRCust_Item62_txt)

QRCust_Item58_txt:=""
QRCust_Item59_txt:=""
QRCust_Item60_txt:=""
QRCust_Item62_txt:=""

If (Count parameters:C259>0)
	//if one param is passed - need all 3
	C_TEXT:C284($1; $2; $3)
	C_TEXT:C284(QRcust1_txt; QRcust2_txt; QRcust3_txt)
	QRcust1_txt:=$1
	QRcust2_txt:=$2
	QRcust3_txt:=$3
	//use SQL to get the values
	Begin SQL
		select [BridgeMHDNBISArchive].Item58, [BridgeMHDNBISArchive].Item59, [BridgeMHDNBISArchive].Item60, [BridgeMHDNBISArchive].Item62
		from [BridgeMHDNBISArchive]
		where
		[BridgeMHDNBISArchive].ArchiveReason_s = :QRcust1_txt AND
		[BridgeMHDNBISArchive].BIN = :QRcust3_txt 
		into :QRCust_Item58_txt, :QRCust_Item59_txt, :QRCust_Item60_txt, :QRCust_Item62_txt
	End SQL
	
Else 
	//use the current archive record
	QRCust_Item58_txt:=[BridgeMHDNBISArchive:139]Item58:129
	QRCust_Item59_txt:=[BridgeMHDNBISArchive:139]Item59:130
	QRCust_Item60_txt:=[BridgeMHDNBISArchive:139]Item60:131
	QRCust_Item62_txt:=[BridgeMHDNBISArchive:139]Item62:133
	
End if 
C_LONGINT:C283($NumValidItems_L)
$NumValidItems_L:=fn_BridgeConditionAvg(->$avgCond; QRCust_Item58_txt; QRCust_Item59_txt; QRCust_Item60_txt; QRCust_Item62_txt)

If ($NumValidItems_L<1)
	$avgCond:=-1
End if 

$0:=$avgCond
//End QR_Archive_AvgBridgeCond