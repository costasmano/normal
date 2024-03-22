//%attributes = {"invisible":true}
//Method: Print_SetPDFDest
//Description
//  `Handle changing the destination
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/08/16, 17:43:40
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	//Handle changing the destination
End if 
//
C_TEXT:C284($prevSpoolDocName; $folderLocation_txt; $destName_txt; $counter_txt; $oldcounter_txt)
C_LONGINT:C283($dest_L; $posCounter_L; $loop_L)
C_TEXT:C284(PRINT_DestFolder_txt; PRINT_DestFileName_txt; PRINT_TempDestFolder_txt)
C_BOOLEAN:C305(PRINT_PdfDest_b)
C_LONGINT:C283(PRINT_destCount_L)

If (PRINT_PdfDest_b)
	//GET PRINT OPTION(Spooler document name option ;$prevSpoolDocName)
	Case of 
			
		: (PRINT_destCount_L>0)
			//CLOSE PRINTING JOB
			PAGE BREAK:C6  //extra break here maybe not needed ???
			DELAY PROCESS:C323(Current process:C322; 20)  // delay a bit to close the previous job
			SET PRINT OPTION:C733(Destination option:K47:7; 1)  //switching to printer and then back to pdf seems to help.
			SET PRINT OPTION:C733(Destination option:K47:7; 3; PRINT_TempDestFolder_txt+PRINT_DestFileName_txt+"_"+String:C10(PRINT_destCount_L)+".pdf")
			
		: (PRINT_destCount_L=0)
			
			C_LONGINT:C283($Destopt_L; $macSpoolFormat_L)
			C_TEXT:C284($SpoolerDocName_txt; $accessPath_txt)
			
			GET PRINT OPTION:C734(Destination option:K47:7; $Destopt_L; $accessPath_txt)
			
			PRINT_DestFolder_txt:=GetPath($accessPath_txt)
			PRINT_DestFileName_txt:=Replace string:C233($accessPath_txt; GetFileExtension($accessPath_txt); "")  //first remove extension - 
			PRINT_DestFileName_txt:=Replace string:C233(PRINT_DestFileName_txt; PRINT_DestFolder_txt; "")
			
			PRINT_TempDestFolder_txt:=Temporary folder:C486+PRINT_DestFileName_txt+Replace string:C233(ISODateTime(Current date:C33(*); Current time:C178(*)); ":"; "-")+<>PL_DirectorySep_s
			If (Test path name:C476(PRINT_TempDestFolder_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475(PRINT_TempDestFolder_txt)
			End if 
			
			SET PRINT OPTION:C733(Destination option:K47:7; 3; PRINT_TempDestFolder_txt+PRINT_DestFileName_txt+"_0.pdf")
			
	End case 
	
End if 
SET PRINT OPTION:C733(Spooler document name option:K47:10; PRINT_DestFileName_txt+"_"+String:C10(PRINT_destCount_L)+".pdf")
PRINT_destCount_L:=PRINT_destCount_L+1

//End Print_SetPDFDest