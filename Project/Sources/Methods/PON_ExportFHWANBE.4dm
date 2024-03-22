//%attributes = {"invisible":true}
//Method: PON_ExportFHWANBE
//Description
//  `method to export NBE elements in XML format to submit to FHWA
//  `works with the current list of bridge records - selects only the NBI records 
//  `Also has two versions of the XML template
//  ` will only process NBI records
// Parameters
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/20/16, 12:51:39
	// ----------------------------------------------------
	//Created : 
	Mods_2016_01_bug
	// Modified by: Costas Manousakis-(Designer)-(1/30/16 15:24:23)
	Mods_2016_01_bug
	//  `Adjusted to consider [PON_ELEM_DEFS]ELEM_SUBSET_KEY which should indicate the 'roll up' key for elements
	// Modified by: Costas Manousakis-(Designer)-(2/12/16 11:41:19)
	Mods_2016_02_bug
	//  `removed the tests to get Bin records from the [pon_elem_insp] table
	//  `use the current selection of bridge records
	//  `skip the processing if there are no bridge records
	//  `find the last dbie approved inspection with NBEs
	// Modified by: Costas Manousakis-(Designer)-(3/16/16 12:54:42)
	Mods_2016_03_bug
	//  `added code when designer and no NBI records in selection to allow searching;
	//  `modified the parameters passed to the progress bar
	//  `Corrected the search in [PON_ELEM_INSP] for the latest inspection
	// Modified by: Costas Manousakis-(Designer)-(3/20/18 17:14:33)
	Mods_2018_03
	//  `modifed so that it will work from the File menu in BridgeList;
	//  `added error reporting and loading templates from resources for 4D versions after v11
	// Modified by: Costas Manousakis-(Designer)-(11/13/18 11:47:20)
	Mods_2018_11
	//  `modified to use method PON_VerifyElementForExport
	// Modified by: Costas Manousakis-(Designer)-(1/8/19 13:39:36)
	Mods_2019_01
	//  `use method PON_CombineRecent to get all elements accumulated from the latest routine inspection.
	//  `allow designer to choose if new method is used or the old of using the latest valid inspection.
	// Modified by: Costas Manousakis-(Designer)-(2/27/19 16:20:23)
	Mods_2019_02_bug
	//  `added more info in the error lines separated by tab
	// Modified by: Costas Manousakis-(Designer)-(3/15/19 15:27:05)
	Mods_2019_03_bug
	//  `added v_1_006_L to count bridges in the export. update NBEExportXMLHeader_v13.xml and NBEExportXMLClose_v13.xml
	// Modified by: Costas Manousakis-(Designer)-(9/27/19 15:54:29)
	Mods_2019_09_bug
	//  `moved to the end the clearing of the blob variables
	// Modified by: Costas Manousakis-(Designer)-(6/30/21 15:38:44)
	Mods_2021_06
	//  `change the search of inspections to use any that have been completed at any time ([Inspections]InspCompleteDate > !00/00/00!
End if 
//
//
ARRAY LONGINT:C221($PonDefElemKey_aL; 0)
ARRAY LONGINT:C221($PonDefElemSubsetKey_aL; 0)
ARRAY TEXT:C222($PonDefFHWAReport_atxt; 0)
ARRAY TEXT:C222($PonDefSmartFlag_atxt; 0)
//save read write status
C_BLOB:C604($SaveRO_state_x)
$SaveRO_state_x:=ut_db_SaveROState

READ ONLY:C145(*)

ALL RECORDS:C47([PON_ELEM_DEFS:178])
SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_KEY:1; $PonDefElemKey_aL; \
[PON_ELEM_DEFS:178]FHWA_REPORTED:21; $PonDefFHWAReport_atxt; \
[PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4; $PonDefSmartFlag_atxt; \
[PON_ELEM_DEFS:178]ELEM_SUBSET_KEY:22; $PonDefElemSubsetKey_aL)

ARRAY TEXT:C222($AllBINs_atxt; 0)
ARRAY LONGINT:C221($InspIDs_aL; 0)

C_TEXT:C284($FHWAEDTemplate_txt; $Process_txt; $crLF; $XMLHeader_txt; $XMLClose_txt)
C_TEXT:C284($Errmsg_txt)

C_BLOB:C604($Result_blb; $Errors_blb)
$crLF:=Char:C90(13)+Char:C90(10)
C_BOOLEAN:C305($GotTemplates_b)
C_BOOLEAN:C305($ExportComplete_b)
C_BOOLEAN:C305($GotBINs_b)

