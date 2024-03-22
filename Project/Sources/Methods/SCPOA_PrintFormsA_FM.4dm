//%attributes = {"invisible":true}
// Method: SCPOA_PrintFormsA_FM
// Description
// Print the "A" forms 
// 
// Parameters
// $1 : $FormName_txt
// $2 : $FormEvent_L (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/05/11, 09:48:25
	// ----------------------------------------------------
	
	Mods_2011_05
	// Modified by: Costas Manousakis-(Designer)-(1/25/12 09:06:01)
	Mods_2012_01
	//  `Use method SCPOA_FillFormPicButtons to fill the checkboxes
	// Modified by: Costas Manousakis-(Designer)-(2/27/12 22:28:57)
	Mods_2012_02
	//  `mods for the latest release of the ScourPOA
	// Modified by: Costas Manousakis-(Designer)-(3/21/12 21:54:25)
	Mods_2012_03
	//  `FV Photo changes : can add more than 4 photos
	// Modified by: Costas Manousakis-(Designer)-(4/18/12 16:43:23)
	Mods_2012_04
	// added to var SCPOA_ReviitEvery_txt a unit of hrs if needed
	// Modified by: Costas Manousakis-(Designer)-(4/19/12 13:32:34)
	Mods_2012_04
	//  `For  form FieldVerificationCardpg2 use the 1st six pictures in the list - dont use the locus map
	// Modified by: Costas Manousakis-(Designer)-(6/8/12 09:05:16)
	Mods_2012_06
	//  `Added missing call in PRINT3-A for SCPOA_NWSStationPrint_txt;
	//  `Added call to fit SCPOA_CLCri_WLvl_txt in FVC1
	// Modified by: Costas Manousakis-(Designer)-(10/23/14 13:47:39)
	Mods_2014_10
	//  `General POA modifications Oct 2014
End if 
C_TEXT:C284($1; $FormName_txt)
$FormName_txt:=$1
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>1)
	C_LONGINT:C283($2)
	$FormEvent_L:=$2
Else 
	$FormEvent_L:=Form event code:C388
