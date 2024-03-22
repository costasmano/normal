//Method: [BridgeMHDNBISArchive];"RailTransitSIA"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/30/18, 16:47:30
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
	// Modified by: Costas Manousakis-(Designer)-(12/2/19 15:37:33)
	Mods_2019_12
	//  `Added ES44AC label and fields in "CommutRtg_@" group
	// Modified by: Costas Manousakis-(Designer)-(2021-10-26 10:11:40)
	Mods_2021_10_bug
	//  `fixed wrong var for item 39
	// Modified by: Costas Manousakis-(Designer)-(2021-10-29T00:00:00 10:37:19)
	Mods_2021_10_bug
	//  `changed labels for HWYRTGs to TBusA, TBusB, TBusC - reuquested by D. NG 10/19/2021
End if 
//

If (Form event code:C388=On Printing Detail:K2:18)
	READ ONLY:C145([RAILBridgeInfo:37])
	QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[BridgeMHDNBISArchive:139]BIN:3)
	C_TEXT:C284(sFHWASelect)  // old C_STRING length 1
	C_TEXT:C284(sItem12)  // old C_STRING length 1
	C_TEXT:C284(sItem35)  // old C_STRING length 1
	C_TEXT:C284(sItem112)  // old C_STRING length 1
	C_TEXT:C284(sItem104)  // old C_STRING length 1
	C_TEXT:C284(sItem103)  // old C_STRING length 1
	C_TEXT:C284(sItem110)  // old C_STRING length 1
	C_TEXT:C284(sItem92A)  // old C_STRING length 1
	C_TEXT:C284(sItem92B)  // old C_STRING length 1
	C_TEXT:C284(sItem92C)  // old C_STRING length 1
	C_TEXT:C284(sCritInsp)  // old C_STRING length 1
	C_TEXT:C284(sClosedInsp)  // old C_STRING length 1
	C_TEXT:C284(sUWSpInsp)  // old C_STRING length 1
	C_TEXT:C284(sAntiM)  // old C_STRING length 1
	C_TEXT:C284(sJointLess)  // old C_STRING length 1
	C_TEXT:C284(sAcrow)  // old C_STRING length 1
	C_TEXT:C284(sPageof)  // old C_STRING length 20
	
	G_SIA_BuildTownLine
	
	vDate:=Current date:C33(*)
	sFHWASelect:=f_Boolean2String([BridgeMHDNBISArchive:139]FHWA Select:4; "YN")
	sItem12:=f_Boolean2String([BridgeMHDNBISArchive:139]Item12:193; "YN")
	sItem35:=f_Boolean2String([BridgeMHDNBISArchive:139]Item35:100; "YN")
	sItem112:=f_Boolean2String([BridgeMHDNBISArchive:139]Item112:117; "YN")
	sItem104:=f_Boolean2String([BridgeMHDNBISArchive:139]Item104:118; "YN")
	sItem103:=f_Boolean2String([BridgeMHDNBISArchive:139]Item103:123; "YN")
	sItem110:=f_Boolean2String([BridgeMHDNBISArchive:139]Item110:124; "YN")
	sItem92A:=f_Boolean2String([BridgeMHDNBISArchive:139]Item92AA:162; "YN")
	sItem92B:=f_Boolean2String([BridgeMHDNBISArchive:139]Item92BA:164; "YN")
	sItem92C:=f_Boolean2String([BridgeMHDNBISArchive:139]Item92CA:166; "YN")
	sCritInsp:=f_Boolean2String([BridgeMHDNBISArchive:139]OtherInsp:42; "YN")
	sClosedInsp:=f_Boolean2String([BridgeMHDNBISArchive:139]ClosedInsp:45; "YN")
	sUWSpInsp:=f_Boolean2String([BridgeMHDNBISArchive:139]UWSpInsp:209; "YN")
	sAntiM:=f_Boolean2String([BridgeMHDNBISArchive:139]AntiMissile:26; "YN")
	sJointLess:=f_Boolean2String([BridgeMHDNBISArchive:139]JointlessBridge:175; "YN")
	sAcrow:=f_Boolean2String([BridgeMHDNBISArchive:139]Acrow Panel:28; "YN")
	C_TEXT:C284(sMissingSigns)  // old C_STRING length 1
	C_TEXT:C284(sMissingSignstext)
	sMissingSignstext:=[BridgeMHDNBISArchive:139]MissSignsDesc:221
	sMissingSigns:=f_Boolean2String([BridgeMHDNBISArchive:139]MissSigns:220; "YN")
	
	
	ARCH_Utils("Rank")
	
	//SIA_RRVariableUtil ("INIT")
	ARCH_Utils("INITRRVARS")
	//SIA_RRVariableUtil ("LOAD")
	ARCH_Utils("LOADRRVARS")
	
	C_TEXT:C284($RecordType_txt)
	$RecordType_txt:=mbta_ReturnBridgeType([BridgeMHDNBISArchive:139]Item8 BridgeCat:204)
	
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
//End [BridgeMHDNBISArchive];"RailTransitSIA"