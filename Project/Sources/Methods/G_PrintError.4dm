//%attributes = {"invisible":true}
//G_PrintError 
//error traping for print preview
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER
//capture Error
viInspPreviewErr:=Error

ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015(SQLErrorNumbers_al; SQL_InternalCodes_atxt; SQL_InternalDescriptions_atxt)
