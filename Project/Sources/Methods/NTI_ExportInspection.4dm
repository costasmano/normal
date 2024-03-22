//%attributes = {"invisible":true}
//Method: NTI_ExportInspection
//Description
//  export the current 1st record in  [tin_inspections]
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/27/16, 09:23:08
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(3/27/18 11:57:12)
	Mods_2018_03
	//  `added [TIN_Insp_Comments] table
	// Modified by: Costas Manousakis-(Designer)-(4/6/18 12:50:35)
	Mods_2018_04
	//  `do not use set ListboxSet0; record should be loaded already from the calling method
	//  `save named selection of images, tmmembers, comments, NTI_elements always
	
End if 
//

C_BOOLEAN:C305($vExport)
COPY NAMED SELECTION:C331([TIN_Inspections:184]; "$PreExportSelection")
//USE SET("ListboxSet0")
If (Not:C34(Is record loaded:C669([TIN_Inspections:184])))
	GOTO SELECTED RECORD:C245([TIN_Inspections:184]; 1)  //get the 1st one on the llst
	LOAD RECORD:C52([TIN_Inspections:184])
Else 
End if 
CONFIRM:C162("Export current inspection (Type "+[TIN_Inspections:184]InspType:21+" TIN "+[TIN_Inspections:184]NTI_i1_S:1+" Date "+String:C10([TIN_Inspections:184]InspDate:3)+") ?")
$vExport:=(OK=1)
If ($vExport)
	
	CUT NAMED SELECTION:C334([TIN_Insp_Images:186]; "INSPEXP_IMGSEL")
	CUT NAMED SELECTION:C334([TIN_Insp_TmMembers:187]; "INSPEXP_FLDTRIPSEL")
	CUT NAMED SELECTION:C334([NTI_ELEM_TIN_INSP:185]; "INSPEXP_NTESEL")
	CUT NAMED SELECTION:C334([TIN_Insp_Comments:188]; "INSPEXP_CMTSSEL")
	
	C_TEXT:C284($ExportFile; $ExportHeader; $TargetDir)
	C_LONGINT:C283($NumTeam_L; $NumElmts_L; $NumPhotos_L; $NumPontisElmt_L; $NumPontisTm_L; $i; $InspID_L)
	$InspID_L:=[TIN_Inspections:184]InspectionID:2  // save it because the element sort unloads the insp record
	
	$ExportFile:="Insp_"+[TIN_Inspections:184]NTI_i1_S:1+"_"+[TIN_Inspections:184]InspType:21+"_"+String:C10([TIN_Inspections:184]InspDate:3)+\
		"_"+String:C10($InspID_L)+".export"
	$ExportFile:=Replace string:C233($ExportFile; "/"; "_")
	$TargetDir:=Select folder:C670("Select folder for Export file")
	SET CHANNEL:C77(10; $TargetDir+$ExportFile)  //Open a channel for a document
	$ExportHeader:="TINInspectionExport"
	SEND VARIABLE:C80($ExportHeader)
	SEND RECORD:C78([TIN_Inspections:184])
	QUERY:C277([TIN_Insp_TmMembers:187]; [TIN_Insp_TmMembers:187]InspectionID:1=$InspID_L)
	$NumTeam_L:=Records in selection:C76([TIN_Insp_TmMembers:187])
	SEND VARIABLE:C80($NumTeam_L)
	
	For ($i; 1; $NumTeam_L)  //team members
		GOTO SELECTED RECORD:C245([TIN_Insp_TmMembers:187]; $i)
		LOAD RECORD:C52([TIN_Insp_TmMembers:187])
		SEND RECORD:C78([TIN_Insp_TmMembers:187])
	End for 
	
	QUERY:C277([TIN_Insp_Images:186]; [TIN_Insp_Images:186]InspectionID:1=$InspID_L)
	$NumPhotos_L:=Records in selection:C76([TIN_Insp_Images:186])
	SEND VARIABLE:C80($NumPhotos_L)
	For ($i; 1; $NumPhotos_L)  //images
		GOTO SELECTED RECORD:C245([TIN_Insp_Images:186]; $i)
		LOAD RECORD:C52([TIN_Insp_Images:186])
		SEND RECORD:C78([TIN_Insp_Images:186])
	End for 
	
	C_LONGINT:C283($NBES_L)
	QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=$InspID_L)
	ORDER BY FORMULA:C300([NTI_ELEM_TIN_INSP:185]; NTI_ElemSort_TIN)
	$NBES_L:=Records in selection:C76([NTI_ELEM_TIN_INSP:185])
	SEND VARIABLE:C80($NBES_L)
	
	For ($i; 1; $NBES_L)  //NTEs
		GOTO SELECTED RECORD:C245([NTI_ELEM_TIN_INSP:185]; $i)
		LOAD RECORD:C52([NTI_ELEM_TIN_INSP:185])
		SEND RECORD:C78([NTI_ELEM_TIN_INSP:185])
	End for 
	
	C_LONGINT:C283($NBES_L)
	QUERY:C277([TIN_Insp_Comments:188]; [TIN_Insp_Comments:188]InspectionID:1=$InspID_L)
	$NBES_L:=Records in selection:C76([TIN_Insp_Comments:188])
	SEND VARIABLE:C80($NBES_L)
	
	For ($i; 1; $NBES_L)  //Comments
		GOTO SELECTED RECORD:C245([TIN_Insp_Comments:188]; $i)
		LOAD RECORD:C52([TIN_Insp_Comments:188])
		SEND RECORD:C78([TIN_Insp_Comments:188])
	End for 
	
	SET CHANNEL:C77(11)  //close file
	
	USE NAMED SELECTION:C332("INSPEXP_IMGSEL")
	USE NAMED SELECTION:C332("INSPEXP_FLDTRIPSEL")
	USE NAMED SELECTION:C332("INSPEXP_NTESEL")
	USE NAMED SELECTION:C332("INSPEXP_CMTSSEL")
	
	ALERT:C41("Created Export file "+Document)
End if 

USE NAMED SELECTION:C332("$PreExportSelection")
CLEAR NAMED SELECTION:C333("$PreExportSelection")

//End NTI_ExportInspection