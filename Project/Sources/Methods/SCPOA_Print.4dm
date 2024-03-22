//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/09, 11:08:41
	// ----------------------------------------------------
	// Method: SCPOA_Print
	// Description
	// 
	// 
	// Parameters
	// $1 : $ShowPrintSett_b : Show any print settings ; false when coming from a listprint
	// $2 : SCPOA_PrintPreview_b (optional) 
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(12/1/09 21:47:14)
	Mods_2009_11
	// Modified by: costasmanousakis-(Designer)-(12/10/09 09:12:25)
	Mods_2009_12
	//Changes/Additions for new version of POA
	// Modified by: costasmanousakis-(Designer)-(12/15/09 13:26:15)
	Mods_2009_12
	//Changed order of printing pages - first page3 then page2
	// Modified by: costasmanousakis-(Designer)-(12/16/09 10:22:54)
	Mods_2009_12
	//set the preview boolean to a proccess var.
	// Modified by: costasmanousakis-(Designer)-(5/12/10 13:28:55)
	Mods_2010_05
	//  `Changed so that all pages go under the same print job;
	//  `Added a spooier document option
	// Modified by: costasmanousakis-(Designer)-(3/30/11 14:40:12)
	Mods_2011_05
	//  ` New Ver of POA
	// Modified by: costasmanousakis-(Designer)-(6/8/11 16:32:53)
	Mods_2011_06
	//  `To select between the old/new version of POA use call to  SCPOA_Variables ("OLDNEWVERSION")
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v1
End if 
C_BOOLEAN:C305($1; $ShowPrintSett_b; SCPOA_PrintPreview_b)
$ShowPrintSett_b:=$1
SCPOA_PrintPreview_b:=False:C215
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	SCPOA_PrintPreview_b:=$2
End if 

C_LONGINT:C283($LastScale_l; $LastOrient_l; $FldNoteCount_L)
GET PRINT OPTION:C734(Orientation option:K47:2; $LastOrient_l)
GET PRINT OPTION:C734(Scale option:K47:3; $LastScale_l)
C_BOOLEAN:C305($GotSections_B; $goPrint_B)

C_LONGINT:C283(SCPOA_PrintSumm_L; SCPOA_PrintPOA_L; SCPOA_PrintLocus_L; SCPOA_PrintDetour_L; SCPOA_PrintFLDNotes_L)
$GotSections_B:=False:C215
If ($ShowPrintSett_b)
	C_LONGINT:C283($PgHt_L; $LocuPictCount_L; $detourPictCount_L)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $LocuPictCount_L)
	QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)
	QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="LOCUS")
	SET QUERY DESTINATION:C396(Into variable:K19:4; $detourPictCount_L)
	QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)
	QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="DETOUR")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $FldNoteCount_L)
	QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)
	QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="FIELD@")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SCPOA_PrintSumm_L:=1
	SCPOA_PrintPOA_L:=1
	If ($LocuPictCount_L>0)
		SCPOA_PrintLocus_L:=1
	Else 
		SCPOA_PrintLocus_L:=0
	End if 
	If ($detourPictCount_L>0)
		SCPOA_PrintDetour_L:=1
	Else 
		SCPOA_PrintDetour_L:=0
	End if 
	If ($FldNoteCount_L>0)
		SCPOA_PrintFLDNotes_L:=1
	Else 
		SCPOA_PrintFLDNotes_L:=0
	End if 
	C_LONGINT:C283($w_L; $H_L)
	FORM GET PROPERTIES:C674([ScourPOA:132]; "PrintSelection"; $w_L; $H_L)
	CENTER_WINDOW($w_L; $H_L; Plain window:K34:13)
	DIALOG:C40([ScourPOA:132]; "PrintSelection")
	CLOSE WINDOW:C154
	If (OK=1)
		If ((SCPOA_PrintSumm_L+SCPOA_PrintPOA_L+SCPOA_PrintLocus_L+SCPOA_PrintDetour_L+SCPOA_PrintFLDNotes_L)>0)
			$GotSections_B:=True:C214
		End if 
	End if 
Else 
	$GotSections_B:=True:C214
End if 

