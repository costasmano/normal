If (False:C215)
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(11/28/07 08:52:43)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(5/14/08 10:03:02)
	Mods_2008_CM_5403
	//Added rank object and method
	// Modified by: costasmanousakis-(Designer)-(10/31/08 11:02:52)
	Mods_2008_CM_5404
	//  ``Added display of RPCs names for the current record
	Mods_2011_10  // CJ Miller`10/04/11, 12:50:56      ` remove references to
	//`[Bridge MHD NBIS]Year Rehab'YearReh
	// Modified by: Costas Manousakis-(Designer)-(10/12/17 14:42:15)
	Mods_2017_10
	//  `Removed var sFHWASelect from form; renamed text label to FHWASelect;
	//  //use method SIA_LoadSelectionListInfo to get dates and update the text label 
	// Modified by: Costas Manousakis-(Designer)-(2021-10-21T00:00:00 17:00:27)
	Mods_2021_10
	//  `Added stairs on/adjacent info in Misc. - adjusted location of objects in Accessibility and Comments
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	C_TEXT:C284(sFHWASelect; sFHWARecord; sComplexBridge; sInspWaiver; sOvrhead; sAntiM)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sJointLess; sAcrow)  // Command Replaced was o_C_STRING length was 1
	C_DATE:C307(vDate)
	
	G_SIA_BuildTownLine
	vDate:=Current date:C33(*)
	C_DATE:C307($FhwaSelDate_d; $BMSLoadDate_d)
	SIA_LoadSelectionListInfo(->$FhwaSelDate_d; ->$BMSLoadDate_d)
	sFHWASelect:=Choose:C955([Bridge MHD NBIS:1]FHWA Select:4; "Y"; "N")+" ("+String:C10($FhwaSelDate_d)+")"
	OBJECT SET TITLE:C194(*; "FHWASelect"; "FHWA Select List= "+sFHWASelect)
	sFHWARecord:=f_Boolean2String([Bridge MHD NBIS:1]FHWARecord:174; "YN")
	sComplexBridge:=f_Boolean2String([Bridge MHD NBIS:1]Complex Bridge:178; "YN")
	sInspWaiver:=f_Boolean2String([Bridge MHD NBIS:1]InspWaiver:48; "YN")
	sOvrhead:=f_Boolean2String([Bridge MHD NBIS:1]OvrHeadSigns:184; "YN")
	sAntiM:=f_Boolean2String([Bridge MHD NBIS:1]AntiMissile:26; "YN")
	sJointLess:=f_Boolean2String([Bridge MHD NBIS:1]JointlessBridge:176; "YN")
	sAcrow:=f_Boolean2String([Bridge MHD NBIS:1]Acrow Panel:28; "YN")
	
	SIA_AccessibilityPrint
	
	C_LONGINT:C283(yearpainted; yearrehab)  //Command Replaced was o_C_INTEGER
	yearpainted:=0
	yearrehab:=0
	
	//added to get the Recommended Posting values from the [RatingReports] table
	G_SIA_GetRecPostings
	SIA_BridgeRankOM
	C_TEXT:C284(SIA_RPCs_txt)
	SIA_RPCs_txt:=QR_RPCNames
	
	READ ONLY:C145([Inspections:27])
	QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
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
	
	C_POINTER:C301($stairum_ptr; $stairowner_ptr)
	$stairum_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "NumStairsOn")
	$stairowner_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "StairOwners")
	C_OBJECT:C1216($StairInfo_o)
	$StairInfo_o:=QR_GetBridgeStairsInfo
	$stairum_ptr->:=OB Get:C1224($StairInfo_o; "count"; Is longint:K8:6)
	$stairowner_ptr->:=OB Get:C1224($StairInfo_o; "owners"; Is text:K8:3)
	
	READ WRITE:C146([Inspections:27])
End if 