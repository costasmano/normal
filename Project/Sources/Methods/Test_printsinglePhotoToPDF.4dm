//%attributes = {"invisible":true}
// Method: Test_printsinglePhotoToPDF
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/10/16, 17:34:19
	// ----------------------------------------------------
	// First Release
	Mods_2016_06
End if 
QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=2017)
C_PICTURE:C286(vPicture1)
vPicture1:=[Standard Photos:36]Std Photo:3
C_LONGINT:C283($prinHt_L)
C_TIME:C306($doc_t)
$doc_t:=Create document:C266(""; ".pdf")
CLOSE DOCUMENT:C267($doc_t)
//PRINT SETTINGS
//SET PRINT OPTION(Paper option ;534;640)
//_O_PAGE SETUP([Standard Photos]; "singlephotoportrait")
FORM SET OUTPUT:C54([Standard Photos:36]; "singlephotoportrait")
SET PRINT OPTION:C733(Destination option:K47:7; 3; Document)
$prinHt_L:=Print form:C5([Standard Photos:36]; "singlephotoportrait")
PAGE BREAK:C6

$doc_t:=Create document:C266(""; ".pdf")
CLOSE DOCUMENT:C267($doc_t)
//PRINT SETTINGS
//SET PRINT OPTION(Paper option ;534;640)
//_O_PAGE SETUP([Standard Photos]; "SinglePrintPhotoLand")
FORM SET OUTPUT:C54([Standard Photos:36]; "SinglePrintPhotoLand")
SET PRINT OPTION:C733(Destination option:K47:7; 3; Document)
$prinHt_L:=Print form:C5([Standard Photos:36]; "SinglePrintPhotoLand")
PAGE BREAK:C6
