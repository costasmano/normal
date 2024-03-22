//%attributes = {"shared":true}
//Method: QR_CurrBridgeOwner
//Description
//  ` Current owner of a BIN Item 8 Owner
// Parameters
// $0 : $Owner_txt  : owner code
// $1 : $BIN_txt
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
C_TEXT:C284($1; QRCustom_MyBIN_txt; QRCust6_txt; QRCust5_txt)
QRCustom_MyBIN_txt:=$1
$Owner_txt:=""
QRCust6_txt:=""
QRCust5_txt:=""
Begin SQL
	select [Bridge MHD NBIS].[Item8 Owner], [Bridge MHD NBIS].BIN
	from [Bridge MHD NBIS]
	where
	[Bridge MHD NBIS].BIN = :QRCustom_MyBIN_txt 
	into :QRCust5_txt, :QRCust6_txt
End SQL

If (QRCustom_MyBIN_txt=QRCust6_txt)
	$Owner_txt:=QRCust5_txt
End if 

$0:=$Owner_txt
//End QR_CurrBridgeOwner