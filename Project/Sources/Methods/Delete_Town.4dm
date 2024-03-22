//%attributes = {"invisible":true}
//procedure: Delete_Town

LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[TownLineInfo:73]BIN:1; ->[TownLineInfo:73]RefID:3; 1)
DELETE RECORD:C58([TownLineInfo:73])