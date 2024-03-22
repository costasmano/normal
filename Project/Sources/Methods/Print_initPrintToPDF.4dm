//%attributes = {"invisible":true}
//Method: Print_initPrintToPDF
//Description
// initialize printing to PDF for Mac
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/05/16, 10:34:43
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	// Modified by: Costas Manousakis-(Designer)-(6/2/20 17:41:52)
	Mods_2020_06
	//  `remove check of spool format Dest Opt = 3 is PDF on mac CallReference #715
End if 
//

C_BOOLEAN:C305(PRINT_PdfDest_b)
C_LONGINT:C283($Destopt_L; $macSpoolFormat_L)
C_TEXT:C284($SpoolerDocName_txt; $accessPath_txt)
PRINT_PdfDest_b:=False:C215
If (<>MacPL_b)  //only works for Mac for now
	//initialize print job name and/or output file name
	PRINT_DestFileName_txt:=[Inspection Type:31]Description:2+"-"+[Inspections:27]BIN:1+"-"+Substring:C12(String:C10([Inspections:27]Insp Date:78; ISO date:K1:8); 1; 10)
	
	GET PRINT OPTION:C734(Destination option:K47:7; $Destopt_L; $accessPath_txt)
	GET PRINT OPTION:C734(Mac spool file format option:K47:11; $macSpoolFormat_L)
	//GET PRINT OPTION(Spooler document name option ;$SpoolerDocName_txt)
	PRINT_PdfDest_b:=(($Destopt_L=3))  //& ($macSpoolFormat_L=0))  //printing to file AND format is PDF
	//initialize printing to PDF
	C_LONGINT:C283(PRINT_destCount_L)
	PRINT_destCount_L:=0
	Print_SetPDFDest
Else 
	
	
End if 

//End Print_initPrintToPDF