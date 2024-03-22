
C_OBJECT:C1216($wpnew)
C_POINTER:C301($area_)
$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "writeproarea2")
C_TEXT:C284($file)
ARRAY TEXT:C222($files; 0)
$file:=Select document:C905(""; ""; "the 4D WRite file"; Multiple files:K24:7; $files)
C_BLOB:C604($wrblb)
DOCUMENT TO BLOB:C525($files{1}; $wrblb)
$area_->:=WP New:C1317($wrblb)

