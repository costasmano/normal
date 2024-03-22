//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/25/08, 12:28:42
	// ----------------------------------------------------
	// Method: ut_WarmUpDatabase
	// Description
	//  ` Perform a 'Warm-up' of the database, by attempting to create and 
	//  ` then delete a record. To be used during startup of a standalone compiled
	//  ` app or on server startup.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	Mods_2010_02
	//  `Change the table to one with a lot of records - [Activity Log]
	
End if 
If ((Application type:C494=4D Server:K5:6) | (Application type:C494=4D Volume desktop:K5:2))
	If (Application type:C494#4D Server:K5:6)
		SHORT_MESSAGE("Warming up database...")
	End if 
	READ ONLY:C145(*)
	
	READ WRITE:C146([Activity Log:59])
	
	ALL RECORDS:C47([Activity Log:59])
	LAST RECORD:C200([Activity Log:59])
	LOAD RECORD:C52([Activity Log:59])
	[Activity Log:59]RefID:28:=[Activity Log:59]RefID:28
	SAVE RECORD:C53([Activity Log:59])
	UNLOAD RECORD:C212([Activity Log:59])
	
	//FLUSH CACHE
	READ WRITE:C146(*)
	If (Application type:C494#4D Server:K5:6)
		CLOSE WINDOW:C154
	End if 
	
End if 