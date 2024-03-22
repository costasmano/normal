//%attributes = {"invisible":true}
// Method: Method: INSP_ExportInspection
// Description
// Export the current inspection into a binary file.
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/18/05, 09:17:56
	// ----------------------------------------------------
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(5/19/2006 15:49:50)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 08:36:11)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(10/30/13 16:34:38)
	Mods_2013_10
	//  `Expanded export to the Tunnelinspection table - if it exists
	// Modified by: Costas Manousakis-(Designer)-(4/16/14 17:25:11)
	Mods_2014_04
	//  `added export of  [ElmtRatingLoads]
	// Modified by: Costas Manousakis-(Designer)-(4/15/15 17:17:30)
	Mods_2015_04
	//  `added export of NBEs
	// Modified by: Costas Manousakis-(Designer)-(2/10/16 09:54:50)
	Mods_2016_02_bug
	//  `remove  Clear Selection at end - not needed because they were  CUT at the beginning
	// Modified by: Costas Manousakis-(Designer)-(6/22/16 09:11:49)
	Mods_2016_NTE
	//  `added export of NTEs
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 16:47:16)
	Mods_2016_08_bug
	//  `added check if this is run not in the context of an input form
	// Modified by: Costas Manousakis-(Designer)-(6/17/20)
	Mods_2020_06
	//  `add BDEPT to name of export, made date YYYY_MM_DD
End if 

C_BOOLEAN:C305($vExport)
If (Not:C34(Is record loaded:C669([Inspections:27])))
	GOTO SELECTED RECORD:C245([Inspections:27]; 1)  //get the 1st one on the llst
	LOAD RECORD:C52([Inspections:27])
