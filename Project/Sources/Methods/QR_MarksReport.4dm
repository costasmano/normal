//%attributes = {"shared":true}
If (False:C215)
	// Created by: Lori Peterson-(Lori)-(12/16/10 11:20:57)
	Mods_2010_12
End if 
C_TEXT:C284($0)
$0:=""
If (Count parameters:C259>0)
	
	C_TEXT:C284($1)
	If ([Bridge MHD NBIS:1]BIN:3#"")
		QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspComplete:168=True:C214)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"DV@")
		RELATE MANY SELECTION:C340([ElementsSafety:29]InspID:4)
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Description:22=($1+"@"))
		//QUERY SELECTION([ElementsSafety];[ElementsSafety]Rating#"N")
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2#" ")
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2#"")
		ORDER BY:C49([ElementsSafety:29]; [Inspections:27]Insp Date:78; <)
		
		If (Records in selection:C76([ElementsSafety:29])=0)
			UNLOAD RECORD:C212([Inspections:27])
			$0:=""
		Else 
			FIRST RECORD:C50([ElementsSafety:29])
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[ElementsSafety:29]InspID:4)
			$0:=[ElementsSafety:29]Rating:2
		End if 
		
	End if 
End if 