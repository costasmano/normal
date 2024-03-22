//%attributes = {"invisible":true}
//Method: Test_makeButton_png
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/24/15, 12:39:24
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04
End if 
//
C_PICTURE:C286($addpic_pict; $fourpart_Pic; $cropPic_pict)
C_BLOB:C604($pic_blob)
C_TIME:C306($picfile_t)
If (False:C215)
	GET PICTURE FROM LIBRARY:C565(6670; $addpic_pict)
	PICTURE TO BLOB:C692($addpic_pict; $pic_blob; ".PNG")
	ALERT:C41("Save source")
	
	$picfile_t:=Create document:C266(""; ".png")
	CLOSE DOCUMENT:C267($picfile_t)
	
	BLOB TO DOCUMENT:C526(Document; $pic_blob)
	
End if 

ALERT:C41("Read newSource")
READ PICTURE FILE:C678(""; $addpic_pict)

ALERT:C41("Read background")
READ PICTURE FILE:C678(""; $fourpart_Pic)
C_LONGINT:C283($MasterpicW; $masterpicH; $FrameH; $offset; $picW; $picH)
PICTURE PROPERTIES:C457($fourpart_Pic; $MasterpicW; $masterpicH)
$FrameH:=$masterpicH/4
PICTURE PROPERTIES:C457($addpic_pict; $picW; $picH)
TRANSFORM PICTURE:C988($addpic_pict; Scale:K61:2; ($MasterpicW/$picW); ($MasterpicW/$picW))
$offset:=($FrameH-($picH*($MasterpicW/$picW)))/2
COMBINE PICTURES:C987($fourpart_Pic; $fourpart_Pic; Superimposition:K61:10; $addpic_pict; 0; $offset)
COMBINE PICTURES:C987($fourpart_Pic; $fourpart_Pic; Superimposition:K61:10; $addpic_pict; 0; $FrameH+$offset)
$cropPic_pict:=$addpic_pict
TRANSFORM PICTURE:C988($cropPic_pict; Crop:K61:7; 2; 2; ($picW-2); ($picH-2))
PICTURE PROPERTIES:C457($fourpart_Pic; $picW; $picH)
COMBINE PICTURES:C987($fourpart_Pic; $fourpart_Pic; Superimposition:K61:10; $addpic_pict; 0; ($FrameH+$FrameH+$offset))
TRANSFORM PICTURE:C988($addpic_pict; Fade to grey scale:K61:6)
COMBINE PICTURES:C987($fourpart_Pic; $fourpart_Pic; Superimposition:K61:10; $cropPic_pict; 0; ($FrameH+$FrameH+$FrameH+$offset))


PICTURE TO BLOB:C692($fourpart_Pic; $pic_blob; ".PNG")
C_TIME:C306($picfile_t)
ALERT:C41("Save combination")
$picfile_t:=Create document:C266(""; ".png")
CLOSE DOCUMENT:C267($picfile_t)
BLOB TO DOCUMENT:C526(Document; $pic_blob)

//End Test_makeButton_png