//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_UpgradeSDPreviousOwner
// User name (OS): charlesmiller
// Date and time: 12/29/09, 12:18:00
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_12  // r004 CJ Miller`12/29/09, 12:18:01      `
End if 
READ ONLY:C145(*)
READ WRITE:C146([SD_History:89])

ALL RECORDS:C47([SD_History:89])
ARRAY TEXT:C222($SDBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
DISTINCT VALUES:C339([SD_History:89]Bin:1; $SDBins_as)
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Size of array:C274($SDBins_as))
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$SDBins_as{$Loop_l})
	SET QUERY DESTINATION:C396(Into set:K19:2; "ProcessSet")
	
	QUERY:C277([SD_History:89]; [SD_History:89]Bin:1=$SDBins_as{$Loop_l})
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	USE SET:C118("ProcessSet")
	Repeat 
		APPLY TO SELECTION:C70([SD_History:89]; [SD_History:89]SD_PreviousOwner_s:19:=[Bridge MHD NBIS:1]LegacyOwner:226)
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
	USE SET:C118("ProcessSet")
	Repeat 
		APPLY TO SELECTION:C70([SD_History:89]; [SD_History:89]SD_Owner_s:17:=[Bridge MHD NBIS:1]Item8 Owner:208)
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
End for 
UNLOAD RECORD:C212([SD_History:89])
//End ut_UpgradeSDPreviousOwner