If (False:C215)
	
	// ----------------------------------------------------
	// Object Method: vbPrintImages
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 15:58:38
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	
	//[Standard Photos]Standard Photos.vbPrintImages 
	//Print preview the current image depending on type of
	//the inspection
	//Created in December 2004
	
	Mods_2004_VN04
	Mods_2005_CJM02  //03/29/05, 15:58:45
	// Modified by: costasmanousakis-(Designer)-(10/10/2006 08:38:22)
	Mods_2006_CM06A
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:32:42)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(2/22/09 23:06:03)
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: Costas Manousakis-(Designer)-(3/11/13 11:25:13)
	Mods_2013_03
	//  `Added the Rail Inspections when counting inspection pages
	// Modified by: Costas Manousakis-(Designer)-(8/28/13 11:25:13)
	Mods_2013_08
	//  `Added Redraw Window at end to fix Windows redraw problem at end of printing
	// Modified by: Costas Manousakis-(Designer)-(10/22/13 09:38:03)
	Mods_2013_10
	//  `Added Tunnel inspection types in the recalc of the inspection pages
	// Modified by: Costas Manousakis-(Designer)-(11/8/13 15:03:20)
	Mods_2013_11
	//  `moved the SAVE RECORD after call to INSP_SavePhoto
	// Modified by: Costas Manousakis-(Designer)-(2023-05-03 15:29:57)
	Mods_2023_05_bug
	//  `for print preview - save the flag when choice is made and use it right before printing.
End if 

C_BOOLEAN:C305($vbIsPrintPreviewed; $vbIsNewRecord; $vbIsRecordModified; $vbPrintFlag; $PrintPreview_b)
C_TEXT:C284($vsInspType)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($vsMessage1; $vsMessage2)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283(vPageNo; vPrintSketchs; vPrintCharts; vPrintPhotos)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($viInspID; $viStdPhotoID; $viRecordNum)
ARRAY LONGINT:C221($aiStdPhotoID; 0)

//Initialize all local variables
$vbPrintFlag:=True:C214
$PrintPreview_b:=False:C215
$vbIsNewRecord:=False:C215
$vbIsRecordModified:=False:C215
$viInspID:=[Standard Photos:36]InspID:1
$viStdPhotoID:=[Standard Photos:36]StdPhotoID:7
$vsMessage1:="Please select either Print or Print Preview for current page images."
$vsMessage2:="Do you want to save the new record you have created?"

//Copy the current selection for later use
COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElements")
COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImages")
G_PrintOptions
//PAGE SETUP([Inspections];"Dive Pr Pg 1")