If (Application version:C493<="1199")
	//v11 code
	$FHWAEDTemplate_txt:="<!--#4DLOOP PON_SUMParentAndKEY_AL--><FHWAED>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<STATE>25</STATE>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<STRUCNUM><!--#4DVAR FHWAITEM8_txt--></STRUCNUM>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<EN><!--#4DVAR PON_SUMEN_AL{PON_SUMParentAndKEY_AL}--></EN>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<!--#4DIF (PON_SUMEPN_AL{PON_SUMParentAndKEY_AL} >0)-->"
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<EPN><!--#4DVAR PON_SUMEPN_AL{PON_SUMParentAndKEY_AL}--></EPN>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<!--#4DENDIF-->"
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<TOTALQTY><!--#4DVAR PON_SUMTotQ_Ar{PON_SUMParentAndKEY_AL}--></TOTALQTY>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS1><!--#4DVAR PON_SUMCS1_Ar{PON_SUMParentAndKEY_AL}--></CS1>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS2><!--#4DVAR PON_SUMCS2_Ar{PON_SUMParentAndKEY_AL}--></CS2>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS3><!--#4DVAR PON_SUMCS3_Ar{PON_SUMParentAndKEY_AL}--></CS3>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS4><!--#4DVAR PON_SUMCS4_Ar{PON_SUMParentAndKEY_AL}--></CS4>"+$crLF
	$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"</FHWAED>"+$crLF+"<!--#4DENDLOOP-->"
	
	$XMLHeader_txt:="<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+$crLF+\
		"<!-- Export from MADOT BMS "+<>Version+" on "+String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+$crLF\
		+"MADOT BMS User: "+Current user:C182+$crLF\
		+"Workstation: "+Current machine:C483+$crLF\
		+"OS User: "+Current system user:C484+$crLF\
		+"Application Name: "+Replace string:C233(Application file:C491; GetPath(Application file:C491); "")+$crLF
	If (Application type:C494=4D Remote mode:K5:5)
		$XMLHeader_txt:=$XMLHeader_txt+"Connected to server at IP: "+G_GetServerTCP+$crLF
		$XMLHeader_txt:=$XMLHeader_txt+"Structure: "+Structure file:C489+$crLF\
			+"Data: "+Data file:C490+$crLF
	End if 
	$XMLHeader_txt:=$XMLHeader_txt+"-->"+$crLF\
		+"<FHWAElement>"+$crLF
	
	$XMLClose_txt:="</FHWAElement>"
