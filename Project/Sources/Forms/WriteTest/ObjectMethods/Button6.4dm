C_POINTER:C301($area_)
$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "writeproarea")
C_OBJECT:C1216($new; $range; $body)
$range:=WP Text range:C1341($area_->; wk start text:K81:165; wk end text:K81:164)
C_COLLECTION:C1488($pars)
$body:=WP Get body:C1516($area_->)
$pars:=WP Get elements:C1550($body; wk type paragraph:K81:191)
C_LONGINT:C283($n)
//need to have use object notation enabled in structure prefs / compatibility
$n:=$pars.length
ALERT:C41("found "+String:C10($n)+" paragraphs")
$n:=WP Get page count:C1412($area_->)
ALERT:C41("found "+String:C10($n)+" pages")
