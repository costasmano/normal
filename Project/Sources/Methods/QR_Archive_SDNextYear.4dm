//%attributes = {"shared":true}
//Method: QR_Archive_SDNextYear
//Description
//  `Check whether next year record is SD or not based on Structdef
// Parameters
// $0 : $SDNextYear_L (0 : not ; 1 : Yes ; -1 : some error
// $1 : $ARCHIVEREAson_txt
// $2 : $archiveDate_txt
// $3 : $BIN_txt
// $4 : $YearDiff_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
	// Modified by: Costas Manousakis-(Designer)-(12/2/15 12:47:26)
	Mods_2015_12_bug
	//  `was  returning var QRCust2_L instread of $SDNextYear_L
End if 
//
C_LONGINT:C283($0; $SDNextYear_L)
$SDNextYear_L:=-1
C_TEXT:C284(QRCustMyYear_txt; QRCustom_MyBIN_txt)
C_TEXT:C284(QRcust1_txt; QRcust2_txt; QRcust3_txt)
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
Begin SQL
	select cast([BridgeMHDNBISArchive].StructDef as INT), [BridgeMHDNBISArchive].BIN
	from [BridgeMHDNBISArchive]
	where
	[BridgeMHDNBISArchive].ArchiveReason_s = :QRcust1_txt AND
	[BridgeMHDNBISArchive].BIN = :QRCustom_MyBIN_txt 
	into :QRCust2_L, :QRcust2_txt
End SQL

If (QRcust2_txt=QRCustom_MyBIN_txt)
	$SDNextYear_L:=QRCust2_L
End if 

$0:=$SDNextYear_L

//End QR_Archive_SDNextYear