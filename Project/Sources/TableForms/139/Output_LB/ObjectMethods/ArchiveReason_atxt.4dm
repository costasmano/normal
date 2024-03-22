
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/04/12, 14:37:16
//----------------------------------------------------
//Method: Object Method: [BridgeMHDNBISArchive].Output.ArchiveReason_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_09  //r001 ` 
	//Modified by: Charles Miller (9/4/12 14:37:18)
	// Modified by: Costas Manousakis-(Designer)-(6/18/13 12:25:52)
	Mods_2013_06
	//  `Added RegionTitle
End if 

If (ArchiveReason_atxt>0)
	
	QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=ArchiveReason_atxt{ArchiveReason_atxt})
	RegionTitle
	ARRAY DATE:C224(ArchiveDate_ad; 0)
	DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveDate_d:224; ArchiveDate_ad)
	
	If (Size of array:C274(ArchiveDate_ad)<2)
		OBJECT SET VISIBLE:C603(*; "ArchiveDate_ad"; False:C215)
	Else 
		ArchiveDate_ad:=-1
		OBJECT SET VISIBLE:C603(*; "ArchiveDate_ad"; True:C214)
	End if 
End if 

//End Object Method: [BridgeMHDNBISArchive].Output.ArchiveReason_atxt

