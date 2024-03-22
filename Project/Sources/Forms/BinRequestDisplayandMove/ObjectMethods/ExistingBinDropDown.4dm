//Method: "BinRequestDisplayandMove".ExistingBinDropDown
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	Mods_2019_07
	// Modified by: Costas Manousakis-(Designer)-(6/1/20 09:52:53)
	Mods_2020_05
	//  `modified to use the PDFJS component.
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($picked_L)
		$picked_L:=MatchedDocuments_atxt
		
		WA OPEN URL:C1020(*; "ExistingBinRequest"; MatchedDocuments_atxt{0}+MatchedDocuments_atxt{$picked_L})
		
End case 

//End "BinRequestDisplayandMove".ExistingBinDropDown