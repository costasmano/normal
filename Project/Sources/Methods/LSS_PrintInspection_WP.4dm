//%attributes = {"invisible":true}
//Method: LSS_PrintInspection_WP
//Description
// Print inpection report with WritePRO
// Parameters
// $1 : a listbox Row
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/25/21, 18:56:23
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_LONGINT:C283(LSS_PrintInspection_WP; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2023-11-08 16:57:12)
	Mods_2023_11
	//  `added spooler name document option in print options to insert structure-type and date
	//  `also placed in paste buffer for use with Microsoft Print to PDF
	// Modified by: manousakisc-(Designer)-(3/14/2024 17:29:48)
	Mods_2024_03_bug
	// //set preview to false only if we will be showing the print dialog
	// //use the case statement to get the main prefix of pages 1 and 2.
	// //check if user canceled after printing page 1 and abort the rest if they did.  
	//  // //happens when printing to Ms print to pdf and user cancels on the save file dialog
	
End if 

//
vPageNo:=2
C_TEXT:C284($oldWinTitle; $newWinTitle; $prevSpoolDocName)  // **Replaced old C_STRING length 255
C_LONGINT:C283($LBCol_L; $LBRow_L; viInspPreviewErr; $DMeterCount_L; $UTCount_L)
C_TEXT:C284($Header_txt)
C_BOOLEAN:C305($CreatePDF_B)
//Guarantee this.
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$LBRow_L:=$1
Else 
	LISTBOX GET CELL POSITION:C971(*; "Inspection_LB"; $LBCol_L; $LBRow_L)
End if 

If ($LBRow_L>0)
	GOTO SELECTED RECORD:C245([LSS_Inspection:164]; $LBRow_L)
	
	SET PRINT OPTION:C733(Orientation option:K47:2; 1)
	SET PRINT OPTION:C733(Paper option:K47:1; "Letter")
	SET PRINT OPTION:C733(Scale option:K47:3; 100)
	//start of Mods_2024_03_bug
	If (<>ShowPrint)
		//set preview to false only if we will be showing the print dialog
		SET PRINT PREVIEW:C364(False:C215)
	End if 
	//end of Mods_2024_03_bug
	
	//start of Mods_2023_11
	QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1=[LSS_Inspection:164]LSS_InspectionTypeId_s:3)
	SET PRINT OPTION:C733(Spooler document name option:K47:10; [LSS_Inventory:165]LSS_StructureNumber_s:6+" "+\
		[LSS_refInspectionType:167]LSS_Description_txt:2+" "\
		+Substring:C12(String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4; ISO date:K1:8); 1; 10))
	SET TEXT TO PASTEBOARD:C523([LSS_Inventory:165]LSS_StructureNumber_s:6+" "+\
		[LSS_refInspectionType:167]LSS_Description_txt:2+" "\
		+Substring:C12(String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4; ISO date:K1:8); 1; 10))
	//end of Mods_2023_11
	
	If (<>ShowPrint)  //| (Not(Is compiled mode))
		PRINT SETTINGS:C106
	End if 
	
End if 

