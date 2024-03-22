//%attributes = {"invisible":true}
// PM: "wrpPrintInPartsSplitPages" (neu LV 02.10.2018) 
// $1 - OBJECT - $wpDoc - Zu splittendes WP-Dokument
// $2 - REAL - $wpAreaWidth - Gewünschte WP-Dokument-Seiten-Breite
// $3 - REAL - $wpAreaHeight - Gewünschte WP-Dokument-Seiten-Höhe
// $4 - OBJECT - $pipParamObj - JSON-Objekt mit PiP-Einstellungen so wie über wrpPrintInPartsNewParamObj angeboten
// $0 - COLLECTION - $colPagedWpDocs - Standalone-Dokumente mit je eine Seite (Einträge in Collection beginnen mit Null, so enthält $colPagedWpDocs[0] die Seite1 und $colPagedWpDocs[1] die Seite2 ...usw)
// Splittet ein WP-Dokument in mehrere Standalone-Dokumente mit je eine Seite und gibt diese als Collection in $0 zurück
// Eine in der Höhe abweichende "Erste Seite innerhalb PiP" kann man über $pipParamObj.currPageLeftoverHeight vorgeben
// $pipParamObj.currPageLeftoverHeight gibt an wieviel Platz auf einer bereits teilweise bedruckten Seite noch verblieben ist
// ...dieser Seitenrest kann genutzt werden um einen ersten Teil des WPs noch mit unterzubringen
// ...so kann die erste WP-Seite (ein Standalone-Dokument in der Ergebnis-Collection) auch abweichend eine geringere Höhe haben
// ...und der verbliebene WP-Rest wird dann automatisch passend auf die folgenden Seiten verteilt
// Letzte Änderung: LV 02.10.2018, 20:30 Uhr

C_OBJECT:C1216($wpDoc; $1)
C_REAL:C285($wpAreaWidth; $2)
C_REAL:C285($wpAreaHeight; $3)
C_OBJECT:C1216($pipParamObj; $4)
C_COLLECTION:C1488($colPagedWpDocs; $0)  // Result-Collection: One Page is one standalone wpDocItem in the collection
C_BOOLEAN:C305($pageMarginsInsideWParea; $isBeginWithNewPage; $firstIsDone)
C_REAL:C285($totalPrintPaperWidth; $totalPrintPaperHeight)
C_REAL:C285($pageMarginTop; $pageMarginRight; $pageMarginBottom; $pageMarginLeft)
C_OBJECT:C1216($wpDocTemplateFirstPage; $wpDocTemplateFollowPage; $wpPropertiesObjFirstPage; $wpPropertiesObjFollowPage)
C_LONGINT:C283($ignorePageLeftoverHeight; $currPageLeftoverHeight)
C_LONGINT:C283($headerHeight; $footerHeight)
C_LONGINT:C283($i; $anz; $numFirstDone; $start)
C_COLLECTION:C1488($colPageStartPositions)
C_OBJECT:C1216($wpRangeAll; $wpRangeEnd; $posStart; $posEnd; $wpBody; $wpRangePages; $objBodyTarget)
C_TEXT:C284($pageMarginValueCssText; $marginTopTxt; $marginRightTxt; $marginBottomTxt; $marginLeftTxt)
C_BOOLEAN:C305($useSpecials; $useSpecialBG; $useSpecialBorder; $useSpecialPadding; $useSpecialMargin)
C_BOOLEAN:C305($headerContainsMargin; $footerContainsMargin)

$pageMarginsInsideWParea:=False:C215  // True=RandImWParea | False=RandAusserhalbWParea
$wpAreaWidth:=0
$wpAreaHeight:=0
$currPageLeftoverHeight:=0
$ignorePageLeftoverHeight:=19  // Default 19px ignorieren und lieber mit frischer Seite beginnen
$colPagedWpDocs:=New collection:C1472

