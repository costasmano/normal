If (False:C215)
	//Form Method: [Bridge MHD NBIS];"SI & A (Insp)"
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(3/28/2007 16:52:28)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 16:04:41)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/28/07 09:00:21)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(5/14/08 10:03:02)
	Mods_2008_CM_5403
	//Added rank object and method
	// Modified by: costasmanousakis-(Designer)-(11/1/10 15:30:41)
	Mods_2010_11
	//  `Adjusted alignment / height of some text labels, variables and fields; moved some labels to page 0; 
	//  `added the Other accessibility info on the Accessibility section
	// Modified by: Costas Manousakis-(Designer)-(2/22/12 10:27:30)
	Mods_2012_02
	//  `Fixed wrong field displayed for Accessibility Other
	// Modified by: Costas Manousakis-(Designer)-(3/21/12 13:49:46)
	Mods_2012_03
	//  `changed sMissingSignstext from A(30) to text
	// Modified by: Costas Manousakis-(Designer)-(10/14/15 10:32:37)
	Mods_2015_10_bug
	//  `Print MBTA  Rating Loads version; added HWYRTG@ objects ; named  previous to DOT_@
	// Modified by: Costas Manousakis-(Designer)-(6/2/16 11:57:49)
	Mods_2016_06_bug
	//  `Fixed wrong fields for HWY_Rtg@ objects
	// Modified by: Costas Manousakis-(Designer)-(6/27/17 16:54:46)
	Mods_2017_06_bug
	//  `<>aFreezeThawDesc can be a text array
	// Modified by: Costas Manousakis-(Designer)-(10/12/17 14:42:15)
	Mods_2017_10
	//  `Removed var sFHWASelect from form; renamed text label to FHWASelect;
	//  //use method SIA_LoadSelectionListInfo to get dates and update the text label 
	// Modified by: Costas Manousakis-(Designer)-(2021-10-20T00:00:00 17:46:25)
	Mods_2021_10
	//  `Added stairs on/adjacent info in Misc. - adjusted location of objects in Accessibility
	// Modified by: Costas Manousakis-(Designer)-(2021-10-29T00:00:00 10:37:19)
	Mods_2021_10_bug
	//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	C_TEXT:C284(item42a; item42b; item43a; item44a; sFHWASelect; sMissingSigns)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem12; sItem35; sItem112; sItem104; sItem103; sItem110; sItem92A; sItem92B)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem92C; sCritInsp; sClosedInsp; sUWSpInsp; sAntiM; sJointLess; sAcrow)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(item43b; item44b)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(vItem13)  // Command Replaced was o_C_STRING length was 12
	C_TEXT:C284(sPageof)  // Command Replaced was o_C_STRING length was 20
	C_TEXT:C284(vItem42a; vItem42b)  // Command Replaced was o_C_STRING length was 24
	C_TEXT:C284(vItem108c; vItem108b; vItem108a)  // Command Replaced was o_C_STRING length was 26
	C_TEXT:C284(vItem43a)  // Command Replaced was o_C_STRING length was 30
	C_TEXT:C284(sMissingSignstext)
	C_TEXT:C284(vItem38; vItem43b; vIntegral; vItem44a; vItem44b)  // Command Replaced was o_C_STRING length was 40
	C_TEXT:C284(vItem33)  // Command Replaced was o_C_STRING length was 42
	C_TEXT:C284(sFreezeThawList)  // Command Replaced was o_C_STRING length was 80
	sMissingSignstext:=[Bridge MHD NBIS:1]MissSignsDesc:224
	sMissingSigns:=f_Boolean2String([Bridge MHD NBIS:1]MissSigns:223; "YN")
	If ((Type:C295(<>aFreezeThawDesc)=String array:K8:15) | (Type:C295(<>aFreezeThawDesc)=Text array:K8:16))
		sFreezeThawList:=Get_Description(-><>aFreezeThawDesc; -><>aFreezeThawCode; ->[Bridge MHD NBIS:1]FreezeThaw:225)
	End if 
	
	SIA_Item107Desc
	
	vItem108a:=Get_Description(-><>aWearing; -><>aWearCod; ->[Bridge MHD NBIS:1]Item108A:80)
	vItem108b:=Get_Description(-><>aMembrane; -><>aMembCod; ->[Bridge MHD NBIS:1]Item108B:81)
	vItem108c:=Get_Description(-><>aDeckProt; -><>aDeckPCod; ->[Bridge MHD NBIS:1]Item108C:82)
	item42a:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 1; 1)
	vItem42a:=Get_Description(-><>aServiceOvr; -><>aSerOvrCode; ->item42a)
	item42b:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 2; 1)
	vItem42b:=Get_Description(-><>aServUndr; -><>aSerUndrCod; ->item42b)
	vItem33:=Get_Description(-><>aItem33des; -><>aItem33; ->[Bridge MHD NBIS:1]Item33:99)
	vItem38:=Get_Description(-><>aItem38des; -><>aItem38; ->[Bridge MHD NBIS:1]Item38:113)
	
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
	
	SIA_AccessibilityPrint
	vItem13:=[Bridge MHD NBIS:1]Item 13A:197+[Bridge MHD NBIS:1]Item 13B:198
	
	item43a:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)
	vItem43a:=Get_Description(-><>aMaterial; -><>aMatCode; ->item43a)
	
	item43b:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
	vItem43b:=Get_Description(-><>aDesign; -><>aDesignCod; ->item43b)
	
	vIntegral:=Get_Description(-><>aIntegralD; -><>aIntegralC; ->[Bridge MHD NBIS:1]JointlessType:202)
	
	item44a:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 1; 1)
	vItem44a:=Get_Description(-><>aDesign; -><>aDesignCod; ->item44a)
	
	item44b:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 2; 2)
	vItem44b:=Get_Description(-><>aDesign; -><>aDesignCod; ->item44b)
	
	//added to get the Recommended Posting values from the [RatingReports] table
	G_SIA_GetRecPostings
	SIA_BridgeRankOM
	OBJECT SET VISIBLE:C603(*; "HWYRTG@"; ([Bridge MHD NBIS:1]InspResp:173="MBTA"))
	OBJECT SET VISIBLE:C603(*; "DOT_@"; ([Bridge MHD NBIS:1]InspResp:173#"MBTA"))
	
	C_POINTER:C301($stairum_ptr; $stairowner_ptr)
	$stairum_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "NumStairsOn")
	$stairowner_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "StairOwners")
	C_OBJECT:C1216($StairInfo_o)
	$StairInfo_o:=QR_GetBridgeStairsInfo
	$stairum_ptr->:=OB Get:C1224($StairInfo_o; "count"; Is longint:K8:6)
	$stairowner_ptr->:=OB Get:C1224($StairInfo_o; "owners"; Is text:K8:3)
	
End if 