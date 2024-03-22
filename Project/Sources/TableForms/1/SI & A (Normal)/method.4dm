If (False:C215)
	//Form Method: [Bridge MHD NBIS];"SI & A (Normal)"
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(3/28/2007 17:00:13)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(5/14/08 10:39:08)
	Mods_2008_CM_5403
	//Added rank object and method
	// Modified by: Costas Manousakis-(Designer)-(3/21/12 13:49:46)
	Mods_2012_03
	//  `changed sMissingSignstext from A(30) to text
	// Modified by: Costas Manousakis-(Designer)-(10/14/15 11:09:56)
	Mods_2015_10_bug
	//  `Print MBTA  Rating Loads version; added HWYRTG@ objects ; named  previous to DOT_@
	// Modified by: Costas Manousakis-(Designer)-(6/2/16 12:03:08)
	Mods_2016_06_bug
	//  `fixed fileds for HWY_RTG@ objects
	// Modified by: Costas Manousakis-(Designer)-(10/12/17 14:42:15)
	Mods_2017_10
	//  `Removed var sFHWASelect from form; renamed text label to FHWASelect;
	//  //use method SIA_LoadSelectionListInfo to get dates and update the text label 
	// Modified by: Costas Manousakis-(Designer)-(2021-10-29T00:00:00 10:37:19)
	Mods_2021_10_bug
	//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
End if 
If (Form event code:C388=On Printing Detail:K2:18)
	C_TEXT:C284(sFHWASelect)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem12)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem35)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem112)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem104)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem103)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem110)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem92A)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem92B)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem92C)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sCritInsp)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sClosedInsp)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sUWSpInsp)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sAntiM)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sJointLess)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sAcrow)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sPageof)  // Command Replaced was o_C_STRING length was 20
	
	G_SIA_BuildTownLine
	
	If ((vPgs*vPgf)=0)
		sPageof:=""
	Else 
		sPageof:="Page "+String:C10(vPgs)+" of "+String:C10(vPgf)
	End if 
	vDate:=Current date:C33(*)
	C_DATE:C307($FhwaSelDate_d; $BMSLoadDate_d)
	SIA_LoadSelectionListInfo(->$FhwaSelDate_d; ->$BMSLoadDate_d)
	sFHWASelect:=Choose:C955([Bridge MHD NBIS:1]FHWA Select:4; "Y"; "N")+" ("+String:C10($FhwaSelDate_d)+")"
	OBJECT SET TITLE:C194(*; "FHWASelect"; "FHWA Select List= "+sFHWASelect)
	sItem12:=f_Boolean2String([Bridge MHD NBIS:1]Item12:196; "YN")
	sItem35:=f_Boolean2String([Bridge MHD NBIS:1]Item35:101; "YN")
	sItem112:=f_Boolean2String([Bridge MHD NBIS:1]Item112:118; "YN")
	sItem104:=f_Boolean2String([Bridge MHD NBIS:1]Item104:119; "YN")
	sItem103:=f_Boolean2String([Bridge MHD NBIS:1]Item103:124; "YN")
	sItem110:=f_Boolean2String([Bridge MHD NBIS:1]Item110:125; "YN")
	sItem92A:=f_Boolean2String([Bridge MHD NBIS:1]Item92AA:163; "YN")
	sItem92B:=f_Boolean2String([Bridge MHD NBIS:1]Item92BA:165; "YN")
	sItem92C:=f_Boolean2String([Bridge MHD NBIS:1]Item92CA:167; "YN")
	sCritInsp:=f_Boolean2String([Bridge MHD NBIS:1]OtherInsp:42; "YN")
	sClosedInsp:=f_Boolean2String([Bridge MHD NBIS:1]ClosedInsp:45; "YN")
	sUWSpInsp:=f_Boolean2String([Bridge MHD NBIS:1]UWSpInsp:212; "YN")
	sAntiM:=f_Boolean2String([Bridge MHD NBIS:1]AntiMissile:26; "YN")
	sJointLess:=f_Boolean2String([Bridge MHD NBIS:1]JointlessBridge:176; "YN")
	sAcrow:=f_Boolean2String([Bridge MHD NBIS:1]Acrow Panel:28; "YN")
	C_TEXT:C284(sMissingSigns)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sMissingSignstext)
	sMissingSignstext:=[Bridge MHD NBIS:1]MissSignsDesc:224
	sMissingSigns:=f_Boolean2String([Bridge MHD NBIS:1]MissSigns:223; "YN")
	
	//added to get the Recommended Posting values from the [RatingReports] table
	G_SIA_GetRecPostings
	SIA_BridgeRankOM
	OBJECT SET VISIBLE:C603(*; "HWYRTG@"; ([Bridge MHD NBIS:1]InspResp:173="MBTA"))
	OBJECT SET VISIBLE:C603(*; "DOT_@"; ([Bridge MHD NBIS:1]InspResp:173#"MBTA"))
	
End if 