C_POINTER:C301($area_)
$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "writeproarea")
C_OBJECT:C1216($new; $range; $pos; $parRange)
$range:=WP Text range:C1341($area_->; wk start text:K81:165; wk end text:K81:164)
ARRAY LONGINT:C221($pages; 0)
C_TEXT:C284(vConsltName; vCityTown; vLocation; vBridgeNo; vBIN; vBridgeKeyNo)
C_DATE:C307(vReportDate)
vConsltName:="The Big Company"
vCityTown:="ATHENS"
vLocation:="Evrota 20"
vBridgeNo:="Big Bridge"
vBIN:="BGHTR"
vBridgeKeyNo:="SWISKEY"
vReportDate:=Current date:C33
// call "visibleHorizontalRuler" action in the current form
INVOKE ACTION:C1439("visibleHorizontalRuler"; ak current form:K76:70)
INVOKE ACTION:C1439(ak compute expressions:K76:79; ak current form:K76:70)

//ST FREEZE EXPRESSIONS($area_->;ST Start text;ST End text)
pageBreakFind($area_; ->$pages)
C_OBJECT:C1216($temp)
C_LONGINT:C283($loop_L)
C_TEXT:C284($txt)
For ($loop_L; 1; Size of array:C274($pages))
	$temp:=WP Text range:C1341($area_->; $pages{$loop_L}; $pages{$loop_L}+20)
	$txt:=WP Get text:C1575($temp; wk expressions as value:K81:255)
	
End for 

C_COLLECTION:C1488($pars)
C_OBJECT:C1216($body)
$body:=WP Get body:C1516($area_->)
$pars:=WP Get elements:C1550($body; wk type paragraph:K81:191)
C_LONGINT:C283($n; $par)
For ($par; 0; ($pars.length-1))
	$parRange:=WP Text range:C1341($pars[$par]; wk start text:K81:165; wk end text:K81:164)
	$pos:=WP Get position:C1577($pars[$par]; wk 4D Write Pro layout:K81:176)
	OB SET:C1220($pars[$par]; "textStart"; $parRange.start; "textEnd"; $parRange.end; "pageStart"; $pos.page)
	
	If ($pos.page=Size of array:C274($pages))
		//last page already
		OB SET:C1220($pars[$par]; "pageEnd"; Size of array:C274($pages))
		
	Else 
		//%W-533.3
		If ($parRange.end<$pages{($pos.page+1)})
			//%W+533.3
			OB SET:C1220($pars[$par]; "pageEnd"; $pos.page)
		Else 
			//find the last page of the paragraph
			OB SET:C1220($pars[$par]; "pageEnd"; Size of array:C274($pages))  // assume it goes all the way to last page
			C_LONGINT:C283($pg)
			For ($pg; $pos.page+2; Size of array:C274($pages))
				If ($parRange.end<$pages{$pg})
					OB SET:C1220($pars[$par]; "pageEnd"; ($pg-1))
				End if 
			End for 
		End if 
		
	End if 
	
End for 
// `go to top of 2nd page
$range:=WP Text range:C1341($area_->; $pages{2}; $pages{2})
C_OBJECT:C1216($pos)
$pos:=WP Get position:C1577($range; wk 4D Write Pro layout:K81:176)
//find which paragraph we're in
C_LONGINT:C283($inPar)
$inPar:=-1
For ($par; 0; ($pars.length-1))
	If ($pages{2}>$pars[$par].textStart) & ($pages{2}<$pars[$par].textEnd)
		$inPar:=$par
		$par:=$pars.length
	End if 
End for 


WP INSERT BREAK:C1413($range; wk page break:K81:188; wk append:K81:179; wk include in range:K81:180)
C_TEXT:C284($title)
$title:="Added this title"
ST SET ATTRIBUTES:C1093($title; ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; 1)
$new:=WP New:C1317($title)
WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
$pos:=WP Get position:C1577($range; wk 4D Write Pro layout:K81:176)


