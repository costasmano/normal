//%attributes = {"invisible":true}
//pageBreakFind
//$1: Pointer to Write Pro Document
//$2: Pointer to Array Longint of start positions in the body
//$3: Optional, default all pages: search up to max pos

C_POINTER:C301($1; $2)
C_LONGINT:C283($3)
C_LONGINT:C283($nbPages)
$nbPages:=WP Get page count:C1412($1->)

If ($nbPages=1)
	ARRAY LONGINT:C221($2->; 1)
	$2->{1}:=1
Else 
	
	C_POINTER:C301($Doc)
	$Doc:=$1
	
	//$Doc->:=WP New($1->)
	
	//All pages?
	If (Count parameters:C259>2)
		If ($3>0) & ($3<$nbPages)
			$nbPages:=$3
		End if 
	End if 
	
	C_OBJECT:C1216($Range)
	C_TEXT:C284($Text)
	$Range:=WP Text range:C1341($Doc->; wk start text:K81:165; wk end text:K81:164)
	$Text:=WP Get text:C1575($Doc->; wk expressions as space:K81:257)
	
	ARRAY LONGINT:C221($2->; $nbPages)
	ARRAY LONGINT:C221($MinMax; 2; $nbPages)
	$2->{1}:=1
	$MinMax{1}{1}:=1
	$MinMax{2}{$nbPages}:=$Range.end
	
	//Modified by: grafa (01.03.2020/21:28) v18.1: 4D Write Pro error
	//  First call of wp get position delivers always page 1 -> One additional call helps
	C_OBJECT:C1216($PosObj)
	$PosObj:=WP Get position:C1577(WP Text range:C1341($Doc->; 1; 1); wk 4D Write Pro layout:K81:176)
	
	//Jede Seite einzeln suchen, dabei MinMax für andere vormerken
	//Binary search
	C_LONGINT:C283($Min; $Max; $Pos; $AnzahlAufrufe; $i; $j)
	$AnzahlAufrufe:=0
	For ($i; 2; $nbPages)
		$Min:=1
		$Max:=$Range.end
		
		//Suchraum mit vorherigen Ergebnissen einschränken
		For ($j; 1; $nbPages)
			Case of 
				: ($j<$i)
					//Schranken der vorherigen Seiten anwenden
					If ($MinMax{2}{$j}>$Min)
						$Min:=$MinMax{2}{$j}+1
					End if 
				: ($j>$i)
					//Schranken der nachfolgenden Seiten anwenden
					If ($MinMax{1}{$j}<$Max) & ($MinMax{1}{$j}>0)
						$Max:=$MinMax{1}{$j}-1
						$j:=$nbPages
					End if 
			End case 
		End for 
		
		//Die Suche startet jetzt
		Repeat 
			Case of 
				: ($Min=$Max)
					//Gefunden
					$2->{$i}:=$Min
					
				: (($Max-$Min)=1)
					//So gut wie gefunden, nur 2 Möglichkeiten
					$PosObj:=WP Get position:C1577(WP Text range:C1341($Doc->; $Min; $Min); wk 4D Write Pro layout:K81:176)
					$AnzahlAufrufe:=$AnzahlAufrufe+1
					If ($PosObj.page=$i)
						$2->{$i}:=$Min
						$MinMax{1}{$i}:=$Min
					Else 
						$2->{$i}:=$Max
						$MinMax{1}{$i}:=$Max
					End if 
				Else 
					//In der Mitte testen
					$Pos:=($Max+$Min)\2
					$PosObj:=WP Get position:C1577(WP Text range:C1341($Doc->; $Pos; $Pos); wk 4D Write Pro layout:K81:176)
					$AnzahlAufrufe:=$AnzahlAufrufe+1
					If ($PosObj.page>=$i)
						//Weiter links suchen
						$Max:=$Pos
					Else 
						//Weiter rechts suchen
						$Min:=$Pos
					End if 
					//Suchbereiche für die weiteren Suchen optimieren
					//%W-533.3
					
					If ($MinMax{1}{$PosObj.page}>$Pos) | ($MinMax{1}{$PosObj.page}=0)
						$MinMax{1}{$PosObj.page}:=$Pos
					End if 
					If ($MinMax{2}{$PosObj.page}<$Pos)
						$MinMax{2}{$PosObj.page}:=$Pos
					End if 
					//%W+533.3
					
			End case 
		Until ($2->{$i}#0)
		//Suchbereiche für die weitere Suche setzen
		$MinMax{1}{$i}:=$2->{$i}
		$MinMax{2}{$i-1}:=$2->{$i}-1
		
	End for 
	
	//Wenn nur Seitenumbruch am Ende der vorletzten Seite, dann hat die letzte Seite kein Zeichen, 
	//Position muss zur Unterscheidung eins hinter dem letzten Zeichen sein
	If ($2->{$nbPages}=$2->{$nbPages-1})
		$2->{$nbPages}:=$2->{$nbPages}+1
	End if 
	
End if 