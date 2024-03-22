//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/26/12, 20:43:06
// ----------------------------------------------------
//Method: SCPOA_Print_A
//Description
//
// Parameters
// $1 : $ShowPrintSett_b : Show any print settings ; false when coming from a listprint
// $2 : SCPOA_PrintPreview_b (optional) 
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02  //copied from SCPOA_Print
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 16:32:36)
	Mods_2013_05
	//  `added readraw window
	// Modified by: Costas Manousakis-(Designer)-(8/21/14 10:11:54)
	Mods_2014_08
	//  `General POA modifications Aug 2014
End if 
//

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

C_LONGINT:C283(SCPOA_PrintSumm_L; SCPOA_PrintPOA_L; SCPOA_PrintLocus_L; SCPOA_PrintDetour_L; SCPOA_PrintFLDNotes_L; SCPOA_PrintFVC_L)
C_LONGINT:C283(SCPOA_PrintSummbtn_L; SCPOA_PrintPOAbtn_L; SCPOA_PrintLocusbtn_L; SCPOA_PrintDetourbtn_L; SCPOA_PrintFLDNotesbtn_L; SCPOA_PrintFVCBtn_L)

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
	SCPOA_PrintFVC_L:=1
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
		If ((SCPOA_PrintSumm_L+SCPOA_PrintPOA_L+SCPOA_PrintLocus_L+SCPOA_PrintDetour_L+SCPOA_PrintFLDNotes_L+SCPOA_PrintFVC_L)>0)
			$GotSections_B:=True:C214
		End if 
	End if 
Else 
	$GotSections_B:=True:C214
End if 

If ($GotSections_B)
	
	If ($ShowPrintSett_b)
		If ((SCPOA_PrintSumm_L+SCPOA_PrintPOA_L+SCPOA_PrintLocus_L+SCPOA_PrintDetour_L+SCPOA_PrintFVC_L)>0)
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
		C_TEXT:C284(SCPOA_PrintReportDate_txt)
		SCPOA_PrintReportDate_txt:=String:C10(Current date:C33(*))
		
		If (SCPOA_PrintSumm_L=1)
			$PgHt_L:=Print form:C5([ScourPOA:132]; "Summary-A")
			$doPagebreak:=True:C214
		End if 
		
		If (SCPOA_PrintPOA_L=1)
			If ($doPagebreak)
				PAGE BREAK:C6(>)
			End if 
			If (OK=1)
				$PgHt_L:=Print form:C5([ScourPOA:132]; "Print1-A")
				If (Ok=1)
					$PgHt_L:=Print form:C5([ScourPOA:132]; "Print2-A")
					If (OK=1)
						$PgHt_L:=Print form:C5([ScourPOA:132]; "Print3-A")
						If (OK=1)
							$PgHt_L:=Print form:C5([ScourPOA:132]; "Print4-A")
							If (OK=1)
								SCPOA_Variables("DETOURBRIDGES")
								$PgHt_L:=Print form:C5([ScourPOA:132]; "Print5-A")
								If (OK=1)
									$PgHt_L:=Print form:C5([ScourPOA:132]; "Print6-A")
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
		
		If ((SCPOA_PrintFVC_L=1) & (OK=1))
			If ($doPagebreak)
				PAGE BREAK:C6(>)
			End if 
			$PgHt_L:=Print form:C5([ScourPOA:132]; "FieldVerificationCardpg1")
			If (OK=1)
				$PgHt_L:=Print form:C5([ScourPOA:132]; "FieldVerificationCardpg2")
			End if 
			$doPagebreak:=True:C214
			
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
//End SCPOA_Print_A