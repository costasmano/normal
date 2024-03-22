//%attributes = {"invisible":true}
//Method: INSP_PrintSelectedReports
//Description
// Print the current selection of [Inspections] records - meant to be run interactively
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Dec 1, 2023, 14:47:38
	Mods_2023_12
	// ----------------------------------------------------
	
End if 
//
C_BOOLEAN:C305($Display_B)
C_TEXT:C284($MonthYear_txt; $TownPrefix_txt; $FinalDirectory_txt; $MountLetter_txt; $pdfFolder_; $DebugPath_txt; \
$FileName_txt; $Report_txt; $PathToOpen_txt)
C_LONGINT:C283($pos_L; $startTickCount_l)
C_TIME:C306($doc_tm)
C_POINTER:C301($DocPath_ptr)
ARRAY LONGINT:C221($badInspIds_aL; 0)
ARRAY DATE:C224($insp_aD; 0)
ARRAY TEXT:C222($Bins_atxt; 0)
ARRAY TEXT:C222($InspType_atxt; 0)
ARRAY LONGINT:C221($inspIds_al; 0)
SELECTION TO ARRAY:C260([Inspections:27]Insp Date:78; $insp_aD; [Inspections:27]BIN:1; $Bins_atxt; [Inspections:27]Insp Type:6; $InspType_atxt; [Inspections:27]InspID:2; $inspIds_al)
ARRAY LONGINT:C221($FilesSize_aL; Size of array:C274($inspIds_al))
ARRAY LONGINT:C221($ElapsedTickCount_aL; Size of array:C274($inspIds_al))
ARRAY TEXT:C222($FilePath_atxt; Size of array:C274($inspIds_al))
C_LONGINT:C283($Loop_L; $RecordCount_L)
C_OBJECT:C1216($Progress_obj)
$RecordCount_L:=Records in selection:C76([Inspections:27])
C_TEXT:C284($parse_txt)

//verify if we want to print all these reports
CONFIRM:C162("Printing "+String:C10($RecordCount_L)+" inspection reports!"; "Continue"; "Cancel")

