//%attributes = {"invisible":true}
//Method: Convert_WKStyleTxtToWP
//Description
// convert 4DWrite Styled text blob to Write Pro Area blob
// Parameters
// $0 : $WP_blob
// $1 : $WKStyledTxt_blob
// $2 : $WKSeedarea_L - use a seed 4D Write area.
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/29/20, 10:28:29
	// ----------------------------------------------------
	//Created : 
	//Mods_2020_11
	
	C_BLOB:C604(Convert_WKStyleTxtToWP; $0)
	C_BLOB:C604(Convert_WKStyleTxtToWP; $1)
	C_LONGINT:C283(Convert_WKStyleTxtToWP; $2)
End if 
//  //
//C_BLOB($0)
//C_BLOB($1)
//C_LONGINT($2)

//C_LONGINT($WKarea;$charcount;$blobOffset)
//C_BLOB($WRBlob;$TempSave;$WRcomments)
//C_TEXT($tag;$folder)

//$WRcomments:=$1
//$WKarea:=$2
//SET BLOB SIZE($TempSave;0)
//C_OBJECT($newWP;$range)
//C_TEXT($lastChar)
//C_LONGINT($Compressed)
//If (BLOB size($WRcomments)>0)
//BLOB PROPERTIES($WRcomments;$Compressed)
//If ($Compressed#0)
//EXPAND BLOB($WRcomments)
//End if 
//$blobOffset:=0
//BLOB TO VARIABLE($WRcomments;$tag;$blobOffset)
//If ($tag="WPAREA")
//  //return a blob size of 0 to indicato no change
//SET BLOB SIZE($TempSave;0)
//Else 
//  // clear the 4D WR area
//$charcount:=‘12000;143‘ ($WKarea;‘k12009;1‘)
//‘12000;59‘ ($WKarea;0;0;(2*$charcount))
//‘12000;113‘ ($WKarea;‘k12007;6‘)
//  //insert the styled text to be converted
//‘12000;128‘ ($WKarea;$WRcomments)
//$WRBlob:=‘12000;140‘ ($WKarea)
//$newWP:=WP New($WRBlob)
//$range:=WP Text range($newWP;wk start text;wk end text)
//$range:=WP Text range($range;($range.end-1);$range.end)

//$lastChar:=WP Get text($range;wk expressions as value)
//If ($lastChar="\r")
//WP SET TEXT($range;"";wk replace;wk include in range)
//End if 
//WP EXPORT VARIABLE($newWP;$TempSave;wk 4wp;wk normal)
//End if 

//End if 
//$0:=$TempSave

//SET BLOB SIZE($TempSave;0)
//SET BLOB SIZE($WRcomments;0)

//End Convert_WKStyleTxtToWP