If ($GotSections_B)
	
	If ($ShowPrintSett_b)
		If ((SCPOA_PrintSumm_L+SCPOA_PrintPOA_L+SCPOA_PrintLocus_L+SCPOA_PrintDetour_L)>0)
			SCPOA_Variables("OLDNEWVERSION")
			PRINT SETTINGS:C106
			$goPrint_B:=(OK=1)
		Else 
			$goPrint_B:=True:C214
		End if 
	Else 
		$goPrint_B:=True:C214
	End if 
	
	If ($goPrint_B)
		
		SET PRINT OPTION:C733(Spooler document name option:K47:10; ("Scour POA BIN "+[ScourPOA:132]BIN:2))
		SET PRINT PREVIEW:C364(SCPOA_PrintPreview_b)
		C_BOOLEAN:C305($lastBreak_b)
		C_TEXT:C284($PriintFormVer_txt)
		$PriintFormVer_txt:=""
		
		C_TEXT:C284($CurrWinTitle)
		$CurrWinTitle:=Get window title:C450
		SET WINDOW TITLE:C213("Scour POA BIN "+[ScourPOA:132]BIN:2)
		//SET PRINT OPTION(Spooler document name option ;"Scour POA BIN "+[ScourPOA]BIN)
		C_BOOLEAN:C305($doPagebreak)
		$doPagebreak:=False:C215
		ON ERR CALL:C155("G_PrintError")
		C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
		viInspPreviewErr:=0  //initialize Error
		//TRACE
		If (SCPOA_PrintSumm_L=1)
			$PgHt_L:=Print form:C5([ScourPOA:132]; "SummaryPrint")
			$doPagebreak:=True:C214
		End if 
		
		If (SCPOA_PrintPOA_L=1)
			If ($doPagebreak)
				PAGE BREAK:C6(>)
			End if 
			C_BOOLEAN:C305(SCPOA_OldVersion_b)
			If (OK=1)
				If (SCPOA_OldVersion_b)
					$PgHt_L:=Print form:C5([ScourPOA:132]; "Print1"+$PriintFormVer_txt)
					PAGE BREAK:C6(>)
					If (Ok=1)
						$PgHt_L:=Print form:C5([ScourPOA:132]; "Print3"+$PriintFormVer_txt)
						PAGE BREAK:C6(>)
						If (Ok=1)
							$PgHt_L:=Print form:C5([ScourPOA:132]; "Print2"+$PriintFormVer_txt)
							PAGE BREAK:C6(>)
							If (Ok=1)
								SCPOA_Variables("DETOURBRIDGES")
								$PgHt_L:=Print form:C5([ScourPOA:132]; "Print4"+$PriintFormVer_txt)
							End if 
						End if 
					End if 
				Else 
					$PgHt_L:=Print form:C5([ScourPOA:132]; "Print1"+$PriintFormVer_txt)
					If (Ok=1)
						$PgHt_L:=Print form:C5([ScourPOA:132]; "Print2A"+$PriintFormVer_txt)
						If (OK=1)
							$PgHt_L:=Print form:C5([ScourPOA:132]; "Print3A"+$PriintFormVer_txt)
							If (OK=1)
								SCPOA_Variables("DETOURBRIDGES")
								$PgHt_L:=Print form:C5([ScourPOA:132]; "Print4A"+$PriintFormVer_txt)
								If (OK=1)
									//PAGE BREAK(>)
									$PgHt_L:=Print form:C5([ScourPOA:132]; "Print5A"+$PriintFormVer_txt)
								End if 
							End if 
						End if 
					End if 
				End if 
				
			End if 
			$doPagebreak:=True:C214
			
		End if 
		
		COPY NAMED SELECTION:C331([ScourPOA_Images:134]; "SCPOATEMPIMAGESELE")
		
		If ((SCPOA_PrintLocus_L=1) & (OK=1))
			QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)
			QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="LOCUS")
			If (Records in selection:C76([ScourPOA_Images:134])=1)
				LOAD RECORD:C52([ScourPOA_Images:134])
				
				If (BLOB size:C605([ScourPOA_Images:134]Image_x:3)>0)
					If ($doPagebreak)
						PAGE BREAK:C6(>)
					End if 
					
					If (OK=1)
						C_PICTURE:C286(SCPOA_Pict1)
						SCPOA_Pict1:=SCPOA_Pict1*0
						BLOB TO PICTURE:C682([ScourPOA_Images:134]Image_x:3; SCPOA_Pict1)
						C_TEXT:C284(SCPOA_Pic1Lbl_txt)
						SCPOA_Pic1Lbl_txt:="LOCUS MAP"
						$PgHt_L:=Print form:C5([ScourPOA:132]; "PrintMap")
						SCPOA_Pict1:=SCPOA_Pict1*0
						$doPagebreak:=True:C214
					End if 
					
				End if 
				
			End if 
			
		End if 
		If ((SCPOA_PrintDetour_L=1) & (OK=1))
			QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)
			QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="DETOUR")
			If (Records in selection:C76([ScourPOA_Images:134])=1)
				LOAD RECORD:C52([ScourPOA_Images:134])
				If (BLOB size:C605([ScourPOA_Images:134]Image_x:3)>0)
					If ($doPagebreak)
						PAGE BREAK:C6(>)
					End if 
					If (OK=1)
						C_PICTURE:C286(SCPOA_Pict1)
						SCPOA_Pict1:=SCPOA_Pict1*0
						BLOB TO PICTURE:C682([ScourPOA_Images:134]Image_x:3; SCPOA_Pict1)
						C_TEXT:C284(SCPOA_Pic1Lbl_txt)
						SCPOA_Pic1Lbl_txt:="DETOUR ROUTE(S)"
						$PgHt_L:=Print form:C5([ScourPOA:132]; "PrintMap")
						//PAGE BREAK  `Last page anyway 
						SCPOA_Pict1:=SCPOA_Pict1*0
						$doPagebreak:=True:C214
						
					End if 
					
				End if 
			Else 
				//PAGE BREAK
			End if 
			
		End if 
		If ($doPagebreak)
			PAGE BREAK:C6  //done
		End if 
		ON ERR CALL:C155("")
		
		If ((SCPOA_PrintFLDNotes_L=1) & (OK=1))
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274(SCPOA_FLDNOTENAMES_atxt))
				SCPOA_FLDNOTEDESC_TXT:=SCPOA_FLDNOTENAMES_atxt{$loop_L}
				SCPOA_FieldNoteCtrl("LOADFROMDB")
				SCPOA_FieldNoteCtrl("PRINT")
				
			End for 
			
		End if 
		USE NAMED SELECTION:C332("SCPOATEMPIMAGESELE")
		CLEAR NAMED SELECTION:C333("SCPOATEMPIMAGESELE")
		
		//SET PRINT OPTION(Spooler document name option ;"")
		SET WINDOW TITLE:C213($CurrWinTitle)
		
		//**************
	End if 
	If (Not:C34($ShowPrintSett_b))
		G_PrintOptions($LastOrient_l; " "; $LastScale_l)
	End if 
	If (SCPOA_PrintPreview_b)
		SET PRINT PREVIEW:C364(False:C215)
		SCPOA_PrintPreview_b:=False:C215
	End if 
End if 
REDRAW WINDOW:C456