//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/10/07, 11:51:29
	// ----------------------------------------------------
	// Method: INSP_CulvertPrPg1_FM
	// Description
	// Form method for the Culvert page 1 form
	// Copied from the form method
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:47:56)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(3/28/08 13:59:50)
	Mods_2008_CM_5403  //Adjust Kilo/milepoint display
	Mods_2011_10  // CJ Miller`10/04/11, 12:43:29      ` remove usage of subtabl
	//LAST SUBRECORD([Bridge MHD NBIS]Year Rehab)
	// Modified by: Costas Manousakis-(Designer)-(10/31/17 11:19:53)
	Mods_2017_10
	//  `changed format of vBarrelSize to n.nnWxn.nnH
End if 
If (False:C215)
	Mods_2004_CM11
	Mods_2005_CM01
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 16:51:09)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(10/22/2007 10:38:18)
	Mods_2007_CM12_5302
	Mods_2013_02  //r001 ` Allow for different headings on weights
	//Modified by: Charles Miller (2/14/13 14:59:23)
End if 

//Load variables
C_LONGINT:C283($i; $j)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($recnum)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($p; $q; $t; $r)
C_LONGINT:C283($elm)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vsCurbRvlNE; vsCurbRvlSW)  // Command Replaced was o_C_STRING length was 3// added for curb reveal
C_TEXT:C284(vItem26)  // Command Replaced was o_C_STRING length was 23

ARRAY INTEGER:C220($A; 0)
ARRAY TEXT:C222($B; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222($C; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($D; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222($U; 0)  //DBD 12/11/02 Added Array String declaration for Altrating//Command Replaced was o_ARRAY string length was 1

ARRAY TEXT:C222($aElmSafetyTxt; 0)  //User defined element descriptions//Command Replaced was o_ARRAY string length was 40
C_TEXT:C284($vDeficiencyDef)  // Command Replaced was o_C_STRING length was 1
$vDeficiencyDef:="-"

//Added to simplify coding of Element info variables
C_LONGINT:C283(INSP_NumItems_L)  //Command Replaced was o_C_INTEGER//number of items on this form
INSP_NumItems_L:=4  //items 62,61,TRA,APP
ARRAY INTEGER:C220(INSP_Start_ai; INSP_NumItems_L)  //start of item counter
ARRAY INTEGER:C220(INSP_Fin_ai; INSP_NumItems_L)  //end of item counter
//load values in the arrays
INSP_Start_ai{1}:=<>k62s_
INSP_Start_ai{2}:=<>k61s_
INSP_Start_ai{3}:=<>kTRAs_
INSP_Start_ai{4}:=<>kAPRs_
INSP_Fin_ai{1}:=<>k62f_
INSP_Fin_ai{2}:=<>k61f_
INSP_Fin_ai{3}:=<>kTRAf_
INSP_Fin_ai{4}:=<>kAPRf_

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		INSP_SetWPHeadings
		vInspTitlePr:=Uppercase:C13(G_Insp_SetTitle)
		G_Insp_FormatTitle
		
		G_Insp_SetDirLbl([Inspections:27]OrientationNS:133)
		
		vsCurbRvlNE:=G_CurbRvl([Inspections:27]CurbRevealNE:10)
		vsCurbRvlSW:=G_CurbRvl([Inspections:27]CurbRevealSW:11)
		
		INSP_KiloPtValues
		//Item21 and 22 - added 4/1/04 (redefine on print form)    
		INSP_Item21Desc
		INSP_Item22Desc
		INSP_Item43Desc
		INSP_Item107Desc
		
		vItem26:=Get_Description(-><>aFC; -><>aFC_Cod; ->[Inspections:27]Item26:200)
		
		//Added variables for Item 62,61  ratings
		vItem62:=G_ElmtRatingTxt([Inspections:27]Item 62:113)
		vItem62UW:=G_ElmtRatingTxt([Inspections:27]Item 62 UW:165)
		vItem62Cur:=G_ElmtRatingTxt([Inspections:27]Item 62 Cur:172)
		vItem61:=G_ElmtRatingTxt([Inspections:27]Item 61:82)
		vItem61UW:=G_ElmtRatingTxt([Inspections:27]Item 61 UW:72)
		vItem61Cur:=G_ElmtRatingTxt([Inspections:27]Item 61 Cur:159)
		
		INSP_Item41Desc
		
		//Adjust Fonts and fields.
		If (Length:C16(vItem26)>14)
			OBJECT SET FONT SIZE:C165(vItem26; 9)
		End if 
		INSP_Item43Desc("Resize")
		
		G_Insp_FmtSTOWN
		
		vBarrelSize:=String:C10([Inspections:27]BarrelsWidth:179; "###0.00W")+"x"+String:C10([Inspections:27]BarrelsHeight:180; "###0.00H")
		
		INSP_FillElementInfo
		
		//Check boxes
		f_Var_to_Series([Inspections:27]CollisionDamSup:13; "xR"; "NRMS"; "N")
		//Load vibration    
		f_Var_to_Series([Inspections:27]LoadVibration:15; "xT"; "NRMS"; "N")
		//Stream velocity    
		f_Var_to_Series([Inspections:27]StreamFlowV:21; "xW"; "THML")
		//Flags    
		vUndermine:=f_Boolean2String([Inspections:27]UnderMining:19; "YN")
		
		
		vLadder1:=Substring:C12([Inspections:27]Ladder:87; 1; 1)
		vBoat1:=Substring:C12([Inspections:27]Boat:88; 1; 1)
		vWader1:=Substring:C12([Inspections:27]Wader:89; 1; 1)
		vAccOther1:=Substring:C12([Inspections:27]OtherAccBool:97; 1; 1)
		vLadder2:=Substring:C12([Inspections:27]Ladder:87; 2; 1)
		vBoat2:=Substring:C12([Inspections:27]Boat:88; 2; 1)
		vWader2:=Substring:C12([Inspections:27]Wader:89; 2; 1)
		vAccOther2:=Substring:C12([Inspections:27]OtherAccBool:97; 2; 1)
		
		vUWInsp:=f_Boolean2String([Inspections:27]UWInspReqd:139; "YN")
		vPlans:=f_Boolean2String([Inspections:27]Plans:69; "YN")
		vVCR:=f_Boolean2String([Inspections:27]VCR:70; "YN")
		
		G_Insp_SetDeptFont
		G_Insp_ApplyRev2_PR
		
		INSP_PR_RatgBlock
End case 