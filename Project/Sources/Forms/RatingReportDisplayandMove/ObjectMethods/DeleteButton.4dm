//Method: RatingReportDisplayandMove.DeleteButton
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/16/17, 14:29:49
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/16/17 16:22:20)
	Mods_2020_05  //Modified Ratings display so mount and movement can be from windows as well as macs
	//Modified by: Chuck Miller (05/11/20 16:22:20)
	// Modified by: Costas Manousakis-(Designer)-(5/29/20 17:15:49)
	Mods_2020_05
	//  `load "about:blank" before updating the area with text. 
End if 
//

C_BOOLEAN:C305($Delete_B)
$Delete_B:=False:C215
If (Test path name:C476(RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{MatchedDocuments_atxt})=Is a document:K24:1)
	
	CONFIRM:C162("Are you sure you wish to Delete "+RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{MatchedDocuments_atxt})
	$Delete_B:=(OK=1)
End if 
If ($Delete_B)
	If (MR_CheckandResetDocumentLock(RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{MatchedDocuments_atxt}; False:C215))
	End if 
	ON ERR CALL:C155("4D_Errors")
	
	If (4DError_b)
		ALERT:C41("4D error occured First description line is "+SQL_InternalDescriptions_atxt{1}+" Notify MADOT BMS Support")
	Else 
		4DError_b:=False:C215
		C_TEXT:C284($Deleted_txt)
		$Deleted_txt:="File named "+RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{MatchedDocuments_atxt}+" will be deleted"
		C_TEXT:C284($file_txt; $WebArea)
		$WebArea:="ExistingRatingReport_MAC"
		
		If (OBJECT Get visible:C1075(*; "ExistingRatingReport_WIN"))
			$WebArea:="ExistingRatingReport_WIN"
		End if 
		
		If (False:C215)
			Case of 
				: (Folder separator:K24:12=":")
					WA OPEN URL:C1020(*; $WebArea; "about:blank")
					WA SET PAGE CONTENT:C1037(*; $WebArea; "<html><body><h1>"+$Deleted_txt+"</h1></body></html>"; "file:///")
					
				Else 
					WA OPEN URL:C1020(*; "ExistingRatingReport_WIN"; "about:blank")
					WA SET PAGE CONTENT:C1037(*; "ExistingRatingReport_WIN"; "<html><body><h1>"+$Deleted_txt+"</h1></body></html>"; "file:///")
			End case 
			
			
		End if 
		
		WA OPEN URL:C1020(*; $WebArea; "about:blank")
		WA SET PAGE CONTENT:C1037(*; $WebArea; "<html><body><h1>"+$Deleted_txt+"</h1></body></html>"; "file:///")
		
		DELETE DOCUMENT:C159(RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{MatchedDocuments_atxt})
		
		$Deleted_txt:="File named "+RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{MatchedDocuments_atxt}+" was deleted"
		
		If (False:C215)
			Case of 
				: (Folder separator:K24:12=":")
					WA OPEN URL:C1020(*; $WebArea; "about:blank")
					WA SET PAGE CONTENT:C1037(*; $WebArea; "<html><body><h1>"+$Deleted_txt+"</h1></body></html>"; "file:///")
				Else 
					WA OPEN URL:C1020(*; "ExistingRatingReport_WIN"; "about:blank")
					WA SET PAGE CONTENT:C1037(*; "ExistingRatingReport_WIN"; "<html><body><h1>"+$Deleted_txt+"</h1></body></html>"; "file:///")
			End case 
			
		End if 
		
		WA OPEN URL:C1020(*; $WebArea; "about:blank")
		WA SET PAGE CONTENT:C1037(*; $WebArea; "<html><body><h1>"+$Deleted_txt+"</h1></body></html>"; "file:///")
		OBJECT SET VISIBLE:C603(*; "DeleteButton"; False:C215)
		DELETE FROM ARRAY:C228(MatchedDocuments_atxt; MatchedDocuments_atxt; 1)
		MatchedDocuments_atxt:=-1
		OBJECT SET TITLE:C194(*; "DuplicateName"; "")
	End if 
	ON ERR CALL:C155("")
End if 
//End RatingReportDisplayandMove.DeleteButton