//%attributes = {"shared":true}
//Method: QR_Archive_GetOwner
//Description
//  ` return ITEm 8 Owner from an archive reoord
// Parameters
// $0 : $Owner_txt
// $1 : $BIN_txt
// $2 : $Reason_txt
// $3 : $ArchDate_d
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
C_TEXT:C284($0; $Owner_txt)
C_TEXT:C284($1; QRCustom_MyBIN_txt)
QRCustom_MyBIN_txt:=$1

C_TEXT:C284(QRCustMyYear_txt; QRCustom_MyBIN_txt)
C_TEXT:C284(QRcust1_txt; QRcust2_txt; QRcust3_txt; QRcust4_txt; QRcust5_txt; QRcust6_txt)
C_DATE:C307(QRCust1_d)

QRCustMyYear_txt:=[BridgeMHDNBISArchive:139]ArchiveReason_s:223
QRCust1_d:=[BridgeMHDNBISArchive:139]ArchiveDate_d:224
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	QRCustMyYear_txt:=$2
	QRCust1_d:=!00-00-00!
	
	If (Count parameters:C259>2)
		C_DATE:C307($3)
		QRCust1_d:=$3
	End if 
	
End if 

$Owner_txt:=""
QRCust6_txt:=""
QRcust2_txt:=""
QRcust3_txt:=""

If (QRCust1_d=!00-00-00!)
	Begin SQL
		select [BridgeMHDNBISArchive].[Item8 Owner] , [BridgeMHDNBISArchive].BIN, date_TO_CHAR([BridgeMHDNBISArchive].ArchiveDate_d , 'mm-dd-yyyy')
		from [BridgeMHDNBISArchive]
		where
		[BridgeMHDNBISArchive].ArchiveReason_s = :QRCustMyYear_txt AND
		[BridgeMHDNBISArchive].BIN = :QRCustom_MyBIN_txt 
		into  :QRcust2_txt,  :QRCust6_txt,   :QRcust3_txt
	End SQL
	
Else 
	Begin SQL
		select [BridgeMHDNBISArchive].[item8 owner] , [BridgeMHDNBISArchive].BIN, date_TO_CHAR([BridgeMHDNBISArchive].ArchiveDate_d , 'mm-dd-yyyy')
		from [BridgeMHDNBISArchive]
		where
		[BridgeMHDNBISArchive].ArchiveReason_s = :QRCustMyYear_txt AND
		[BridgeMHDNBISArchive].ArchiveDate_d = :QRCust1_d AND
		[BridgeMHDNBISArchive].BIN = :QRCustom_MyBIN_txt 
		into  :QRcust2_txt,  :QRCust6_txt,  :QRcust3_txt
	End SQL
	
End if 

If (QRCust6_txt=QRCustom_MyBIN_txt)
	$Owner_txt:=QRcust2_txt
End if 

$0:=$Owner_txt
//End QR_Archive_GetOwner