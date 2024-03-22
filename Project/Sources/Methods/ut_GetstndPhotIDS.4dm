//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut__GetstndPhotIDS
// User name (OS): charlesmiller
// Date and time: 04/26/09, 12:28:44
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r002  `04/26/09, 12:28:46 `Costing - Add fields and update forms
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

ARRAY LONGINT:C221($UniqueKeys_al; 0)
C_TIME:C306($doc)
ALL RECORDS:C47([InventoryPhotos:113])
ARRAY LONGINT:C221($UniqueKeys_al; Records in selection:C76([InventoryPhotos:113]))

READ ONLY:C145([InventoryPhotos:113])
DISTINCT VALUES:C339([InventoryPhotos:113]InvPhoto_ID:1; $UniqueKeys_al)
C_BLOB:C604($Blob_blb)
SET BLOB SIZE:C606($Blob_blb; 0)
VARIABLE TO BLOB:C532($UniqueKeys_al; $Blob_blb)
$doc:=Create document:C266("")
CLOSE DOCUMENT:C267($doc)
BLOB TO DOCUMENT:C526(Document; $Blob_blb)

ARRAY LONGINT:C221($UniqueKeys_al; 0)

READ ONLY:C145([Standard Photos:36])
ALL RECORDS:C47([Standard Photos:36])
ARRAY LONGINT:C221($UniqueKeys_al; Records in selection:C76([Standard Photos:36]))
DISTINCT VALUES:C339([Standard Photos:36]StdPhotoID:7; $UniqueKeys_al)
C_BLOB:C604($Blob_blb)
SET BLOB SIZE:C606($Blob_blb; 0)
VARIABLE TO BLOB:C532($UniqueKeys_al; $Blob_blb)
$doc:=Create document:C266("")
CLOSE DOCUMENT:C267($doc)
BLOB TO DOCUMENT:C526(Document; $Blob_blb)






//End ut__GetstndPhotIDS