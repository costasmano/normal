
C_OBJECT:C1216($wpnew; $body; $endbodyrange; $endpos; $newendpos; $newendrange)
C_POINTER:C301($area_)

$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "wparea")
C_TEXT:C284($fourlines)
$fourlines:=4*(Char:C90(13))
$body:=WP Get body:C1516($area_->)

$endbodyrange:=WP Text range:C1341($body; wk end text:K81:164; wk end text:K81:164)
WP SET TEXT:C1574($endbodyrange; $fourlines; wk append:K81:179; wk exclude from range:K81:181)

$newendrange:=WP Text range:C1341($body; wk end text:K81:164; wk end text:K81:164)
$newendpos:=WP Text range:C1341($body; $endbodyrange.end; $newendrange.end)

WP SET TEXT:C1574($newendpos; ""; wk replace:K81:177; wk include in range:K81:180)