End if 
Case of 
	: ($FormEvent_L=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		C_TEXT:C284(SCPOA_PRINTPAGENO_TXT)
		C_BOOLEAN:C305($Fit_b)
		SCPOA_FillFormPicButtons
		Case of 
			: ($FormName_txt="PRINT2A")
				//[ScourPOA];"Print2A"
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_WatchReg_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_WatchUW_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_InstTYpe_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_InstLoc_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ScCritAction_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_FixedTerm_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_2cEvtScCritAction_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_2cEvtFixedTerm_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ScCritDisch_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_IncrInspPrg_Addtl_txt; 9; 5)
				
			: ($FormName_txt="PRINT3A")
				//[ScourPOA];"Print3A"
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_OthScCritAction_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_FlMonLookFor_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_PostFldWatch_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_PostFldElevs_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_PostFldAction_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_EmergFac_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_BrgClosure_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_CLCri_Other_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ClosureResp_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_Contacts_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_CLCri_wSurf_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_Stage_s; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_DischOvrFeet_txt; 9; 5)
				C_TEXT:C284(SCPOA_NWSStationPrint_txt)
				If (SCPOA_NWSStation_txt#"")
					SCPOA_NWSStationPrint_txt:=SCPOA_NWSStation_txt
					If (SCPOA_NWSStationURL_txt#"")
						SCPOA_NWSStationPrint_txt:=SCPOA_NWSStationPrint_txt+" ("+SCPOA_NWSStationURL_txt+")"
					End if 
					$Fit_b:=ut_FitPrintFormObject(->SCPOA_NWSStationPrint_txt; 9; 5)
					
				Else 
					SCPOA_NWSStationPrint_txt:=""
				End if 
				
			: ($FormName_txt="PRINT4A")
				//[ScourPOA];"Print4A"
				
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ReOpenResp_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_DetourDesc_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_BrgCloStreamElNo_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_BrgCloStreamElAbNo_txt; 9; 5)
				
			: ($FormName_txt="PRINT5A")
				//[ScourPOA];"Print5A"
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ComplCNT_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_PropCNT_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_CNTNotReq_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_Inst_Other_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_LeadAgency_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_OtherProj_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_SchedInfo_txt; 9; 5)
				
			: ($FormName_txt="PRINT1-A")
				
			: ($FormName_txt="PRINT2-A")
				SCPOA_PRINTPAGENO_TXT:="3"
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_WatchReg_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_IncrInspPrg_Addtl_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_WatchUW_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_InstTYpe_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_InstLoc_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_FixedDevProced_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ScCritAction_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_FixedTerm_txt; 9; 5)
				
			: ($FormName_txt="PRINT3-A")
				SCPOA_PRINTPAGENO_TXT:="4"
				
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_CritWSEMarkLoc_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ScourCritFeat_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_FlMonLookFor_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_NWSStationPrint_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_OthScCritElev_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_PostFldWatch_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_PostFldElevs_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_PostFldAction_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_EmergFac_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_BrgClosure_txt; 9; 5)
				C_TEXT:C284(SCPOA_NWSStationPrint_txt)
				If (SCPOA_NWSStation_txt#"")
					SCPOA_NWSStationPrint_txt:=SCPOA_NWSStation_txt
					If (SCPOA_NWSStationURL_txt#"")
						SCPOA_NWSStationPrint_txt:=SCPOA_NWSStationPrint_txt+" ("+SCPOA_NWSStationURL_txt+")"
					End if 
					$Fit_b:=ut_FitPrintFormObject(->SCPOA_NWSStationPrint_txt; 9; 5)
					
				Else 
					SCPOA_NWSStationPrint_txt:=""
				End if 
				
			: ($FormName_txt="PRINT4-A")
				SCPOA_PRINTPAGENO_TXT:="5"
				
				SCPOA_CLCri_WLvl_p_txt:=String:C10(SCPOA_CLCri_WLvl_r)+" ft. "+SCPOA_CLCri_WLvl_txt
				SCPOA_OthScCritElev_p_txt:=String:C10(SCPOA_OthScCritElev_r)+" ft. "+SCPOA_OthScCritElev_txt
				
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_CLCri_WLvl_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_OthScCritElev_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_CLCri_Other_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_CLCri_NOAAI_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ClosureResp_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_Contacts_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_PreExistCond_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ReOpenResp_txt; 9; 5)
				
			: ($FormName_txt="PRINT5-A")
				SCPOA_PRINTPAGENO_TXT:="6"
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_DetourDesc_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_TrafEqLoc_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_TrafEqDist_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_TrafEqDBE_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_AddtlCritCons_txt; 9; 5)
				
			: ($FormName_txt="PRINT6-A")
				SCPOA_PRINTPAGENO_TXT:="7"
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_ComplCNT_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_PropCNT_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_CNTNotReq_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_OtherProj_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_SchedInfo_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_7BInstallBy_txt; 9; 5)
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_7BContactPers_txt; 9; 5)
				
			: ($FormName_txt="FieldVerificationCardpg1")
				
				SCPOA_ReviitEvery_txt:=""
				
				SCPOA_CLCri_WLvl_p_txt:=String:C10(SCPOA_CLCri_WLvl_r)+" ft. "+SCPOA_CLCri_WLvl_txt
				SCPOA_OthScCritElev_p_txt:=String:C10(SCPOA_OthScCritElev_r)+" ft. "+SCPOA_OthScCritElev_txt
				
				Case of 
					: (SCPOA_2DFreqCont_L=1)
						SCPOA_ReviitEvery_txt:="Cont."
					: (SCPOA_2DFreq3Hr_L=1)
						SCPOA_ReviitEvery_txt:="6 Hrs"
					: (SCPOA_2DFreq12Hr_L=1)
						SCPOA_ReviitEvery_txt:="12 Hrs"
					: (SCPOA_2DFreqDay_L=1)
						SCPOA_ReviitEvery_txt:="24 Hrs"
					: (SCPOA_2DFreqOther_L=1)
						SCPOA_ReviitEvery_txt:=SCPOA_OthFldMonFreqDesc_txt
				End case 
				$Fit_b:=ut_FitPrintFormObject(->SCPOA_CLCri_WLvl_txt; 9; 5)
				
				
			: ($FormName_txt="FieldVerificationCardpg2")
				C_PICTURE:C286(SCPOA_Pict1; SCPOA_Pict2; SCPOA_Pict3; SCPOA_Pict4; SCPOA_Pict5; SCPOA_Pict6)
				C_TEXT:C284(SCPOA_Pic1Lbl_txt; SCPOA_Pic2Lbl_txt; SCPOA_Pic3Lbl_txt; SCPOA_Pic4Lbl_txt; SCPOA_Pic5Lbl_txt; SCPOA_Pic6Lbl_txt)
				SCPOA_Pict1:=SCPOA_Pict1*0
				SCPOA_Pic1Lbl_txt:=""
				SCPOA_Pic2Lbl_txt:=""
				SCPOA_Pic3Lbl_txt:=""
				SCPOA_Pic4Lbl_txt:=""
				SCPOA_Pic5Lbl_txt:=""
				SCPOA_Pic6Lbl_txt:=""
				READ ONLY:C145([ScourPOA_Images:134])
				If (False:C215)
					QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)
					QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5="LOCUS")
					If (Records in selection:C76([ScourPOA_Images:134])=1)
						LOAD RECORD:C52([ScourPOA_Images:134])
						
						If (BLOB size:C605([ScourPOA_Images:134]Image_x:3)>0)
							
							If (OK=1)
								BLOB TO PICTURE:C682([ScourPOA_Images:134]Image_x:3; SCPOA_Pict1)
								SCPOA_Pic1Lbl_txt:="LOCUS MAP"
							End if 
							
						End if 
						
					End if 
					
				End if 
				SCPOA_Pict2:=SCPOA_Pict2*0
				SCPOA_Pict3:=SCPOA_Pict2*0
				SCPOA_Pict4:=SCPOA_Pict2*0
				SCPOA_Pict5:=SCPOA_Pict2*0
				SCPOA_Pict6:=SCPOA_Pict2*0
				C_LONGINT:C283($numPics)
				ARRAY LONGINT:C221($SeqCopy_aL; 0)
				ARRAY LONGINT:C221($FVSeqCopy_aL; 0)
				ARRAY LONGINT:C221($RecNumCopy_aL; 0)
				COPY ARRAY:C226(SCPOA_PhotoSeq_aL; $SeqCopy_aL)
				COPY ARRAY:C226(SCPOA_FVPhotoSeq_aL; $FVSeqCopy_aL)
				COPY ARRAY:C226(SCPOA_PhotoRecs_aL; $RecNumCopy_aL)
				MULTI SORT ARRAY:C718($FVSeqCopy_aL; >; $SeqCopy_aL; >; $RecNumCopy_aL)
				CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; $RecNumCopy_aL)
				$numPics:=Records in selection:C76([ScourPOA_Images:134])
				If (Records in selection:C76([ScourPOA_Images:134])>0)
					C_LONGINT:C283($picCounter_L)
					C_POINTER:C301($pic_ptr; $lbl_ptr)
					$picCounter_L:=1
					FIRST RECORD:C50([ScourPOA_Images:134])
					While ((Not:C34(End selection:C36([ScourPOA_Images:134]))) & ($picCounter_L<7))
						If (BLOB size:C605([ScourPOA_Images:134]Image_x:3)>0)
							$pic_ptr:=Get pointer:C304("SCPOA_Pict"+String:C10($picCounter_L))
							$lbl_ptr:=Get pointer:C304("SCPOA_Pic"+String:C10($picCounter_L)+"Lbl_txt")
							BLOB TO PICTURE:C682([ScourPOA_Images:134]Image_x:3; $pic_ptr->)
							$lbl_ptr->:=[ScourPOA_Images:134]ImgDescr_txt:4
							$picCounter_L:=$picCounter_L+1
							
						End if 
						NEXT RECORD:C51([ScourPOA_Images:134])
					End while 
					
				End if 
				
				READ ONLY:C145([ScourPOA_Images:134])
				CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
				
			: ($FormName_txt="PRINTMAP")
				OBJECT SET VISIBLE:C603(*; "PAGENUMBERLABEL"; False:C215)
		End case 
		
End case 