Else 
End if 
CONFIRM:C162("Export current inspection (Type "+[Inspections:27]Insp Type:6+" BIN "+[Inspections:27]BIN:1+" Date "+String:C10([Inspections:27]Insp Date:78)+") ?")
$vExport:=(OK=1)
If ($vExport)
	C_TEXT:C284($VarName_txt)
	C_LONGINT:C283($Table_L; $Field_L)
	RESOLVE POINTER:C394(Current form table:C627; $VarName_txt; $Table_L; $Field_L)
	If ($Table_L>0)
		If (Table:C252(Current form table:C627)=Table:C252(->[Inspections:27]))
			CUT NAMED SELECTION:C334([ElementsSafety:29]; "INSPEXP_ELMTSEL")
			CUT NAMED SELECTION:C334([Standard Photos:36]; "INSPEXP_IMGSEL")
			CUT NAMED SELECTION:C334([Field Trip:43]; "INSPEXP_FLDTRIPSEL")
			CUT NAMED SELECTION:C334([PON_ELEM_INSP:179]; "INSPEXP_NBESEL")
			CUT NAMED SELECTION:C334([NTI_ELEM_BIN_INSP:183]; "INSPEXP_NTESEL")
		End if 
	End if 
	
	C_TEXT:C284($ExportFile; $ExportHeader; $TargetDir)
	C_LONGINT:C283($NumTeam_L; $NumElmts_L; $NumPhotos_L; $NumPontisElmt_L; $NumPontisTm_L; $i)
	$ExportFile:="Insp_"+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Inspections:27]BIN:1+"_"+[Inspections:27]Insp Type:6+"_"+\
		String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")+"_"+\
		String:C10(Month of:C24([Inspections:27]Insp Date:78); "00")+"_"+\
		String:C10(Day of:C23([Inspections:27]Insp Date:78); "00")+".export"
	$ExportFile:=Replace string:C233($ExportFile; "/"; "_")
	$TargetDir:=Select folder:C670("Select folder for Export file")
	SET CHANNEL:C77(10; $TargetDir+$ExportFile)  //Open a channel for a document
	$ExportHeader:="InspectionExport"
	SEND VARIABLE:C80($ExportHeader)
	SEND RECORD:C78([Inspections:27])
	QUERY:C277([Field Trip:43]; [Field Trip:43]InspID:1=[Inspections:27]InspID:2)
	$NumTeam_L:=Records in selection:C76([Field Trip:43])
	SEND VARIABLE:C80($NumTeam_L)
	
	For ($i; 1; $NumTeam_L)
		GOTO SELECTED RECORD:C245([Field Trip:43]; $i)
		LOAD RECORD:C52([Field Trip:43])
		SEND RECORD:C78([Field Trip:43])
	End for 
	QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
	$NumElmts_L:=Records in selection:C76([ElementsSafety:29])
	SEND VARIABLE:C80($NumElmts_L)
	For ($i; 1; $NumElmts_L)
		GOTO SELECTED RECORD:C245([ElementsSafety:29]; $i)
		LOAD RECORD:C52([ElementsSafety:29])
		SEND RECORD:C78([ElementsSafety:29])
	End for 
	QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2)
	$NumPhotos_L:=Records in selection:C76([Standard Photos:36])
	SEND VARIABLE:C80($NumPhotos_L)
	For ($i; 1; $NumPhotos_L)
		GOTO SELECTED RECORD:C245([Standard Photos:36]; $i)
		LOAD RECORD:C52([Standard Photos:36])
		SEND RECORD:C78([Standard Photos:36])
	End for 
	QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
	C_LONGINT:C283($BMSInspID_L)
	$BMSInspID_L:=[Combined Inspections:90]BMSInspID:3
	If ([Combined Inspections:90]BMSInspID:3>0)
		//send Pontis
		QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
		If (Records in selection:C76([BMS Inspections:44])=1)
			SEND VARIABLE:C80($BMSInspID_L)  //send this as marker
			LOAD RECORD:C52([BMS Inspections:44])
			SEND RECORD:C78([BMS Inspections:44])
			QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
			$NumElmts_L:=Records in selection:C76([Cond Units:45])
			SEND VARIABLE:C80($NumElmts_L)
			For ($i; 1; $NumElmts_L)
				GOTO SELECTED RECORD:C245([Cond Units:45]; $i)
				LOAD RECORD:C52([Cond Units:45])
				SEND RECORD:C78([Cond Units:45])
			End for 
			QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[BMS Inspections:44]Inspection ID:1)
			$NumTeam_L:=Records in selection:C76([BMS Field Trip:56])
			SEND VARIABLE:C80($NumTeam_L)
			For ($i; 1; $NumTeam_L)
				GOTO SELECTED RECORD:C245([BMS Field Trip:56]; $i)
				LOAD RECORD:C52([BMS Field Trip:56])
				SEND RECORD:C78([BMS Field Trip:56])
			End for 
			
		Else 
			$BMSInspID_L:=-1
			SEND VARIABLE:C80($BMSInspID_L)
		End if 
	Else 
		$BMSInspID_L:=-1  //set it to -1 for safety
		SEND VARIABLE:C80($BMSInspID_L)
	End if 
	
	LOAD RECORD:C52([Combined Inspections:90])
	SEND RECORD:C78([Combined Inspections:90])
	
	QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Combined Inspections:90]NBISInspID:2)
	C_LONGINT:C283($tunnelInspID_L)
	$tunnelInspID_L:=-1
	If (Records in selection:C76([TunnelInspection:152])=1)
		LOAD RECORD:C52([TunnelInspection:152])
		$tunnelInspID_L:=[TunnelInspection:152]TunnelInspID_L:15
		SEND VARIABLE:C80($tunnelInspID_L)
		SEND RECORD:C78([TunnelInspection:152])
	Else 
		SEND VARIABLE:C80($tunnelInspID_L)
	End if 
	
	QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
	ARRAY LONGINT:C221($ElmIds_aL; Records in selection:C76([ElementsSafety:29]))
	SELECTION TO ARRAY:C260([ElementsSafety:29]ElmSafetyID:7; $ElmIds_aL)
	QUERY WITH ARRAY:C644([ElmtRatingLoads:158]ElmSafetyID:2; $ElmIds_aL)
	C_LONGINT:C283($ElmRtgLoads_L)
	$ElmRtgLoads_L:=Records in selection:C76([ElmtRatingLoads:158])
	SEND VARIABLE:C80($ElmRtgLoads_L)
	
	For ($i; 1; $ElmRtgLoads_L)
		GOTO SELECTED RECORD:C245([ElmtRatingLoads:158]; $i)
		LOAD RECORD:C52([ElmtRatingLoads:158])
		SEND RECORD:C78([ElmtRatingLoads:158])
	End for 
	
	QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=[Inspections:27]InspID:2)
	ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_ElemSort)  //this must be sorted for input reasons.
	
	C_LONGINT:C283($NBES_L)
	$NBES_L:=Records in selection:C76([PON_ELEM_INSP:179])
	SEND VARIABLE:C80($NBES_L)
	
	For ($i; 1; $NBES_L)
		GOTO SELECTED RECORD:C245([PON_ELEM_INSP:179]; $i)
		LOAD RECORD:C52([PON_ELEM_INSP:179])
		SEND RECORD:C78([PON_ELEM_INSP:179])
	End for 
	
	QUERY:C277([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]INSPID:1=[Inspections:27]InspID:2)
	ORDER BY FORMULA:C300([NTI_ELEM_BIN_INSP:183]; NTI_ElemSort)
	$NBES_L:=Records in selection:C76([NTI_ELEM_BIN_INSP:183])
	SEND VARIABLE:C80($NBES_L)
	
	For ($i; 1; $NBES_L)
		GOTO SELECTED RECORD:C245([NTI_ELEM_BIN_INSP:183]; $i)
		LOAD RECORD:C52([NTI_ELEM_BIN_INSP:183])
		SEND RECORD:C78([NTI_ELEM_BIN_INSP:183])
	End for 
	
	SET CHANNEL:C77(11)  //close file
	
	If ($Table_L>0)
		If (Table:C252(Current form table:C627)=Table:C252(->[Inspections:27]))
			USE NAMED SELECTION:C332("INSPEXP_ELMTSEL")
			USE NAMED SELECTION:C332("INSPEXP_IMGSEL")
			USE NAMED SELECTION:C332("INSPEXP_FLDTRIPSEL")
			USE NAMED SELECTION:C332("INSPEXP_NBESEL")
			USE NAMED SELECTION:C332("INSPEXP_NTESEL")
		End if 
		
	End if 
	
	ALERT:C41("Created Export file "+Document)
End if 