Else   // v15 code
	
	If (False:C215)
		// v15 Code
		$FHWAEDTemplate_txt:="<!--#4DEVAL xxx:=\"<!--\"--><!--4DEVAL xxx--> INSP ID: <!--#4DTEXT [Inspections]InspID-->"+\
			" Date: <!--#4DTEXT [Inspections]Insp Date--> Type: <!--#4DTEXT [Inspections]Insp Type--> -->"+$crLF\
			+"<!--#4DLOOP PON_SUMParentAndKEY_AL--><FHWAED>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<STATE>25</STATE>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<STRUCNUM><!--#4DTEXT FHWAITEM8_txt--></STRUCNUM>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<EN><!--#4DTEXT PON_SUMEN_AL{PON_SUMParentAndKEY_AL}--></EN>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<!--#4DIF (PON_SUMEPN_AL{PON_SUMParentAndKEY_AL} >0)-->"
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<EPN><!--#4DTEXT PON_SUMEPN_AL{PON_SUMParentAndKEY_AL}--></EPN>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<!--#4DENDIF-->"
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<TOTALQTY><!--#4DTEXT PON_SUMTotQ_Ar{PON_SUMParentAndKEY_AL}--></TOTALQTY>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS1><!--#4DTEXT PON_SUMCS1_Ar{PON_SUMParentAndKEY_AL}--></CS1>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS2><!--#4DTEXT PON_SUMCS2_Ar{PON_SUMParentAndKEY_AL}--></CS2>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS3><!--#4DTEXT PON_SUMCS3_Ar{PON_SUMParentAndKEY_AL}--></CS3>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"<CS4><!--#4DTEXT PON_SUMCS4_Ar{PON_SUMParentAndKEY_AL}--></CS4>"+$crLF
		$FHWAEDTemplate_txt:=$FHWAEDTemplate_txt+"</FHWAED>"+$crLF+"<!--#4DENDLOOP-->"
		If (False:C215)
			C_TIME:C306($temp_f)
			C_TEXT:C284($temp_txt)
			$temp_txt:=Select document:C905(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBEExportXML_v13.xml"; ".xml"; "Save xml template"; File name entry:K24:17)
			$temp_f:=Create document:C266(Document)
			SEND PACKET:C103($temp_f; $FHWAEDTemplate_txt)
			CLOSE DOCUMENT:C267($temp_f)
		End if 
		
		$XMLHeader_txt:="<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+$crLF
		$XMLHeader_txt:=$XMLHeader_txt+"<!--#4DEVAL xxx:=\"<!--\"--><!--4DEVAL xxx--> Export from MADOT BMS "
		$XMLHeader_txt:=$XMLHeader_txt+"<!--#4DTEXT <>Version--> on <!--#4DEVAL Current date:C33(*)--> <!--#4DEVAL Current time:C178(*)--> "+$crLF
		$XMLHeader_txt:=$XMLHeader_txt+"MADOT BMS User: <!--#4DEVAL Current User:C182-->"+$crLF
		$XMLHeader_txt:=$XMLHeader_txt+"Workstation: <!--#4DEVAL Current machine:C483-->"+$crLF
		$XMLHeader_txt:=$XMLHeader_txt+"OS User: <!--#4DEVAL Current machine owner-->"+$crLF
		$XMLHeader_txt:=$XMLHeader_txt+"Application name : <!--#4DEVAL Application file:C491-->"+$crLF
		$XMLHeader_txt:=$XMLHeader_txt+"<!--#4DIF (Application type=4)-->Connected to server at IP: <!--#4DTEXT v_2_013_txt-->"+$crLF
		$XMLHeader_txt:=$XMLHeader_txt+"Structure: <!--#4DEVAL Structure file-->"+$crLF+"<!--#4DENDIF-->"
		$XMLHeader_txt:=$XMLHeader_txt+"-->"+$crLF+"<FHWAElement>"+$crLF
		If (False:C215)
			C_TIME:C306($temp_f)
			C_TEXT:C284($temp_txt)
			$temp_txt:=Select document:C905(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBEExportXMLHeader_v13.xml"; ".xml"; "Save xml template"; File name entry:K24:17)
			$temp_f:=Create document:C266(Document)
			SEND PACKET:C103($temp_f; $XMLHeader_txt)
			CLOSE DOCUMENT:C267($temp_f)
		End if 
		
		$XMLClose_txt:="</FHWAElement>"
		If (False:C215)
			C_TIME:C306($temp_f)
			C_TEXT:C284($temp_txt)
			$temp_txt:=Select document:C905(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBEExportXMLClose_v13.xml"; ".xml"; "Save xml template"; File name entry:K24:17)
			$temp_f:=Create document:C266(Document)
			SEND PACKET:C103($temp_f; $XMLClose_txt)
			CLOSE DOCUMENT:C267($temp_f)
		End if 
		
	Else 
		$GotTemplates_b:=True:C214
		If (Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBEExportXML_v13.xml")=Is a document:K24:1)
			C_BLOB:C604($file_blb)
			DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBEExportXML_v13.xml"; $file_blb)
			$FHWAEDTemplate_txt:=BLOB to text:C555($file_blb; Mac text without length:K22:10)
			
		Else 
			$GotTemplates_b:=False:C215
			ALERT:C41("Export template "+"NBE"+<>PL_DirectorySep_s+"NBEExportXML_v13.xml not found!")
		End if 
		
		If (Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBEExportXMLHeader_v13.xml")=Is a document:K24:1)
			C_BLOB:C604($file_blb)
			DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBEExportXMLHeader_v13.xml"; $file_blb)
			$XMLHeader_txt:=BLOB to text:C555($file_blb; Mac text without length:K22:10)
			
		Else 
			$GotTemplates_b:=False:C215
			ALERT:C41("Export template "+"NBE"+<>PL_DirectorySep_s+"NBEExportXMLHeader_v13.xml not found!")
		End if 
		
		If (Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBEExportXMLClose_v13.xml")=Is a document:K24:1)
			C_BLOB:C604($file_blb)
			DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBEExportXMLClose_v13.xml"; $file_blb)
			$XMLClose_txt:=BLOB to text:C555($file_blb; Mac text without length:K22:10)
		Else 
			$GotTemplates_b:=False:C215
			ALERT:C41("Export template "+"NBE"+<>PL_DirectorySep_s+"NBEExportXMLHeader_v13.xml not found!")
		End if 
		
	End if 
	
End if 

//get list of BINs to perform the export of NBEs
COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "PRENBEXPORTBINS")
//  //QUERY SELECTION([Bridge MHD NBIS];[Bridge MHD NBIS]FHWARecord=True)
//  //sort by BDEpt and BIN
//ORDER BY([Bridge MHD NBIS];[Bridge MHD NBIS]BDEPT;>;[Bridge MHD NBIS]BIN;>)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $AllBINs_atxt)

$GotBINs_b:=(Size of array:C274($AllBINs_atxt)>0)
If (Not:C34($GotBINs_b) & (User in group:C338(Current user:C182; "Design Access Group")))
	CONFIRM:C162("No Bridge Records selected! Do you want to do a custom search?"; "Search"; "Cancel")
	If (OK=1)
		C_BOOLEAN:C305($SearchDone_b)
		$SearchDone_b:=False:C215
		
		Repeat 
			QUERY:C277([Bridge MHD NBIS:1])
			If (OK=1)
				QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
				ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; >; [Bridge MHD NBIS:1]BIN:3; >)
				SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $AllBINs_atxt)
				If (Size of array:C274($AllBINs_atxt)>0)
					CONFIRM:C162("Found "+String:C10(Size of array:C274($AllBINs_atxt))+" NBI records. Continue with export?"; "Continue"; "Try again")
					If (OK=1)
						$GotBINs_b:=(Size of array:C274($AllBINs_atxt)>0)
						$SearchDone_b:=True:C214
					End if 
					
				Else 
					CONFIRM:C162("No NBI records found in selection! Try again?"; "Yes"; "No")
					If (OK=1)
						
					Else 
						$SearchDone_b:=True:C214
					End if 
					
				End if 
				
			Else 
				CONFIRM:C162("Try Search again?"; "Yes"; "No")
				If (OK=1)
				Else 
					$SearchDone_b:=True:C214
				End if 
				
			End if 
			
		Until ($SearchDone_b)
		
	End if 
	
End if 

If ($GotBINs_b & $GotTemplates_b)
	
	C_BOOLEAN:C305($DoAllListed_b)
	$DoAllListed_b:=False:C215
	If (User in group:C338(Current user:C182; "Design Access Group"))
		CONFIRM:C162("Do NBI bridges only or all in list?"; "NBI Only"; "All Listed")
		$DoAllListed_b:=(OK=0)
	End if 
	C_BOOLEAN:C305($UseRecent_b)
	$UseRecent_b:=True:C214
	If (User in group:C338(Current user:C182; "Design Access Group"))
		CONFIRM:C162("Use the most recent completed inspection for NBEs or accumulate from latest routine?"; "Use Recent"; "Accumulate")
		$UseRecent_b:=(OK=1)
	End if 
	C_TEXT:C284(v_2_013_txt)  //SERVERIP
	
	v_2_013_txt:=G_GetServerTCP
	
	C_LONGINT:C283(v_1_006_L)  //Rank - use var for Bridge Rank to count number of bridges-used in the end xml
	v_1_006_L:=0
	
	PROCESS 4D TAGS:C816($XMLHeader_txt; $Process_txt)
	
	TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)  //start the xml 
	
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("NBE to FHWA export"; Size of array:C274($AllBINs_atxt); True:C214; " Bridge Records"; 3)
	
	$ExportComplete_b:=True:C214
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($AllBINs_atxt))
		If (Not:C34(Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))))
			
			If (($loop_L%10)=0)
				//update progress
				UpdateProgressNew($progress_o; $loop_L)
				
			End if 
			
			ARRAY LONGINT:C221($InspIDs_aL; 0)  //clear inspids_AL 
			ARRAY INTEGER:C220($InspDBIEAppr_aL; 0)
			ARRAY DATE:C224($InspDate_ad; 0)
			ARRAY DATE:C224($InspCompleteDate_ad; 0)
			C_LONGINT:C283($InspID_L)
			$InspID_L:=0
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$AllBINs_atxt{$loop_L})
			C_TEXT:C284($Record_txt)
			
			If ([Bridge MHD NBIS:1]FHWARecord:174)
				$Record_txt:=[Bridge MHD NBIS:1]BIN:3+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]Item8 BridgeCat:207+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]InspResp:173+Char:C90(Tab:K15:37)+"NBI:"+Char:C90(Tab:K15:37)
			Else 
				$Record_txt:=[Bridge MHD NBIS:1]BIN:3+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]Item8 BridgeCat:207+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]InspResp:173+Char:C90(Tab:K15:37)+"Non-NBI:"+Char:C90(Tab:K15:37)
			End if 
			
			If ([Bridge MHD NBIS:1]FHWARecord:174 | $DoAllListed_b)
				
				C_TEXT:C284(FHWAITEM8_txt)
				ARRAY LONGINT:C221(PON_SUMEn_AL; 0)
				ARRAY LONGINT:C221(PON_SUMEPN_AL; 0)
				ARRAY LONGINT:C221(PON_SUMParentAndKEY_AL; 0)
				ARRAY REAL:C219(PON_SUMTotQ_Ar; 0)
				ARRAY REAL:C219(PON_SUMCS1_Ar; 0)
				ARRAY REAL:C219(PON_SUMCS2_Ar; 0)
				ARRAY REAL:C219(PON_SUMCS3_Ar; 0)
				ARRAY REAL:C219(PON_SUMCS4_Ar; 0)
				
				ARRAY LONGINT:C221($En_AL; 0)
				ARRAY LONGINT:C221($EPN_AL; 0)
				ARRAY LONGINT:C221($ParentAndKEY_AL; 0)
				ARRAY REAL:C219($TotQ_Ar; 0)
				ARRAY REAL:C219($CS1_Ar; 0)
				ARRAY REAL:C219($CS2_Ar; 0)
				ARRAY REAL:C219($CS3_Ar; 0)
				ARRAY REAL:C219($CS4_Ar; 0)
				
				If ([Bridge MHD NBIS:1]FHWAItem8:229#"")
					FHWAITEM8_txt:=[Bridge MHD NBIS:1]FHWAItem8:229
				Else 
					FHWAITEM8_txt:=[Bridge MHD NBIS:1]Item8:206
				End if 
				
				If ($UseRecent_b)  //use recent inspection
					
					//get the latest DBIE approved inspection with NBEs
					QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
					If (False:C215)
						QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved; *)
						QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]InspDBIE1stApprDate:225>!00-00-00!)
					Else 
						QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspCompleteDate:221>!00-00-00!)
					End if 
					QUERY SELECTION:C341([Inspections:27]; [PON_ELEM_INSP:179]INSPID:21>0)
					ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
					SELECTION TO ARRAY:C260([Inspections:27]InspID:2; $InspIDs_aL; \
						[Inspections:27]InspReviewed:12; $InspDBIEAppr_aL; [Inspections:27]Insp Date:78; $InspDate_ad; \
						[Inspections:27]InspCompleteDate:221; $InspCompleteDate_ad)
					
					Case of 
						: (Size of array:C274($InspIDs_aL)=0)
							//there are no approved inspections / inspections marked completeat least once
							//$Errmsg_txt:=$Record_txt+" Error : No DBIE Approved Inspections with NBEs found !!"+$crLF
							$Errmsg_txt:=$Record_txt+" Error : No Inspections that have been completed onve and with NBEs found !!"+$crLF
							TEXT TO BLOB:C554($Errmsg_txt; $Errors_blb; Mac text without length:K22:10; *)
							
						: ($InspDBIEAppr_aL{1}=BMS Approved)
							//latest one is also approved - good to go 
							$InspID_L:=$InspIDs_aL{1}
						Else 
							C_LONGINT:C283($lastApproved_L)
							If (False:C215)
								$lastApproved_L:=Find in array:C230($InspDBIEAppr_aL; BMS Approved)
							Else 
								$lastApproved_L:=1  //with the new search all inspections found have an inspection complete date
							End if 
							
							If ($lastApproved_L<=0)
								//there are no completely approved inspections
								$Errmsg_txt:=$Record_txt+" Error : Out of "+String:C10(Size of array:C274($InspIDs_aL))+\
									" inspections did not find any with Final DBIE Approval !!"+$crLF
								TEXT TO BLOB:C554($Errmsg_txt; $Errors_blb; Mac text without length:K22:10; *)
							Else 
								$InspID_L:=$InspIDs_aL{$lastApproved_L}
								$Errmsg_txt:=$Record_txt+" Warning : Using Inspection dated "+\
									String:C10($InspDate_ad{$lastApproved_L})+"! First completed on "+String:C10($InspCompleteDate_ad{$lastApproved_L})+$crLF
								//+String($lastApproved_L-1)+`" Later inspections do not have final DBIE Approval !!"+$crLF
								TEXT TO BLOB:C554($Errmsg_txt; $Errors_blb; Mac text without length:K22:10; *)
							End if 
							
					End case   // check inspection approvals
					
					If ($InspID_L>0)  // we have the latest inspection
						
						//got one to work with
						//load the inspection for messages
						QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$InspID_L)
						
						QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=$InspID_L)
						//sort them in right order
						ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_ElemSort)
						
						SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEM_KEY:3; $En_AL; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; $EPN_AL; [PON_ELEM_INSP:179]ELEM_QUANTITY:7; $TotQ_Ar; \
							[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; $CS1_Ar; [PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; $CS2_Ar; [PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; $CS3_Ar; \
							[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; $CS4_Ar)
						
					End if 
					
				Else   //accumulate elements from the last routine
					
					C_OBJECT:C1216($mergedNBEDs_o)
					
					$mergedNBEDs_o:=PON_CombineRecent(True:C214; False:C215)  // combine completed inspections
					
					If (OB Get:C1224($mergedNBEDs_o; "error"; Is text:K8:3)#"")
						
						$Errmsg_txt:=$Record_txt+" Errors retrieving NBES : "+OB Get:C1224($mergedNBEDs_o; "error"; Is text:K8:3)+$crlf
						
						TEXT TO BLOB:C554($Errmsg_txt; $Errors_blb; Mac text without length:K22:10; *)
					Else 
						//unpack the arrays we need
						OB GET ARRAY:C1229($mergedNBEDs_o; "keys"; $En_AL)
						OB GET ARRAY:C1229($mergedNBEDs_o; "parent"; $EPN_AL)
						OB GET ARRAY:C1229($mergedNBEDs_o; "totq"; $TotQ_Ar)
						OB GET ARRAY:C1229($mergedNBEDs_o; "q1"; $CS1_Ar)
						OB GET ARRAY:C1229($mergedNBEDs_o; "q2"; $CS2_Ar)
						OB GET ARRAY:C1229($mergedNBEDs_o; "q3"; $CS3_Ar)
						OB GET ARRAY:C1229($mergedNBEDs_o; "q4"; $CS4_Ar)
					End if 
					
				End if 
				
				If (Size of array:C274($En_AL)>0)  // if we got a list of NBEs
					
					//size process arrays used in xml template
					ARRAY LONGINT:C221(PON_SUMEn_AL; Size of array:C274($En_AL))
					ARRAY LONGINT:C221(PON_SUMEPN_AL; Size of array:C274($En_AL))
					ARRAY LONGINT:C221(PON_SUMParentAndKEY_AL; Size of array:C274($En_AL))
					ARRAY REAL:C219(PON_SUMTotQ_Ar; Size of array:C274($En_AL))
					ARRAY REAL:C219(PON_SUMCS1_Ar; Size of array:C274($En_AL))
					ARRAY REAL:C219(PON_SUMCS2_Ar; Size of array:C274($En_AL))
					ARRAY REAL:C219(PON_SUMCS3_Ar; Size of array:C274($En_AL))
					ARRAY REAL:C219(PON_SUMCS4_Ar; Size of array:C274($En_AL))
					
					//loop to sum the quantities
					C_LONGINT:C283($Elemindx_L; $myParAndKey_L; $pondefIndx_L; $CurrElemKey_L; $CurrParKey_L; $ElemLoop_L)
					C_BOOLEAN:C305($report_b)
					For ($ElemLoop_L; 1; Size of array:C274($En_AL))
						//skip any defects
						C_LONGINT:C283($pondefIndx_L)
						$pondefIndx_L:=Find in array:C230($PonDefElemKey_aL; $EN_AL{$ElemLoop_L})
						
						Case of 
							: ($pondefIndx_L<0)  //key not found in defs
								
								If ($UseRecent_b)
									$Errmsg_txt:=$Record_txt+" Inspection ID "+String:C10([Inspections:27]InspID:2)+" type "\
										+[Inspections:27]Insp Type:6+" date "+String:C10([Inspections:27]Insp Date:78)+" Elem Key "+String:C10($EN_AL{$ElemLoop_L})+" "+\
										"is not a valid element key !"+\
										$crLF
								Else 
									$Errmsg_txt:=$Record_txt+\
										" Elem Key "+String:C10($EN_AL{$ElemLoop_L})+" "+\
										"is not a valid element key !"+\
										$crLF
								End if 
								TEXT TO BLOB:C554($Errmsg_txt; $Errors_blb; Mac text without length:K22:10; *)
								
							: ($PonDefSmartFlag_atxt{$pondefIndx_L}="Y")  //smartflag
							Else 
								
								$report_b:=False:C215
								
								C_OBJECT:C1216($params_o)
								OB SET:C1220($params_o; "elemkey"; $EN_AL{$ElemLoop_L}; "parentkey"; $EPN_AL{$ElemLoop_L}; \
									"Keylist"; ->$PonDefElemKey_aL; "rollupkeys"; ->$PonDefElemSubsetKey_aL; "reportables"; ->$PonDefFHWAReport_atxt)
								PON_VerifyElementForExport($params_o)
								C_LONGINT:C283($Error_L)
								$Error_L:=OB Get:C1224($params_o; "error"; Is longint:K8:6)
								
								If ($Error_L=0)
									$CurrElemKey_L:=OB Get:C1224($params_o; "elemkey"; Is longint:K8:6)
									$CurrParKey_L:=OB Get:C1224($params_o; "parentkey"; Is longint:K8:6)
									$report_b:=OB Get:C1224($params_o; "reported"; Is boolean:K8:9)
								Else 
									//error or reason not to report element
									//add to Error file
									
									If ($UseRecent_b)  //we have an inspection report to refer to
										$Errmsg_txt:=$Record_txt+" Inspection ID "+String:C10([Inspections:27]InspID:2)+" type "\
											+[Inspections:27]Insp Type:6+" date "+String:C10([Inspections:27]Insp Date:78)+" Elem Key "+String:C10($EN_AL{$ElemLoop_L})+" "+\
											OB Get:C1224($params_o; "errortxt"; Is text:K8:3)+\
											$crLF
										
									Else   //error from accumulated NBEs
										$Errmsg_txt:=$Record_txt+" Elem Key "+String:C10($EN_AL{$ElemLoop_L})+" "+\
											OB Get:C1224($params_o; "errortxt"; Is text:K8:3)+\
											$crLF
										
									End if 
									
									TEXT TO BLOB:C554($Errmsg_txt; $Errors_blb; Mac text without length:K22:10; *)
									
								End if 
								
								If ($report_b)
									$myParAndKey_L:=0
									If ($CurrParKey_L<=0)
										$myParAndKey_L:=$CurrElemKey_L*10000
									Else 
										$myParAndKey_L:=$CurrParKey_L*10000+$CurrElemKey_L
									End if 
									
									$Elemindx_L:=Find in array:C230(PON_SUMParentAndKEY_AL; $myParAndKey_L)
									If ($Elemindx_L<=0)
										$Elemindx_L:=Find in array:C230(PON_SUMParentAndKEY_AL; 0)  // get the first 0 
										PON_SUMParentAndKEY_AL{$Elemindx_L}:=$myParAndKey_L
										PON_SUMEn_AL{$Elemindx_L}:=$CurrElemKey_L
										PON_SUMEPN_AL{$Elemindx_L}:=$CurrParKey_L
									End if 
									
									//now sum quantities
									PON_SUMTotQ_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}+$TotQ_Ar{$ElemLoop_L}
									PON_SUMCS1_Ar{$Elemindx_L}:=PON_SUMCS1_Ar{$Elemindx_L}+$CS1_Ar{$ElemLoop_L}
									PON_SUMCS2_Ar{$Elemindx_L}:=PON_SUMCS2_Ar{$Elemindx_L}+$CS2_Ar{$ElemLoop_L}
									PON_SUMCS3_Ar{$Elemindx_L}:=PON_SUMCS3_Ar{$Elemindx_L}+$CS3_Ar{$ElemLoop_L}
									PON_SUMCS4_Ar{$Elemindx_L}:=PON_SUMCS4_Ar{$Elemindx_L}+$CS4_Ar{$ElemLoop_L}
									
								End if 
								
						End case 
						
					End for 
					
					//Find last nonzero in  summ array 
					C_LONGINT:C283($TrimTo_L)
					$TrimTo_L:=Find in array:C230(PON_SUMParentAndKEY_AL; 0)
					If ($TrimTo_L>0)
						ARRAY LONGINT:C221(PON_SUMParentAndKEY_AL; ($TrimTo_L-1))  // resize the array 
					End if 
					
					If (Size of array:C274(PON_SUMParentAndKEY_AL)>0)
						//now loop and fix quantities to round to zero 
						For ($Elemindx_L; 1; Size of array:C274(PON_SUMParentAndKEY_AL))
							PON_SUMTotQ_Ar{$Elemindx_L}:=Round:C94(PON_SUMTotQ_Ar{$Elemindx_L}; 0)
							PON_SUMCS4_Ar{$Elemindx_L}:=Round:C94(PON_SUMCS4_Ar{$Elemindx_L}; 0)
							PON_SUMCS3_Ar{$Elemindx_L}:=Round:C94(PON_SUMCS3_Ar{$Elemindx_L}; 0)
							PON_SUMCS2_Ar{$Elemindx_L}:=Round:C94(PON_SUMCS2_Ar{$Elemindx_L}; 0)
							
							If ((PON_SUMTotQ_Ar{$Elemindx_L}-(PON_SUMCS4_Ar{$Elemindx_L}+PON_SUMCS3_Ar{$Elemindx_L}+PON_SUMCS2_Ar{$Elemindx_L}))>=0)
								PON_SUMCS1_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}-(PON_SUMCS4_Ar{$Elemindx_L}+PON_SUMCS3_Ar{$Elemindx_L}+PON_SUMCS2_Ar{$Elemindx_L})
							Else 
								PON_SUMCS1_Ar{$Elemindx_L}:=0
								If ((PON_SUMTotQ_Ar{$Elemindx_L}-(PON_SUMCS4_Ar{$Elemindx_L}+PON_SUMCS3_Ar{$Elemindx_L}))>=0)
									PON_SUMCS2_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}-(PON_SUMCS4_Ar{$Elemindx_L}+PON_SUMCS3_Ar{$Elemindx_L})
								Else 
									PON_SUMCS2_Ar{$Elemindx_L}:=0
									If ((PON_SUMTotQ_Ar{$Elemindx_L}-PON_SUMCS4_Ar{$Elemindx_L})>=0)
										PON_SUMCS3_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}-PON_SUMCS4_Ar{$Elemindx_L}
									Else 
										PON_SUMCS3_Ar{$Elemindx_L}:=0
										PON_SUMCS4_Ar{$Elemindx_L}:=PON_SUMTotQ_Ar{$Elemindx_L}
									End if 
								End if 
								
							End if 
						End for 
						
						v_1_006_L:=v_1_006_L+1
						
						PROCESS 4D TAGS:C816($FHWAEDTemplate_txt; $Process_txt)
						TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)
						
					Else   //no valid elements in inspection
						//add to Error file
						$Errmsg_txt:=$Record_txt+" Inspection ID "+String:C10([Inspections:27]InspID:2)+" type "\
							+[Inspections:27]Insp Type:6+" date "+String:C10([Inspections:27]Insp Date:78)+" has no valid NBEs!"+$crLF
						TEXT TO BLOB:C554($Errmsg_txt; $Errors_blb; Mac text without length:K22:10; *)
					End if   //checking for valid elements
					
				End if   //end of processing NBEs
				
			Else   // not processing this BIN
				
				If (User in group:C338(Current user:C182; "Design Access Group"))
					$Errmsg_txt:=$Record_txt+" Error : Not an NBI record and Not processing all bridges in List !!"+$crLF
				Else 
					$Errmsg_txt:=$Record_txt+" Error : Not an NBI record !!"+$crLF
				End if 
				TEXT TO BLOB:C554($Errmsg_txt; $Errors_blb; Mac text without length:K22:10; *)
			End if 
			
			UNLOAD RECORD:C212([Bridge MHD NBIS:1])
			
		Else   //aborting export
			$loop_L:=Size of array:C274($AllBINs_atxt)+1  //exit loop
			$ExportComplete_b:=False:C215
		End if 
		
	End for 
	
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	
	If (Not:C34($ExportComplete_b))
		CONFIRM:C162("User Aborted processing! Save results / errors to file?"; "Save"; "Don't Save")
		$ExportComplete_b:=(OK=1)
	End if 
	If ($ExportComplete_b)
		PROCESS 4D TAGS:C816($XMLClose_txt; $Process_txt)
		TEXT TO BLOB:C554($Process_txt; $Result_blb; Mac text without length:K22:10; *)  //close the xml 
		C_TIME:C306($ExportFile_t)
		C_TEXT:C284($ExportFile_txt; $ErrorFile_txt)
		$ExportFile_t:=Create document:C266(""; ".xml")
		If (OK=1)
			$ExportFile_txt:=Document
			CLOSE DOCUMENT:C267($ExportFile_t)
			BLOB TO DOCUMENT:C526($ExportFile_txt; $Result_blb)
			If (BLOB size:C605($Errors_blb)>0)
				$ErrorFile_txt:=Replace string:C233($ExportFile_txt; ".xml"; "_error.txt")
				$ExportFile_t:=Create document:C266($ErrorFile_txt)
				CLOSE DOCUMENT:C267($ExportFile_t)
				BLOB TO DOCUMENT:C526($ErrorFile_txt; $Errors_blb)
				ALERT:C41("Errors are reported in file "+$ErrorFile_txt)
			End if 
			SHOW ON DISK:C922($ExportFile_txt)
			
		End if 
		
	End if 
	
Else 
	
	Case of 
		: (Not:C34($GotTemplates_b))
			ALERT:C41("Some Required Templates Not found!")
		: (Not:C34($GotBINs_b))
			ALERT:C41("There are no Bridge Records to do the export!")
	End case 
	
End if 

//reset the bridge list
USE NAMED SELECTION:C332("PRENBEXPORTBINS")
CLEAR NAMED SELECTION:C333("PRENBEXPORTBINS")
ut_db_RestoreROState($SaveRO_state_x)

SET BLOB SIZE:C606($Result_blb; 0)
SET BLOB SIZE:C606($SaveRO_state_x; 0)
SET BLOB SIZE:C606($Errors_blb; 0)

//End PON_ExportFHWANBE