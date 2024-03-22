// ----------------------------------------------------
// Object Method: PRJ_FileNumbers_al
// User name (OS): charlesmiller
// Date and time: 05/08/09, 09:58:28
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r001  `05/08/09, 09:58:30  `Continue changes PRJ Design Contract Changes 
End if 



If (PRJ_FileNumbers_al>1)
	QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=PRJ_FileNumbers_al{PRJ_FileNumbers_al})
	
	OBJECT SET VISIBLE:C603(*; "PF_Description"; True:C214)
Else 
	
	OBJECT SET VISIBLE:C603(*; "PF_Description"; False:C215)
End if 
//End Object Method: PRJ_FileNumbers_al