//Either new record has created or the current record has been modified
Case of 
		//Check to see whether there is new record that has been created      
	: (Is new record:C668([Standard Photos:36]))
		//Prompt the user to save the new record that have been created
		CONFIRM:C162($vsMessage2)
		If (OK=1)
			//Promt the user to select either Print or Print Preview option
			CONFIRM:C162($vsMessage1; "Print"; "Print Preview")
			If (OK=1)  //Print option
				PRINT SETTINGS:C106
				If (OK#1)
					$vbPrintFlag:=False:C215
				End if 
				
			Else   //Print Preview option        
				$PrintPreview_b:=True:C214
			End if 
			
			$vbIsNewRecord:=True:C214
			INSP_SavePhoto
			SAVE RECORD:C53([Standard Photos:36])
			InitChangeStack(2)
			
			//Update the current selection with the new record
			QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=$viInspID)
			
			//Sort images according to their types and sequence numbers
			G_SortInspImages
			
			//Saved the current updated selection with the new record
			COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElements")
			COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImages")
			
			//Put the current selection in to aiStdPhotoID array 
			SELECTION TO ARRAY:C260([Standard Photos:36]StdPhotoID:7; $aiStdPhotoID)
			
			//Abort print preview       
		Else 
			$vbPrintFlag:=False:C215
		End if 
		
		//Check to see whether the current photo has been modified
	: ((Modified record:C314([Standard Photos:36])) | (vbPictureChanged))
		//prompt the user to save the changes that have been made
		CONFIRM:C162("Do you want to save all the changes you have made?")
		If (OK=1)
			//Promt the user to select either Print or Print Preview option
			CONFIRM:C162($vsMessage1; "Print"; "Print Preview")
			If (OK=1)  //Print option
				PRINT SETTINGS:C106
				If (OK#1)
					$vbPrintFlag:=False:C215
				End if 
			Else   //Print Preview option    
				$PrintPreview_b:=True:C214
				//SET PRINT PREVIEW(True)
			End if 
			
			$vbIsRecordModified:=True:C214
			INSP_SavePhoto
			SAVE RECORD:C53([Standard Photos:36])
			vbPictureChanged:=False:C215
			InitChangeStack(2)
			
			//Update the current selection with the updated record
			QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=$viInspID)
			
			//Sort images according to their types and sequence numbers
			G_SortInspImages
			
			//Saved the current updated selection with the new record
			COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElements")
			COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImages")
			
			//Put the current selection in to aiStdPhotoID array 
			SELECTION TO ARRAY:C260([Standard Photos:36]StdPhotoID:7; $aiStdPhotoID)
			
			//Abort print preview      
		Else 
			$vbPrintFlag:=False:C215
		End if 
		
		//There are no changes for the images of the current page  
	Else 
		vButtonPrintPreview:=0
		vButtonPrint:=0
		vButtonCancel:=0
		vTextMsg:=$vsMessage1
		C_LONGINT:C283($tempWin)
		$tempWin:=Open window:C153(100; 300; 595; 500; 0; "Print or Print Preview for Current Page Images")
		DIALOG:C40([Dialogs:21]; "PrintPreviewImages")
		CLOSE WINDOW:C154
		Case of 
			: (vButtonPrintPreview=1)
				$PrintPreview_b:=True:C214
			: (vButtonPrint=1)
				PRINT SETTINGS:C106
				If (OK#1)
					$vbPrintFlag:=False:C215
				End if 
			: (vButtonCancel=1)
				$vbPrintFlag:=False:C215
		End case 
End case 

//Print preview the current images
If ($vbPrintFlag)
	//get the inspection type
	$vsInspType:=[Inspections:27]Insp Type:6
	
	sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
	ON ERR CALL:C155("G_PrintError")
	C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER
	viInspPreviewErr:=0
	
	Case of 
			//Culvert Inspection    
		: (($vsInsptype="CUL") | ($vsInsptype="RRC"))
			G_CountCulvInspPgs
			
			//Closed Bridge Inspection    
		: ($vsInsptype="CLD")
			G_CountClsdInspPgs
			
			//Routine or Routine Arch Inspection    
		: (($vsInsptype="RTN") | ($vsInsptype="RTA") | ($vsInsptype="RRR") | ($vsInsptype="RRA") | ($vsInsptype="TAL") | ($vsInsptype="TOV"))
			G_CountRTNInspPgs
			
			//Special Member or Fracture Critical or Damage Inspection    
		: (($vsInsptype="CMI") | ($vsInsptype="FCR") | ($vsInsptype="DAM") | ($vsInsptype="OTH") | ($vsInsptype="FRZ") | ($vsInsptype="RRS") | ($vsInsptype="RRF") | ($vsInsptype="RRO") | ($vsInsptype="RRD") | ($vsInsptype="TSP") | ($vsInsptype="TOT") | ($vsInsptype="TDA"))
			G_CountSpInspPgs
			
			//Underwater or Underwater Special Member or 
			//Underwater Close Clearance Inspection    
		: (($vsInsptype="DVE") | ($vsInsptype="DVS") | ($vsInsptype="DVL"))
			G_CountDiveInspPgs
	End case 
	
	USE NAMED SELECTION:C332("TempElements")
	USE NAMED SELECTION:C332("TempImages")
	
	//Make sure that the current pointer is pointing to the new record
	If ($vbIsNewRecord | $vbIsRecordModified)
		$viRecordNum:=Find in array:C230($aiStdPhotoID; $viStdPhotoID)
		If ($viRecordNum>0)
			GOTO SELECTED RECORD:C245([Standard Photos:36]; $viRecordNum)
		End if 
	End if 
	
	//set print preview according to choices above
	SET PRINT PREVIEW:C364($PrintPreview_b)
	PreviewInspectionImages
End if 

ON ERR CALL:C155("")
SET PRINT PREVIEW:C364(False:C215)
CLEAR NAMED SELECTION:C333("TempElements")
CLEAR NAMED SELECTION:C333("TempImages")
REDRAW WINDOW:C456