If (Count parameters:C259>0)
	$wpDoc:=OB Copy:C1225($1)
	If (Count parameters:C259>1)
		$wpAreaWidth:=$2
		If (Count parameters:C259>2)
			$wpAreaHeight:=$3
			If (Count parameters:C259>3)
				$pipParamObj:=$4
			End if 
		End if 
	End if 
End if 

Case of 
	: (Not:C34(OB Is defined:C1231($wpDoc)))
	: (OB Is empty:C1297($wpDoc))
	Else 
		$headerContainsMargin:=True:C214
		$footerContainsMargin:=True:C214
		$pageMarginsInsideWParea:=$pipParamObj.pageMarginsInsideWP
		$ignorePageLeftoverHeight:=$pipParamObj.ignorePageLeftoverH
		$totalPrintPaperWidth:=$pipParamObj.totalPrintPaperWidt  // Angabe in px (72dpi) ...total, also inclusive der wahlweise linken+rechten Seitenränder/pageMargin
		$totalPrintPaperHeight:=$pipParamObj.totalPrintPaperHeig  // Angabe in px (72dpi) ...total, also inclusive der wahlweise oben+unten Seitenränder/pageMargin
		$pageMarginTop:=$pipParamObj.pageMarginTop
		$pageMarginRight:=$pipParamObj.pageMarginRight
		$pageMarginBottom:=$pipParamObj.pageMarginBottom
		$pageMarginLeft:=$pipParamObj.pageMarginLeft
		If ($pipParamObj.headerUse)
			$headerHeight:=$pipParamObj.headerHeight
		Else 
			$headerHeight:=0
		End if 
		If ($pipParamObj.footerUse)
			$footerHeight:=$pipParamObj.footerHeight
		Else 
			$footerHeight:=0
		End if 
		If ($headerHeight<1)  //...Korrektur, wenn HeaderHöhe kleiner Minimum, dann Header nicht drucken
			$pipParamObj.headerUse:=False:C215
			$headerHeight:=0
		End if 
		If ($footerHeight<1)  //...Korrektur, wenn HeaderHöhe kleiner Minimum, dann Header nicht drucken
			$pipParamObj.footerUse:=False:C215
			$footerHeight:=0
		End if 
		If (($headerHeight+$footerHeight+$pageMarginTop+$pageMarginBottom+($ignorePageLeftoverHeight*2))>$totalPrintPaperHeight)
			// Sonder-Fehlfall, wenn Header+Footer schon nahezu das ganze Blatt überfüllen, dann drucken wir zur Not besser ohne Header+Footer
			$pipParamObj.headerUse:=False:C215
			$headerHeight:=0
			$pipParamObj.footerUse:=False:C215
			$footerHeight:=0
		End if 
		If (($headerContainsMargin) & ($pipParamObj.headerUse))
			$pageMarginTop:=0
		End if 
		If (($footerContainsMargin) & ($pipParamObj.footerUse))
			$pageMarginBottom:=0
		End if 
		If ($pageMarginsInsideWParea)
			$currPageLeftoverHeight:=$pipParamObj.currPageLeftoverHei-$footerHeight  // Angabe in px (72dpi)
		Else 
			$currPageLeftoverHeight:=$pipParamObj.currPageLeftoverHei-$pageMarginBottom-$footerHeight  // Angabe in px (72dpi)
		End if 
		$isBeginWithNewPage:=($currPageLeftoverHeight<=$ignorePageLeftoverHeight)
		
		// Merke: 1px=1pt wenn 72dpi (Embedd-Print-Form)
		If ($pageMarginsInsideWParea)
			$marginTopTxt:=Replace string:C233(String:C10($pageMarginTop); ","; ".")+"pt "
			$marginRightTxt:=Replace string:C233(String:C10($pageMarginRight); ","; ".")+"pt "
			$marginBottomTxt:=Replace string:C233(String:C10($pageMarginBottom); ","; ".")+"pt "
			$marginLeftTxt:=Replace string:C233(String:C10($pageMarginLeft); ","; ".")+"pt"
			$pageMarginValueCssText:=$marginTopTxt+$marginRightTxt+$marginBottomTxt+$marginLeftTxt
		Else 
			$pageMarginValueCssText:="0cm"
		End if 
		
		$wpPropertiesObjFollowPage:=wrpNewTempStandards("A4"; True:C214)
		$wpPropertiesObjFollowPage.secti:=True:C214
		$wpPropertiesObjFollowPage.secti:=Replace string:C233(String:C10($wpAreaWidth); ","; ".")+"pt"  // ...darf nur in "pt" oder "cm" angegeben werden (also keine "px"), ausserdem wird der Wert WPintern gerundet auf Null-Nachkommastellen und wir überlassen besser wp die Art der Rundung je nach wp-version
		$wpPropertiesObjFollowPage.secti:=Replace string:C233(String:C10($wpAreaHeight); ","; ".")+"pt"  // ...darf nur in "pt" oder "cm" angegeben werden (also keine "px"), ausserdem wird der Wert WPintern gerundet auf Null-Nachkommastellen und wir überlassen besser wp die Art der Rundung je nach wp-version
		$wpPropertiesObjFollowPage.secti:=$pageMarginValueCssText
		$wpDocTemplateFollowPage:=wrpNewTemplate($wpPropertiesObjFollowPage)
		$useSpecialBG:=$pipParamObj.useDocBG
		$useSpecialBorder:=$pipParamObj.useDocBorder
		$useSpecialPadding:=$pipParamObj.useDocPadding
		$useSpecialMargin:=$pipParamObj.useDocMargin
		$useSpecials:=(($useSpecialBG) | ($useSpecialBorder) | ($useSpecialPadding) | ($useSpecialMargin))
		If ($useSpecials)
			If ($useSpecialBG)
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundClip
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundColor
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundHeight
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundImage
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundImageURL
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundOrigin
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundPositionHorizon
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundPositionVertica
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundRepeat
				$wpDocTemplateFollowPage.backgro:=$wpDoc.backgroundWidth
			End if 
			If ($useSpecialBorder)
				$wpDocTemplateFollowPage.borderC:=$wpDoc.borderColorTop
				$wpDocTemplateFollowPage.borderC:=$wpDoc.borderColorRight
				$wpDocTemplateFollowPage.borderC:=$wpDoc.borderColorBottom
				$wpDocTemplateFollowPage.borderC:=$wpDoc.borderColorLeft
				$wpDocTemplateFollowPage.borderR:=$wpDoc.borderRadius
				$wpDocTemplateFollowPage.borderS:=$wpDoc.borderStyleTop
				$wpDocTemplateFollowPage.borderS:=$wpDoc.borderStyleRight
				$wpDocTemplateFollowPage.borderS:=$wpDoc.borderStyleBottom
				$wpDocTemplateFollowPage.borderS:=$wpDoc.borderStyleLeft
				$wpDocTemplateFollowPage.borderW:=$wpDoc.borderWidthTop
				$wpDocTemplateFollowPage.borderW:=$wpDoc.borderWidthRight
				$wpDocTemplateFollowPage.borderW:=$wpDoc.borderWidthBottom
				$wpDocTemplateFollowPage.borderW:=$wpDoc.borderWidthLeft
			End if 
			If ($useSpecialPadding)
				$wpDocTemplateFollowPage.padding:=$wpDoc.paddingTop
				$wpDocTemplateFollowPage.padding:=$wpDoc.paddingRight
				$wpDocTemplateFollowPage.padding:=$wpDoc.paddingBottom
				$wpDocTemplateFollowPage.padding:=$wpDoc.paddingLeft
			End if 
			If ($useSpecialMargin)
				// ...das funktioniert nur gemeinsam mit: $pageMarginsInsideWParea:=True
				// sorry, im PagedMode wird Document/Abstände leider in der section0 hinterlegt
				// ...diese section0 Attribute können nicht mit getAttrib gelesen werden
				// ...und gedruckt wird hier im EmbeddMode zwingend wg. PrintForm, EmbeddMode kennt keine section0 oder sonstige Abschnitte/Köpfe/Füsse
				// CSS-Beispiel(PagedMode): div.section0 { -d4-page-margin:1cm }
				// So funktioniert das hier nur wenn Doc/Abstände im EmbeddMode angegeben wurden
				// ...denn dann haben wir eine normale Body-CSS-Rule zum lesen und zum schreiben
				// CSS-Beispiel(EmbeddMode): body { -d4-version:2.01;margin:1cm }
				$objBodyTarget:=WP Get body:C1516($wpDocTemplateFollowPage)
				$objBodyTarget.marginTop:=$wpDoc.marginTop
				$objBodyTarget.marginRight:=$wpDoc.marginRight
				$objBodyTarget.marginBottom:=$wpDoc.marginBottom
				$objBodyTarget.marginLeft:=$wpDoc.marginLeft
			End if 
		End if 
		
		If (($currPageLeftoverHeight#$wpAreaHeight) & (Not:C34($isBeginWithNewPage)))
			// Erste-Seite mit abweichender Höhe(Resthöhe)
			$wpPropertiesObjFirstPage:=wrpNewTempStandards("A4"; True:C214)
			$wpPropertiesObjFirstPage.sectio:=True:C214
			$wpPropertiesObjFirstPage.sectio:=Replace string:C233(String:C10($wpAreaWidth); ","; ".")+"pt"  // ...darf nur in "pt" oder "cm" angegeben werden (also keine "px"), ausserdem wird der Wert WPintern gerundet auf Null-Nachkommastellen und wir überlassen besser wp die Art der Rundung je nach wp-version
			$wpPropertiesObjFirstPage.sectio:=Replace string:C233(String:C10($currPageLeftoverHeight); ","; ".")+"pt"  // ...darf nur in "pt" oder "cm" angegeben werden (also keine "px"), ausserdem wird der Wert WPintern gerundet auf Null-Nachkommastellen und wir überlassen besser wp die Art der Rundung je nach wp-version
			$wpPropertiesObjFirstPage.sectio:=$pageMarginValueCssText
			$wpDocTemplateFirstPage:=wrpNewTemplate($wpPropertiesObjFirstPage)
			$useSpecialBG:=$pipParamObj.useDocBG
			$useSpecialBorder:=$pipParamObj.useDocBorder
			$useSpecialPadding:=$pipParamObj.useDocPadding
			$useSpecialMargin:=$pipParamObj.useDocMargin
			$useSpecials:=(($useSpecialBG) | ($useSpecialBorder) | ($useSpecialPadding) | ($useSpecialMargin))
			If ($useSpecials)
				If ($useSpecialBG)
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundClip
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundColor
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundHeight
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundImage
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundImageURL
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundOrigin
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundPositionHorizon
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundPositionVertica
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundRepeat
					$wpDocTemplateFirstPage.backgrou:=$wpDoc.backgroundWidth
				End if 
				If ($useSpecialBorder)
					$wpDocTemplateFirstPage.borderCo:=$wpDoc.borderColorTop
					$wpDocTemplateFirstPage.borderCo:=$wpDoc.borderColorRight
					$wpDocTemplateFirstPage.borderCo:=$wpDoc.borderColorBottom
					$wpDocTemplateFirstPage.borderCo:=$wpDoc.borderColorLeft
					$wpDocTemplateFirstPage.borderRa:=$wpDoc.borderRadius
					$wpDocTemplateFirstPage.borderSt:=$wpDoc.borderStyleTop
					$wpDocTemplateFirstPage.borderSt:=$wpDoc.borderStyleRight
					$wpDocTemplateFirstPage.borderSt:=$wpDoc.borderStyleBottom
					$wpDocTemplateFirstPage.borderSt:=$wpDoc.borderStyleLeft
					$wpDocTemplateFirstPage.borderWi:=$wpDoc.borderWidthTop
					$wpDocTemplateFirstPage.borderWi:=$wpDoc.borderWidthRight
					$wpDocTemplateFirstPage.borderWi:=$wpDoc.borderWidthBottom
					$wpDocTemplateFirstPage.borderWi:=$wpDoc.borderWidthLeft
				End if 
				If ($useSpecialPadding)
					$wpDocTemplateFirstPage.paddingT:=$wpDoc.paddingTop
					$wpDocTemplateFirstPage.paddingR:=$wpDoc.paddingRight
					$wpDocTemplateFirstPage.paddingB:=$wpDoc.paddingBottom
					$wpDocTemplateFirstPage.paddingL:=$wpDoc.paddingLeft
				End if 
				If ($useSpecialMargin)
					// ...das funktioniert nur gemeinsam mit: $pageMarginsInsideWParea:=True
					// sorry, im PagedMode wird Document/Abstände leider in der section0 hinterlegt
					// ...diese section0 Attribute können nicht mit getAttrib gelesen werden
					// ...und gedruckt wird hier im EmbeddMode zwingend wg. PrintForm, EmbeddMode kennt keine section0 oder sonstige Abschnitte/Köpfe/Füsse
					// CSS-Beispiel(PagedMode): div.section0 { -d4-page-margin:1cm }
					// So funktioniert das hier nur wenn Doc/Abstände im EmbeddMode angegeben wurden
					// ...denn dann haben wir eine normale Body-CSS-Rule zum lesen und zum schreiben
					// CSS-Beispiel(EmbeddMode): body { -d4-version:2.01;margin:1cm }
					$objBodyTarget:=WP Get body:C1516($wpDocTemplateFirstPage)
					$objBodyTarget.marginTop:=$wpDoc.marginTop
					$objBodyTarget.marginRight:=$wpDoc.marginRight
					$objBodyTarget.marginBottom:=$wpDoc.marginBottom
					$objBodyTarget.marginLeft:=$wpDoc.marginLeft
				End if 
			End if 
			$colPagedWpDocs.push(OB Copy:C1225($wpDocTemplateFirstPage))  // Create first Item in collection
			$wpRangeAll:=WP Text range:C1341($wpDocTemplateFirstPage; wk start text:K81:165; wk end text:K81:164)
			WP INSERT DOCUMENT:C1411($wpRangeAll; $wpDoc; wk replace:K81:177; wk include in range:K81:180)
			
			$wpBody:=WP Get body:C1516($wpDocTemplateFirstPage)
			$wpRangeAll:=WP Text range:C1341($wpBody; wk start text:K81:165; wk end text:K81:164)
			$posStart:=WP Get position:C1577($wpRangeAll; wk 4D Write Pro layout:K81:176)
			$wpRangeEnd:=WP Text range:C1341($wpRangeAll; wk end text:K81:164; wk end text:K81:164)
			$posEnd:=WP Get position:C1577($wpRangeEnd; wk 4D Write Pro layout:K81:176)
			
			// ##Paged-Doc-Array erzeugen##: Nur erste Seite(wenn abweichend)
			$colPageStartPositions:=wrpGetDocPagePositions($wpDocTemplateFirstPage; 2)
			If ($colPageStartPositions.length>1)  // Wenn es mehr wie eine Seite gibt...
				$wpRangePages:=WP Text range:C1341($wpDocTemplateFirstPage; $colPageStartPositions[1]-1; $colPageStartPositions[1])
				WP INSERT BREAK:C1413($wpRangePages; wk line break:K81:186; wk replace:K81:177; wk include in range:K81:180)
				WP INSERT BREAK:C1413($wpRangePages; wk page break:K81:188; wk prepend:K81:178; wk include in range:K81:180)
				$wpRangePages:=WP Text range:C1341($wpDocTemplateFirstPage; $wpRangePages.end-1; $wpRangePages.end)
				WP SET TEXT:C1574($wpRangePages; ""; wk replace:K81:177)
				
				// ## Doc-Folgeseiten erzeugen##: (noch mit ErsteSeite die in Folge entfernt wird)
				$wpRangeAll:=WP Text range:C1341($wpDocTemplateFollowPage; wk start text:K81:165; wk end text:K81:164)
				WP INSERT DOCUMENT:C1411($wpRangeAll; $wpDocTemplateFirstPage; wk replace:K81:177; wk include in range:K81:180)
				
				$wpRangePages:=WP Text range:C1341($wpDocTemplateFirstPage; $colPageStartPositions[1]-1; wk end text:K81:164)
				WP SET TEXT:C1574($wpRangePages; ""; wk replace:K81:177)  // Delete range after First-Page
			End if 
			$colPagedWpDocs[0]:=OB Copy:C1225($wpDocTemplateFirstPage)
			
		Else   // ...andernfalls haben wir nur eine Seite (weil kein Anfang der zweiten Seite in $colPageStartPositions verzeichnet wurde)
			$wpRangeAll:=WP Text range:C1341($wpDocTemplateFollowPage; wk start text:K81:165; wk end text:K81:164)
			WP INSERT DOCUMENT:C1411($wpRangeAll; $wpDoc; wk replace:K81:177; wk include in range:K81:180)
		End if 
		
		// Folgeseiten(oder inclusive Erste-Seite wenn sie gleiche Maße hat wie Folgeseiten)
		$wpBody:=WP Get body:C1516($wpDocTemplateFollowPage)
		$wpRangeAll:=WP Text range:C1341($wpBody; wk start text:K81:165; wk end text:K81:164)
		$posStart:=WP Get position:C1577($wpRangeAll; wk 4D Write Pro layout:K81:176)
		$wpRangeEnd:=WP Text range:C1341($wpRangeAll; wk end text:K81:164; wk end text:K81:164)
		$posEnd:=WP Get position:C1577($wpRangeEnd; wk 4D Write Pro layout:K81:176)
		
		// ##Paged-Doc-Array erzeugen##: Alle Seiten/Folgeseiten
		$firstIsDone:=($colPagedWpDocs.length>0)
		$numFirstDone:=Num:C11($firstIsDone)
		$start:=$numFirstDone+1
		$anz:=WP Get page count:C1412($wpDocTemplateFollowPage)
		If ($anz=1)
			If (Not:C34($firstIsDone))
				$colPagedWpDocs.push(OB Copy:C1225($wpDocTemplateFollowPage))
			End if 
		Else 
			$colPageStartPositions:=wrpGetDocPagePositions($wpDocTemplateFollowPage; $anz)
			For ($i; $start; $anz)
				$colPagedWpDocs.push(OB Copy:C1225($wpDocTemplateFollowPage))
				Case of 
					: ($i>=$colPageStartPositions.length)  // Letzte Seite
						// Delete range before Last-Page
						$wpRangePages:=WP Text range:C1341($colPagedWpDocs[$i-1]; wk start text:K81:165; $colPageStartPositions[$i-1])
						WP INSERT BREAK:C1413($wpRangePages; wk page break:K81:188; wk append:K81:179; wk include in range:K81:180)  // ...bei Delete-Before muss der Paragraph gesplittet werden, sonst bekommt er die Styles der Vorläufer weil er kein eigenes Element mehr ist wenn man ihn seinen Anfang weglöscht (PageBreak wird nur als Mittel zum Splitt eingesetzt und wird in Folge gelöscht;; Der Fall ist nur relevant wenn AusschnittEnde innerhalb eines Paragraphen liegt und AusschnittStart ausserhab dessen)
						WP SET TEXT:C1574($wpRangePages; ""; wk replace:K81:177)  // Delete range before Last-Page (inclusive des obigen Hilfsmittel-PageBreakInserts)
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
				End case 
			End for 
		End if 
End case 

$0:=$colPagedWpDocs
