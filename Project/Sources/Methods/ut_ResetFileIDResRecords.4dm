//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 03/03/16, 16:48:50
//----------------------------------------------------
//Method: ut_ResetFileIDResRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_03_bug  // 
	//Modified by: Chuck Miller (3/3/16 17:11:48)
	
End if 
[FileIDRes Table:60]Destination ID:3:="DEL-"+[FileIDRes Table:60]Destination ID:3
[FileIDRes Table:60]Local ID:2:="DEL-"+[FileIDRes Table:60]Local ID:2
SAVE RECORD:C53([FileIDRes Table:60])

//End ut_ResetFileIDResRecords