//%attributes = {"invisible":true}
//G_StoreRecResolution
//Store the resolution of record IDs in [FileIDRes Table]
//Mar-2003
C_LONGINT:C283($1; $vlTableNo)
C_TEXT:C284($2; $vsLocalRef)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($3; $vsRemRef)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($4; $vsRemoteServ)  // Command Replaced was o_C_STRING length was 80

$vlTableNo:=$1
$vsLocalRef:=$2
$vsRemRef:=$3
$vsRemoteServ:=$4

//Put two entries into the file address resolution table
CREATE RECORD:C68([FileIDRes Table:60])
[FileIDRes Table:60]File Number:1:=$vlTableNo
[FileIDRes Table:60]Local ID:2:=$vsRemRef
[FileIDRes Table:60]Destination ID:3:=$vsLocalRef
[FileIDRes Table:60]Destination:4:="Here"  //one for data coming from server
SAVE RECORD:C53([FileIDRes Table:60])
CREATE RECORD:C68([FileIDRes Table:60])
[FileIDRes Table:60]File Number:1:=$vlTableNo
[FileIDRes Table:60]Local ID:2:=$vsLocalRef
[FileIDRes Table:60]Destination ID:3:=$vsRemRef
[FileIDRes Table:60]Destination:4:=$vsRemoteServ  //and one for data going back to server
SAVE RECORD:C53([FileIDRes Table:60])
UNLOAD RECORD:C212([FileIDRes Table:60])