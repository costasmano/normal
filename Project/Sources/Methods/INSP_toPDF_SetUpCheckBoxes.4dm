//%attributes = {"invisible":true}
//Method: INSP_toPDF_SetUpCheckBoxes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/07/21, 13:01:27
	// ----------------------------------------------------
	//Created : 
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
End if 

vPrintPage1:=1
vPrintSPMemPgs:=1
vPrintCmts:=1
vPrintSketches:=1
vPrintCharts:=1
vPrintPhotos:=1
vPrintPontis:=1
vPrintPontisField:=0
vPrintInvPhotos:=0
viInspPreviewErr:=0
//End INSP_toPDF_SetUpCheckBoxes