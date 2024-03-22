If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/17/10 09:02:18)
	Mods_2010_05
	//  `Changed from Relate Many to a query by BIN and Order by
End if 

//Add button in Consultant Inspection
C_BOOLEAN:C305(vbNewInspRec)

FORM SET INPUT:C55([Cons Inspection:64]; "Cslt Insp In")
ADD RECORD:C56([Cons Inspection:64])
vbNewInspRec:=False:C215
QUERY:C277([Cons Inspection:64]; [Cons Inspection:64]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]InspMonth:34; <)
