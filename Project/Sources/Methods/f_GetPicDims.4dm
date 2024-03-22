//%attributes = {"invisible":true}
C_TEXT:C284($0; $vDims)  // Command Replaced was o_C_STRING length was 80
C_PICTURE:C286($1; $vpicture)
C_LONGINT:C283($vHt; $vWdth)
$vpicture:=$1
PICTURE PROPERTIES:C457($vpicture; $vWdth; $vHt)
$vDims:=String:C10($vWdth)+"X"+String:C10($vHt)
$vpicture:=$vpicture*0
$0:=$vDims