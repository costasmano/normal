
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/13/12, 13:53:34
//----------------------------------------------------
//Method: Form Method: [Inspections];"RailRoutine Culvert"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_09  //r001 ` 
	//Modified by: Charles Miller (9/13/12 13:53:36)
	Mods_2012_12  //r001 ` Add code for new inspection types
	//Modified by: Charles Miller (12/13/12 14:08:51)
	Mods_2013_02  //r001 ` Allow for different headings on weights
	//Modified by: Charles Miller (2/14/13 16:01:54)
	// Modified by: Costas Manousakis-(Designer)-(7/29/13 11:33:18)
	Mods_2013_07
	//  `Modified print forms for MBTA to display the title MBTA Area engineer only.
	// Modified by: Costas Manousakis-(Designer)-(4/9/15 12:34:15)
	Mods_2015_04_bug
	//  `fixed wrong variable name in place of  vDN62_13
	// Modified by: Costas Manousakis-(Designer)-(4/23/15 15:26:24)
	Mods_2015_04_bug
	//  `fixed label for BDEPT
	// Modified by: Costas Manousakis-(Designer)-(11/30/15 14:10:19)
	Mods_2015_11_bug
	//  `fix accessibility  items - wrong variables were being filled.
	// Modified by: Costas Manousakis-(Designer)-(1/16/18 14:01:16)
	Mods_2018_01
	//  `increased allowed entry in Total Hrs
	// Modified by: Costas Manousakis-(Designer)-(12/3/19 15:03:54)
	Mods_2019_12
	//  `added invis rectangle "WTPositnArea"; use FORM_HideEnclosedObjs to hide all objects inside it
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		INSP_SetWPHeadings
		vInspTitlePr:=Uppercase:C13(G_Insp_SetTitle)
		INSP_FormatTitle_new
		
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
		
		vBarrelSize:=String:C10([Inspections:27]BarrelsWidth:179; "###0.00ft")+"x"+String:C10([Inspections:27]BarrelsHeight:180; "###0.00ft")
		
		//INSP_FillElementInfo 
		INSP_LoadESForReport("RRC")  //not sure inspection type
		
		//Check boxes
		f_Var_to_Series([Inspections:27]CollisionDamSup:13; "xR"; "NRMS"; "N")
		//Load vibration    
		f_Var_to_Series([Inspections:27]LoadVibration:15; "xT"; "NRMS"; "N")
		//Stream velocity    
		f_Var_to_Series([Inspections:27]StreamFlowV:21; "xW"; "THML")
		//Flags    
		vUndermine:=f_Boolean2String([Inspections:27]UnderMining:19; "YN")
		
		vLadder:=Substring:C12([Inspections:27]Ladder:87; 2; 1)
		vBoat:=Substring:C12([Inspections:27]Boat:88; 2; 1)
		vWader:=Substring:C12([Inspections:27]Wader:89; 2; 1)
		vAccOther:=Substring:C12([Inspections:27]OtherAccBool:97; 2; 1)
		
		vNeedLadder:=Substring:C12([Inspections:27]Ladder:87; 1; 1)
		vNeedBoat:=Substring:C12([Inspections:27]Boat:88; 1; 1)
		vNeedWader:=Substring:C12([Inspections:27]Wader:89; 1; 1)
		vNeedAccOther:=Substring:C12([Inspections:27]OtherAccBool:97; 1; 1)
		
		vUWInsp:=f_Boolean2String([Inspections:27]UWInspReqd:139; "YN")
		vPlans:=f_Boolean2String([Inspections:27]Plans:69; "YN")
		vVCR:=f_Boolean2String([Inspections:27]VCR:70; "YN")
		
		G_Insp_SetDeptFont
		G_Insp_ApplyRev2_PR
		
		INSP_PR_RatgBlock
		
		FORM_HideEnclosedObjs("WTPostingArea"; Form all pages:K67:7)
		
End case 
