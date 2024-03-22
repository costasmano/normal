//%attributes = {"invisible":true}
//   Method: PON_ExportCU2Migrator
//  Description
//  Export cond units in xml format for AASHTOWARE migrator
//  requires CUEXPORTTEMPLATE.xml in NBE folder of Resources
//  Parameters
If (False:C215)
	//   ----------------------------------------------------
	//   User name(OS): Costas Manousakis
	//   User(4D): Designer
	//   Date and time: 12/27/14, 21:12:40
	//   ----------------------------------------------------
	//   Created :
	Mods_2014_12
	//Calls in template
	PON_PREPAREELMTDATA
	// Modified by: Costas Manousakis (3/13/17)
	Mods_2017_03
	//for 4D versions other than v11 use the v13 template
End if 
// 

C_BLOB:C604($templatexml_blb; $xmlexport_blb)
C_TEXT:C284($templVers_txt)
$templVers_txt:=Substring:C12(Application version:C493; 1; 2)

If ($templVers_txt="11")
	
Else 
	$templVers_txt:="13"
End if 

If (Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"CUEXPORTTEMPLATE_v"+$templVers_txt+".xml")=Is a document:K24:1)
	DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"CUEXPORTTEMPLATE_v"+$templVers_txt+".xml"; $templatexml_blb)
	C_LONGINT:C283($numrecs_L)
	CONFIRM:C162("Work with current list of Cond Units ("+String:C10(Records in selection:C76([Cond Units:45]))+") or New Query?"; "Current"; "New")
	If (OK=1)
	Else 
		QUERY:C277([Cond Units:45])
	End if 
	
	If (OK=1)
		If (Records in selection:C76([Cond Units:45])>0)
			C_LONGINT:C283($maxLim_L)
			$maxLim_L:=50000
			REDUCE SELECTION:C351([Cond Units:45]; $maxLim_L)
			CONFIRM:C162("exporting "+String:C10(Records in selection:C76([Cond Units:45]))+" records!"; "Continue?"; "Cancel")
			If (OK=1)
				PON_ExportDateTime_txt:=Substring:C12(String:C10(Current date:C33(*); ISO date:K1:8); 1; 10)+" "+Substring:C12(String:C10(Current time:C178(*); ISO time:K7:8); 12)
				PON_NumeExport_L:=Records in selection:C76([Cond Units:45])
				PON_ExportPrecision_L:=Int:C8(Num:C11(Request:C163("Enter precision for quantities"; "4")))
				SHORT_MESSAGE("Exporting....")
				C_TIME:C306($start_t; $end_t; $duration_t)
				$start_t:=Current time:C178(*)
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
	ALERT:C41("Template CUEXPORTTEMPLATE_v"+$templVers_txt+".xml not found in the NBE folder of Resources!")
End if 

//End PON_ExportCU2Migrator