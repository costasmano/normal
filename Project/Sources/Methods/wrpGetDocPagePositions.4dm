//%attributes = {"invisible":true}
// PM: "wrpGetDocPagePositions"  (neu LV 02.10.2018)
// $1 - OBJECT - $wpDoc - wpDocument in dem die Seitenanfangspositionen ermittelt werden sollen
// $2 - LONGINT - $stopAtPage - Optional, nur Positionen bis Seite, ansonsten alle Seiten
// $0 - COLLECTION - $colPageStartPositions - Je ein Eintrag pro Seite (Einträge in Collection beginnen mit Null, so enthält $colPageStartPositions[0] die AnfangsPosSeite1 und $colPageStartPositions[1] die AnfangsPosSeite2 ...usw)
// Gibt eine Collection zurück mit Positionen ab der die Seiten beginnen
// Jedes Item in dieser Ergebnis-Collection stellt Eine-Seite dar und der Wert ihre Startposition
// Dieses Item gibt die Zeichenposition(wievielte Zeichen im Dokument) an ab der eine Seite beginnt
// Letzte Änderung: LV 02.10.2018, 20:30 Uhr

C_OBJECT:C1216($wpDoc; $1)
C_LONGINT:C283($stopAtPage; $2)
C_COLLECTION:C1488($colPageStartPositions; $0)
C_OBJECT:C1216($wpBody; $wpRange)
C_BOOLEAN:C305($doBreakLoop; $doBreakLoop2)
C_LONGINT:C283($i; $start; $end; $leftOverChars; $leftOverPages; $averagePerPage; $pageCount)
C_LONGINT:C283($optItem; $startOpt; $endOpt)

$endOpt:=11
ARRAY LONGINT:C221($arrForecastOpt; $endOpt)

$i:=0
$start:=0
$end:=0
$leftOverChars:=0
$leftOverPages:=0
$averagePerPage:=0
$pageCount:=0

If (Count parameters:C259>0)
	$wpDoc:=OB Copy:C1225($1)
	$pageCount:=WP Get page count:C1412($wpDoc)
	If (Count parameters:C259>1)
		$stopAtPage:=$2
	Else 
		$stopAtPage:=$pageCount
	End if 
Else 
	$wpDoc:=WP New:C1317
	$pageCount:=WP Get page count:C1412($wpDoc)
	$stopAtPage:=$pageCount
End if 

$colPageStartPositions:=New collection:C1472(1)
If ($stopAtPage>1)
	$wpBody:=WP Get body:C1516($wpDoc)
	$wpRange:=WP Text range:C1341($wpBody; wk start text:K81:165; wk end text:K81:164)
	$start:=$wpRange.start
	$end:=$wpRange.end
	$leftOverPages:=$pageCount-$colPageStartPositions.length
	$averagePerPage:=Round:C94($end/($leftOverPages+1); 0)
	$doBreakLoop:=False:C215
	// ForecastOptimizeValues
	$arrForecastOpt{1}:=$averagePerPage
	$arrForecastOpt{2}:=Round:C94($averagePerPage/1.25; 0)
	$arrForecastOpt{3}:=Round:C94($averagePerPage/1.5; 0)
	$arrForecastOpt{4}:=Round:C94($averagePerPage/3; 0)
	$arrForecastOpt{5}:=Round:C94($averagePerPage/4; 0)
	$arrForecastOpt{6}:=Round:C94($averagePerPage/5; 0)
	$arrForecastOpt{7}:=250
	$arrForecastOpt{8}:=100
	$arrForecastOpt{9}:=25
	$arrForecastOpt{10}:=10
	$arrForecastOpt{11}:=5
	$startOpt:=1
	$i:=2
	While (($i<=$end) & (Not:C34($doBreakLoop)))
		If (wrpGetPageAtCharPos($wpBody; $i)>$colPageStartPositions.length)
			$colPageStartPositions.push($i)
			If ($colPageStartPositions.length=$stopAtPage)
				$doBreakLoop:=True:C214  //..nothing more to do, break (only to speed up)
			Else 
				$leftOverPages:=$pageCount-$colPageStartPositions.length
				$averagePerPage:=Round:C94(($end-$i)/($leftOverPages+1); 0)
				// ForecastOptimizeValues
				$arrForecastOpt{1}:=$averagePerPage
				$arrForecastOpt{2}:=Round:C94($averagePerPage/1.25; 0)
				$arrForecastOpt{3}:=Round:C94($averagePerPage/1.5; 0)
				$arrForecastOpt{4}:=Round:C94($averagePerPage/3; 0)
				$arrForecastOpt{5}:=Round:C94($averagePerPage/4; 0)
				$arrForecastOpt{6}:=Round:C94($averagePerPage/5; 0)
				$arrForecastOpt{7}:=250
				$arrForecastOpt{8}:=100
				$arrForecastOpt{9}:=25
				$arrForecastOpt{10}:=10
				$arrForecastOpt{11}:=5
				$startOpt:=1
			End if 
		End if 
		If (Not:C34($doBreakLoop))
			$leftOverChars:=$end-$i
			If ($leftOverChars>18)  // wenn noch viel zu tun ist, dann Abkürzung suchen
				$optItem:=$startOpt
				$doBreakLoop2:=False:C215
				While ((Not:C34($doBreakLoop2)) & ($optItem<=$endOpt))  // Abkürzung suchen (nur um den Vorgang wenn möglich zu beschleunigen)
					If (($i+$arrForecastOpt{$optItem})<=$end)
						If (wrpGetPageAtCharPos($wpBody; $i+$arrForecastOpt{$optItem})=$colPageStartPositions.length)  // Wenn PrognoseCharPos noch auf selber Seite liegt
							$i:=$i+$arrForecastOpt{$optItem}  // ...dann mit PrognoseCharPos weitermachen und abkürzen
							If ($optItem>1)
								$startOpt:=$optItem-1
							End if 
							$doBreakLoop2:=True:C214
						Else 
							If ($optItem=$endOpt)
								$startOpt:=$endOpt+1
							End if 
						End if 
					End if 
					$optItem:=$optItem+1
				End while 
			End if 
			$i:=$i+1
		End if 
	End while 
End if 

$0:=$colPageStartPositions
