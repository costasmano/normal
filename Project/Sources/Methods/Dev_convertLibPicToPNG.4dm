//%attributes = {"invisible":true}
//Method: Dev_convertLibPicToPNG
//Description
// convert a libary picture into a png 4 state button
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/18/18, 14:27:05
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06
End if 
//

C_PICTURE:C286($libpic; $libgreypic; $cropPic; $fourpartPic)
C_TEXT:C284($picLibName_txt)
//$picLibName_txt:="BMS 20 SaveContinue"  //get picture name
//$picLibName_txt:=Request("Pic lib name";$picLibName_txt)
ARRAY TEXT:C222($picLibNames_atxt; 0)
ARRAY LONGINT:C221($picLibRefs_aL; 0)
PICTURE LIBRARY LIST:C564($picLibRefs_aL; $picLibNames_atxt)
SORT ARRAY:C229($picLibNames_atxt)
C_LONGINT:C283($picked_L)
$picked_L:=G_PickFromList(->$picLibNames_atxt)
If ($picked_L>0)
	
	$picLibName_txt:=$picLibNames_atxt{$picked_L}
	GET PICTURE FROM LIBRARY:C565($picLibName_txt; $libpic)
	C_BLOB:C604($pic_blob)
	C_TIME:C306($picfile_t)
	
	PICTURE TO BLOB:C692($libpic; $pic_blob; ".PNG")
	//ALERT("Save source")
	C_TEXT:C284($file_txt; $File2_txt; $file4_txt; $FileAll_txt)
	ARRAY TEXT:C222($selectedFiles_atxt; 0)
	
	$file_txt:=Select document:C905($picLibName_txt; ".png"; "Choose file to save lib pict as png"; File name entry:K24:17)
	$File2_txt:=Replace string:C233(Document; $picLibName_txt; ($picLibName_txt+" 2"))
	$File4_txt:=Replace string:C233(Document; $picLibName_txt; ($picLibName_txt+" 4"))
	$FileAll_txt:=Replace string:C233(Document; $picLibName_txt; ($picLibName_txt+" 4states"))
	
	$picfile_t:=Create document:C266(Document; ".png")
	CLOSE DOCUMENT:C267($picfile_t)
	BLOB TO DOCUMENT:C526(Document; $pic_blob)
	$picfile_t:=Create document:C266($File2_txt; ".png")
	CLOSE DOCUMENT:C267($picfile_t)
	BLOB TO DOCUMENT:C526(Document; $pic_blob)
	$picfile_t:=Create document:C266($File4_txt; ".png")
	CLOSE DOCUMENT:C267($picfile_t)
	BLOB TO DOCUMENT:C526(Document; $pic_blob)
	SHOW ON DISK:C922($File4_txt)
	
	ALERT:C41("Now adjust the pngs for state 2 and 4 as needed.  When ready, click OK to contunue")
	
	//$file_txt:=Select document($File2_txt;".png";"Select png for "+$picLibName_txt+" state 2";0;$selectedFiles_atxt)
	
	DOCUMENT TO BLOB:C525($File2_txt; $pic_blob)
	BLOB TO PICTURE:C682($pic_blob; $cropPic)
	
	//$file_txt:=Select document($File4_txt;".png";"Select png for "+$picLibName_txt+" state 4";0;$selectedFiles_atxt)
	
	DOCUMENT TO BLOB:C525($File4_txt; $pic_blob)
	BLOB TO PICTURE:C682($pic_blob; $libgreypic)
	
	C_LONGINT:C283($MasterpicW; $masterpicH; $FrameH; $offset; $picW; $picH)
	
	PICTURE PROPERTIES:C457($libpic; $picW; $picH)
	
	//$libgreypic:=$libpic
	//$cropPic:=$libpic
	//TRANSFORM PICTURE($libgreypic;Fade to grey scale)
	//TRANSFORM PICTURE($cropPic;Crop;2;2;($picW-2);($picH-2))
	
	COMBINE PICTURES:C987($fourpartPic; $libpic; Vertical concatenation:K61:9; $cropPic)
	
	COMBINE PICTURES:C987($fourpartPic; $fourpartPic; Vertical concatenation:K61:9; $libpic)
	COMBINE PICTURES:C987($fourpartPic; $fourpartPic; Vertical concatenation:K61:9; $libgreypic)
	
	
	PICTURE TO BLOB:C692($fourpartPic; $pic_blob; ".PNG")
	
	//$file_txt:=Select document($picLibName_txt+" 4states";".png";"Choose file to save lib pict as png";File name entry)
	
	$picfile_t:=Create document:C266($FileAll_txt; ".png")
	CLOSE DOCUMENT:C267($picfile_t)
	
	BLOB TO DOCUMENT:C526(Document; $pic_blob)
	SHOW ON DISK:C922($FileAll_txt)
	
End if 

//End Dev_convertLibPicToPNG