//%attributes = {"invisible":true}
//CreateRandomSetinCI_Contract 
//purpose: create a random set of bridges from the Search by ContractNo dialog
If (False:C215)
	//created: 4/22/2004
	//copied and modified from CreateRandomSet
	
	// Modified by: Costas Manousakis-(Designer)-(12/30/13 16:44:16)
	Mods_2013_12
	//  `Instead of blanking the search variables,  leave them with a space as a workaround for the v13  upgrade.
End if 

C_TEXT:C284($s)  // Command Replaced was o_C_STRING length was 30
If ((vAddTo=True:C214) & (Records in set:C195("Random Set")=0))
	CREATE SET:C116([Cons Inspection:64]; "Random Set")
End if 

OBJECT SET ENABLED:C1123(bFind; False:C215)  // Command Replaced was o_DISABLE BUTTON 
SHORT_MESSAGE("Looking…")

If (vAddTo=False:C215)
	USE NAMED SELECTION:C332("UserRegionA")
Else 
	ALL RECORDS:C47([Cons Inspection:64])
End if 

If (vContractNo#"")
	$s:=Replace string:C233(vContractNo; " "; "")
	If (Length:C16($s)<3)
		$s:=$s+"@"
	End if 
	QUERY SELECTION:C341([Cons Inspection:64]; [Cons Inspection:64]ConContractNo:7=$s)
End if 

If (vsAssignNo#"")
	QUERY SELECTION:C341([Cons Inspection:64]; [Cons Inspection:64]AssignConNumber:6=Num:C11(vsAssignNo))
End if 

CLOSE WINDOW:C154
OBJECT SET ENABLED:C1123(bFind; True:C214)  // Command Replaced was o_ENABLE BUTTON 
vContractNo:=" "
vsAssignNo:=""
GOTO OBJECT:C206(vContractNo)

CREATE SET:C116([Cons Inspection:64]; "Found Bridge Recs Set")
If (Records in set:C195("Random Set")=0)
	If (vAddTo=False:C215)
		CREATE EMPTY SET:C140([Cons Inspection:64]; "Random Set")
	End if 
End if 
UNION:C120("Random Set"; "Found Bridge Recs Set"; "Random Set")
CLEAR SET:C117("Found Bridge Recs Set")