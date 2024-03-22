// ----------------------------------------------------
// User name (OS): costasmanousakis
// User name (4D): Designer
// Date and time: 10/18/11, 12:07:58
// ----------------------------------------------------
// Method: Form Method: MHD Specific Items
// Description
//  ` Copied from corresponding form in  [Bridge MHD NBIS]
// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(10/30/18 12:52:33)
	Mods_2018_10
	//  `Added single posting values
	
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	C_TEXT:C284(sFHWASelect; sFHWARecord; sComplexBridge; sInspWaiver; sOvrhead; sAntiM)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sJointLess; sAcrow)  // Command Replaced was o_C_STRING length was 1
	C_DATE:C307(vDate)
	
	//Need o version for Archivedtable  : G_SIA_BuildTownLine 
	ARCH_Utils("TOWNLINE")
	vDate:=Current date:C33(*)
	sFHWASelect:=f_Boolean2String([BridgeMHDNBISArchive:139]FHWA Select:4; "YN")
	sFHWARecord:=f_Boolean2String([BridgeMHDNBISArchive:139]FHWARecord:173; "YN")
	sComplexBridge:=f_Boolean2String([BridgeMHDNBISArchive:139]Complex Bridge:177; "YN")
	sInspWaiver:=f_Boolean2String([BridgeMHDNBISArchive:139]InspWaiver:48; "YN")
	sOvrhead:=f_Boolean2String([BridgeMHDNBISArchive:139]OvrHeadSigns:181; "YN")
	sAntiM:=f_Boolean2String([BridgeMHDNBISArchive:139]AntiMissile:26; "YN")
	sJointLess:=f_Boolean2String([BridgeMHDNBISArchive:139]JointlessBridge:175; "YN")
	sAcrow:=f_Boolean2String([BridgeMHDNBISArchive:139]Acrow Panel:28; "YN")
	
	
	//Need o version for Archivedtable : `  `SIA_AccessibilityPrint 
	ARCH_Utils("AccessibilityPrint")
	
	C_LONGINT:C283(yearpainted; yearrehab)  //Command Replaced was o_C_INTEGER
	yearpainted:=0
	yearrehab:=0
	
	//added to get the Recommended Posting values from the [RatingReports] table
	//Need o version for Archivedtable   : G_SIA_GetRecPostings 
	ARCH_Utils("RATINGS")
	
	//Need o version for Archivedtable   : SIA_BridgeRankOM 
	ARCH_Utils("RANK")
	
	C_TEXT:C284(SIA_RPCs_txt)
	//Need o version for Archivedtable   : SIA_RPCs_txt:=QR_RPCNames 
	SIA_RPCs_txt:=QR_RPCNames([BridgeMHDNBISArchive:139]BIN:3; [BridgeMHDNBISArchive:139]BDEPT:1)
	
	READ ONLY:C145([Inspections:27])
	QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[BridgeMHDNBISArchive:139]BIN:3)
	C_TEXT:C284(vsRatingPriority)  // Command Replaced was o_C_STRING length was 12
	vsRatingPriority:=""
	If (Records in selection:C76([Inspections:27])>0)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RT@"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL")
		ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
		REDUCE SELECTION:C351([Inspections:27]; 1)
		C_TEXT:C284(vsRatingPriority)  // Command Replaced was o_C_STRING length was 12
		vsRatingPriority:=""
		Case of 
			: ([Inspections:27]RatingPriority:85="H")
				vsRatingPriority:="High"
			: ([Inspections:27]RatingPriority:85="M")
				vsRatingPriority:="Medium"
			: ([Inspections:27]RatingPriority:85="L")
				vsRatingPriority:="Low"
		End case 
	End if 
	READ WRITE:C146([Inspections:27])
End if 