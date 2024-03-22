//%attributes = {"invisible":true}
//procedure: CreateRandomSetinConsltRating
//purpose: create a random set of bridges  from the Search Bridge dialog
If (False:C215)
	//created: 6/26/2003
	//copied and modified from CreateRandomSet
	
	// Modified by: Costas Manousakis-(Designer)-(12/30/13 16:44:16)
	Mods_2013_12
	//  `Instead of blanking the search variables,  leave them with a space as a workaround for the v13  upgrade.
End if 

C_TEXT:C284($s)  // Command Replaced was o_C_STRING length was 30
If ((vAddTo=True:C214) & (Records in set:C195("Random Set")=0))
	CREATE SET:C116([Conslt Rating:63]; "Random Set")
End if 

OBJECT SET ENABLED:C1123(bFind; False:C215)  // Command Replaced was o_DISABLE BUTTON 
SHORT_MESSAGE("Looking…")

If (vAddTo=False:C215)
	USE NAMED SELECTION:C332("UserRegionA")
Else 
	ALL RECORDS:C47([Conslt Rating:63])
End if 

If (vBDEPT#"")
	$s:=Replace string:C233(vBDEPT; "_"; "")
	If (Length:C16($s)<6)
		$s:=$s+"@"
	End if 
	QUERY SELECTION:C341([Conslt Rating:63]; [Bridge MHD NBIS:1]BDEPT:1=$s)
End if 

If (vBIN#"")
	$s:=Replace string:C233(vBIN; " "; "")
	If (Length:C16($s)<3)
		$s:=$s+"@"
	End if 
	QUERY SELECTION:C341([Conslt Rating:63]; [Conslt Rating:63]BIN:1=$s)
End if 

CLOSE WINDOW:C154
OBJECT SET ENABLED:C1123(bFind; True:C214)  // Command Replaced was o_ENABLE BUTTON 
vBIN:=" "
vBDEPT:=""
GOTO OBJECT:C206(vBIN)

CREATE SET:C116([Conslt Rating:63]; "Found Bridge Recs Set")
If (Records in set:C195("Random Set")=0)
	If (vAddTo=False:C215)
		CREATE EMPTY SET:C140([Conslt Rating:63]; "Random Set")
	End if 
End if 
UNION:C120("Random Set"; "Found Bridge Recs Set"; "Random Set")
CLEAR SET:C117("Found Bridge Recs Set")