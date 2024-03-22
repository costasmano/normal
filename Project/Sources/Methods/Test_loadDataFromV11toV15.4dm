//%attributes = {"invisible":true}
//Method: Test_loadDataFromV11toV15
//Description
// test of data from v11 to v15 when fields added in v11 db AFTER the uuid field added in v15
// tables [RAILBridgeInfo] and [ElmtRatingLoads]
// populate new fields in  records of table. save the data for comparison. export records with send record
// load that export in a v15 db and verify if data read correctly
// Option ResetUUID will apply a new uuid to fields for [RAILBridgeInfo] and [ElmtRatingLoads]
// Option Load will load from a file created usind SEND RECORD for tables [RAILBridgeInfo] and [ElmtRatingLoads]
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/08/17, 16:15:49
	// ----------------------------------------------------
	//Created : 
	Mods_2017_03
End if 
//
C_TEXT:C284($WhatToDo_txt)
$WhatToDo_txt:=Request:C163("Choose one of Load ; ResetUUID"; "ResetUUID")


Case of 
	: ($WhatToDo_txt="LOAD")
		//[RAILBridgeInfo]
		ALERT:C41("[RAILBridgeInfo]")
		SET CHANNEL:C77(10; "")
		While (OK=1)
			RECEIVE RECORD:C79([RAILBridgeInfo:37])
			[RAILBridgeInfo:37]RAILBridgeInfo_UUIDKey_s:46:=Generate UUID:C1066
			SAVE RECORD:C53([RAILBridgeInfo:37])
		End while 
		SET CHANNEL:C77(11)
		
		ALERT:C41("[[ElmtRatingLoads]]")
		SET CHANNEL:C77(10; "")
		While (OK=1)
			RECEIVE RECORD:C79([ElmtRatingLoads:158])
			[ElmtRatingLoads:158]ElmtRatingLoads_UUIDKey_s:15:=Generate UUID:C1066
			SAVE RECORD:C53([ElmtRatingLoads:158])
		End while 
		SET CHANNEL:C77(11)
		
	: ($WhatToDo_txt="ResetUUID")
		ALL RECORDS:C47([RAILBridgeInfo:37])
		
		While (Not:C34(End selection:C36([RAILBridgeInfo:37])))
			[RAILBridgeInfo:37]RAILBridgeInfo_UUIDKey_s:46:=Generate UUID:C1066
			SAVE RECORD:C53([RAILBridgeInfo:37])
			NEXT RECORD:C51([RAILBridgeInfo:37])
		End while 
		
		ALL RECORDS:C47([ElmtRatingLoads:158])
		
		While (Not:C34(End selection:C36([ElmtRatingLoads:158])))
			[ElmtRatingLoads:158]ElmtRatingLoads_UUIDKey_s:15:=Generate UUID:C1066
			SAVE RECORD:C53([ElmtRatingLoads:158])
			NEXT RECORD:C51([ElmtRatingLoads:158])
		End while 
		
		
End case 


//End Test_loadDataFromV11toV15