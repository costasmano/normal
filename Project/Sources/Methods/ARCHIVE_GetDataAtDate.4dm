//%attributes = {}
//Method: ARCHIVE_GetDataAtDate
//Description
// get data for a BIN at a date from the BridgeMHDNBISArchive table
// load the data in an object passed as a pointer. Attributes are :
// "NBI" b, "NHS" b, "SD" b, "Owner" , "InspResp", "Item2", "Item49" (M), "Item52" (m), "Item34" (m), "Item32" (m), "Area" (sqm)
// Parameters
// $1 : $Obj_ptr
// $2 : $BIN_txt
// $3 : $Date_d
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/14/17, 17:21:48
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
	
	C_POINTER:C301(ARCHIVE_GetDataAtDate; $1)
	C_TEXT:C284(ARCHIVE_GetDataAtDate; $2)
	C_DATE:C307(ARCHIVE_GetDataAtDate; $3)
	
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($2; $BIN_txt)
C_DATE:C307($3; $date_d)

C_BOOLEAN:C305($NBI_b; $sd_b; $NHS_b)
C_REAL:C285($Area_r; $item49; $Item52; $item34; $item32)
C_TEXT:C284($InspResp_txt; $item8own_txt; $item2_txt)
$BIN_txt:=$2
$date_d:=$3

Begin SQL
	SELECT 
	[BridgeMHDNBISArchive].[InspResp],
	[BridgeMHDNBISArchive].[Item2],
	[BridgeMHDNBISArchive].[FHWARecord]  ,
	[BridgeMHDNBISArchive].[Item104] ,
	[BridgeMHDNBISArchive].[Item8 Owner]  ,
	[BridgeMHDNBISArchive].[StructDef] ,
	[BridgeMHDNBISArchive].[Item49],
	[BridgeMHDNBISArchive].[Item52],
	[BridgeMHDNBISArchive].[Item34],
	[BridgeMHDNBISArchive].[Item32]
	from
	[BridgeMHDNBISArchive]
	where
	[BridgeMHDNBISArchive].[BIN] = :$BIN_txt
	and
	[BridgeMHDNBISArchive].[ArchiveDate_d] = :$date_d 
	into 
	:$InspResp_txt ,
	:$Item2_txt ,
	:$NBI_b ,
	:$NHS_b ,
	:$item8own_txt ,
	:$sd_b ,
	:$item49, :$Item52 , :$item34 , :$item32 ;
	
End SQL

$Area_r:=QR_BridgeArea_r($item49; $Item52; $item34; $item32)

OB SET:C1220($1->; "NBI"; $NBI_b; "NHS"; $NHS_b; "SD"; $sd_b; "Owner"; $item8own_txt; "InspResp"; $InspResp_txt; "Item2"; $Item2_txt; \
"Area"; $Area_r; "Item49"; $item49; "Item52"; $Item52; "Item34"; $item34; "Item32"; $item32)

//End ARCHIVE_GetDataAtDate