// ----------------------------------------------------
// Object Method: SD_Owner_s
// User name (OS): charlesmiller
// Date and time: 12/29/09, 15:11:30
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_12  // r004 CJ Miller`12/29/09, 15:11:31      ``Add [Bridge MHD NBIS]LegacyOwner to SD Data
End if 
If (<>SD_UseLegacy_l=0)
	[SD_History:89]SD_Owner_s:17:=[SD_History:89]SD_Owner_s:17
Else 
	[SD_History:89]SD_Owner_s:17:=[SD_History:89]SD_PreviousOwner_s:19
End if 
//End Object Method: SD_Owner_s