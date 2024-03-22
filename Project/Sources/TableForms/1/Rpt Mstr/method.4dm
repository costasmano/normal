If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/3/10 16:45:43)
	Mods_2010_02
	//change font size for windows
	// Modified by: Costas Manousakis-(Designer)-(5/10/16 16:35:34)
	Mods_2016_05_bug
	//  `added Item 104 in the list 
	// Modified by: Costas Manousakis-(Designer)-(6/14/19 10:35:11)
	Mods_2019_06_bug
	//  `Adjusted size and vert location of column labels, TownNmae and row data
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		If (<>WindowsPL_b)
			OBJECT SET FONT SIZE:C165(*; "Text@"; 6)
		End if 
		
End case 