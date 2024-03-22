If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/19/11, 12:00:29
	// ----------------------------------------------------
	// Form Method: [Bridge MHD NBIS];"RailTransitSIA"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_01
	// Modified by: costasmanousakis-(Designer)-(12/7/11 17:05:28)
	Mods_2011_12
	//  `modified Form to show Railroad bridge no and branch name- got rid of Milepoint
	// Modified by: Costas Manousakis-(Designer)-(3/21/12 13:49:46)
	Mods_2012_03
	//  `changed sMissingSignstext from A(30) to text
	// Modified by: Costas Manousakis-(Designer)-(6/10/13 13:47:13)
	Mods_2013_06
	//  `changed label Work Car to  Work Car Combination
	// Modified by: Costas Manousakis-(Designer)-(3/3/14 10:16:33)
	Mods_2014_03
	//  `Fixed sizes and styles of objects
	// Modified by: Costas Manousakis-(Designer)-(4/22/14 14:46:45)
	Mods_2014_04
	//  `added Hybrid Artic loads 
	// Modified by: Costas Manousakis-(Designer)-(10/14/15 12:41:46)
	Mods_2015_10_bug
	//  `moved to the correct spot sitem35 variable
	// Modified by: Costas Manousakis-(Designer)-(5/23/16 14:05:37)
	Mods_2016_05_bug
	//  `fixed Other Accessibility fields, and adjusted print formats on numbers to show 0  values (ex. 0 FT, or 0 IN)
	// Modified by: Costas Manousakis-(Designer)-(5/27/16 11:42:19)
	Mods_2016_05_bug
	//  `Fixed item 28 under to point to RailInfo Tracks Under
	// Modified by: Costas Manousakis-(Designer)-(10/7/16 15:46:04)
	Mods_2016_10
	//  `Fixed label for CommuterRtg 286K car
	// Modified by: Costas Manousakis-(Designer)-(10/11/16 17:43:59)
	Mods_2016_10
	//  `Added 315K label and fields in "CommutRtg_@" group
	// Modified by: Costas Manousakis-(Designer)-(12/2/19 15:34:45)
	Mods_2019_12
	//  `Added ES44AC label and fields in "CommutRtg_@" group
	// Modified by: Costas Manousakis-(Designer)-(7/7/20 16:09:57)
	Mods_2020_07_bug
	//  `Replaced 263K lalbels and ratings on page 7 with HSP-46 data
	// Modified by: Costas Manousakis-(Designer)-(2021-10-26 10:11:40)
	Mods_2021_10_bug
	//  `fixed wrong var for item 39
	// Modified by: Costas Manousakis-(Designer)-(2021-10-29T00:00:00 10:37:19)
	Mods_2021_10_bug
	//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - requested by D. NG 10/19/2021
	// Modified by: Costas Manousakis-(Designer)-(2022-03- 18:58:52)
	Mods_2022_03
	//  `added two Revenue cars
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
	
	vDate:=Current date:C33(*)
	sFHWASelect:=f_Boolean2String([Bridge MHD NBIS:1]FHWA Select:4; "YN")
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
	
	SIA_BridgeRankOM
	SIA_RRVariableUtil("INIT")
	SIA_RRVariableUtil("LOAD")
	
	C_TEXT:C284($RecordType_txt)
	$RecordType_txt:=mbta_ReturnBridgeType
	OBJECT SET VISIBLE:C603(*; "@CommutRtg_@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "@TransitRtg_@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "@HWYRtg_@"; False:C215)
	Case of 
		: ($RecordType_txt="Transit@")
			OBJECT SET VISIBLE:C603(*; "@TransitRtg_@"; True:C214)
			
		: ($RecordType_txt="Commuter@")
			OBJECT SET VISIBLE:C603(*; "@CommutRtg_@"; True:C214)
			
		: ($RecordType_txt="Highway@")
			OBJECT SET VISIBLE:C603(*; "@HWYRtg_@"; True:C214)
			
		Else 
			
	End case 
	
End if 