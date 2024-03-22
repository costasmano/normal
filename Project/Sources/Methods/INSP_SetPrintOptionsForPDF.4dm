//%attributes = {"invisible":true}
//Method: INSP_SetPrintOptionsForPDF
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 12/31/20, 14:03:33
	// ----------------------------------------------------
	//Created : 
	Mods_2020_12  //Add code that will create PDFs of all [Inspections]InspApproved=2
End if 
//
If (True:C214)
	SET PRINT OPTION:C733(Orientation option:K47:2; 1)
	SET PRINT OPTION:C733(Scale option:K47:3; 100)
	SET PRINT OPTION:C733(Paper option:K47:1; 612; 792)
	SET PRINTABLE MARGIN:C710(12; 12; 12; 12)
	//SET PRINT OPTION(_o_Hide printing progress option; 1)
	
Else 
	SET PRINT OPTION:C733(Orientation option:K47:2; 1)
	SET PRINT OPTION:C733(Paper option:K47:1; "US Letter")
	SET PRINT OPTION:C733(Scale option:K47:3; 100)
	
	//GET PRINTABLE MARGIN($left;$top;$right;$bott)
	// set printable margins to 12 12 12 12
	SET PRINTABLE MARGIN:C710(12; 12; 12; 12)
	
End if 
//End INSP_SetPrintOptionsForPDF