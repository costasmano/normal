
C_POINTER:C301($area_)
$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "writeproarea")
C_OBJECT:C1216($new; $range; $lastChar)
$range:=WP Text range:C1341($area_->; wk start text:K81:165; wk end text:K81:164)
C_LONGINT:C283($endC)
$endC:=1
$lastChar:=WP Text range:C1341($range; $range.end-$endC; wk end text:K81:164)
Repeat 
	If (WP Get text:C1575($lastChar)="\t") | (WP Get text:C1575($lastChar)="\r")
		WP SET TEXT:C1574($lastChar; ""; wk replace:K81:177; wk include in range:K81:180)
	End if 
	$endC:=$endC+1
	$lastChar:=WP Text range:C1341($range; $range.end-$endC; wk end text:K81:164)
	
Until (Not:C34((WP Get text:C1575($lastChar)="\t") | (WP Get text:C1575($lastChar)="\r")))

