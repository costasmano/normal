//%attributes = {}
// Method: F_GetCityOrTown
// Description
// Return whether "Townname" is a City or Town
// Parameters
// $0 : $CityTown_txt
// $1 : $TownName_txt Name of town coming from the [Bridge MHD NBIS]Town Name field
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/24/08, 09:29:21
	// ----------------------------------------------------
	
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	// Modified by: Costas Manousakis-(Designer)-(5/13/20 16:15:19)
	Mods_2020_05
	//  `modified to take advantage of the new field [Town Address]TownBDEPTPrefix
	//  `will try that first and then use the old method.
End if 

C_TEXT:C284($0; $CityTown_txt; $1; $TownName_txt; $BdeptPrefix_txt)
$TownName_txt:=$1
READ ONLY:C145([Town Address:78])

Begin SQL
	select [Town Data].[BDEPT Prefix]
	from [Town Data]
	where [Town Data].[Town Name] = :$TownName_txt
	into :$BdeptPrefix_txt;
End SQL
If ($BdeptPrefix_txt#"")
	QUERY:C277([Town Address:78]; [Town Address:78]TownBDEPTPrefix:17=$BdeptPrefix_txt)
End if 
If (Records in selection:C76([Town Address:78])=0)
	QUERY BY FORMULA:C48([Town Address:78]; Replace string:C233(\
		Replace string:C233([Town Address:78]OfficialTownName:4; "City of "; ""); \
		"Town of "; "")=$TownName_txt)
End if 

If (Records in selection:C76([Town Address:78])=0)
	$CityTown_txt:="Town"
Else 
	$CityTown_txt:=Substring:C12([Town Address:78]OfficialTownName:4; 1; (Position:C15(" "; [Town Address:78]OfficialTownName:4)-1))
End if 

$0:=$CityTown_txt