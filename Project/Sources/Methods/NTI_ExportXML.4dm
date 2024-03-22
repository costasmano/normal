//%attributes = {"invisible":true}
//Method: NTI_ExportXML
//Description
//Export [NTI_TunnelInfo] records in XML format
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 11/05/15, 15:17:09
	//----------------------------------------------------
	Mods_2015_10  // 
	//Modified by: administrator (11/5/15 15:17:11)
	// Modified by: Costas Manousakis-(Designer)-(3/29/17 15:38:55)
	Mods_2017_03
	//  `added choise for design user to consider approved,complete or any inspection found
	// Modified by: Costas Manousakis-(Designer)-(3/31/17 13:39:30)
	Mods_2017_03
	//  `Added option to export NTI only or NTI + NTEs
	// Modified by: Costas Manousakis-(Designer)-(2/11/19 14:35:40)
	Mods_2019_02_bug
	//  `Change varname for export nte optios to NTI_FHWAExportOpt_txt from FHWAITEM8_txt
	//  `Ask for the option only when exporting NTEs
	// Modified by: Costas Manousakis-(Designer)-(3/29/19 14:54:48)
	Mods_2019_03
	//  `changed prompts for type of export and inspection status to dynamic menu
	// Modified by: Costas Manousakis-(Designer)-(2022-03-21 10:47:01)
	Mods_2022_03
	//  `allow personnel group NTI_Administrators to choose status of inspections
	// Modified by: Costas Manousakis-(Designer)-(2023-11-13 10:07:10)
	Mods_2023_11
	//  `added option to menu to export GeoJSON file from current list of structures
End if 


