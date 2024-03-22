//%attributes = {"invisible":true}
//Method: LSS_PrintMultipleInspections
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/25/18, 14:35:49
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
	Mods_2018_07  //Add code to print damage inspections
	// Modified by: Costas Manousakis-(Designer)-(6/19/20 18:58:55)
	Mods_2020_06
	//  `added progress bar with option to stop the printing and added alert at the end
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 18:12:48)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-01-03T00:00:00 16:56:34)
	Mods_2022_01
	//  `create a new sorted selection of the highlited records and then run the printing
	// Modified by: Costas Manousakis-(Designer)-(2022-09-15 17:22:58)
	Mods_2022_09_bug
	//  `when calling LSS_PrintInspection_WP pass the selected record number. 
	//  `Save in pasteboard a name for the file to be used when saving pdfs
	// Modified by: Costas Manousakis-(Designer)-(2023-05-25 13:44:23)
	Mods_2023_05_bug
	//  `fix/adjustments when printing to pdf - adjust for mac or windows pdf printers.
	//  `  logic does not work with PDF Report writer. 
	//  `if printing to pdf show the last created pdf at the end
	// Modified by: Costas Manousakis-(Designer)-(2023-11-08 17:44:12)
	Mods_2023_11
	//  `Initialize the spooler document name using the 1st inspection
	//  `Stop if user cancels out of print settings
	//  `Handle case of using Microsoft or Adobe
	// Modified by: manousakisc-(Designer)-(3/14/2024 17:29:48)
	Mods_2024_03_bug
	// //ask for destination of pdf files only if not in print preview
	
End if 
//
SET PRINT OPTION:C733(Orientation option:K47:2; 1)
SET PRINT OPTION:C733(Paper option:K47:1; "Letter")
SET PRINT OPTION:C733(Scale option:K47:3; 100)
C_BOOLEAN:C305($SaveShowPrint_B)

FIRST RECORD:C50([LSS_Inspection:164])

//start of Mods_2023_11
QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1=[LSS_Inspection:164]LSS_InspectionTypeId_s:3)

SET PRINT OPTION:C733(Spooler document name option:K47:10; \
[LSS_Inventory:165]LSS_StructureNumber_s:6+" "+\
[LSS_refInspectionType:167]LSS_Description_txt:2+" "+\
Substring:C12(String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4; ISO date:K1:8); 1; 10))
SET TEXT TO PASTEBOARD:C523(\
[LSS_Inventory:165]LSS_StructureNumber_s:6+" "+\
[LSS_refInspectionType:167]LSS_Description_txt:2+" "+\
Substring:C12(String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4; ISO date:K1:8); 1; 10))
//end of Mods_2023_11

