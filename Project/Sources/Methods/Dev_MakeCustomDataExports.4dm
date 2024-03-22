//%attributes = {"invisible":true}
//Method: Dev_MakeCustomDataExports
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/28/17, 09:34:37
	// ----------------------------------------------------
	//Created : 
	Mods_2017_06
End if 
//

QUERY:C277([Bridge MHD NBIS:1])

C_LONGINT:C283($count)
$count:=Num:C11(Request:C163("How many of the "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" records?"))

REDUCE SELECTION:C351([Bridge MHD NBIS:1]; $count)
If (Records in selection:C76([Bridge MHD NBIS:1])>0)
	C_TEXT:C284($folder)
	$folder:=Select folder:C670("Choose folder for exports")
	
	ALERT:C41("exporting "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" [Bridge MHD NBIS]")
	SET CHANNEL:C77(10; $folder+"BridgeTable.export")
	FIRST RECORD:C50([Bridge MHD NBIS:1])
	While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
		SEND RECORD:C78([Bridge MHD NBIS:1])
		NEXT RECORD:C51([Bridge MHD NBIS:1])
	End while 
	SET CHANNEL:C77(11)
	RELATE MANY SELECTION:C340([Inspections:27]BIN:1)
	ALERT:C41("exporting "+String:C10(Records in selection:C76([Inspections:27]))+" inspections")
	SET CHANNEL:C77(10; $folder+"inspections.export")
	FIRST RECORD:C50([Inspections:27])
	While (Not:C34(End selection:C36([Inspections:27])))
		SEND RECORD:C78([Inspections:27])
		NEXT RECORD:C51([Inspections:27])
	End while 
	SET CHANNEL:C77(11)
	
	RELATE MANY SELECTION:C340([Combined Inspections:90]BIN:1)
	ALERT:C41("exporting "+String:C10(Records in selection:C76([Combined Inspections:90]))+" [Combined Inspections]")
	SET CHANNEL:C77(10; $folder+"Combined Inspections.export")
	FIRST RECORD:C50([Combined Inspections:90])
	While (Not:C34(End selection:C36([Combined Inspections:90])))
		SEND RECORD:C78([Combined Inspections:90])
		NEXT RECORD:C51([Combined Inspections:90])
	End while 
	SET CHANNEL:C77(11)
	RELATE MANY SELECTION:C340([BMS Inspections:44]BIN:2)
	ALERT:C41("exporting "+String:C10(Records in selection:C76([BMS Inspections:44]))+" [[BMS Inspections]]")
	SET CHANNEL:C77(10; $folder+"BMS Inspections.export")
	FIRST RECORD:C50([BMS Inspections:44])
	While (Not:C34(End selection:C36([BMS Inspections:44])))
		SEND RECORD:C78([BMS Inspections:44])
		NEXT RECORD:C51([BMS Inspections:44])
	End while 
	SET CHANNEL:C77(11)
	RELATE MANY SELECTION:C340([InventoryPhotoInsp:112]BIN:2)
	ALERT:C41("exporting "+String:C10(Records in selection:C76([InventoryPhotoInsp:112]))+" [InventoryPhotoInsp]")
	SET CHANNEL:C77(10; $folder+"InventoryPhotoInsp.export")
	FIRST RECORD:C50([InventoryPhotoInsp:112])
	While (Not:C34(End selection:C36([InventoryPhotoInsp:112])))
		SEND RECORD:C78([InventoryPhotoInsp:112])
		NEXT RECORD:C51([InventoryPhotoInsp:112])
	End while 
	SET CHANNEL:C77(11)
	RELATE MANY SELECTION:C340([RatingReports:65]BIN:1)
	ALERT:C41("exporting "+String:C10(Records in selection:C76([RatingReports:65]))+" [RatingReports]")
	SET CHANNEL:C77(10; $folder+"RatingReports.export")
	FIRST RECORD:C50([RatingReports:65])
	While (Not:C34(End selection:C36([RatingReports:65])))
		SEND RECORD:C78([RatingReports:65])
		NEXT RECORD:C51([RatingReports:65])
	End while 
	SET CHANNEL:C77(11)
	ALL RECORDS:C47([Personnel:42])
	ALERT:C41("Exporting Personnel")
	SET CHANNEL:C77(10; $folder+"Personnel.export")
	FIRST RECORD:C50([Personnel:42])
	While (Not:C34(End selection:C36([Personnel:42])))
		SEND RECORD:C78([Personnel:42])
		NEXT RECORD:C51([Personnel:42])
	End while 
	SET CHANNEL:C77(11)
	ALL RECORDS:C47([Inspection Type:31])
	ALERT:C41("Exporting [Inspection Type]")
	SET CHANNEL:C77(10; $folder+"Inspection Type.export")
	FIRST RECORD:C50([Inspection Type:31])
	While (Not:C34(End selection:C36([Inspection Type:31])))
		SEND RECORD:C78([Inspection Type:31])
		NEXT RECORD:C51([Inspection Type:31])
	End while 
	SET CHANNEL:C77(11)
	
End if 
//End Dev_MakeCustomDataExports