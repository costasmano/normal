//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/23/09, 10:48:35
	// ----------------------------------------------------
	// Method: DCM_CreateWorkOrder
	// Description
	// create the work order
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(3/7/11 09:00:31)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
	// Modified by: costasmanousakis-(Designer)-(4/11/11 17:39:43)
	Mods_2011_04
	//  `  `Define vDistrict:=String(Num(DCM_Project]District))
	Mods_2011_06  //r002 CJ Miller`06/03/11, 16:11:27      `Make vDistrict alpha 2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(6/29/21 12:57:57)
	Mods_2021_WP
	//  `
End if 
READ ONLY:C145([Templates:86])
QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_DistrMaintWorkOrder")
If (Records in selection:C76([Templates:86])=1)
	C_BLOB:C604($TemplBlob_x)
	$TemplBlob_x:=[Templates:86]Template_:3
	C_TEXT:C284(DCM_WO_Town_txt; DCM_WO_Facility_txt; DCM_WO_BridgeNo_txt; DCM_WO_Equipment_txt; DCM_WO_Schedule_txt; DCM_WO_SpecialInstr_txt; DCM_WO_Attachment_txt)
	C_TEXT:C284(vDistrict)  // Command Replaced was o_C_STRING length was 2
	DCM_WO_Town_txt:=""
	DCM_WO_Facility_txt:=""
	DCM_WO_BridgeNo_txt:=""
	DCM_WO_Equipment_txt:=""
	DCM_WO_Schedule_txt:=""
	DCM_WO_SpecialInstr_txt:=""
	DCM_WO_Attachment_txt:=""
	If (Size of array:C274(DCM_AttachmentList_atxt)>0)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(DCM_AttachmentList_atxt))
			If ($loop_L=1)
				DCM_WO_Attachment_txt:=DCM_WO_Attachment_txt+String:C10($loop_L; "###.")+Char:C90(9)+DCM_AttachmentList_atxt{$loop_L}+Char:C90(13)
			Else 
				DCM_WO_Attachment_txt:=DCM_WO_Attachment_txt+Char:C90(9)+String:C10($loop_L; "###.")+Char:C90(9)+DCM_AttachmentList_atxt{$loop_L}+Char:C90(13)
				
			End if 
		End for 
		
		DCM_WO_Attachment_txt:="\r"+DCM_WO_Attachment_txt
	End if 
	
	READ ONLY:C145([DCM_Project:138])
	UNLOAD RECORD:C212([DCM_Project:138])
	FIRST RECORD:C50([DCM_Project:138])
	DCM_WO_Town_txt:=[DCM_Project:138]Town:7
	DCM_WO_Facility_txt:=[DCM_Project:138]Location:6
	DCM_WO_BridgeNo_txt:=Substring:C12([DCM_Project:138]BridgeNo:4; 1; 1)+"-"+Substring:C12([DCM_Project:138]BridgeNo:4; 2; 2)+"-"+Substring:C12([DCM_Project:138]BridgeNo:4; 4; 3)+" ("+[DCM_Project:138]BIN:5+")"
	vDistrict:=String:C10(Num:C11([DCM_Project:138]District:8))
	READ WRITE:C146([DCM_Project:138])
	
	C_OBJECT:C1216($WPArea; $WpBody; $Range; $Insert)
	C_TEXT:C284($WPtext)
	$WPArea:=WP New:C1317([Templates:86]Template_:3)
	$WpBody:=WP Get body:C1516($WPArea)
	
	C_LONGINT:C283($numRefs_L; $RefLoop_L)
	C_LONGINT:C283($newArea)
	C_LONGINT:C283($info1_L; $info2_L; $type_L; $dateForm_L; $TimeForm_L; $start; $end; $start0; $findit)
	C_TEXT:C284($refName_txt; $numForm_txt)
	ARRAY TEXT:C222($Sections_atxt; 0)
	ARRAY POINTER:C280($blobs_aptr; 0)
	APPEND TO ARRAY:C911($Sections_atxt; "DEFICIENCY:")
	APPEND TO ARRAY:C911($blobs_aptr; ->DCM_WO_Deficiency_x)
	APPEND TO ARRAY:C911($Sections_atxt; "REPAIR SCOPE:")
	APPEND TO ARRAY:C911($blobs_aptr; ->DCM_WO_Scope_x)
	APPEND TO ARRAY:C911($Sections_atxt; "TRAFFIC MANAGEMENT/STAGGING:")
	APPEND TO ARRAY:C911($blobs_aptr; ->DCM_WO_Traffic_x)
	APPEND TO ARRAY:C911($Sections_atxt; "EQUIPMENT:")
	APPEND TO ARRAY:C911($blobs_aptr; ->DCM_WO_Equipment_x)
	APPEND TO ARRAY:C911($Sections_atxt; "MATERIALS:")
	APPEND TO ARRAY:C911($blobs_aptr; ->DCM_WO_Materials_x)
	APPEND TO ARRAY:C911($Sections_atxt; "SCHEDULE:")
	APPEND TO ARRAY:C911($blobs_aptr; ->DCM_WO_Sched_x)
	APPEND TO ARRAY:C911($Sections_atxt; "SPECIAL INSTRUCTION:")
	APPEND TO ARRAY:C911($blobs_aptr; ->DCM_WO_SpecInst_x)
	
	$start:=0
	ST COMPUTE EXPRESSIONS:C1285($WpArea; ST Start text:K78:15; ST End text:K78:16)
	ST FREEZE EXPRESSIONS:C1282($WpArea; ST Start text:K78:15; ST End text:K78:16; *)
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($Sections_atxt))
		$WPText:=WP Get text:C1575($WPArea)
		$findit:=Position:C15($Sections_atxt{$loop_L}; $WPtext; $start)
		$Range:=WP Text range:C1341($WPArea; $findit; ($findit+1+Length:C16($Sections_atxt{$loop_L})))
		//ALERT(WP Get text($range))
		If (BLOB size:C605($blobs_aptr{$loop_L}->)>0)
			$Insert:=WP New:C1317($blobs_aptr{$loop_L}->)
			C_REAL:C285($mar_r; $marB_r; $marL_r; $marR_r; $marT_r)
			WP GET ATTRIBUTES:C1345($Range; wk margin bottom:K81:14; $marB_r; wk margin left:K81:11; $marL_r; wk margin right:K81:12; $marR_r; wk margin top:K81:13; $marT_r)
			WP SET TEXT:C1574($Range; "\r"; wk append:K81:179; wk include in range:K81:180)
			WP INSERT DOCUMENT:C1411($Range; $Insert; wk append:K81:179; wk include in range:K81:180)
			WP SET ATTRIBUTES:C1342($Range; wk margin bottom:K81:14; $marB_r; wk margin left:K81:11; $marL_r; wk margin right:K81:12; $marR_r; wk margin top:K81:13; $marT_r)
		End if 
		$start:=$Range.end
	End for 
	
	C_TEXT:C284($docSpec; $fileExtension)
	ARRAY TEXT:C222($files_atxt; 0)
	//$docSpec:=ut_CreateMSOfficeDoc (".doc";"RTF ")
	$docSpec:=Select document:C905(""; ".docx"; "Select file to save Work order"; File name entry:K24:17; $files_atxt)
	If (OK=1)
		C_OBJECT:C1216($footer_o)
		ST COMPUTE EXPRESSIONS:C1285($WpArea; ST Start text:K78:15; ST End text:K78:16)
		ST FREEZE EXPRESSIONS:C1282($WpArea; ST Start text:K78:15; ST End text:K78:16; *)
		$footer_o:=WP Get footer:C1504($WpArea; 1; wk first page:K81:203)
		ST COMPUTE EXPRESSIONS:C1285($footer_o; ST Start text:K78:15; ST End text:K78:16)
		ST FREEZE EXPRESSIONS:C1282($footer_o; ST Start text:K78:15; ST End text:K78:16; *)
		$footer_o:=WP Get footer:C1504($WpArea; 1)
		ST COMPUTE EXPRESSIONS:C1285($footer_o; ST Start text:K78:15; ST End text:K78:16)
		ST FREEZE EXPRESSIONS:C1282($footer_o; ST Start text:K78:15; ST End text:K78:16; *)
		$footer_o:=WP Get header:C1503($WpArea; 1)
		ST COMPUTE EXPRESSIONS:C1285($footer_o; ST Start text:K78:15; ST End text:K78:16)
		ST FREEZE EXPRESSIONS:C1282($footer_o; ST Start text:K78:15; ST End text:K78:16; *)
		
		WP EXPORT DOCUMENT:C1337($WpArea; $files_atxt{1}; wk 4wp:K81:4; wk normal:K81:7)
		SHOW ON DISK:C922($files_atxt{1})
		ut_OpenDocument($files_atxt{1})
		
	End if 
	
Else 
	ALERT:C41("Missing Template WRT_DistrMaintWorkOrder!!")
End if 
