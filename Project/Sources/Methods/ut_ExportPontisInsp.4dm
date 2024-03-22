//%attributes = {"invisible":true}
If (False:C215)
	//Export BMS Inspections and CondUnits for Pontis import
	Mods_2005_CM17
	Mods_2011_06  // CJ Miller`06/14/11, 10:32:15      ` Type all local variables for v11
End if 

If (Current user:C182="Designer")
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	RELATE MANY SELECTION:C340([Inspections:27]BIN:1)
	C_TEXT:C284($vs_MinDate)
	C_DATE:C307($vd_MinDate)
	C_LONGINT:C283($Choise)
	$vs_MinDate:=Request:C163("Enter Date"; "12/31/97")
	$vd_MinDate:=Date:C102($vs_MinDate)
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Date:78>$vd_MinDate)
	$Choise:=ut_3Option_Confirm("Select QC Status"; "Completed"; "DBIE OK"; "Final OK")
	Case of 
		: ($Choise=1)
			QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspComplete:168=True:C214)
		: ($Choise=2)
			QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved)
		: ($Choise=3)
			QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspApproved:167=BMS Approved)
	End case 
	CONFIRM:C162("Exclude UW Inspections from export?")
	If (OK=1)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"DV@")
	End if 
	
	RELATE MANY SELECTION:C340([Combined Inspections:90]NBISInspID:2)
	RELATE ONE SELECTION:C349([Combined Inspections:90]; [BMS Inspections:44])
	
	ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4)
	CONFIRM:C162("Now Exporting BMS Inspections Table!")
	If (OK=1)
		EXPORT DATA:C666("")
	End if 
	RELATE MANY SELECTION:C340([Cond Units:45]Inspection ID:2)
	CONFIRM:C162("Now Exporting Cond Units Table!")
	If (OK=1)
		EXPORT DATA:C666("")
	End if 
	
End if 