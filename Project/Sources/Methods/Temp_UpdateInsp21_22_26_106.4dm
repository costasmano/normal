//%attributes = {"invisible":true}
//ALL RECORDS([Inspections])
//C_LONGINT($vlNumRec)
//$vlNumRec:=Records in selection([Inspections])
//SET CURSOR(4)
//FIRST RECORD([Inspections])
//For ($i;1;$vlNumRec)
//RELATE ONE([Inspections]BIN)
//[Inspections]Item21:=[Bridge MHD NBIS]Item21
//[Inspections]Item22:=[Bridge MHD NBIS]Item22
//[Inspections]Item26:=[Bridge MHD NBIS]Item26
//[Inspections]Item106:=[Bridge MHD NBIS]Item106
//SAVE RECORD([Inspections])
//NEXT RECORD([Inspections])
//
//End for 
//FLUSH BUFFERS
//SET CURSOR(0)