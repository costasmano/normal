If (False:C215)
	//[Dialogs];"InspDialog1"
	//Set defaults
	// Modified by: costasmanousakis-(Designer)-(12/30/09 12:42:56)
	Mods_2009_12
	//  `Added checkbox on form for bridges needing inspection
	// Modified by: Costas Manousakis-(Designer)-(9/11/13 09:39:50)
	Mods_2013_09
	//  `Added 2nd page for Tunnel inspections - move Cancel and OK to pg 0
End if 

If (Form event code:C388=On Load:K2:1)
	n1:=1
	o1:=1
	p1:=1
	CBWaiver:=0
	C_BOOLEAN:C305(BRGList_TunnelsOnly_b)
	If (BRGList_TunnelsOnly_b)
		FORM GOTO PAGE:C247(2)
	End if 
End if 