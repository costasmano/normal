//%attributes = {"invisible":true}
//Method: Dev_LoadCustomData
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/28/17, 16:26:14
	// ----------------------------------------------------
	//Created : 
	Mods_2017_06_bug
End if 
//

ALERT:C41("Bridge table")
SET CHANNEL:C77(10; "")
RECEIVE RECORD:C79([Bridge MHD NBIS:1])
While (ok=1)
	SAVE RECORD:C53([Bridge MHD NBIS:1])
	RECEIVE RECORD:C79([Bridge MHD NBIS:1])
End while 
SET CHANNEL:C77(11)

ALERT:C41("[Inspections] table")
SET CHANNEL:C77(10; "")
RECEIVE RECORD:C79([Inspections:27])
While (ok=1)
	SAVE RECORD:C53([Inspections:27])
	RECEIVE RECORD:C79([Inspections:27])
End while 

SET CHANNEL:C77(11)

ALERT:C41("[[Combined Inspections]] table")
SET CHANNEL:C77(10; "")
RECEIVE RECORD:C79([Combined Inspections:90])
While (ok=1)
	SAVE RECORD:C53([Combined Inspections:90])
	RECEIVE RECORD:C79([Combined Inspections:90])
End while 

SET CHANNEL:C77(11)

ALERT:C41("[[BMS Inspections]] table")
SET CHANNEL:C77(10; "")
RECEIVE RECORD:C79([BMS Inspections:44])
While (ok=1)
	SAVE RECORD:C53([BMS Inspections:44])
	RECEIVE RECORD:C79([BMS Inspections:44])
End while 

SET CHANNEL:C77(11)

ALERT:C41("[[InventoryPhotoInsp]] table")
SET CHANNEL:C77(10; "")
RECEIVE RECORD:C79([InventoryPhotoInsp:112])
While (ok=1)
	SAVE RECORD:C53([InventoryPhotoInsp:112])
	RECEIVE RECORD:C79([InventoryPhotoInsp:112])
End while 

SET CHANNEL:C77(11)

ALERT:C41("[[RatingReports]] table")
SET CHANNEL:C77(10; "")
RECEIVE RECORD:C79([RatingReports:65])
While (ok=1)
	SAVE RECORD:C53([RatingReports:65])
	RECEIVE RECORD:C79([RatingReports:65])
End while 

SET CHANNEL:C77(11)

ALERT:C41("[[Personnel]] table")
SET CHANNEL:C77(10; "")
RECEIVE RECORD:C79([Personnel:42])
While (ok=1)
	SAVE RECORD:C53([Personnel:42])
	RECEIVE RECORD:C79([Personnel:42])
End while 

SET CHANNEL:C77(11)

ALERT:C41("[[Inspection Type]] table")
SET CHANNEL:C77(10; "")
RECEIVE RECORD:C79([Inspection Type:31])
While (ok=1)
	SAVE RECORD:C53([Inspection Type:31])
	RECEIVE RECORD:C79([Inspection Type:31])
End while 

SET CHANNEL:C77(11)

ALERT:C41("Done")
//End Dev_LoadCustomData