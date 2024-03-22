//%attributes = {"invisible":true}
If (False:C215)
	//PRINT_QAFORM 
	Mods_2010_12
	//Created by: Kenny Yang-(Designer) `10/04/10, 11:15:46   `// Modified by: Costas Manousakis-(Designer)-(6/20/12 08:40:10)\
		
	Mods_2012_06
	//  `Method only available for RTN  inspections - not CUL or RTA
	//  `Fix call to GetAreaBIEinfo
	// Modified by: Costas Manousakis-(Designer)-(8/21/12 09:47:14)
	Mods_2012_08
	//  `Save the current inspection record and load it before printing so that the team leader and member information on page 1 is correct
	// Modified by: Costas Manousakis-(Designer)-(6/29/21 15:25:24)
	Mods_2021_v17
	//  `modified to work in v17 preview must be set after the print settings
End if 

C_TEXT:C284($oldWinTitle; $newWinTitle; $prevSpoolDocName)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($FormWindow; $numrecs; $recL; $i)
C_BOOLEAN:C305($OKtoPrint; $foundit_b)
If ([Combined Inspections:90]InspType:5="RTN")
	$OKtoPrint:=True:C214
Else 
	ALERT:C41("Invalid Inspection Type selected! Only available for Routine inspections.")
	$OKtoPrint:=False:C215
End if 
C_TEXT:C284($currType)  // Command Replaced was o_C_STRING length was 3
If ($OKtoPrint)
	$currType:=[Combined Inspections:90]InspType:5
	$numrecs:=Records in selection:C76([Combined Inspections:90])
	$recL:=Selected record number:C246([Combined Inspections:90])
	$foundit_b:=False:C215
	For ($i; ($recL-1); (1); (-1))
		GOTO SELECTED RECORD:C245([Combined Inspections:90]; $i)
		LOAD RECORD:C52([Combined Inspections:90])
		
		If ([Combined Inspections:90]InspType:5=$currtype)
			$i:=0
			CONFIRM:C162("The report you have selected is not the most recent inspection. Do you wish to co"+"ntinue anyways? "; "Continue"; "Cancel")
			If (OK=0)
				$OKtoPrint:=False:C215
			End if 
		End if 
		
	End for 
	
End if 

If ($OKtoPrint)
	GOTO SELECTED RECORD:C245([Combined Inspections:90]; $recL)
	
	INSP_PRN_InitVars
	//2005-01-04 ASL
	//Guarantee this.
	SET PRINT PREVIEW:C364(False:C215)
	
	//This creates a job name for the print jobs to follow
	$oldWinTitle:=Get window title:C450
	$newWinTitle:="Evaluation Form "+[Bridge MHD NBIS:1]BIN:3+" "
	SET WINDOW TITLE:C213($newWinTitle)
	
	G_InitInspVars
	
	sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
	
	If (OK=1)
		
		//PAGE SETUP([Inspections];"Dive Pr Pg 1")
		G_PrintOptions
		If (<>ShowPrint)
			PRINT SETTINGS:C106
		End if 
		
		If (OK=1)  //user can cancel from the print settings  
			BRING TO FRONT:C326(Current process:C322)
			
			C_LONGINT:C283(INSP_NumItems_L)  //Command Replaced was o_C_INTEGER//number of items on this form
			INSP_NumItems_L:=5  //items 58,59,60,OVR,APR
			ARRAY INTEGER:C220(INSP_Start_ai; INSP_NumItems_L)  //start of item counter
			ARRAY INTEGER:C220(INSP_Fin_ai; INSP_NumItems_L)  //end of item counter
			//load values in the arrays
			INSP_Start_ai{1}:=<>k58s_
			INSP_Start_ai{2}:=<>k59s_
			INSP_Start_ai{3}:=<>k60s_
			INSP_Start_ai{4}:=<>kOVRs_
			INSP_Start_ai{5}:=<>kAPRs_
			INSP_Fin_ai{1}:=<>k58f_
			INSP_Fin_ai{2}:=<>k59f_
			INSP_Fin_ai{3}:=<>k60f_
			INSP_Fin_ai{4}:=<>kOVRf_
			INSP_Fin_ai{5}:=<>kAPRf_
			
			INSP_Item43Desc
			INSP_FillElementInfo
			GetAreaBIEinfo(String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60)))
			
			vInspTitlePr:=G_Insp_SetTitle
			
			//Added variables for Item 58,59,60,60uw ratings
			vItem58:=G_ElmtRatingTxt([Inspections:27]Item 58:79)
			vItem59:=G_ElmtRatingTxt([Inspections:27]Item 59:80)
			vItem60:=G_ElmtRatingTxt([Inspections:27]Item 60:81)
			vItem60UW:=G_ElmtRatingTxt([Inspections:27]Item 60 UW:66)
			vItem60Cur:=G_ElmtRatingTxt([Inspections:27]Item 60 Cur:155)
			C_DATE:C307(vInspdate_d)
			
			C_TEXT:C284(BRIDGEBIN)
			BRIDGEBIN:=sBDEPT+" / "+[Inspections:27]BIN:1
			
			vInspdate_d:=[Inspections:27]Insp Date:78
			
			C_LONGINT:C283($CurrInspRecID_L)
			$CurrInspRecID_L:=[Inspections:27]InspID:2
			
			For ($i; ($recL+1); ($numrecs))
				
				GOTO SELECTED RECORD:C245([Combined Inspections:90]; $i)
				LOAD RECORD:C52([Combined Inspections:90])
				
				If ([Combined Inspections:90]InspType:5=$currtype)
					$foundit_b:=True:C214
					$i:=$numrecs+1
				End if 
				
			End for 
			
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
			INSP_FillPreElementInfo
			
			vpItem58:=G_ElmtRatingTxt([Inspections:27]Item 58:79)
			vpItem59:=G_ElmtRatingTxt([Inspections:27]Item 59:80)
			vpItem60:=G_ElmtRatingTxt([Inspections:27]Item 60:81)
			vpItem60UW:=G_ElmtRatingTxt([Inspections:27]Item 60 UW:66)
			vpItem60Cur:=G_ElmtRatingTxt([Inspections:27]Item 60 Cur:155)
			VpInspdate:=[Combined Inspections:90]InspDate:4
			
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$CurrInspRecID_L)
			C_LONGINT:C283($PrintHt_L)
			$PrintHt_L:=Print form:C5([Inspections:27]; "Evaluation Form Page1")
			$PrintHt_L:=Print form:C5([Inspections:27]; "Evaluation Form Page2")
			$PrintHt_L:=Print form:C5([Inspections:27]; "Evaluation Form Page3")
			$PrintHt_L:=Print form:C5([Inspections:27]; "Evaluation Form Page4")
			$PrintHt_L:=Print form:C5([Inspections:27]; "Evaluation Form Page5")
			//send a last page break to spool the job 
			PAGE BREAK:C6
		End if 
		
		ON ERR CALL:C155("")  //reset the error handler
		SET WINDOW TITLE:C213($oldWinTitle)
	End if 
End if 