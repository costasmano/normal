//%attributes = {"invisible":true}
//Method: NTI_OpenInspection
//Description
// Open the current TIN Inspections
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/26/16, 11:32:24
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(2/2/17 15:10:41)
	Mods_2017_02
	//  `add code to load corresponding [NTI_TunnelInfo] record when in  RO mode
	// Modified by: Costas Manousakis-(Designer)-(12/20/18 11:53:32)
	Mods_2018_12_bug
	//  `make sure inspection record is loaded in RO when exiting method.
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 14:41:42)
	
End if 
//
C_BOOLEAN:C305($Edit_b)
$Edit_b:=NTI_InspectionPermission

C_LONGINT:C283($Width_L; $Height_L; $Choice_L)
FORM SET INPUT:C55([TIN_Inspections:184]; "Input")
FORM GET PROPERTIES:C674([TIN_Inspections:184]; "Input"; $Width_L; $Height_l)
//save RO state of [TIN_Inspections]
C_BOOLEAN:C305($ROState_b)
$ROState_b:=Read only state:C362([TIN_Inspections:184])

If ($Edit_b)
	$Choice_L:=ut_LoadRecordInteractiveV2(->[TIN_Inspections:184])
Else 
	$Choice_L:=2
End if 
C_TEXT:C284($vsSaveForward)
C_BOOLEAN:C305(vbInspectionLocked)
$vsSaveForward:=vsForward
//change Forward address per district       

//If (Structure file="MHD BMS External@")
//If (Num([NTI_TunnelInfo]NTI_i6_s)#0)
//vsForward:="District "+String(Num([NTI_TunnelInfo]NTI_i6_s))+" BMS"
//End if 
//End if 

Case of 
	: ($Choice_L=1)
		ut_SetReadWrite("Write"; ->[TIN_Insp_Images:186]; ->[TIN_Insp_TmMembers:187]; ->[NTI_ELEM_TIN_INSP:185])
		vbInspectionLocked:=False:C215
		vsForward:=Synch_ReturnForward([NTI_TunnelInfo:181]NTI_i6_s:11; [NTI_TunnelInfo:181]NTI_InspResp:73; ""; [TIN_Inspections:184]TeamLeader:11)
		
		MODIFY RECORD:C57([TIN_Inspections:184])
		ut_SetReadWrite("Read"; ->[TIN_Insp_Images:186]; ->[TIN_Insp_TmMembers:187]; ->[NTI_ELEM_TIN_INSP:185])
		UNLOAD RECORD:C212([TIN_Insp_Images:186])
		UNLOAD RECORD:C212([TIN_Insp_TmMembers:187])
		UNLOAD RECORD:C212([NTI_ELEM_TIN_INSP:185])
		
	: ($Choice_L=2)
		vbInspectionLocked:=True:C214
		READ ONLY:C145([TIN_Inspections:184])
		ut_SetReadWrite("read"; ->[TIN_Insp_Images:186]; ->[TIN_Insp_TmMembers:187]; ->[NTI_ELEM_TIN_INSP:185])
		UNLOAD RECORD:C212([TIN_Insp_Images:186])
		LOAD RECORD:C52([TIN_Inspections:184])
		If ([NTI_TunnelInfo:181]NTI_i1_s:6#[TIN_Inspections:184]NTI_i1_S:1)
			//tunnel record not loaded -
			C_BOOLEAN:C305($AutoOne_b; $AutoMany_b)
			GET AUTOMATIC RELATIONS:C899($AutoOne_b; $AutoMany_b)
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			READ ONLY:C145([NTI_TunnelInfo:181])
			QUERY:C277([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i1_s:6=[TIN_Inspections:184]NTI_i1_S:1)
			LOAD RECORD:C52([NTI_TunnelInfo:181])
			SET AUTOMATIC RELATIONS:C310($AutoOne_b; $AutoMany_b)
		End if 
		DIALOG:C40([TIN_Inspections:184]; "Input")
End case 

vsForward:=$vsSaveForward
If ($ROState_b)
	//restore it and make sure record is loaded RO
	READ ONLY:C145([TIN_Inspections:184])
	UNLOAD RECORD:C212([TIN_Inspections:184])
	LOAD RECORD:C52([TIN_Inspections:184])
	
End if 
//End NTI_OpenInspection