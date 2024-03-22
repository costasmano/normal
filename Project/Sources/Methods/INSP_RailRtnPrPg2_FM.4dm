//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/17/11, 10:50:22
	// ----------------------------------------------------
	// Method: INSP_RailRtnPrPg2_FM
	// Description
	// Form method for the second page of the Rail Routine form
	// Copied from INSP_RoutinePrPg2_FM
	
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_01
	//`RR
	Mods_2013_01  //r001 ` 
	//Modified by: Charles Miller (1/8/13 15:44:03)
	
End if 

//Load variables
C_LONGINT:C283($i; $recnum; $elm; $j)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($p; $q; $r; $t)

C_TEXT:C284(xR1; xR2; xR3; xR4; xR5; xS1; xS2; xS3)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vClrPost; vBrClrSgnNE; vBrClrSgnSW; vAdClrSgnNE; vAdClrSgnSW)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284(vLiftBucket; vLadder; vBoat; vWader; vInspect50; vRigging; vStaging; vTraffic; vFlagman; vPolice; vAccOther)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vNeedLiftBucket; vNeedLadder; vNeedBoat; vNeedWader; vNeedInspect50; vNeedRigging; vNeedStaging; vNeedTraffic; vNeedFlagman; vNeedPolice; vNeedAccOther)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vPlans; vVCR; vRatingRep; vRerating)  // Command Replaced was o_C_STRING length was 1

C_LONGINT:C283(INSP_NumItems_L)  //Command Replaced was o_C_INTEGER//number of items on this form
INSP_NumItems_L:=3  //items 61,62,  GENERAL
ARRAY INTEGER:C220(INSP_Start_ai; INSP_NumItems_L)  //start of item counter
ARRAY INTEGER:C220(INSP_Fin_ai; INSP_NumItems_L)  //end of item counter
//load values in the arrays
INSP_Start_ai{1}:=2400
INSP_Start_ai{2}:=2500
INSP_Start_ai{3}:=2550
INSP_Fin_ai{1}:=2408
INSP_Fin_ai{2}:=2507
INSP_Fin_ai{3}:=2561

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		
		vItem62:=G_ElmtRatingTxt([Inspections:27]Item 62:113)
		vItem61:=G_ElmtRatingTxt([Inspections:27]Item 61:82)
		vItem61UW:=G_ElmtRatingTxt([Inspections:27]Item 61 UW:72)
		vItem61Cur:=G_ElmtRatingTxt([Inspections:27]Item 61 Cur:159)
		
		G_Insp_SetDirLbl([Inspections:27]OrientationNS:133)
		
		G_Insp_FmtSTOWN
		If ([Inspections:27]Insp Type:6#"RRR")
			INSP_FillElementInfo
		Else 
			INSP_LoadESForReport([Inspections:27]Insp Type:6)
		End if 
		//Check boxes
		f_Var_to_Series([Inspections:27]StreamFlowV:21; "xR"; "THMLN")
		
		If ([Inspections:27]ClrPosting:49=True:C214)
			vClrPost:=""
			vBrClrSgnNE:=[Inspections:27]BrClrSignsNE:54
			vBrClrSgnSW:=[Inspections:27]BrClrSignsSW:55
			vAdClrSgnNE:=[Inspections:27]AdClrSignNE:56
			vAdClrSgnSW:=[Inspections:27]AdClrSignSW:57
		Else 
			vClrPost:="X"
			vBrClrSgnNE:=""
			vBrClrSgnSW:=""
			vAdClrSgnNE:=""
			vAdClrSgnSW:=""
		End if 
		vLiftBucket:=Substring:C12([Inspections:27]LiftBucket:86; 2; 1)
		vLadder:=Substring:C12([Inspections:27]Ladder:87; 2; 1)
		vBoat:=Substring:C12([Inspections:27]Boat:88; 2; 1)
		vWader:=Substring:C12([Inspections:27]Wader:89; 2; 1)
		vInspect50:=Substring:C12([Inspections:27]Inspector50:90; 2; 1)
		vRigging:=Substring:C12([Inspections:27]Rigging:91; 2; 1)
		vStaging:=Substring:C12([Inspections:27]Staging:92; 2; 1)
		vTraffic:=Substring:C12([Inspections:27]Traffic Control:93; 2; 1)
		vFlagman:=Substring:C12([Inspections:27]RR Flagman:94; 2; 1)
		vPolice:=Substring:C12([Inspections:27]Police:95; 2; 1)
		vAccOther:=Substring:C12([Inspections:27]OtherAccBool:97; 2; 1)
		vNeedLiftBucket:=Substring:C12([Inspections:27]LiftBucket:86; 1; 1)
		vNeedLadder:=Substring:C12([Inspections:27]Ladder:87; 1; 1)
		vNeedBoat:=Substring:C12([Inspections:27]Boat:88; 1; 1)
		vNeedWader:=Substring:C12([Inspections:27]Wader:89; 1; 1)
		vNeedInspect50:=Substring:C12([Inspections:27]Inspector50:90; 1; 1)
		vNeedRigging:=Substring:C12([Inspections:27]Rigging:91; 1; 1)
		vNeedStaging:=Substring:C12([Inspections:27]Staging:92; 1; 1)
		vNeedTraffic:=Substring:C12([Inspections:27]Traffic Control:93; 1; 1)
		vNeedFlagman:=Substring:C12([Inspections:27]RR Flagman:94; 1; 1)
		vNeedPolice:=Substring:C12([Inspections:27]Police:95; 1; 1)
		vNeedAccOther:=Substring:C12([Inspections:27]OtherAccBool:97; 1; 1)
		
		vPlans:=f_Boolean2String([Inspections:27]Plans:69; "YN")
		vVCR:=f_Boolean2String([Inspections:27]VCR:70; "YN")
		
End case 