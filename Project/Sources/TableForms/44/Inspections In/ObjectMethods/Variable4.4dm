//SC aBIE on layout [BMS Inspections];"Inspections In".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Pop up menu for District Bridge Inspection Engineer.

//TRACE
If (False:C215)
	Mods_2017_08  //replace _ o _during
End if 
REDRAW:C174(aBIE)
If ((Form event code:C388=On Clicked:K2:4) & (aBIE>0))
	vBIE:=aBIE{aBIE}
End if 
POPUPMENUC(->aBIE; ->aBIE_ID; ->[BMS Inspections:44]DBrInspEngr:5)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([BMS Inspections:44]DBrInspEngr:5)#[BMS Inspections:44]DBrInspEngr:5)
		PushChange(1; ->[BMS Inspections:44]DBrInspEngr:5)
	End if 
End if 