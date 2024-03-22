C_BLOB:C604($tempBlb_x)
SET BLOB SIZE:C606($tempBlb_x; 0)

C_POINTER:C301($WpArea_ptr)
$WpArea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WriteProArea")

C_OBJECT:C1216($Range)
$Range:=WP Text range:C1341($WpArea_ptr->; wk start text:K81:165; wk end text:K81:164)
If ($Range.end>1)
	WP EXPORT VARIABLE:C1319($WpArea_ptr->; $tempBlb_x; wk 4wp:K81:4; wk normal:K81:7)
End if 

DCM_WO_Write_ptr->:=$tempBlb_x