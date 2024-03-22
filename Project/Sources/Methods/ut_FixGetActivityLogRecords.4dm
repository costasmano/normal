//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name(OS): Chuck Miller
// Date and time: 02/16/16, 16:58:00
// ----------------------------------------------------
// Method: ut_FixGetActivityLogRecords
// Description
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_02_bug
	// Modified by: Chuck Miller(2/16/16 16:58:01)
	
End if 
C_LONGINT:C283($1; $LocalID_L; $DRCCount_L)
$LocalID_L:=$1
C_LONGINT:C283($0)

QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=[FileIDRes Table:60]File Number:1; *)
QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Local ID:15=String:C10($LocalID_L))
SET QUERY DESTINATION:C396(Into variable:K19:4; $DRCCount_L)
QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Activity Type:3="DRC")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$DRCCount_L
//End ut_FixGetActivityLogRecords

