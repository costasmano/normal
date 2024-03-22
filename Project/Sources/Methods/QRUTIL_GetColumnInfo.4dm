//%attributes = {"invisible":true}
//Method: QRUTIL_GetColumnInfo
//Description
// get all  the column info for a quick report ares
// Parameters
// $0 : $infoObject_o {"columnTitle" :{}, "columnObject" : {}, "columnHide" : {}, "columnSize" : {}, "repeatedValue" : {}, "columnFormat" : {} }
// $1 : $QuickReportArea_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/05/19, 13:51:04
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
	C_OBJECT:C1216(QRUTIL_GetColumnInfo; $0)
	C_LONGINT:C283(QRUTIL_GetColumnInfo; $1)
	
End if 
//
C_OBJECT:C1216($0)
C_LONGINT:C283($1)

C_LONGINT:C283($numColumns_L; $col_L)
$numColumns_L:=QR Count columns:C764($1)

ARRAY TEXT:C222($colTitle_atxt; $numColumns_L)
ARRAY TEXT:C222($colObject_atxt; $numColumns_L)
ARRAY LONGINT:C221($hide_aL; $numColumns_L)
ARRAY LONGINT:C221($colSize_aL; $numColumns_L)
ARRAY LONGINT:C221($repeated_aL; $numColumns_L)
ARRAY TEXT:C222($format_atxt; $numColumns_L)

For ($col_L; 1; $numColumns_L)
	
	QR GET INFO COLUMN:C766($1; $col_L; $colTitle_atxt{$col_L}; $colObject_atxt{$col_L}; \
		$hide_aL{$col_L}; $colSize_aL{$col_L}; $repeated_aL{$col_L}; $format_atxt{$col_L})
	
End for 

OB SET ARRAY:C1227($0; "columnTitle"; $colTitle_atxt)
OB SET ARRAY:C1227($0; "columnObject"; $colObject_atxt)
OB SET ARRAY:C1227($0; "columnHide"; $hide_aL)
OB SET ARRAY:C1227($0; "columnSize"; $colSize_aL)
OB SET ARRAY:C1227($0; "repeatedValue"; $repeated_aL)
OB SET ARRAY:C1227($0; "columnFormat"; $format_atxt)

//End QRUTIL_GetColumnInfo