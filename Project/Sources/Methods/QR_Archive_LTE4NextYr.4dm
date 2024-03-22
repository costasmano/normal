//%attributes = {"shared":true}
//Method: QR_Archive_LTE4NextYr
//Description
//  ` Return Whether the archive record from next year has rtgs lte 4
// Parameters
// $0 : $SDNextYear_L (0 : not ; 1 : Yes ; -1 : some error
// $1 : $ARCHIVEREAson_txt (optional - if non-blank passed must pass $2 $3)
// $2 : $archiveDate_txt  (optional)
// $3 : $BIN_txt (optional)
// $4 : $YearDiff_L (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12, 10:51:34
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
End if 
//
C_LONGINT:C283($0; $SDNextYear_L)
$SDNextYear_L:=-1
C_TEXT:C284(QRCustMyYear_txt; QRCustom_MyBIN_txt)
C_TEXT:C284(QRcust1_txt; QRcust2_txt; QRcust3_txt; QRcust4_txt; QRcust5_txt; QRCust6_txt)
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

C_LONGINT:C283($MyYear_L; QRCust1_L; QRCust2_L)

$MyYear_L:=Num:C11(Substring:C12(QRCustMyYear_txt; Length:C16("NBI TAPE ")+1))
QRcust1_txt:="NBI TAPE "+String:C10($MyYear_L+$YearDiff_L)
QRcust2_txt:=""
QRcust3_txt:=""
QRcust4_txt:=""
QRcust5_txt:=""
QRCust6_txt:=""
Begin SQL
	select [BridgeMHDNBISArchive].Item58 , [BridgeMHDNBISArchive].Item59 , [BridgeMHDNBISArchive].Item60 , [BridgeMHDNBISArchive].Item62 , [BridgeMHDNBISArchive].BIN
	from [BridgeMHDNBISArchive]
	where
	[BridgeMHDNBISArchive].ArchiveReason_s = :QRcust1_txt AND
	[BridgeMHDNBISArchive].BIN = :QRCustom_MyBIN_txt 
	into  :QRcust2_txt, :QRcust3_txt, :QRcust4_txt, :QRcust5_txt, :QRCust6_txt
End SQL

If (QRCust6_txt=QRCustom_MyBIN_txt)
	$SDNextYear_L:=QR_Appraisal_LTE4_L(QRcust2_txt; QRcust3_txt; QRcust4_txt; QRcust5_txt)
End if 

$0:=$SDNextYear_L
//End QR_Archive_LTE4NextYr