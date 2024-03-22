If (False:C215)
	//Object Method: [Contracts].Contracts In.cboType 
	// Modified by: costasmanousakis-(Designer)-(9/8/2006 10:47:31)
	Mods_2006_CM06
	// Modified by: Costas Manousakis-(Designer)-(5/11/16 16:10:28)
	Mods_2016_05_bug
	//  `use TOL_ListToArray ("RtgInspContrType to load  the list
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		TOL_ListToArray("RtgInspContrType"; Self:C308)
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

POPUPMENUC(Self:C308; Self:C308; ->[Contracts:79]ContractType:2)