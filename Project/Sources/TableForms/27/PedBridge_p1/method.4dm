
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/13/12, 13:53:34
//----------------------------------------------------
//Method: Form Method: [Inspections]PedBridge_p1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_09  //r001 ` 
	//Modified by: Charles Miller (9/13/12 13:53:36)
	// Modified by: Costas Manousakis-(Designer)-(7/29/13 11:33:18)
	Mods_2013_07
	//  `Modified print forms for MBTA to display the title MBTA Area engineer only.
	// Modified by: Costas Manousakis-(Designer)-(2/2/18 15:30:33)
	Mods_2018_02_bug
	//  `added missing  vYrRehab:=[Inspections]YrRehab
	// Modified by: Costas Manousakis-(Designer)-(10/25/19 14:16:40)
	Mods_2019_10_bug
	//  `adjusted location and objects on page 0, fixed the inspection date and format of other values on page 1 - CallReference #667
	// Modified by: Costas Manousakis-(Designer)-(2021-11-19T00:00:00 12:57:30)
	Mods_2021_11_bug
	//  `use Choose instead of f_Boolean2String ; Added filling of vOvrHead
	//  `Added missing vars for 4th element of approaches
	//  `fix wrong var name for vRN59_8
	//  `added item 60 from UW and item 60 cur
	
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		vPageNo:=1
		C_TEXT:C284(xR1; xR2; xR3; xR4; xS1; xS2; xS3; xS4; xT1; xT2; xT3; xT4; xU1; xU2; xU3; xU4)  // old C_STRING length 1
		C_TEXT:C284(xV1; xV2; xV3; xV4; xW1; xW2; xW3; xW4)  // old C_STRING length 1
		C_TEXT:C284(vFC; vCracks; vUndermine; vOvrHead)  // old C_STRING length 1
		C_TEXT:C284(vsCurbRvlNE; vsCurbRvlSW)  // added for curb reveal ` old C_STRING length 3
		
		INSP_KiloPtValues
		
		vInspTitlePr:=Uppercase:C13(G_Insp_SetTitle)
		vInspTitlePr:=Replace string:C233(vInspTitlePr; "Pedestrian"; "")
		vInspTitlePr:=f_TrimStr(vInspTitlePr; True:C214; True:C214)
		INSP_FormatTitle_new
		
		sTOWN:=Uppercase:C13([Bridge MHD NBIS:1]Town Name:175)
		G_Insp_FmtSTOWN
		
		INSP_Item21Desc
		INSP_Item22Desc
		INSP_Item107Desc
		INSP_Item43Desc
		INSP_Item43Desc("RESIZE")
		INSP_Item44Desc
		INSP_Item44Desc("RESIZE")
		
		//change font if more than one Bdept number is to be printed.
		If (Length:C16(vItem26)>14)
			OBJECT SET FONT SIZE:C165(vItem26; 9)
		End if 
		G_Insp_SetDirLbl([Inspections:27]OrientationNS:133)
		
		vItem58:=G_ElmtRatingTxt([Inspections:27]Item 58:79)
		vItem59:=G_ElmtRatingTxt([Inspections:27]Item 59:80)
		vItem60:=G_ElmtRatingTxt([Inspections:27]Item 60:81)
		vItem60UW:=G_ElmtRatingTxt([Inspections:27]Item 60 UW:66)
		vItem60Cur:=G_ElmtRatingTxt([Inspections:27]Item 60 Cur:155)
		
		INSP_SetUpvDBIE
		//vDBIE:=fn_ReturnName (->[Inspections]DBrInspEngr)
		G_TeamLeader
		G_TmMemberList
		
		INSP_LoadESForReport("PED")
		//vTN58_1
		//vRN58_1
		//vDN58_1
		
		//Get the year rehab'd      
		vYrRehab:=[Inspections:27]YrRehab:158
		
		f_Var_to_Series([Inspections:27]CollisionDamSup:13; "xR"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]LoadDeflection:14; "xS"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]LoadVibration:15; "xT"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]CollisionDamSub:18; "xU"; "NRMS"; "N")
		
		vFC:=Choose:C955([Inspections:27]FractureCrit:16; "Y"; "N")
		vCracks:=Choose:C955([Inspections:27]Cracks:17; "Y"; "N")
		vUndermine:=Choose:C955([Inspections:27]UnderMining:19; "Y"; "N")
		vADA:=Choose:C955([Inspections:27]ADA_Accessible_b:216; "Y"; "N")
		C_LONGINT:C283($vlNumOVRs)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $vlNumOVRs)
		QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2; *)
		QUERY:C277([ElementsSafety:29]; [ElementDict:30]Category:3="OVR"; *)
		QUERY:C277([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"N")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		vOvrHead:=Choose:C955(($vlNumOVRs>0); "Y"; "N")
		
End case 


//End Form Method: [Inspections]PedBridge_p1