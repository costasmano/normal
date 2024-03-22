//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 06/08/17, 14:30:32
//----------------------------------------------------
//Method: ut_FixBadUUIDs
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_06_bug  //
	
	
	//Modified by: Chuck Miller (6/8/17 14:30:35)
	
End if 
ARRAY TEXT:C222($UUIDS_atxt; 0)
ARRAY TEXT:C222($DuplicateUUIDS_atxt; 0)

ALL RECORDS:C47([RAILBridgeInfo:37])
DISTINCT VALUES:C339([RAILBridgeInfo:37]RAILBridgeInfo_UUIDKey_s:46; $UUIDS_atxt)
C_LONGINT:C283($Loop_L; $Count_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)

For ($Loop_L; 1; Size of array:C274($UUIDS_atxt))
	QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]RAILBridgeInfo_UUIDKey_s:46=$UUIDS_atxt{$Loop_L})
	If ($Count_L>1)
		APPEND TO ARRAY:C911($DuplicateUUIDS_atxt; $UUIDS_atxt{$Loop_L})
	End if 
End for 

SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY WITH ARRAY:C644([RAILBridgeInfo:37]RAILBridgeInfo_UUIDKey_s:46; $DuplicateUUIDS_atxt)
READ WRITE:C146([RAILBridgeInfo:37])
For ($Loop_L; 1; Records in selection:C76([RAILBridgeInfo:37]))
	GOTO SELECTED RECORD:C245([RAILBridgeInfo:37]; $Loop_L)
	LOAD RECORD:C52([RAILBridgeInfo:37])
	[RAILBridgeInfo:37]RAILBridgeInfo_UUIDKey_s:46:=Generate UUID:C1066
	SAVE RECORD:C53([RAILBridgeInfo:37])
	UNLOAD RECORD:C212([RAILBridgeInfo:37])
	
End for 

ARRAY TEXT:C222($UUIDS_atxt; 0)
ARRAY TEXT:C222($DuplicateUUIDS_atxt; 0)

ALL RECORDS:C47([ElmtRatingLoads:158])
DISTINCT VALUES:C339([ElmtRatingLoads:158]ElmtRatingLoads_UUIDKey_s:15; $UUIDS_atxt)
C_LONGINT:C283($Loop_L; $Count_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)

For ($Loop_L; 1; Size of array:C274($UUIDS_atxt))
	QUERY:C277([ElmtRatingLoads:158]; [ElmtRatingLoads:158]ElmtRatingLoads_UUIDKey_s:15=$UUIDS_atxt{$Loop_L})
	If ($Count_L>1)
		APPEND TO ARRAY:C911($DuplicateUUIDS_atxt; $UUIDS_atxt{$Loop_L})
	End if 
End for 

SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY WITH ARRAY:C644([ElmtRatingLoads:158]ElmtRatingLoads_UUIDKey_s:15; $DuplicateUUIDS_atxt)
READ WRITE:C146([ElmtRatingLoads:158])
For ($Loop_L; 1; Records in selection:C76([ElmtRatingLoads:158]))
	GOTO SELECTED RECORD:C245([ElmtRatingLoads:158]; $Loop_L)
	LOAD RECORD:C52([ElmtRatingLoads:158])
	[ElmtRatingLoads:158]ElmtRatingLoads_UUIDKey_s:15:=Generate UUID:C1066
	SAVE RECORD:C53([ElmtRatingLoads:158])
	UNLOAD RECORD:C212([ElmtRatingLoads:158])
	
End for 


//End ut_FixBadUUIDs

