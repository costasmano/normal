//Method: "RatingReportDisplayandMove"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/09/17, 16:06:42
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/14/17 16:39:12)
	Mods_2020_05  //Modified Ratings display so mount and movement can be from windows as well as macs
	//Modified by: Chuck Miller (05/11/20 16:22:20)
	// Modified by: Costas Manousakis-(Designer)-(5/29/20 17:10:31)
	Mods_2020_05
	//  `made the _MAC webareas NOT use the integrated webkit
	//  `enabled on Activate and on Unload on form events
	//  `use the PDFJS component to display the pdf on a mac to fix problems in OSX 10.13
	//  `use the copy of the pdf made by the component to display the pdf on WIN so the original is not locked by Adobe
	Mods_2020_08  //Complete work on moving signed PDF inspection reports like we do with ratings
	//Modified by: CJ (8/11/20 12:41:29)
	// Modified by: Costas Manousakis-(Designer)-(8/28/20 10:52:00)
	Mods_2020_08_bug
	//  `adjusted location and size of objects; vert marg of form; made web areas grow vert; and bottom obj move vert.
	//  `switch from using set values for window widths to calculated from form width and use the curr window ht (bot-top)
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		WA OPEN URL:C1020(*; "NewRatingReport_WIN"; "about:blank")
		WA OPEN URL:C1020(*; "NewRatingReport_MAC"; "about:blank")
		WA OPEN URL:C1020(*; "ExistingRatingReport_WIN"; "about:blank")
		WA OPEN URL:C1020(*; "ExistingRatingReport_MAC"; "about:blank")
		SET TIMER:C645(1)
		
	: (Form event code:C388=On Timer:K2:25)
		ARRAY TEXT:C222(v_65_035_atxt; 0)
		C_TEXT:C284(CopyFrom_txt)
		If (MovePage_L=0)
			MovePage_L:=1
		End if 
		FORM GOTO PAGE:C247(MovePage_L)
		ARRAY TEXT:C222($Selected_atxt; 0)
		C_TEXT:C284($SelectedFile_txt; $FourDigitYear_txt; $TwoDigitYear_txt)
		C_LONGINT:C283($loop_l)
		Case of 
			: (MovePage_L=1)  //Rating reports
				$SelectedFile_txt:=Select document:C905(""; ""; "Select Rating report pdf"; Multiple files:K24:7; $Selected_atxt)
				If (OK=1)
					OM_SetColoronForm(" ")
					OBJECT SET VISIBLE:C603(*; "CopyButton"; False:C215)
					
					$FourDigitYear_txt:=String:C10(Year of:C25([RatingReports:65]ReportDate:4); "0000")+String:C10(Month of:C24([RatingReports:65]ReportDate:4); "00")
					$TwoDigitYear_txt:=String:C10(Month of:C24([RatingReports:65]ReportDate:4); "00")+Substring:C12(String:C10(Year of:C25([RatingReports:65]ReportDate:4); "0000"); 3; 2)
					
					CopyFrom_txt:=$Selected_atxt{1}
					
					ARRAY TEXT:C222($Documents_atxt; 0)
					CLEAR VARIABLE:C89($Documents_atxt)
					ARRAY TEXT:C222(MatchedDocuments_atxt; 0)
					CLEAR VARIABLE:C89(MatchedDocuments_atxt)
					$SelectedFile_txt:=String:C10(Month of:C24([RatingReports:65]ReportDate:4); "00")+$SelectedFile_txt
					
					DOCUMENT LIST:C474(RatingRPTBDEPTFolder_txt; $Documents_atxt; Ignore invisible:K24:16)
					For ($loop_l; 1; Size of array:C274($Documents_atxt))
						If (Position:C15([Bridge MHD NBIS:1]BDEPT:1; $Documents_atxt{$loop_l})=1)
							If (Position:C15([Bridge MHD NBIS:1]BIN:3; $Documents_atxt{$loop_l})>0)
								If (Position:C15($FourDigitYear_txt; $Documents_atxt{$loop_l})>0) | (Position:C15($TwoDigitYear_txt; $Documents_atxt{$loop_l})>0)
									APPEND TO ARRAY:C911(MatchedDocuments_atxt; $Documents_atxt{$loop_l})
								End if 
							End if 
						End if 
					End for 
					SORT ARRAY:C229(MatchedDocuments_atxt)
					OBJECT SET VISIBLE:C603(*; "ExistingRatingReport@"; False:C215)
					OBJECT SET VISIBLE:C603(*; "NewRatingReport@"; False:C215)
					
					OBJECT SET VISIBLE:C603(*; "NewRatingReport_WIN"; True:C214)
					WA OPEN URL:C1020(*; "NewRatingReport_WIN"; $Selected_atxt{1})
					
					OBJECT SET VISIBLE:C603(*; "DeleteButton"; False:C215)
					OBJECT SET VISIBLE:C603(*; "DuplicateName"; False:C215)
					
					C_LONGINT:C283($left; $top; $right; $bottom)
					C_LONGINT:C283($Width_l; $Height_L)
					FORM GET PROPERTIES:C674("RatingReportDisplayandMove"; $Width_l; $Height_L)
					
					If (Size of array:C274(MatchedDocuments_atxt)>0)
						OBJECT SET VISIBLE:C603(*; "DuplicateName"; True:C214)
						OBJECT SET VISIBLE:C603(*; "DeleteButton"; True:C214)
						OBJECT SET VISIBLE:C603(*; "ExistingRatingReport@"; True:C214)
						
						ut_ResizeWindow(Frontmost window:C447; $Width_l; $Height_L)
						
						//C_OBJECT($Exist_o)
						//$Exist_o:=PDFViewer_New (RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{1})
						//C_TEXT($tHTML)
						OBJECT SET VISIBLE:C603(*; "ExistingRatingReport_WIN"; True:C214)
						WA OPEN URL:C1020(*; "ExistingRatingReport_WIN"; RatingRPTBDEPTFolder_txt+MatchedDocuments_atxt{1})
						
						MatchedDocuments_atxt:=1
						OBJECT SET TITLE:C194(*; "DuplicateName"; MatchedDocuments_atxt{MatchedDocuments_atxt})
					Else 
						
						GET WINDOW RECT:C443($left; $top; $right; $bottom; Frontmost window:C447)
						If (($right-$left)>($Width_l/2))
							ut_ResizeWindow(Frontmost window:C447; ($Width_l/2); ($bottom-$top))
						End if 
						
					End if 
					
				Else 
					CANCEL:C270
				End if 
			: (MovePage_L=2)  //Inspection reports
				
				$SelectedFile_txt:=Select document:C905(""; ".pdf"; "Select Signed Inspection PDF"; Multiple files:K24:7; $Selected_atxt)
				If (OK=1)
					OBJECT SET VISIBLE:C603(*; "CopyButton"; True:C214)
					CopyFrom_txt:=$Selected_atxt{1}
					ARRAY TEXT:C222($Documents_atxt; 0)
					CLEAR VARIABLE:C89($Documents_atxt)
					ARRAY TEXT:C222(MatchedDocuments_atxt; 0)
					CLEAR VARIABLE:C89(MatchedDocuments_atxt)
					C_TEXT:C284($Newname_txt)
					$Newname_txt:=String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")+"-"+\
						String:C10(Month of:C24([Inspections:27]Insp Date:78); "00")+"-"+\
						String:C10(Day of:C23([Inspections:27]Insp Date:78); "00")+"-"+\
						[Bridge MHD NBIS:1]BDEPT:1+"-"+[Bridge MHD NBIS:1]BIN:3+"-"+\
						[Inspection Type:31]Description:2
					
					C_BOOLEAN:C305($isCombined_B)
					
					If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
						$isCombined_B:=[Inspections:27]InspRtnSpcMemFlag:209
					Else 
						$isCombined_B:=(G_Insp_CountSpMs>0)
					End if 
					If ($isCombined_B)
						$Newname_txt:=$Newname_txt+" & Spec Mem"
					End if 
					$Newname_txt:=Replace string:C233($Newname_txt; "/"; "_")
					
					OBJECT SET TITLE:C194(*; "FileName"; $Newname_txt)
					$SelectedFile_txt:=String:C10(Month of:C24([Inspections:27]Insp Date:78); "00")+$SelectedFile_txt
					$FourDigitYear_txt:=String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")+"-"+String:C10(Month of:C24([Inspections:27]Insp Date:78); "00")
					
					DOCUMENT LIST:C474(MoveSignedInspFolder_txt; $Documents_atxt; Ignore invisible:K24:16)
					
					$loop_l:=Find in array:C230($Documents_atxt; $Newname_txt+".pdf")
					If ($loop_l>0)
						APPEND TO ARRAY:C911(MatchedDocuments_atxt; $Documents_atxt{$loop_l})
					End if 
					SORT ARRAY:C229(MatchedDocuments_atxt)
					OBJECT SET VISIBLE:C603(*; "ExistingRatingReport@"; False:C215)
					OBJECT SET VISIBLE:C603(*; "NewRatingReport@"; False:C215)
					
					OBJECT SET VISIBLE:C603(*; "NewRatingReport_WIN"; True:C214)
					WA OPEN URL:C1020(*; "NewRatingReport_WIN"; $Selected_atxt{1})
					
					OBJECT SET VISIBLE:C603(*; "DeleteButton"; False:C215)
					OBJECT SET VISIBLE:C603(*; "DuplicateName"; False:C215)
					
					C_LONGINT:C283($left; $top; $right; $bottom)
					C_LONGINT:C283($Width_l; $Height_L)
					FORM GET PROPERTIES:C674("RatingReportDisplayandMove"; $Width_l; $Height_L)
					
					If (Size of array:C274(MatchedDocuments_atxt)>0)
						OBJECT SET VISIBLE:C603(*; "DuplicateName"; True:C214)
						OBJECT SET VISIBLE:C603(*; "DeleteButton"; True:C214)
						OBJECT SET VISIBLE:C603(*; "ExistingRatingReport@"; True:C214)
						
						ut_ResizeWindow(Frontmost window:C447; $Width_l; $Height_L)
						
						C_OBJECT:C1216($Exist_o)
						$Exist_o:=PDFViewer_New(MoveSignedInspFolder_txt+MatchedDocuments_atxt{1})
						C_TEXT:C284($tHTML)
						
						OBJECT SET VISIBLE:C603(*; "ExistingRatingReport_WIN"; True:C214)
						WA OPEN URL:C1020(*; "ExistingRatingReport_WIN"; MoveSignedInspFolder_txt+MatchedDocuments_atxt{1})
						
						MatchedDocuments_atxt:=1
						OBJECT SET TITLE:C194(*; "DuplicateName"; MatchedDocuments_atxt{MatchedDocuments_atxt})
					Else 
						
						GET WINDOW RECT:C443($left; $top; $right; $bottom; Frontmost window:C447)
						If (($right-$left)>($Width_l/2))
							ut_ResizeWindow(Frontmost window:C447; ($Width_l/2); ($bottom-$top))
						End if 
						
					End if 
					
				Else 
					CANCEL:C270
				End if 
				
		End case 
		
		SET TIMER:C645(0)
		
	: (Form event code:C388=On Activate:K2:9)
		C_LONGINT:C283($lWindow)
		$lWindow:=Open form window:C675("PDF_Display_Helper"; Toolbar form window:K39:16)
		DIALOG:C40("PDF_Display_Helper")
		CLOSE WINDOW:C154($lWindow)
		
	: (Form event code:C388=On Unload:K2:2)
		//PDFViewer_CleanAll   //clean up all temp files
End case 
//End RatingReportDisplayandMove