C_BLOB:C604($templatexml_blb; $xmlexport_blb)
C_TEXT:C284($templVers_txt; $TemplName_txt)
$templVers_txt:=Substring:C12(Application version:C493; 1; 2)
If ($templVers_txt#"11")
	$templVers_txt:="13"  // for 4D > v11 use the v13 template
End if 
ARRAY TEXT:C222($MenuChoise_atxt; 0)
ARRAY TEXT:C222($MenuCmd_atxt; 0)
APPEND TO ARRAY:C911($MenuChoise_atxt; "Export only NTI Info")
APPEND TO ARRAY:C911($MenuCmd_atxt; "NTI")

If (User in group:C338(Current user:C182; "Design Access Group") | (GRP_UserInGroup("NTI_Administrators")=1))
	APPEND TO ARRAY:C911($MenuChoise_atxt; "Export NTI w/ NTE Elements\\Use Approved Inspections")
	APPEND TO ARRAY:C911($MenuCmd_atxt; "NTINTE-APPROVED")
	APPEND TO ARRAY:C911($MenuChoise_atxt; "Export NTI w/ NTE Elements\\Use Completed Inspections")
	APPEND TO ARRAY:C911($MenuCmd_atxt; "NTINTE-COMPLETED")
	APPEND TO ARRAY:C911($MenuChoise_atxt; "Export NTI w/ NTE Elements\\Use Any Inspections")
	APPEND TO ARRAY:C911($MenuCmd_atxt; "NTINTE-ANY")
	
Else 
	APPEND TO ARRAY:C911($MenuChoise_atxt; "Export NTI w/ NTE Elements")
	APPEND TO ARRAY:C911($MenuCmd_atxt; "NTINTE")
End if 
//start of Mods_2023_11
APPEND TO ARRAY:C911($MenuChoise_atxt; "Create a GeoJSON file for use with GeoDOT apps")
APPEND TO ARRAY:C911($MenuCmd_atxt; "GEOJSON")
//end of Mods_2023_11

C_TEXT:C284($menuRef_txt; $menuSelected_txt)
$menuRef_txt:=MENU_BuildMenuFromArrays(->$MenuChoise_atxt; ->$MenuCmd_atxt; "\\")
$menuSelected_txt:=Dynamic pop up menu:C1006($menuRef_txt)
RELEASE MENU:C978($menuRef_txt)
$TemplName_txt:=""
C_TEXT:C284(NTI_FHWAExportOpt_txt)
NTI_FHWAExportOpt_txt:="APPROVED"

Case of 
	: ($menuSelected_txt="NTI")
		$TemplName_txt:="TINXML_v"
		
	: ($menuSelected_txt="NTINTE")
		$TemplName_txt:="TINNTEXML_v"
		
	: ($menuSelected_txt="NTINTE-APPROVED")
		$TemplName_txt:="TINNTEXML_v"
		NTI_FHWAExportOpt_txt:="APPROVED"
		
	: ($menuSelected_txt="NTINTE-COMPLETED")
		$TemplName_txt:="TINNTEXML_v"
		NTI_FHWAExportOpt_txt:="COMPLETED"
		
	: ($menuSelected_txt="NTINTE-ANY")
		$TemplName_txt:="TINNTEXML_v"
		NTI_FHWAExportOpt_txt:="ANY"
		
End case 

Case of 
	: ($TemplName_txt="")
		
		Case of 
				//start of Mods_2023_11
			: ($menuSelected_txt="GEOJSON")
				MAP_BuildTunnelGeoJSON
		End case 
		//end of Mods_2023_11
		
	: (Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+"TIN"+<>PL_DirectorySep_s+$TemplName_txt+$templVers_txt+".xml")=Is a document:K24:1)
		DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+"TIN"+<>PL_DirectorySep_s+$TemplName_txt+$templVers_txt+".xml"; $templatexml_blb)
		C_LONGINT:C283($numrecs_L)
		CONFIRM:C162("Work with current list of Tunnel Information ("+String:C10(Records in selection:C76([NTI_TunnelInfo:181]))+") or New Query?"; "Current"; "New")
		If (OK=1)
		Else 
			QUERY:C277([NTI_TunnelInfo:181])
		End if 
		
		If (OK=1)
			If (Records in selection:C76([NTI_TunnelInfo:181])>0)
				
				CONFIRM:C162("exporting "+String:C10(Records in selection:C76([NTI_TunnelInfo:181]))+" records!"; "Continue?"; "Cancel")
				If (OK=1)
					
					ARRAY LONGINT:C221(v_182_004_aL; 0)
					ARRAY LONGINT:C221(v_182_013_aL; 0)
					ARRAY TEXT:C222(v_182_016_atxt; 0)
					READ ONLY:C145([NTI_ELEM_DEFS:182])
					READ ONLY:C145([NTI_ELEM_TIN_INSP:185])
					READ ONLY:C145([TIN_Inspections:184])
					READ ONLY:C145([NTI_TunnelInfo:181])
					NTI_INIT
					ALL RECORDS:C47([NTI_ELEM_DEFS:182])
					//load these for use in NTI_LoadExportArrays called from the XML template
					SELECTION TO ARRAY:C260([NTI_ELEM_DEFS:182]ELEM_KEY:4; v_182_004_aL; [NTI_ELEM_DEFS:182]REPORTED:16; v_182_016_atxt; [NTI_ELEM_DEFS:182]ELEM_SUBSET_KEY:13; v_182_013_aL)
					
					SHORT_MESSAGE("Exporting....")
					C_TIME:C306($start_t; $end_t; $duration_t)
					$start_t:=Current time:C178(*)
					// for each TIN method NTI_XMLScript is called and NTI_LoadExportArrays is called to create the NTE element arrays
					PROCESS 4D TAGS:C816($templatexml_blb; $xmlexport_blb)
					CLOSE WINDOW:C154
					$end_t:=Current time:C178(*)
					ALERT:C41("Duration : "+String:C10($end_t-$start_t))
					C_TIME:C306($export_t)
					$export_t:=Create document:C266(""; ".xml")
					
					If (OK=1)
						C_TEXT:C284($export_txt)
						$export_txt:=document
						CLOSE DOCUMENT:C267($export_t)
						BLOB TO DOCUMENT:C526($export_txt; $xmlexport_blb)
						ALERT:C41("Saved document "+$export_txt)
						SHOW ON DISK:C922($export_txt; *)
					End if 
				End if 
				
			Else 
				ALERT:C41("No Records selected!")
			End if 
			
		End if 
		
	Else 
		ALERT:C41("Template TINXML_v"+$templVers_txt+".xml not found in the TIN folder of Resources!")
		
End case 

//End NTI_ExportXML