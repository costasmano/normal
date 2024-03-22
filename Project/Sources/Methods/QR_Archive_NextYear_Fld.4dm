//%attributes = {"invisible":true,"shared":true}
//Method: QR_Archive_NextYear_Fld
//Description
//
// Parameters
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
C_TEXT:C284($0; $FldValue_txt)
$FldValue_txt:="??????"

C_TEXT:C284(QRCustMyYear_txt; QRCustom_MyBIN_txt)
C_TEXT:C284(QRcust1_txt; QRcust2_txt; QRcust3_txt; QRcust4_txt; QRcust5_txt; QRCust6_txt)
QRCustMyYear_txt:=[BridgeMHDNBISArchive:139]ArchiveReason_s:223
QRCustom_MyBIN_txt:=[BridgeMHDNBISArchive:139]BIN:3

C_TEXT:C284($1; $Fld_txt)

If (Count parameters:C259>1)
	//if one param is passed - need all 1,2,3
	C_TEXT:C284($2; $3; $4)
	//use SQL to get the values
	If ($2#"")
		QRCustMyYear_txt:=$2
		QRcust2_txt:=$3
		QRCustom_MyBIN_txt:=$4
	End if 
	
End if 
C_LONGINT:C283($YearDiff_L)
$YearDiff_L:=1
If (Count parameters:C259>4)
	C_LONGINT:C283($5)
	$YearDiff_L:=$5
End if 

C_LONGINT:C283($MyYear_L; QRCust1_L; QRCust2_L)

$MyYear_L:=Num:C11(Substring:C12(QRCustMyYear_txt; Length:C16("NBI TAPE ")+1))
QRcust1_txt:="NBI TAPE "+String:C10($MyYear_L+$YearDiff_L)
Begin SQL
	select [BridgeMHDNBISArchive].Item58 , [BridgeMHDNBISArchive].BIN
	from [BridgeMHDNBISArchive]
	where
	[BridgeMHDNBISArchive].ArchiveReason_s = :QRcust1_txt AND
	[BridgeMHDNBISArchive].BIN = :QRCustom_MyBIN_txt 
	into  :QRcust2_txt,  :QRCust6_txt
End SQL

If (QRCust6_txt=QRCustom_MyBIN_txt)
	$FldValue_txt:=QRcust2_txt
End if 

$0:=$FldValue_txt
//End QR_Archive_NextYear_Fld