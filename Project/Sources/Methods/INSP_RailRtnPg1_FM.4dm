//%attributes = {"invisible":true}
// Method: INSP_RailRtnPg1_FM
// Description
//  ` Form method for Rail Routine and Arch page 1 s
// 
// Parameters
// $1 : $FormEvent_L (optional)
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 12/27/12, 10:09:14
	// ----------------------------------------------------
	// First Release
	Mods_2012_12
	
	// Modified by: manousakisc (10/16/2013)
	Mods_2013_10
	//  `Use different text boxes for window and mac platforms
	// Modified by: Costas Manousakis-(Designer)-(4/18/17 10:53:14)
	Mods_2017_04
	//  `for OVerhead Y/N (variable vOvrHead) search Elements by InspID instead of Selection. 
	//  //The selection has been modified by INSP_LoadESForReport
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
//
C_TEXT:C284(vItem26)  // Command Replaced was o_C_STRING length was 23
C_TEXT:C284(xR1; xR2; xR3; xR4; xS1; xS2; xS3; xS4; xT1; xT2; xT3; xT4; xU1; xU2; xU3; xU4)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(xV1; xV2; xV3; xV4; xW1; xW2; xW3; xW4)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vFC; vCracks; vUndermine; vOvrHead)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vsCurbRvlNE; vsCurbRvlSW)  // Command Replaced was o_C_STRING length was 3// added for curb reveal
C_REAL:C285(vRRClearance_R)

Case of 
	: ($FormEvent_L=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		OBJECT SET VISIBLE:C603(*; "@_mac"; <>MacPL_b)
		OBJECT SET VISIBLE:C603(*; "@_win"; <>WindowsPL_b)
		
		If ([RAILBridgeInfo:37]BIN:1="")
			// there is no RailBridgeInfo record loaded
			READ ONLY:C145([RAILBridgeInfo:37])
			QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			FIRST RECORD:C50([RAILBridgeInfo:37])
		End if 
		
		vInspTitlePr:=Uppercase:C13(G_Insp_SetTitle)
		INSP_FormatTitle_new
		vRRClearance_R:=Round:C94([Bridge MHD NBIS:1]Item54B:108/(0.3048); 2)
		vsCurbRvlNE:=G_CurbRvl([Inspections:27]CurbRevealNE:10)
		vsCurbRvlSW:=G_CurbRvl([Inspections:27]CurbRevealSW:11)
		INSP_KiloPtValues
		INSP_Item21Desc
		INSP_Item22Desc
		
		vItem26:=Get_Description(-><>aFC; -><>aFC_Cod; ->[Inspections:27]Item26:200)
		INSP_Item41Desc
		INSP_Item43Desc
		INSP_Item107Desc
		
		//Added variables for Item 58,59,60,60uw ratings
		vItem58:=G_ElmtRatingTxt([Inspections:27]Item 58:79)
		vItem59:=G_ElmtRatingTxt([Inspections:27]Item 59:80)
		vItem60:=G_ElmtRatingTxt([Inspections:27]Item 60:81)
		vItem60UW:=G_ElmtRatingTxt([Inspections:27]Item 60 UW:66)
		vItem60Cur:=G_ElmtRatingTxt([Inspections:27]Item 60 Cur:155)
		
		//Adjust Fonts and fields.
		If (Length:C16(vItem26)>14)
			OBJECT SET FONT SIZE:C165(vItem26; 9)
		End if 
		INSP_Item43Desc("Resize")
		
		G_Insp_FmtSTOWN
		
		//INSP_FillElementInfo 
		INSP_LoadESForReport([Inspections:27]Insp Type:6)
		
		//Check boxes
		f_Var_to_Series([Inspections:27]CollisionDamSup:13; "xR"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]LoadDeflection:14; "xS"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]LoadVibration:15; "xT"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]CollisionDamSub:18; "xU"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]Scour:20; "xV"; "NRMS"; "N")
		
		//Flags    
		vFC:=f_Boolean2String([Inspections:27]FractureCrit:16; "YN")
		vCracks:=f_Boolean2String([Inspections:27]Cracks:17; "YN")
		vUndermine:=f_Boolean2String([Inspections:27]UnderMining:19; "YN")
		C_LONGINT:C283($vlNumOVRs)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $vlNumOVRs)
		QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2; *)
		QUERY:C277([ElementsSafety:29]; [ElementDict:30]Category:3="OVR"; *)
		QUERY:C277([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"N")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		vOvrHead:=f_Boolean2String(($vlNumOVRs>0); "YN")
		
		G_Insp_SetDirLbl([Inspections:27]OrientationNS:133)
		
		G_Insp_SetDeptFont
		G_Insp_ApplyRev2_PR
		ut_FitPrintFormObject(->[Bridge MHD NBIS:1]Bridge Name:29; 11; 8)
		
End case 

//End INSP_RailRtnPg1_FM