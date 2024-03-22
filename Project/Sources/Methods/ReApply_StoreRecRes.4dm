//%attributes = {"invisible":true}
// Method: ReApply_StoreRecRes
// Description
// Store a Record in the FileIDRes Table for the Reapply of activity log entries.
// 
// Parameters
//C_LONGINT($1;$vlTableNo)   : Table number
//C_STRING(80;$2;$vsLocalRef) : Original ID 
//C_STRING(80;$3;$vsRemRef) : New ID created during the Reapply
//C_STRING(80;$4;$vsRemoteServ) : fake destination  - set to "REAPPLY" from the Reapply_NRC method
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/15/10, 11:28:39
	// ----------------------------------------------------
	
	Mods_2010_03  // ("REAPPLY")
End if 
C_LONGINT:C283($1; $vlTableNo)
C_TEXT:C284($2; $vsLocalRef)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($3; $vsRemRef)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($4; $vsRemoteServ)  // Command Replaced was o_C_STRING length was 80

$vlTableNo:=$1
$vsLocalRef:=$2
$vsRemRef:=$3
$vsRemoteServ:=$4

CREATE RECORD:C68([FileIDRes Table:60])
[FileIDRes Table:60]File Number:1:=$vlTableNo
[FileIDRes Table:60]Local ID:2:=$vsRemRef
[FileIDRes Table:60]Destination ID:3:=$vsLocalRef
[FileIDRes Table:60]Destination:4:=$vsRemoteServ
SAVE RECORD:C53([FileIDRes Table:60])
ADD TO SET:C119([FileIDRes Table:60]; REAPPLY_FILEIDRES_SET)
UNLOAD RECORD:C212([FileIDRes Table:60])
