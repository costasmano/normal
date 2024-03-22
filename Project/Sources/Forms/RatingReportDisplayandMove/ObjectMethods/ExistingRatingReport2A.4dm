//Method: RatingReportDisplayandMove.MatchedDocuments_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/14/17, 14:24:11
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/16/17 16:22:20)
	Mods_2020_05  //Modified Ratings display so mount and movement can be from windows as well as macs
	//Modified by: Chuck Miller (05/11/20 16:22:20)
	// Modified by: Costas Manousakis-(Designer)-(5/29/20 17:07:48)
	Mods_2020_05
	//  `modified to use the PDFJS component.  For Mac use the PDFJS viewer, 
	//  `for WIN use the copy of the pdf made by the component to avoid locking original by Adobe
End if 
//
If (MatchedDocuments_atxt>0)
	C_OBJECT:C1216($Exist_o)
	$Exist_o:=PDFViewer_New(RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{MatchedDocuments_atxt})
	C_TEXT:C284($tHTML)
	OBJECT SET VISIBLE:C603(*; "ExistingRatingReport_WIN"; True:C214)
	WA OPEN URL:C1020(*; "ExistingRatingReport_WIN"; RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{MatchedDocuments_atxt})
	OBJECT SET TITLE:C194(*; "DuplicateName"; MatchedDocuments_atxt{MatchedDocuments_atxt})
	OBJECT SET VISIBLE:C603(*; "DeleteButton"; True:C214)
End if 

//End RatingReportDisplayandMove.MatchedDocuments_atxt