//%attributes = {"invisible":true}
//Method: ut_insertTxt2WRblb
//Description
//  `Insert a text into a styled text from a 4D Write doc stored in a blob  
//  `main use to add text to comment blobs used in inspection reports. these blobs contain only styled text

// Parameters
// $1 : $Blob_ptr : pointer to the blob with the styled text
// $2 : $Insert_txt : text to insert
// $3 : $InsertPos_L : postion in styled text to insert the new text (measured in characters as returned by WR Count wr nb chars for example)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/15/14, 14:28:08
	// ----------------------------------------------------
	//Created : 
	Mods_2014_08
	Mods_2021_Delete
End if 
//  //
//C_POINTER($1)
//C_TEXT($2)

//C_POINTER($Blob_ptr)
//C_TEXT($Insert_txt)

//$Blob_ptr:=$1
//$Insert_txt:=$2

//C_LONGINT($InsertPos_L)
//If (Count parameters>2)
//C_LONGINT($3)
//$InsertPos_L:=$3
//Else 
//$InsertPos_L:=0
//End if 

//C_LONGINT($TempArea_L)
//$TempArea_L:=WR New offscreen area 
//If (BLOB size($Blob_ptr->)>0)
//WR INSERT STYLED TEXT ($TempArea_L;$Blob_ptr->)
//WR EXECUTE COMMAND ($TempArea_L;wr cmd select all)
//C_TEXT($curr_txt)
//$curr_txt:=WR Get selected text ($TempArea_L)

//If ($InsertPos_L>=0)
//Else 
//$InsertPos_L:=WR Count ($TempArea_L;wr nb characters)+1
//End if 
//Else 
//$InsertPos_L:=0
//End if 

//WR SET SELECTION ($TempArea_L;$InsertPos_L;$InsertPos_L)
//WR INSERT TEXT ($TempArea_L;$Insert_txt)
//WR EXECUTE COMMAND ($TempArea_L;wr cmd select all)
//$Blob_ptr->:=WR Get styled text ($TempArea_L)

//WR EXECUTE COMMAND ($TempArea_L;wr cmd select all)
//C_TEXT($curr_txt)
//$curr_txt:=WR Get selected text ($TempArea_L)

//WR DELETE OFFSCREEN AREA ($TempArea_L)
//  //End ut_insertTxt2WRblb