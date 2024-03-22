C_POINTER:C301($area_)
$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "wparea")
C_OBJECT:C1216($new; $range)
$range:=WP Text range:C1341($area_->; wk start text:K81:165; wk end text:K81:164)

C_BLOB:C604(TempSave)
WP EXPORT VARIABLE:C1319($area_->; TempSave; wk 4wp:K81:4; wk normal:K81:7)
C_TEXT:C284($doc)
ARRAY TEXT:C222($files_a; 0)
$doc:=Select document:C905(""; ""; "File to save to"; File name entry:K24:17; $files_a)
If (Size of array:C274($files_a)>0)
	WP EXPORT DOCUMENT:C1337($area_->; $files_a{1}; wk 4wp:K81:4; wk normal:K81:7)
	
	$area_->:=WP New:C1317("")
End if 