If (OK=1)
	
	SET PRINT OPTION:C733(Orientation option:K47:2; 1)
	SET PRINT OPTION:C733(Scale option:K47:3; 100)
	SET PRINT OPTION:C733(Paper option:K47:1; 612; 792)
	SET PRINTABLE MARGIN:C710(12; 12; 12; 12)
	
	C_BOOLEAN:C305($GenerateArchivalPdf_b)
	$GenerateArchivalPdf_b:=False:C215
	
	//Choose printing options - regular report print - print Archive version (includes QA /QC form and pdf attachments
	
	// if attachments are included then must have PDFtoolkit installed on windows
	
	PRINT SETTINGS:C106
	
	If (OK=1)
		
		C_LONGINT:C283($prDest_L)
		C_TEXT:C284($pdffile_; $pdfFolder_)
		GET PRINT OPTION:C734(Destination option:K47:7; $prDest_L; $pdffile_)
		$pdffile_:=""
		//check to see if we are generating pdfs and adjust/select folder location
		If (Is macOS:C1572)
			//check if saving to pdf
			If ($prDest_L=3)
				If ($pdffile_#"")  // do we have a file?
					$pdfFolder_:=File:C1566($pdffile_; fk platform path:K87:2).parent.platformPath
					//if only one report is printed, then will continue
					If (Records in set:C195("InspReviewSelect")>1)
						//else alert user that first report will be printed with the selected name
						// the rest will be in the same folder named structurenumber-inspectiontype-date
						ALERT:C41("Printing multiple inspections to PDF!\n"+\
							"First report will be printed as specified, the remaining reports will be printed named \n"+\
							"\"BDEPT-BIN-InspectionDate-InspectionType.pdf\". You can choose further options.")
					End if 
					
				Else 
					//printing to PDF but no file - Prompt for a folder
					$pdfFolder_:=Select folder:C670("Select folder for generated PDF files"; "")
					
					If (OK=1)
					Else 
						//No folder selected - place them in Documents folder
						ALERT:C41("Generated pdfs will be placed in the Documents folder under InspectionPDFs_"+Substring:C12(String:C10(Current date:C33; ISO date:K1:8); 1; 10))
						$pdfFolder_:=System folder:C487(Documents folder:K41:18)+Folder separator:K24:12+"InspectionPDFs_"+Substring:C12(String:C10(Current date:C33; ISO date:K1:8); 1; 10)+Folder separator:K24:12
					End if 
					
				End if 
			End if 
			
		Else 
			//windows
			//check if the printer being used is a pdf printer and Print Preview is not selected
			C_TEXT:C284($currprinter_)
			
			$currprinter_:=Get current printer:C788
			If ((Position:C15("PDF"; $currprinter_)>0) & Not:C34(Get print preview:C1197))
				// if printer is Adobe pdf we cannot automatically save the pdf to a location - Adobe brings up the save dialog
				If ($currprinter_#"Adobe @")
					//not Adobe - should work with Microsoft pdf printer
					ALERT:C41("Printing to a PDF printer \""+$currprinter_+"\"\n"+\
						"Select folder where pdf files(s) will be generated. "+\
						"They will be named: \n"+\
						"\"BDEPT-BIN-InspectionDate-InspectionType.pdf\" .")
					$pdfFolder_:=Select folder:C670("Select folder for generated PDF files"; 200)
					
					If (OK=1)
					Else 
						//No folder selected - place them in Documents folder
						ALERT:C41("Generated pdfs will be placed in the Documents folder under InspectionPDFs_"+Substring:C12(String:C10(Current date:C33; ISO date:K1:8); 1; 10))
						$pdfFolder_:=System folder:C487(Documents folder:K41:18)+Folder separator:K24:12+"InspectionPDFs_"+Substring:C12(String:C10(Current date:C33; ISO date:K1:8); 1; 10)+Folder separator:K24:12
					End if 
				Else 
					ALERT:C41("When printing to Adobe PDF cannot automatically save pdfs to a location. "+\
						"You will be prompted to save each pdf generated! "+\
						"Automatic saving can be done with the Microsoft Print to PDF printer.")
				End if 
			End if 
			
		End if   // if macOS
		
		C_BLOB:C604($RoState_x)
		$RoState_x:=ut_db_SaveROState
		READ ONLY:C145(*)
		
		C_BOOLEAN:C305($printtopdf_b)
		$printtopdf_b:=($pdfFolder_#"")  // we are making pdfs
		
		If ($printtopdf_b)
			// check if reports should be separated by Town-BDEPT-BIN folders or just placed in the same folder
			ARRAY TEXT:C222($folderChoices_atxt; 0)
			APPEND TO ARRAY:C911($folderChoices_atxt; "All reports in same folder")
			APPEND TO ARRAY:C911($folderChoices_atxt; "Separate by BDEPT_BIN")
			APPEND TO ARRAY:C911($folderChoices_atxt; "Separate by Town/BDEPT_BIN")
			APPEND TO ARRAY:C911($folderChoices_atxt; "Separate by Town/BDEPT_BIN/Year")
			C_LONGINT:C283($folderChoice_L)
			$folderChoice_L:=G_PickFromList(->$folderChoices_atxt; "Select option for report placement")
			$Progress_obj:=ProgressNew("Creating "+String:C10($RecordCount_L)+" PDF Inspection reports "; $RecordCount_L; True:C214; " report"; 3)
			
		Else 
			$Progress_obj:=ProgressNew("Printing "+String:C10($RecordCount_L)+" Inspection reports "; $RecordCount_L; True:C214; " report"; 3)
		End if 
		
		C_BOOLEAN:C305($NeedToCombinePdfs_B; $WriteLogFile_B)
		C_TEXT:C284($CreateInspLog_txt)
		
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		
		
		If ($GenerateArchivalPdf_b)
			//define a temp folder if generating archival pdfs
			$TempFolder_txt:=System folder:C487(Documents folder:K41:18)+"TempLocalInspectionPDF"
			If (Test path name:C476($TempFolder_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475($TempFolder_txt)
			End if 
			$TempFolder_txt:=$TempFolder_txt+Folder separator:K24:12
			
		End if 
		
		For ($Loop_l; 1; Records in selection:C76([Inspections:27]))
			
			If ($GenerateArchivalPdf_b)
				//if doing archival pdf clear out the temp folder
				insp_RemovePreviousPDF($TempFolder_txt)
			End if 
			
			GOTO SELECTED RECORD:C245([Inspections:27]; $loop_l)
			
			UpdateProgressNew($Progress_obj; $loop_l)
			
			$startTickCount_l:=Tickcount:C458
			
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
			QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
			
			If ([Combined Inspections:90]BMSInspID:3>0)
				QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
			Else 
				UNLOAD RECORD:C212([BMS Inspections:44])
			End if 
			
			If (PON_NBEDateOn_b([Inspections:27]Insp Date:78))
				PON_ListElements
				CLEAR SET:C117("PON_LISTINSPELEMS")  // we do not need the set created in PON_ListElements
			Else 
				DISPL_CUs
			End if 
			
			$TownPrefix_txt:=Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
			QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$TownPrefix_txt)
			QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
			
			If ($printtopdf_b)
				// if creating pdf file set the output file
				Case of 
					: ($folderChoice_L=1)
						//all files in same folder
						$FinalDirectory_txt:=$pdfFolder_
					: ($folderChoice_L=2)
						//split by BDEPT_BIN folders
						$FinalDirectory_txt:=$pdfFolder_+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3+Folder separator:K24:12
					: ($folderChoice_L=3)
						//split by Town/BDEPT_BIN
						$FinalDirectory_txt:=$pdfFolder_+$TownPrefix_txt+" "+[Town Data:2]Town Name:1+Folder separator:K24:12+\
							[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3+Folder separator:K24:12
					: ($folderChoice_L=4)
						//split by Town/BDEPT_BIN
						$FinalDirectory_txt:=$pdfFolder_+$TownPrefix_txt+" "+[Town Data:2]Town Name:1+Folder separator:K24:12+\
							[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3+Folder separator:K24:12+\
							String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")+Folder separator:K24:12
						
				End case 
				
				//make sure town folder exists for this bridge
				If (Test path name:C476($FinalDirectory_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($FinalDirectory_txt; *)
				End if 
				
			End if   //if print to pdf
			
			$FileName_txt:=[Bridge MHD NBIS:1]BDEPT:1+"-"+[Bridge MHD NBIS:1]BIN:3+"-"+\
				Substring:C12(String:C10([Inspections:27]Insp Date:78; ISO date:K1:8); 1; 10)+"-"+\
				[Inspection Type:31]Description:2+".PDF"
			$FileName_txt:=Replace string:C233($FileName_txt; "/"; "_")
			$FileName_txt:=Replace string:C233($FileName_txt; ":"; "_")
			
			G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1; ->[PON_ELEM_INSP:179]INSPID:21)
			
			INSP_BuildTmMbrArea
			
			C_BOOLEAN:C305($Esig_active_b)
			C_BOOLEAN:C305(INSP_CreatePDFsofApproved_B; $NeedToCombinePdfs_B)
			$NeedToCombinePdfs_B:=False:C215
			
			If ($GenerateArchivalPdf_b)  // not printing for archival reasons
				
				INSP_CreatePDFsofApproved_B:=True:C214  // flag would be used when printing in batch mode reports to be archived.
				
				C_DATE:C307(<>Insp_ESignatureStart)
				If (<>Insp_ESignatureStart#!00-00-00!)
					$Esig_active_b:=([Inspections:27]Insp Date:78>=<>Insp_ESignatureStart)
				End if 
				
				//generate additional pdfs that cannot be part of the inspection print process
				ARRAY TEXT:C222($Files_atxt; 0)
				C_TEXT:C284($TempFolder_txt; $ResultFile_txt)
				APPEND TO ARRAY:C911($Files_atxt; $TempFolder_txt+$FileName_txt)
				INSP_CreateAdditionalPages(->$Files_atxt; ->$TempFolder_txt)
				$NeedToCombinePdfs_B:=(Size of array:C274($Files_atxt)>1)
				
			End if 
			
			ON ERR CALL:C155("PrintTOPDFError")
			
			SET PRINT OPTION:C733(Spooler document name option:K47:10; $FileName_txt)
			
			$pdffile_:=$FinalDirectory_txt+$FileName_txt
			
			If (Is Windows:C1573)
				//Windows
				If (Position:C15("PDF"; Get current printer:C788)>0)
					
					Case of 
						: (Get current printer:C788="Microsoft@")  // microsoft pdf printer
							SET PRINT OPTION:C733(Destination option:K47:7; 2; $pdffile_)
						: (Get current printer:C788="Adobe@")  // adobe pdf printer ; option 2 makes .PS files
							SET PRINT OPTION:C733(Destination option:K47:7; 3; $pdffile_)
							
					End case 
					
				End if 
				
			Else 
				//Mac
				If ($printtopdf_b)
					SET PRINT OPTION:C733(Destination option:K47:7; 3; $pdffile_)
				End if 
			End if 
			
			PRINT_PdfDest_b:=False:C215
			OPEN PRINTING JOB:C995
			
			If ($Esig_active_b)
				
				Print form:C5([Inspections:27]; "QCQAPrint")
				PAGE BREAK:C6
				
			End if 
			
			// these needed so page counting can be done.
			C_BOOLEAN:C305(vbInspectionLocked; INSP_PageCountDone_b)
			vbInspectionLocked:=True:C214
			INSP_PageCountDone_b:=False:C215
			//print the inspection report - 
			
			Case of 
				: ([Inspections:27]Insp Type:6="DV@")
					
					Print_Dive_F_PDF
					
				: (([Inspections:27]Insp Type:6="RT@"))
					
					PRINT_ROUTINE_F_PDF
					
				: ([Inspections:27]Insp Type:6="CUL")
					
					PRINT_CULVERT_F_PDF
					
				: ([Inspections:27]Insp Type:6="CMI") | ([Inspections:27]Insp Type:6="FCR") | ([Inspections:27]Insp Type:6="OTH")
					
					PRINT_Critical_PDF
					//PRINT_Critical 
				: ([Inspections:27]Insp Type:6="DAM")
					
					PRINT_Damage_PDF
					
					
				: ([Inspections:27]Insp Type:6="FRZ")
					
					PRINT_FREEZE_F_PDF
					
				: ([Inspections:27]Insp Type:6="CLD")
					
					PRINT_Closed_PDF
					
					
				: ([Inspections:27]Insp Type:6="PON")
					
					PRINT_PONTIS_F_PDF
					
				: ([Inspections:27]Insp Type:6="PED")
					
					INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
					PRINT_ROUTINE_F_PDF
					
				: ([Inspections:27]Insp Type:6="RRR")
					
					INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
					PRINT_ROUTINE_F_PDF
					
				: ([Inspections:27]Insp Type:6="PED")  //Pedestrian bridge
					
					INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
					PRINT_ROUTINE_F_PDF
					
				: ([Inspections:27]Insp Type:6="RRA")  //Rail routine arch
					
					INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
					PRINT_ROUTINE_F_PDF
					
				: ([Inspections:27]Insp Type:6="RRC")  //Rail routine culvert
					
					INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
					PRINT_CULVERT_F_PDF
					
				: ([Inspections:27]Insp Type:6="RRS") | ([Inspections:27]Insp Type:6="RRF") | ([Inspections:27]Insp Type:6="RRO")  //Rail special, fract crit, other
					
					INSP_LoadElmLabelsforReport([Inspections:27]BaseType_s:215)
					PRINT_Critical_PDF
					
				: ([Inspections:27]Insp Type:6="RRD")  //Rail damage
					
					INSP_LoadElmLabelsforReport([Inspections:27]BaseType_s:215)
					PRINT_Damage_PDF
					
				: ([Inspections:27]Insp Type:6="TAL")
					
					INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
					QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
					NTI_INIT
					PRINT_TunnelAllItems_F_PDF
					
				: ([Inspections:27]Insp Type:6="TOV")
					
					INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
					QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
					NTI_INIT
					PRINT_TunnelAllItems_F_PDF
					
				: (([Inspections:27]Insp Type:6="TSP") | ([Inspections:27]Insp Type:6="TDA") | ([Inspections:27]Insp Type:6="TOT"))
					
					INSP_LoadElmLabelsforReport("TAL")
					QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
					NTI_INIT
					PRINT_Critical_PDF
			End case   // case of report type
			
			CLOSE PRINTING JOB:C996
			
			If ($NeedToCombinePdfs_B)
				
				PDF_CombinePdfs(->$Files_atxt; $pdffile_)
				
			End if 
			
			$ElapsedTickCount_aL{$Loop_L}:=Tickcount:C458-$startTickCount_l
			$FilePath_atxt{$Loop_L}:=$FinalDirectory_txt+$FileName_txt
			
			//check if progress stopped
			If (Progress Stopped(OB Get:C1224($Progress_obj; "progress"; Is longint:K8:6)))
				//abort loop
				$Loop_l:=Records in selection:C76([Inspections:27])+1
			End if 
			
		End for 
		
		Progress QUIT(OB Get:C1224($Progress_obj; "progress"; Is longint:K8:6))
		
		If (False:C215)  // not collecting statistics yet
			
			For ($Loop_L; 1; Size of array:C274($FilesSize_aL))
				
				$FilesSize_aL{$Loop_L}:=Get document size:C479($FilePath_atxt{$Loop_L})
				If ($FilesSize_aL{$Loop_L}=0)
					APPEND TO ARRAY:C911(SQL_InternalDescriptions_atxt; "File size 0 for file "+$FilePath_atxt{$Loop_L})
					
				End if 
				
			End for 
			
			$Report_txt:="Inspection ID,Inspection Date,BIN,Inspection Type,Elapsed Tick Count,File Size,Doc Path\n"+\
				ut_ArrayToText_CSV(","; ->$inspIds_al; ->$insp_aD; ->$Bins_atxt; ->$InspType_atxt; ->$ElapsedTickCount_aL; ->$FilesSize_aL; ->$FilePath_atxt)
			$FileName_txt:="ValidInsp_"+$MonthYear_txt+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 8)+".csv"
			TEXT TO DOCUMENT:C1237($DocPath_ptr->+$FileName_txt; $Report_txt; UTF8 text without length:K22:17)
			$PathToOpen_txt:=$DocPath_ptr->+$FileName_txt
			Repeat 
				//IDLE
				DELAY PROCESS:C323(Current process:C322; 20)
			Until (Test path name:C476($PathToOpen_txt)=Is a document:K24:1)
			
		End if 
		
		ut_db_RestoreROState($RoState_x)
		
		SET PRINT OPTION:C733(Spooler document name option:K47:10; "Untitled")
		
		If ($pdfFolder_#"")  // we printed pdfs - show the contents of the folder
			SHOW ON DISK:C922($pdfFolder_; *)
		End if 
		
	End if   // if ok after print settings
	
End if   // if ok to print the reports

//End INSP_PrintSelectedReports   