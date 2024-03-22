
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/04/12, 14:44:44
//----------------------------------------------------
//Method: Object Method: [BridgeMHDNBISArchive].Output.ArchiveDate_ad
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_09  //r001 ` 
	//Modified by: Charles Miller (9/4/12 14:44:45)
	// Modified by: Costas Manousakis-(Designer)-(6/18/13 12:25:35)
	Mods_2013_06
	//  `added RegionTitle
End if 

If (ArchiveDate_ad>0)
	QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=ArchiveReason_atxt{ArchiveReason_atxt})
	
	QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=ArchiveDate_ad{ArchiveDate_ad})
	RegionTitle
End if 
//End Object Method: [BridgeMHDNBISArchive].Output.ArchiveReason_ad

