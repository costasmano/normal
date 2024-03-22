//%attributes = {"shared":true}
//Method: QR_Archive_RebltOrRem_NxtYr
//Description
//  ` Whether a record was rebuilt next year or removed
// Parameters
// $0 : $SDNextYear_L
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
C_BOOLEAN:C305($Reblt_Or_REM_b; $SQLSearchError_b)
$SQLSearchError_b:=False:C215
$Reblt_Or_REM_b:=False:C215
$MyYear_L:=Num:C11(Substring:C12(QRCustMyYear_txt; Length:C16("NBI TAPE ")+1))
QRcust1_txt:="NBI TAPE "+String:C10($MyYear_L+$YearDiff_L)
QRCust6_txt:=""
QRCust2_txt:=""
Begin SQL
	select [BridgeMHDNBISArchive].[Item8 BridgeCat] ,  [BridgeMHDNBISArchive].BIN
	from [BridgeMHDNBISArchive]
	where
	[BridgeMHDNBISArchive].ArchiveReason_s = :QRcust1_txt AND
	[BridgeMHDNBISArchive].BIN = :QRCustom_MyBIN_txt 
	into  :QRcust2_txt, :QRCust6_txt
End SQL

If (QRCust6_txt=QRCustom_MyBIN_txt)
	$Reblt_Or_REM_b:=(QRcust2_txt="REM")
Else 
	$SQLSearchError_b:=True:C214
End if 
QRCust6_txt:=""
QRCust2_L:=0
Begin SQL
	select [Bridge MHD NBIS].Item106,[Bridge MHD NBIS].BIN
	from [Bridge MHD NBIS]
	where
	[Bridge MHD NBIS].BIN = :QRCustom_MyBIN_txt 
	into :QRCust2_L, :QRCust6_txt
End SQL

If (QRCust6_txt=QRCustom_MyBIN_txt)
	$Reblt_Or_REM_b:=$Reblt_Or_REM_b | ((QRcust2_L>$MyYear_L) & (QRcust2_L<=($MyYear_L+$YearDiff_L)))
Else 
	$SQLSearchError_b:=True:C214
End if 

If (Not:C34($SQLSearchError_b))
	If ($Reblt_Or_REM_b)
		$SDNextYear_L:=1
	Else 
		$SDNextYear_L:=0
	End if 
	
End if 

$0:=$SDNextYear_L
//End QR_Archive_RebltOrRem_NxtYr