//get the preview choise here and set it for later
If (OK=1)  //user can cancel from the print settings  
	
	BRING TO FRONT:C326(Current process:C322)
	G_PrintOptions
	
	VSINSPDEPARTMENT:="MASSACHUSETTS DEPARTMENT OF TRANSPORTATION"
	LOAD RECORD:C52([LSS_Inspection:164])
	LSS_FillPage1_FM([LSS_Inspection:164]LSS_InspectionTypeId_s:3)
	
	vTotalPages:=2
	//Get number of photos
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_InspectionPhotoSet")
	QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
	SET QUERY DESTINATION:C396(Into set:K19:2; "DMeterPhotoSet")
	USE SET:C118("LSS_InspectionPhotoSet")
	QUERY SELECTION:C341([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch D Meter")
	SET QUERY DESTINATION:C396(Into set:K19:2; "UMeterPhotoSet")
	USE SET:C118("LSS_InspectionPhotoSet")
	QUERY SELECTION:C341([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch UT")
	DIFFERENCE:C122("LSS_InspectionPhotoSet"; "DMeterPhotoSet"; "LSS_InspectionPhotoSet")
	DIFFERENCE:C122("LSS_InspectionPhotoSet"; "UMeterPhotoSet"; "LSS_InspectionPhotoSet")
	SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_SketchSet")
	USE SET:C118("LSS_InspectionPhotoSet")
	QUERY SELECTION:C341([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch@")
	SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_ChartSet")
	USE SET:C118("LSS_InspectionPhotoSet")
	QUERY SELECTION:C341([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoType_s:3="Chart@")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	DIFFERENCE:C122("LSS_InspectionPhotoSet"; "LSS_SketchSet"; "LSS_InspectionPhotoSet")
	DIFFERENCE:C122("LSS_InspectionPhotoSet"; "LSS_ChartSet"; "LSS_InspectionPhotoSet")
	
	
	//vTotalPages:=vTotalPages+Records in set("DMeterPhotoSet")
	
	//vTotalPages:=vTotalPages+Records in set("UMeterPhotoSet")
	
	vTotalPages:=vTotalPages+Records in set:C195("LSS_SketchSet")
	
	vTotalPages:=vTotalPages+Records in set:C195("LSS_ChartSet")
	
	vTotalPages:=vTotalPages+Round:C94((Records in set:C195("LSS_InspectionPhotoSet")/2); 0)
	C_BOOLEAN:C305($SkipPhotoLog_B)
	$SkipPhotoLog_B:=False:C215
	If (vTotalPages=2)
		$SkipPhotoLog_B:=True:C214
	End if 
	
	SET QUERY DESTINATION:C396(Into variable:K19:4; $DMeterCount_L)
	QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)  //missing
	
	If ($DMeterCount_L>0)  //Add demeter count assume all fits on one page for now
		vTotalPages:=vTotalPages+1
	End if 
	//SET QUERY DESTINATION(Into variable ;$UTCount_L)
	//Assume 1 page for each [LSS_UT] record and that all results for that UT fit on one page
	READ ONLY:C145([LSS_UT:175])
	QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
	$UTCount_L:=0
	If (Records in selection:C76([LSS_UT:175])>0)
		C_LONGINT:C283($UTRodCount_L; $numExtraPgs_L; $numExtraRods_L)
		FIRST RECORD:C50([LSS_UT:175])
		While (Not:C34(End selection:C36([LSS_UT:175])))
			SET QUERY DESTINATION:C396(Into variable:K19:4; $UTRodCount_L)
			QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=[LSS_UT:175]LSS_UTId_s:1)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($UTRodCount_L>11)
				$numExtraRods_L:=$UTRodCount_L-11
				$numExtraPgs_L:=($numExtraRods_L\18)
				If (($numExtraPgs_L*18)<$numExtraRods_L)
					$numExtraPgs_L:=$numExtraPgs_L+1
				End if 
				$UTCount_L:=$UTCount_L+1+$numExtraPgs_L
			Else 
				$UTCount_L:=$UTCount_L+1
			End if 
			
			NEXT RECORD:C51([LSS_UT:175])
		End while 
		
	End if 
	
	vTotalPages:=vTotalPages+$UTCount_L
	
	vbTopOfPage:=True:C214  //say we start from top of page
	
	C_LONGINT:C283($NumPages; $NumNewPages; $vLLine2; $vlLineSt; $Loop_L; $Position_L; $vlStartSel; $vlEndSel; $vrOrigPos; $viAlignmen; $vlStartInsert; $vlEndInsert; $i; $PhotoPages_L; $CommentPages_L)
	C_REAL:C285($viNumtabs)
	C_LONGINT:C283($Uniform; $viAlignment; $viFindRes)  // **replaced _ o _C_INTEGER()
	C_REAL:C285($Indent_r; $vrParIndent)
	C_TEXT:C284($vtWordst)
	
	C_TEXT:C284($vsFillChar)  // **Replaced old C_STRING length 80
	ARRAY LONGINT:C221($DeletePositions_aL; 0)
	//Do we only have headers if so delete all
	C_BOOLEAN:C305($OnlyHeaders_B)
	$OnlyHeaders_B:=True:C214
	$Loop_L:=1
	Repeat 
		If (Not:C34(LSS_ElementHeader_ab{$Loop_L}))
			$OnlyHeaders_B:=False:C215
		End if 
		$Loop_L:=$Loop_L+1
		
	Until (Not:C34($OnlyHeaders_B)) | ($Loop_L>Size of array:C274(LSS_ElementHeader_ab))
	
	
	If ($OnlyHeaders_B)
		$Loop_L:=Size of array:C274(LSS_ElementLabel_atxt)
		DELETE FROM ARRAY:C228(LSS_ElementLabel_atxt; 1; $Loop_L)
		DELETE FROM ARRAY:C228(LSS_ElementRemarks_atxt; 1; $Loop_L)
		DELETE FROM ARRAY:C228(LSS_ElementHeader_ab; 1; $Loop_L)
	End if 
	
	For ($Loop_L; Size of array:C274(LSS_ElementHeader_ab); 1; -1)
		If (LSS_ElementHeader_ab{$Loop_L})
			$Position_L:=Find in array:C230(LSS_ElementHeaderNo_atxt; LSS_ElementLabel_atxt{$Loop_L}; $Loop_L+1)
			If ($Position_L<1)
				APPEND TO ARRAY:C911($DeletePositions_aL; $Loop_L)
			End if 
		End if 
	End for 
	
	//For ($Loop_L;1;Size of array($DeletePositions_aL);1;-1)
	For ($Loop_L; 1; Size of array:C274($DeletePositions_aL))
		DELETE FROM ARRAY:C228(LSS_ElementLabel_atxt; $DeletePositions_aL{$Loop_L}; 1)
		DELETE FROM ARRAY:C228(LSS_ElementRemarks_atxt; $DeletePositions_aL{$Loop_L}; 1)
		DELETE FROM ARRAY:C228(LSS_ElementHeader_ab; $DeletePositions_aL{$Loop_L}; 1)
	End for 
	C_OBJECT:C1216($WPArea_; $ImageLogArea_)
	$WPArea_:=INSP_InitializeWPArea(New object:C1471("templateType"; "Normal"))
	
	$ImageLogArea_:=INSP_InitializeWPArea(New object:C1471("templateType"; "Normal"))
	
	If (([LSS_Inspection:164]LSS_GeneralComments_txt:32="") & ([LSS_Inspection:164]LSS_AdditionalComments_txt:38="") & (Size of array:C274(LSS_ElementRemarks_atxt)=0))
	Else 
		vInspFontName:="Arial"
		vInspFontSize:=11
		
		//WR UPDATE MODE ($mainarea;0)  `turn off updating
		vbTopOfPage:=True:C214
		If ([LSS_Inspection:164]LSS_GeneralComments_txt:32#"")
			INSP_AddTextToArea_WP($WPArea_; "GENERAL REMARKS"; [LSS_Inspection:164]LSS_GeneralComments_txt:32)
		End if 
		
		For ($Loop_L; 1; Size of array:C274(LSS_ElementHeader_ab))
			If (LSS_ElementHeader_ab{$loop_L})
				
				$Header_txt:=LSS_GetHeader(LSS_ElementLabel_atxt{$loop_L})
				LSS_NonDamageAddHeader_WP($WPArea_; $Header_txt; LSS_ElementHeader_ab{$Loop_L}; $Loop_L)
			Else 
				
				LSS_NonDamageAddHeader_WP($WPArea_; LSS_ElementLabel_atxt{$Loop_L}; LSS_ElementHeader_ab{$Loop_L}; $Loop_L)
				$Header_txt:=""
			End if 
		End for 
		If ([LSS_Inspection:164]LSS_AdditionalComments_txt:38#"")
			INSP_AddTextToArea_WP($WPArea_; Uppercase:C13("\rAdditional Comments"); [LSS_Inspection:164]LSS_AdditionalComments_txt:38)
		End if 
		
		vTotalPages:=vTotalPages+WP Get page count:C1412($WPArea_)
		
	End if 
	
	If (Not:C34($SkipPhotoLog_B))
		
		ARRAY TEXT:C222($PhotoDescription_atxt; 0)
		ARRAY TEXT:C222($PhotoType_atxt; 0)
		ARRAY LONGINT:C221($PhotoSeq_aL; 0)
		C_TEXT:C284($ID_txt; $PhotoType_txt)
		
		LSS_ReturnPhotoComments(->$PhotoSeq_aL; ->$PhotoDescription_atxt; ->$PhotoType_atxt; [LSS_Inspection:164]LSS_InspectionId_s:1)
		ARRAY LONGINT:C221($SortPosition_aL; 0)
		ARRAY LONGINT:C221($SortPosition_aL; Size of array:C274($PhotoDescription_atxt))
		ARRAY TEXT:C222($PhototTitle_atxt; 0)
		ARRAY TEXT:C222($PhototTitle_atxt; Size of array:C274($PhotoDescription_atxt))
		
		For ($Loop_L; Size of array:C274($PhotoType_atxt); 1; -1)
			Case of 
				: ($PhotoType_atxt{$Loop_L}="Sketch")
					$SortPosition_aL{$Loop_L}:=1
					
				: ($PhotoType_atxt{$Loop_L}="Chart")
					$SortPosition_aL{$Loop_L}:=2
					
				: ($PhotoType_atxt{$Loop_L}="Sketch D Meter")
					DELETE FROM ARRAY:C228($PhotoSeq_aL; $Loop_L; 1)
					DELETE FROM ARRAY:C228($PhotoDescription_atxt; $Loop_L; 1)
					DELETE FROM ARRAY:C228($PhotoType_atxt; $Loop_L; 1)
					DELETE FROM ARRAY:C228($SortPosition_aL; $Loop_L; 1)
					
				: ($PhotoType_atxt{$Loop_L}="Sketch UT")
					DELETE FROM ARRAY:C228($PhotoSeq_aL; $Loop_L; 1)
					DELETE FROM ARRAY:C228($PhotoDescription_atxt; $Loop_L; 1)
					DELETE FROM ARRAY:C228($PhotoType_atxt; $Loop_L; 1)
					DELETE FROM ARRAY:C228($SortPosition_aL; $Loop_L; 1)
				Else 
					$SortPosition_aL{$Loop_L}:=3
					
			End case 
			
		End for 
		MULTI SORT ARRAY:C718($SortPosition_aL; >; $PhotoSeq_aL; >; $PhotoDescription_atxt; $PhotoType_atxt)
		C_TEXT:C284($PhotoList_txt; $PhotoTitle_txt)
		$PhotoList_txt:=""
		For ($Loop_L; 1; Size of array:C274($PhotoDescription_atxt))
			
			If ($Loop_L<Size of array:C274($PhotoDescription_atxt))
				$PhotoList_txt:=$PhotoList_txt+$PhotoType_atxt{$Loop_L}+" "+String:C10($PhotoSeq_aL{$Loop_L})+" : "+<>sTAB+$PhotoDescription_atxt{$Loop_L}+<>sCR
			Else 
				$PhotoList_txt:=$PhotoList_txt+$PhotoType_atxt{$Loop_L}+" "+String:C10($PhotoSeq_aL{$Loop_L})+" : "+<>sTAB+$PhotoDescription_atxt{$Loop_L}
			End if 
		End for 
		
		INSP_AddTextToArea_WP($ImageLogArea_; ""; $PhotoList_txt; "-2.5cm")
		
		$PhotoPages_L:=WP Get page count:C1412($ImageLogArea_)
		
		vTotalPages:=vTotalPages+$PhotoPages_L
	End if 
	
	//start of Mods_2024_03_bug
	
	C_BOOLEAN:C305($userabort_b)
	C_TEXT:C284($pg_txt)
	
	$userabort_b:=False:C215
	Case of 
		: ([LSS_Inventory:165]LSS_Category_s:2="Sign")
			//Print form([LSS_Inspection];"SignStructurePg1")
			//PAGE BREAK(>)
			//Print form([LSS_Inspection];"SignStructurePg2")
			$pg_txt:="SignStructurePg"
			
			//PAGE BREAK(>)
			
		: ([LSS_Inventory:165]LSS_Category_s:2="Signal")
			//Print form([LSS_Inspection];"TrafficSignalStructurePg1")
			//PAGE BREAK(>)
			//Print form([LSS_Inspection];"TrafficSignalStructurePg2")
			$pg_txt:="TrafficSignalStructurePg"
			//PAGE BREAK(>)
			
		: ([LSS_Inventory:165]LSS_Category_s:2="Light")
			//Print form([LSS_Inspection];"LightStructurePg1")
			//PAGE BREAK(>)
			//Print form([LSS_Inspection];"LightStructurePg2")
			$pg_txt:="LightStructurePg"
			//PAGE BREAK(>)
			
		: ([LSS_Inventory:165]LSS_Category_s:2="ITS")
			//Print form([LSS_Inspection];"ITSStructurePg1")
			//PAGE BREAK(>)
			//Print form([LSS_Inspection];"ITSStructurePg2")
			$pg_txt:="ITSStructurePg"
			//PAGE BREAK(>)
			
	End case 
	
	Print form:C5([LSS_Inspection:164]; $pg_txt+"1")
	
	If (ok=1)
		PAGE BREAK:C6(>)
		Print form:C5([LSS_Inspection:164]; $pg_txt+"2")
	Else 
		$userabort_b:=True:C214
	End if 
	
	If (Not:C34($userabort_b))  //error or user abort on first page -skip the rest   // Mods_2024_03_bug
		//end of Mods_2024_03_bug
		
		//Print comments pages
		C_OBJECT:C1216($wpbody)
		$wpbody:=WP Text range:C1341($WPArea_; wk start text:K81:165; wk end text:K81:164)
		If ($wpbody.start=$wpbody.end)  // nothing in there
		Else 
			
			C_OBJECT:C1216($pipParamObj)
			$pipParamObj:=wrpPrintInPartsNewParamObj
			$pipParamObj.isOpenPrintingJob:=False:C215  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven
			
			// typical pages
			$pipParamObj.firstPageFormName:="LSS_Comments_WP"
			$pipParamObj.firstPageFormTable:=Table:C252(->[LSS_Inspection:164])
			$pipParamObj.PagesFormName:="LSS_Comments_WP"
			$pipParamObj.PagesFormTable:=Table:C252(->[LSS_Inspection:164])
			wrpCustomPrintParts($WPArea_; $pipParamObj)
			
		End if 
		//Add print [LSS_DMeter]
		If ($DMeterCount_L>0)
			//Add print [LSS_DMeter]
			LSS_PrintDMeter(($UTCount_L=0) & $SkipPhotoLog_B)
		End if 
		//Add print [LSS_UT]
		
		If ($UTCount_L>0)
			//Add print [LSS_UT]
			LSS_PrintUT(Not:C34($SkipPhotoLog_B))
		End if 
		If (Not:C34($SkipPhotoLog_B))
			
			C_OBJECT:C1216($pipParamObj)
			$pipParamObj:=wrpPrintInPartsNewParamObj
			$pipParamObj.isOpenPrintingJob:=False:C215  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven
			
			// typical pages
			$pipParamObj.firstPageFormName:="LSS_PhotoLog_WP"
			$pipParamObj.firstPageFormTable:=Table:C252(->[LSS_Inspection:164])
			$pipParamObj.PagesFormName:="LSS_PhotoLog_WP"
			$pipParamObj.PagesFormTable:=Table:C252(->[LSS_Inspection:164])
			wrpCustomPrintParts($ImageLogArea_; $pipParamObj)
			
		End if 
		
		C_LONGINT:C283($PhotoCount_L; $ChartCount_L; $SketchCount_L)
		C_BOOLEAN:C305($HaveMorePages_B)
		
		$PhotoCount_L:=Records in set:C195("LSS_InspectionPhotoSet")
		$ChartCount_L:=Records in set:C195("LSS_ChartSet")
		$SketchCount_L:=Records in set:C195("LSS_SketchSet")
		$HaveMorePages_B:=($PhotoCount_L>0) | ($ChartCount_L>0) | ($SketchCount_L>0)
		If ($HaveMorePages_B)
			LSS_PrintPhoto(True:C214)
		Else 
			PAGE BREAK:C6
		End if 
		
	End if   // end of if not userabort    // Mods_2024_03_bug
	
	CLEAR SET:C117("LSS_InspectionPhotoSet")
	CLEAR SET:C117("DMeterPhotoSet")
	CLEAR SET:C117("UMeterPhotoSet")
	CLEAR SET:C117("LSS_SketchSet")
	CLEAR SET:C117("LSS_ChartSet")
	
	UNLOAD RECORD:C212([LSS_Inspection:164])
	
	REDRAW WINDOW:C456
End if 
//start of Mods_2023_11
SET PRINT OPTION:C733(Spooler document name option:K47:10; "Untitled")
//end of Mods_2023_11

//End LSS_PrintInspection_WP