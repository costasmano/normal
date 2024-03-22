//%attributes = {"invisible":true}
// Method: SCPOA_PrintPG1_FM
// Description
//  ` Print method for Page 1 of ScourPOA form Print1-A
// Parameters
// $1 : $FormEvent_L - Optional
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/09, 09:01:54
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: costasmanousakis-(Designer)-(4/19/11 16:55:45)
	Mods_2011_05
	//  `SCPOA V2
	// Modified by: costasmanousakis-(Designer)-(6/15/11 08:20:20)
	Mods_2011_06
	//  `Added fit for vars SCPOA_PierSCChordDist_txt ,SCPOA_AbutSCChordDist_txt
	//  `Added code to move the abut and pier elevation and distance text closer to
	//  `the labels to allow morespace for printing.
	// Modified by: costasmanousakis-(Designer)-(6/23/11 17:41:59)
	Mods_2011_06
	//  `defined new var SCPOA_ApproveChkBx_2 = SCPOA_ApproveChkBx due to some
	//  `strange behavior during printing. box would show shaded....
	
	// Modified by: Costas Manousakis-(Designer)-(2/29/12 20:23:36)
	Mods_2012_02
	//  `add SCPOA_FillFormPicButtons and new form -A
	// Modified by: Costas Manousakis-(Designer)-(3/14/13 17:15:18)
	Mods_2013_03
	//  `Added calc for checkbox SCPOA_SourceRefList_L
End if 

// Declare local variables
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		SCPOA_FillFormPicButtons
		ut_getFormVariables(Current method name:C684)
		
		If (SCPOA_SourceRefs_txt#"")
			SCPOA_SourceRefList_L:=1
		Else 
			SCPOA_SourceRefList_L:=0
		End if 
		
		C_TEXT:C284($POAPrep_txt)
		If (SCPOA_POAEval_txt="")
			$POAPrep_txt:=""
		Else 
			$POAPrep_txt:=Uppercase:C13("Comments by POA Preparer:")+<>sCR+SCPOA_POAEval_txt
		End if 
		
		If (SCPOA_Descr1_txt="")
			SCPOA_Eval_txt:=$POAPrep_txt
		Else 
			SCPOA_Eval_txt:=Uppercase:C13("Comments from HNTB Study of 1998: ")+<>sCR+"<<"+SCPOA_Descr1_txt+">>"
			If ($POAPrep_txt="")
			Else 
				SCPOA_Eval_txt:=SCPOA_Eval_txt+<>sCR+$POAPrep_txt
			End if 
			
		End if 
		
		C_TEXT:C284($POAPrep_txt)
		If (SCPOA_POAHist_txt="")
			$POAPrep_txt:=""
		Else 
			$POAPrep_txt:="Comments by POA Preparer:"+<>sCR+SCPOA_POAHist_txt
		End if 
		
		If (SCPOA_Descr2_txt="")
			SCPOA_SCHist_txt:=$POAPrep_txt
		Else 
			SCPOA_SCHist_txt:=SCPOA_Descr2_txt
			If ($POAPrep_txt="")
			Else 
				SCPOA_SCHist_txt:=SCPOA_SCHist_txt+<>sCR+$POAPrep_txt
			End if 
		End if 
		SCPOA_ApprDate_txt:=F_dateToString([ScourPOA:132]DateApproved:5; Internal date short:K1:7)
		SCPOA_ComplDate_txt:=F_dateToString([ScourPOA:132]DateCompleted:8; Internal date short:K1:7)
		SCPOA_POANextUpdate_txt:=F_dateToString(SCPOA_POANextUpdate_d; Internal date short:K1:7)
		SCPOA_Footing_OM(On Load:K2:1)
		SCPOA_FootingMatl_OM(On Load:K2:1)
		SCPOA_Variables("PRINTPG1")
		C_LONGINT:C283(SCPOA_ApproveChkBx_2)
		SCPOA_ApproveChkBx_2:=SCPOA_ApproveChkBx
		C_BOOLEAN:C305($Fit_b)
		C_LONGINT:C283($ObL; $ObT; $ObR; $ObB; $ObBW; $ObBH)
		C_LONGINT:C283($Ob2L; $Ob2T; $Ob2R; $Ob2B)
		OBJECT GET COORDINATES:C663(*; "AbutBotEl_label"; $ObL; $ObT; $ObR; $ObB)
		OBJECT GET BEST SIZE:C717(*; "AbutBotEl_label"; $ObBW; $ObBH)
		OBJECT GET COORDINATES:C663(*; "SCPOA_AbutSCElev_txt"; $Ob2L; $Ob2T; $Ob2R; $Ob2B)
		OBJECT MOVE:C664(*; "SCPOA_AbutSCElev_txt"; ($ObL+$ObBW+2); $Ob2T; $Ob2R; $Ob2B; *)
		OBJECT GET COORDINATES:C663(*; "AbutDistRef_label"; $ObL; $ObT; $ObR; $ObB)
		OBJECT GET BEST SIZE:C717(*; "AbutDistRef_label"; $ObBW; $ObBH)
		OBJECT GET COORDINATES:C663(*; "SCPOA_AbutSCChordDist_txt"; $Ob2L; $Ob2T; $Ob2R; $Ob2B)
		OBJECT MOVE:C664(*; "SCPOA_AbutSCChordDist_txt"; ($ObL+$ObBW+2); $Ob2T; $Ob2R; $Ob2B; *)
		OBJECT GET COORDINATES:C663(*; "PierBotEl_label"; $ObL; $ObT; $ObR; $ObB)
		OBJECT GET BEST SIZE:C717(*; "PierBotEl_label"; $ObBW; $ObBH)
		OBJECT GET COORDINATES:C663(*; "SCPOA_PierSCElev_txt"; $Ob2L; $Ob2T; $Ob2R; $Ob2B)
		OBJECT MOVE:C664(*; "SCPOA_PierSCElev_txt"; ($ObL+$ObBW+2); $Ob2T; $Ob2R; $Ob2B; *)
		OBJECT GET COORDINATES:C663(*; "PierDistRef_label"; $ObL; $ObT; $ObR; $ObB)
		OBJECT GET BEST SIZE:C717(*; "PierDistRef_label"; $ObBW; $ObBH)
		OBJECT GET COORDINATES:C663(*; "SCPOA_PierSCChordDist_txt"; $Ob2L; $Ob2T; $Ob2R; $Ob2B)
		OBJECT MOVE:C664(*; "SCPOA_PierSCChordDist_txt"; ($ObL+$ObBW+2); $Ob2T; $Ob2R; $Ob2B; *)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_Eval_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_SCHist_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->VSINSPDEPARTMENT; 14; 10)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_AbutSCElev_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_PierSCElev_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_AbutSCCritical_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_PierSCCritical_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_AbutSCChordDist_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_PierSCChordDist_txt; 9; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_SourceRefs_txt; 9; 5)
		
End case 

//End of form method