If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 
//start of Mods_2023_11
If (OK=1)
	//end of Mods_2023_11
	C_LONGINT:C283($prDest_L)
	C_TEXT:C284($pdffile_; $pdfFolder_)
	GET PRINT OPTION:C734(Destination option:K47:7; $prDest_L; $pdffile_)
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
						"\"StructureNumber InspectionType InspectionDate.pdf\" in the same folder.")
				End if 
				
			Else 
				//printing to PDF but no file - Prompt for a folder
				$pdfFolder_:=Select folder:C670("Select folder for generated PDF files"; "")
				
				If (OK=1)
				Else 
					//No folder selected - place them in Documents folder
					ALERT:C41("Generated pdfs will be placed in the Documents folder")
					$pdfFolder_:=System folder:C487(Documents folder:K41:18)
				End if 
				
			End if 
		End if 
		
	Else 
		//windows
		//check if the printer being used is a pdf printer and NOT in print preview
		C_TEXT:C284($currprinter_)
		$currprinter_:=Get current printer:C788
		//start of Mods_2024_03_bug
		If (Position:C15("PDF"; $currprinter_)>0) & Not:C34(Is in print preview:C1198)
			//end of Mods_2024_03_bug
			ALERT:C41("Printing to a PDF printer \""+$currprinter_+"\"\n"+\
				"Select folder where pdf files(s) will be generated. "+\
				"They will be named: \n"+\
				"\"StructureNumber InspectionType InspectionDate.pdf\" .")
			//printing to PDF but no file - Prompt for a folder
			$pdfFolder_:=Select folder:C670("Select folder for generated PDF files"; "")
			
			If (OK=1)
			Else 
				//No folder selected - place them in Documents folder
				ALERT:C41("Generated pdfs will be placed in the Documents folder")
				$pdfFolder_:=System folder:C487(Documents folder:K41:18)
			End if 
		End if 
	End if 
	$SaveShowPrint_B:=<>ShowPrint
	<>ShowPrint:=False:C215  // to avoid showing print for every print inspection
	
	C_LONGINT:C283($LBRow_L; $Selected_L; $printCount_L)
	$Selected_L:=Records in set:C195("InspReviewSelect")
	COPY NAMED SELECTION:C331([LSS_Inspection:164]; "$CurrentSel")
	ARRAY LONGINT:C221($CurrSelRecs_aL; 0)
	SELECTION TO ARRAY:C260([LSS_Inspection:164]; $CurrSelRecs_aL)
	COPY SET:C600("InspReviewSelect"; "SaveHilite")
	USE SET:C118("InspReviewSelect")
	ARRAY LONGINT:C221($SelRecNums_aL; Records in selection:C76([LSS_Inspection:164]))
	ARRAY LONGINT:C221($SelRecNumSort_aL; Records in selection:C76([LSS_Inspection:164]))
	SELECTION TO ARRAY:C260([LSS_Inspection:164]; $SelRecNums_aL)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($SelRecNums_aL))
		$SelRecNumSort_aL{$loop_L}:=Find in array:C230($CurrSelRecs_aL; $SelRecNums_aL{$loop_L})
	End for 
	SORT ARRAY:C229($SelRecNumSort_aL; $SelRecNums_aL)
	CREATE SELECTION FROM ARRAY:C640([LSS_Inspection:164]; $SelRecNums_aL)
	$printCount_L:=0
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Printing Inspection reports"; $Selected_L; True:C214; " Inspections"; 0)
	C_BOOLEAN:C305($aborted_B)
	$aborted_B:=False:C215
	For ($LBRow_L; 1; Records in selection:C76([LSS_Inspection:164]))
		GOTO SELECTED RECORD:C245([LSS_Inspection:164]; $LBRow_L)
		If (Is in set:C273("InspReviewSelect"))
			$printCount_L:=$printCount_L+1
			//update progress
			UpdateProgressNew($progress_o; $printCount_L)
			
			LOAD RECORD:C52([LSS_Inspection:164])
			QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=[LSS_Inspection:164]LSS_InventoryId_s:2)
			C_TEXT:C284($InspTypeDescription_txt; $AllowedElements_txt)
			LSS_RTRNInspectionData([LSS_Inspection:164]LSS_InspectionTypeId_s:3; ->$InspTypeDescription_txt; ->$AllowedElements_txt)
			
			C_TEXT:C284($pdfFilename_)
			$pdfFilename_:=[LSS_Inventory:165]LSS_StructureNumber_s:6+" "+$InspTypeDescription_txt+" "+\
				Substring:C12(String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4; ISO date:K1:8); 1; 10)+".pdf"
			If (Is macOS:C1572)
				//need to set the pdf file name 
				//for the first inspection it will be the name selected
				If ($prDest_L=3)
					// printing to pdf $pdfFolder_ is set
					// if $pdffile_ has not been specified for 1st report, use the $pdfFilename_
					If ($pdffile_#"") & ($LBRow_L=1)
					Else 
						$pdffile_:=$pdfFolder_+$pdfFilename_
					End if 
				End if 
				
				SET PRINT OPTION:C733(Destination option:K47:7; $prDest_L; $pdffile_)
				
			Else 
				//Windows
				//start of Mods_2023_11
				If (Position:C15("PDF"; Get current printer:C788)>0)
					$pdffile_:=$pdfFolder_+$pdfFilename_
					
					Case of 
						: (Get current printer:C788="Microsoft@")  // microsoft pdf printer
							SET PRINT OPTION:C733(Destination option:K47:7; 2; $pdffile_)
						: (Get current printer:C788="Adobe@")  // adobe pdf printer
							SET PRINT OPTION:C733(Destination option:K47:7; 3; $pdffile_)
							
					End case 
					
					
				End if 
			End if 
			//end of Mods_2023_11
			
			SET TEXT TO PASTEBOARD:C523($pdfFilename_)
			
			If (Position:C15("Damage"; $InspTypeDescription_txt)>0)
				Compiler_FieldVariables(Table:C252(->[LSS_Inspection:164]))
				Compiler_FieldVariables(Table:C252(->[LSS_Inventory:165]))
				Compiler_FieldVariables(Table:C252(->[LSS_ElementInspection:163]))
				
				LSS_CreateElementInputArrays($AllowedElements_txt)
				
				LSS_LoadArraysForInputForm
				LSS_PrintDamageInspection_WP
			Else 
				LSS_LoadArraysForInputForm
				
				LSS_PrintInspection_WP($LBRow_L)
				
			End if 
			
		End if 
		//check if progress stopped
		If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
			$LBRow_L:=Records in selection:C76([LSS_Inspection:164])+1  //abort loop
			$aborted_B:=True:C214
		End if 
		
	End for 
	USE NAMED SELECTION:C332("$CurrentSel")
	CLEAR NAMED SELECTION:C333("$CurrentSel")
	COPY SET:C600("SaveHilite"; "InspReviewSelect")
	CLEAR SET:C117("SaveHilite")
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	
	If ($aborted_B)
		ALERT:C41("Printing of inspection reports was aborted!")
	Else 
		ALERT:C41("Printing of inspection reports was completed!")
	End if 
	
	If ($pdffile_#"")
		SHOW ON DISK:C922($pdffile_)
	End if 
	//restore
	<>ShowPrint:=$SaveShowPrint_B
	
End if 

//start of Mods_2023_11
SET PRINT OPTION:C733(Spooler document name option:K47:10; "Untitled")
//end of Mods_2023_11
//End LSS_PrintMultipleInspections