If (False:C215)
	//SC ZZ5 on layout [Personnel];"Inspectors In".
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	//Delete Record
	
	Mods_2005_CM05
	Mods_2005_CM16
End if 

C_TEXT:C284($Text)  //Alert message text.

$Text:="Do you really want to delete this inspector?"
CONFIRM:C162($Text)
If (OK=1)
	C_LONGINT:C283($BMSTrips; $SFTYTrips; $BMSTMLdr; $SFTYTmLdr; $BMSBIE; $SFTYBIE; $totalHits)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $BMSTrips)
	QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Person ID:2=[Personnel:42]Person ID:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $BMSTMLdr)
	QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]TeamLeader:6=[Personnel:42]Person ID:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $BMSBIE)
	QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]DBrInspEngr:5=[Personnel:42]Person ID:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $SFTYTrips)
	QUERY:C277([Field Trip:43]; [Field Trip:43]Person ID:2=[Personnel:42]Person ID:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $SFTYTmLdr)
	QUERY:C277([Inspections:27]; [Inspections:27]TeamLeader:4=[Personnel:42]Person ID:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $SFTYBIE)
	QUERY:C277([Inspections:27]; [Inspections:27]DBrInspEngr:3=[Personnel:42]Person ID:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$totalHits:=$BMSTrips+$BMSTMLdr+$BMSBIE+$SFTYTrips+$SFTYTmLdr+$SFTYBIE
	
	If ($totalHits>0)
		$Text:="This inspector is "
		If ($BMSTrips>0)
			$Text:=$Text+"a BMS Tm Mbr ("+String:C10($BMSTrips)+") "
		End if 
		If ($BMSTMLdr>0)
			$Text:=$Text+"a BMS Tm Ldr ("+String:C10($BMSTMLdr)+")"
		End if 
		If ($BMSBIE>0)
			$Text:=$Text+"a BMS BIE ("+String:C10($BMSBIE)+")"
		End if 
		If ($SFTYTrips>0)
			$Text:=$Text+"a SFTY Tm Mbr ("+String:C10($SFTYTrips)+")"
		End if 
		If ($SFTYTMLdr>0)
			$Text:=$Text+"a SFTY Tm Ldr ("+String:C10($SFTYTMLdr)+")"
		End if 
		If ($SFTYBIE>0)
			$Text:=$Text+"a SFTY BIE ("+String:C10($SFTYBIE)+")"
		End if 
		
		$Text:=$Text+"!"+<>sCR+"This record will not be deleted!"
		ALERT:C41($Text)
	Else 
		//The relation automatically deletes related many records.    
		LogDeletion(->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; 1)
		DELETE RECORD:C58([Personnel:42])
		CANCEL:C270
	End if 
End if 