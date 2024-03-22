If (False:C215)
	//Form Method: [Bridge MHD NBIS]TunnelSIA 
	//Copied from Form Method: [Bridge MHD NBIS]SI & A (Insp) 
	// Modified by: Costas Manousakis-(Designer)-(4/24/13 12:58:34)
	Mods_2013_04
	//  `
	// Modified by: Costas Manousakis-(Designer)-(9/6/13 14:29:28)
	Mods_2013_09
	//  `Removed un needed inspection fields  added new ones
	// Modified by: Costas Manousakis-(Designer)-(6/27/17 16:56:21)
	Mods_2017_06_bug
	//  `<>aFreezeThawDesc can be a text array
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
	vChemicalAnchors:=f_Boolean2String([TunnelInfo:151]ChemicalAnchors_b:5; "YN")
	
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
End if 