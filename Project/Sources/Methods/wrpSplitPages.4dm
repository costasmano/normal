//%attributes = {"invisible":true}
//Method: wrpSplitPages
//Description
// Taken from code by Lutz Veith and modified to use the current page settings of the document
// Parameters
// $1 : $wpDoc : WP doc to split in pages
// $0 : $colPagedWpDocs : collection of objects each being a single page
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/13/21, 12:23:03
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(wrpSplitPages; $1)
	C_COLLECTION:C1488(wrpSplitPages; $0)
End if 
//
C_OBJECT:C1216($wpDoc; $1)
C_COLLECTION:C1488($colPagedWpDocs; $0)  // Result-Collection: One Page is one standalone wpDocItem in the collection

If (Count parameters:C259>0)
	$wpDoc:=OB Copy:C1225($1)
End if 

C_COLLECTION:C1488($colPageStartPositions)
C_LONGINT:C283($i; $start; $end)
C_OBJECT:C1216($wpRangePages)
C_COLLECTION:C1488($colPageParagraphs; $colParStartEnds)
C_TEXT:C284($Textindent; $leftMar)

$colPagedWpDocs:=New collection:C1472

$end:=WP Get page count:C1412($wpDoc)
$start:=1
Case of 
	: (Not:C34(OB Is defined:C1231($wpDoc)))
	: (OB Is empty:C1297($wpDoc))
	Else 
		
		$colPageStartPositions:=wrpGetDocPagePositions($wpDoc)
		$colParStartEnds:=wrpGetParagraphsStartEnd($wpDoc)
		
		For ($i; $start; $end)
			$colPagedWpDocs.push(OB Copy:C1225($wpDoc))
			Case of 
				: ($i>=$colPageStartPositions.length)  // Letzte Seite = Last page
					// Delete range before Last-Page
					$wpRangePages:=WP Text range:C1341($colPagedWpDocs[$i-1]; wk start text:K81:165; $colPageStartPositions[$i-1])
					WP INSERT BREAK:C1413($wpRangePages; wk page break:K81:188; wk append:K81:179; wk include in range:K81:180)  // ...bei Delete-Before muss der Paragraph gesplittet werden, sonst bekommt er die Styles der Vorläufer weil er kein eigenes Element mehr ist wenn man ihn seinen Anfang weglöscht (PageBreak wird nur als Mittel zum Splitt eingesetzt und wird in Folge gelöscht;; Der Fall ist nur relevant wenn AusschnittEnde innerhalb eines Paragraphen liegt und AusschnittStart ausserhab dessen)
					WP SET TEXT:C1574($wpRangePages; ""; wk replace:K81:177)  // Delete range before Last-Page (inclusive des obigen Hilfsmittel-PageBreakInserts)
					
					If (wrpPosInsideParagraph($colPageStartPositions[$i-1]; $colParStartEnds))
						$colPageParagraphs:=WP Get elements:C1550(WP Get body:C1516($colPagedWpDocs[$i-1]); wk type paragraph:K81:191)  // paragraphs work on the body of the document
						WP SET ATTRIBUTES:C1342($colPageParagraphs[0]; wk layout unit:K81:78; wk unit pt:K81:136)
						WP GET ATTRIBUTES:C1345($colPageParagraphs[0]; wk text indent:K81:52; $Textindent; wk margin left:K81:11; $leftMar)
						
						Case of 
							: (Num:C11($Textindent)>0)
								WP SET ATTRIBUTES:C1342($colPageParagraphs[0]; wk text indent:K81:52; "0pt")
							: (Num:C11($Textindent)<0)
								$leftMar:=String:C10(Num:C11($leftMar)-Num:C11($Textindent))+"pt"
								WP SET ATTRIBUTES:C1342($colPageParagraphs[0]; wk margin left:K81:11; $leftMar; wk text indent:K81:52; "0pt")
						End case 
						
						$colPageParagraphs[0].listType:=0  // and no bullets
					End if 
					
				: ($i=1)  // Erste Seite (nur wenn noch nicht als abweichend erledigt)
					$wpRangePages:=WP Text range:C1341($colPagedWpDocs[$i-1]; $colPageStartPositions[1]-1; wk end text:K81:164)
					WP SET TEXT:C1574($wpRangePages; ""; wk replace:K81:177)  // Delete range after First-Page
				Else 
					$wpRangePages:=WP Text range:C1341($colPagedWpDocs[$i-1]; $colPageStartPositions[$i]-1; wk end text:K81:164)
					WP SET TEXT:C1574($wpRangePages; ""; wk replace:K81:177)  // Delete range after Current-Page
					// Delete range before Current-Page
					$wpRangePages:=WP Text range:C1341($colPagedWpDocs[$i-1]; wk start text:K81:165; $colPageStartPositions[$i-1])
					WP INSERT BREAK:C1413($wpRangePages; wk page break:K81:188; wk append:K81:179; wk include in range:K81:180)  // ...bei Delete-Before muss der Paragraph gesplittet werden, sonst bekommt er die Styles der Vorläufer weil er kein eigenes Element mehr ist wenn man ihn seinen Anfang weglöscht (PageBreak wird nur als Mittel zum Splitt eingesetzt und wird in Folge gelöscht;; Der Fall ist nur relevant wenn AusschnittEnde innerhalb eines Paragraphen liegt und AusschnittStart ausserhab dessen)
					WP SET TEXT:C1574($wpRangePages; ""; wk replace:K81:177)  // Delete range before Current-Page (inclusive des obigen Hilfsmittel-PageBreakInserts)
					
					If (wrpPosInsideParagraph($colPageStartPositions[$i-1]; $colParStartEnds))
						$colPageParagraphs:=WP Get elements:C1550(WP Get body:C1516($colPagedWpDocs[$i-1]); wk type paragraph:K81:191)  // paragraphs work on the body of the document
						WP SET ATTRIBUTES:C1342($colPageParagraphs[0]; wk layout unit:K81:78; wk unit pt:K81:136)
						WP GET ATTRIBUTES:C1345($colPageParagraphs[0]; wk text indent:K81:52; $Textindent; wk margin left:K81:11; $leftMar)
						
						Case of 
							: (Num:C11($Textindent)>0)
								WP SET ATTRIBUTES:C1342($colPageParagraphs[0]; wk text indent:K81:52; "0pt")
							: (Num:C11($Textindent)<0)
								$leftMar:=String:C10(Num:C11($leftMar)-Num:C11($Textindent))+"pt"
								WP SET ATTRIBUTES:C1342($colPageParagraphs[0]; wk margin left:K81:11; $leftMar; wk text indent:K81:52; "0pt")
						End case 
						
						$colPageParagraphs[0].listType:=0  // and no bullets
					End if 
					
			End case 
		End for 
		
End case 

$0:=$colPagedWpDocs
//End wrpSplitPages