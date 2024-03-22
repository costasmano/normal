If (False:C215)
	//Object Method: [Contracts].Contracts In.cboStatus 
	// Modified by: costasmanousakis-(Designer)-(9/8/2006 10:49:37)
	Mods_2006_CM06
	// Modified by: Costas Manousakis-(Designer)-(5/11/16 16:09:57)
	Mods_2016_05_bug
	//  `use TOL_ListToArray ("RtgInspContrStatus to load the list
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		TOL_ListToArray("RtgInspContrStatus"; Self:C308)
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

POPUPMENUC(Self:C308; Self:C308; ->[Contracts:79]ContractStatus:7)