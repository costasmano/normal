//%attributes = {"invisible":true}
//Method: INSP_PrintToPDF
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 12/29/20, 12:39:44
	// ----------------------------------------------------
	//Created : 
	Mods_2020_12
	//Add code that will create PDFs of all [Inspections]InspApproved=2
	//[Inspections]InspApproved= 2
	C_BOOLEAN:C305(INSP_PrintToPDF; $1)
	C_POINTER:C301(INSP_PrintToPDF; $2; $3)
	C_TEXT:C284(INSP_PrintToPDF; $4; $5)
	
	// Modified  (2021-10-19)
	Mods_2021_10
	//  `added printing of form [Inspections];"qcqaprint" 
	
	//error report
	// inspection id, date, bdept, bin, and reason
	Mods_2022_04  //Change the way we identiify the Server IP address and whether we are in test or not
	//Modified by: Chuck Miller (4/5/22 12:23:05)
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 14:54:46)
	Mods_2023_04
	//  `Removed IDLe before calls to Delay process
End if 


C_BOOLEAN:C305($1; $Display_B)
$Display_B:=$1
C_POINTER:C301($2; $DocPath_ptr; $3; $RecordNumber_aPtr)
C_TEXT:C284($4; $5; $MonthYear_txt; $FinalDirectory_txt; $CallingMethod_txt; $selected_txt)
$DocPath_ptr:=$2
$RecordNumber_aPtr:=$3
$MonthYear_txt:=$4
$CallingMethod_txt:=$5

C_TEXT:C284($selected_txt; $inspIds_txt)


Begin SQL
	select [Parameters].[Description]
	from
	[Parameters]
	where
	[Parameters].[ParamCode] = 'PDFSkipIdsINSP'
	into
	:$inspIds_txt;
	
End SQL
ARRAY LONGINT:C221($badInspIds_aL; 0)
ut_NewTextToArray($inspIds_txt; ->$badInspIds_aL; ",")

C_LONGINT:C283($pos_L)

$CreateInspLog_txt:=ut_GetSysParameter("CreateInspLog"; "true")
$WriteLogFile_B:=($CreateInspLog_txt="true")
If ($WriteLogFile_B)
	C_TEXT:C284($DebugPath_txt)
	$DebugPath_txt:=System folder:C487(Documents folder:K41:18)+"Debug_Folder"
	If (Test path name:C476($DebugPath_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($DebugPath_txt)
	End if 
	$DebugPath_txt:=$DebugPath_txt+Folder separator:K24:12+"Debug_"+$MonthYear_txt+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
	C_TIME:C306($doc_tm)
	$doc_tm:=Create document:C266($DebugPath_txt)
	CLOSE DOCUMENT:C267($doc_tm)
End if 
ARRAY TEXT:C222($FileNames_atxt; 0)
C_TEXT:C284($Report_txt)

CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $RecordNumber_aPtr->)
ARRAY LONGINT:C221($inspIds_al; 0)
ARRAY TEXT:C222($Bins_atxt; 0)
ARRAY TEXT:C222($InspType_atxt; 0)
ARRAY DATE:C224($insp_aD; 0)
ARRAY LONGINT:C221($ElapsedTickCount_aL; 0)
ARRAY LONGINT:C221($FilesSize_aL; 0)
ARRAY TEXT:C222($FilePath_atxt; 0)
//SELECTION TO ARRAY([Inspections]Insp Date;$insp_aD;[Inspections]BIN;$Bins_atxt;[Inspections]Insp Type;$InspType_atxt;[Inspections]InspID;$inspIds_al)
//ARRAY LONGINT($FilesSize_aL;Size of array($inspIds_al))
//ARRAY LONGINT($ElapsedTickCount_aL;Size of array($inspIds_al))
//ARRAY TEXT($FilePath_atxt;Size of array($inspIds_al))
//

READ ONLY:C145(*)
C_TEXT:C284($FileName_txt; $popupMenu_txt; $targetPath_txt; $PathToOpen_txt; $baseSpec_txt; $ServerMask_txt; $Townfolder_txt; $Townfolder_txt; $MountLetter_txt)
C_TEXT:C284($MountVolume_txt; $TownPrefix_txt)
C_LONGINT:C283($Loop_L; $StartLoop_L; $startTickCount_l)
C_BOOLEAN:C305(vbInspectionLocked; vbInspectionLocked; INSP_PageCountDone_b)
C_BOOLEAN:C305($FolderOrMountError_B)
$FolderOrMountError_B:=False:C215
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")

C_BOOLEAN:C305($InTest_B)
$InTest_B:=(ut_ReturnServerIP#ut_GetSysParameter("PRODSERVERIP"; "146.243.135.242"))

Case of 
	: (Not:C34(Is compiled mode:C492))
		$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_T"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Admin/Insp-Test/B-Inspection/ApprovedInspectionReportPDFs")
	: (Application type:C494=4D Volume desktop:K5:2) & ($InTest_B)
		$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_P"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/ApprovedInspectionReportPDFs")
	: (Application type:C494=4D Remote mode:K5:5) & ($InTest_B)
		$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_T"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Admin/Insp-Test/B-Inspection/ApprovedInspectionReportPDFs")
	Else 
		$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_P"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/ApprovedInspectionReportPDFs")
End case 

If (ut_isSharedFolderMounted($ServerMask_txt; $baseSpec_txt; ->$MountVolume_txt))
	C_BOOLEAN:C305($Proceed_B)
	C_TEXT:C284($Directory_txt)
	$Proceed_B:=True:C214
	ARRAY TEXT:C222($DirectoryParts_atxt; 0)
	ut_NewTextToArray($baseSpec_txt; ->$DirectoryParts_atxt; "/")
	If (Folder separator:K24:12=":")
		$StartLoop_L:=3
		$Directory_txt:=$DirectoryParts_atxt{2}
	Else 
		$Directory_txt:=""
		$StartLoop_L:=3
		$MountLetter_txt:=Substring:C12($MountVolume_txt; 1; 2)
	End if 
	For ($Loop_L; $StartLoop_L; Size of array:C274($DirectoryParts_atxt))
		$Directory_txt:=$Directory_txt+Folder separator:K24:12+$DirectoryParts_atxt{$Loop_L}
		If (Test path name:C476($Directory_txt)=Is a folder:K24:2)
		Else 
			$Proceed_B:=False:C215
		End if 
	End for 
	
End if 
InitPers
INSP_Read_Write_Tables("READ")
SET FIELD RELATION:C919([ElementsSafety:29]InspID:4; Manual:K51:3; Manual:K51:3)
SHOW ON DISK:C922($Directory_txt)
$TempFolder_txt:=System folder:C487(Documents folder:K41:18)+"LocalInspectionPDF"
If (Test path name:C476($TempFolder_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($TempFolder_txt)
End if 
$TempFolder_txt:=$TempFolder_txt+Folder separator:K24:12

If ($Proceed_B)
	
	
	If (OK=1)
		ORDER BY:C49([Inspections:27]; [Bridge MHD NBIS:1]BDEPT:1; >)
		SELECTION TO ARRAY:C260([Inspections:27]Insp Date:78; $insp_aD; [Inspections:27]BIN:1; $Bins_atxt; [Inspections:27]Insp Type:6; $InspType_atxt; [Inspections:27]InspID:2; $inspIds_al)
		ARRAY LONGINT:C221($FilesSize_aL; Size of array:C274($inspIds_al))
		ARRAY LONGINT:C221($ElapsedTickCount_aL; Size of array:C274($inspIds_al))
		ARRAY TEXT:C222($FilePath_atxt; Size of array:C274($inspIds_al))
		C_LONGINT:C283($Loop_L; $RecordCount_L)
		C_OBJECT:C1216($Progress_obj)
		$RecordCount_L:=Records in selection:C76([Inspections:27])
		C_TEXT:C284($parse_txt)
		If ($Display_B)
			If (Length:C16($MonthYear_txt)=10)
				$parse_txt:="for  "+$MonthYear_txt
			Else 
				ARRAY TEXT:C222($parts_atxt; 0)
				ut_NewTextToArray($MonthYear_txt; ->$parts_atxt; "-")
				
				$parse_txt:="From "+$parts_atxt{3}+"/"+$parts_atxt{2}+"/"+$parts_atxt{1}
				
			End if 
			$Progress_obj:=ProgressNew("Creating "+String:C10($RecordCount_L)+" PDF inspection reports "+$parse_txt; $RecordCount_L; True:C214; ""; 3)
			
			
		End if 
		C_BOOLEAN:C305($NeedToCombinePdfs_B; $WriteLogFile_B)
		C_TEXT:C284($CreateInspLog_txt)
		
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		For ($Loop_l; 1; Records in selection:C76([Inspections:27]))
			
			insp_RemovePreviousPDF($TempFolder_txt)
			
			GOTO SELECTED RECORD:C245([Inspections:27]; $loop_l)
			
			$pos_L:=Find in array:C230($badInspIds_aL; [Inspections:27]InspID:2)
			If ($pos_L<1)
				If ($Display_B)
					UpdateProgressNew($Progress_obj; $loop_l)
				End if 
				$startTickCount_l:=Tickcount:C458
				
				
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
				QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
				
				If ([Combined Inspections:90]BMSInspID:3>0)
					QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
				Else 
					UNLOAD RECORD:C212([BMS Inspections:44])
				End if 
				
				If (PON_NBEDateOn_b([Inspections:27]Insp Date:78))
					PON_ListElements
					CLEAR SET:C117("PON_LISTINSPELEMS")  // we do not need the set created in PON_ListElements
				Else 
					DISPL_CUs
				End if 
				
				
				$TownPrefix_txt:=Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
				QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$TownPrefix_txt)
				$FinalDirectory_txt:=$MountLetter_txt+$Directory_txt+Folder separator:K24:12+$TownPrefix_txt+" "+[Town Data:2]Town Name:1
				
				QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
				
				//make sure town folder exists for this bridge
				If ($WriteLogFile_B)
					$doc_tm:=Append document:C265($DebugPath_txt)
					SEND PACKET:C103($doc_tm; [Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+\
						[Bridge MHD NBIS:1]BIN:3+Char:C90(Tab:K15:37)+\
						String:C10([Inspections:27]InspID:2)+Char:C90(Tab:K15:37)+\
						[Inspections:27]Insp Type:6+Char:C90(Tab:K15:37)+\
						String:C10([Inspections:27]Insp Date:78)+Char:C90(Carriage return:K15:38))
					CLOSE DOCUMENT:C267($doc_tm)
				End if 
				If (Test path name:C476($FinalDirectory_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($FinalDirectory_txt)
				End if 
				$FinalDirectory_txt:=$FinalDirectory_txt+Folder separator:K24:12+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3
				
				If (Test path name:C476($FinalDirectory_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($FinalDirectory_txt)
				End if 
				
				$FinalDirectory_txt:=$FinalDirectory_txt+Folder separator:K24:12+String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")
				If (Test path name:C476($FinalDirectory_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($FinalDirectory_txt)
				End if 
				
				
				
				$FileName_txt:=[Bridge MHD NBIS:1]BDEPT:1+"-"+[Bridge MHD NBIS:1]BIN:3+"-"+\
					String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")+"-"+\
					String:C10(Month of:C24([Inspections:27]Insp Date:78); "00")+"-"+\
					String:C10(Day of:C23([Inspections:27]Insp Date:78); "00")+"-"+\
					[Inspection Type:31]Description:2+".PDF"
				$FileName_txt:=Replace string:C233($FileName_txt; "/"; "_")
				$FileName_txt:=Replace string:C233($FileName_txt; ":"; "_")
				
				ARRAY TEXT:C222($Files_atxt; 0)
				C_TEXT:C284($TempFolder_txt; $ResultFile_txt)
				APPEND TO ARRAY:C911($Files_atxt; $TempFolder_txt+$FileName_txt)
				INSP_CreateAdditionalPages(->$Files_atxt; ->$TempFolder_txt)
				$NeedToCombinePdfs_B:=(Size of array:C274($Files_atxt)>1)
				
				G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1; ->[PON_ELEM_INSP:179]INSPID:21)
				
				INSP_BuildTmMbrArea
				INSP_SetPrintOptionsForPDF
				C_BOOLEAN:C305(INSP_CreatePDFsofApproved_B)
				INSP_CreatePDFsofApproved_B:=True:C214
				
				C_DATE:C307(<>Insp_ESignatureStart)
				C_BOOLEAN:C305($Esig_active_b)
				If (<>Insp_ESignatureStart#!00-00-00!)
					$Esig_active_b:=([Inspections:27]Insp Date:78>=<>Insp_ESignatureStart)
				End if 
				
				ON ERR CALL:C155("PrintTOPDFError")
				If ($NeedToCombinePdfs_B)
					SET PRINT OPTION:C733(Destination option:K47:7; 3; $TempFolder_txt+$FileName_txt)
				Else 
					SET PRINT OPTION:C733(Destination option:K47:7; 3; $FinalDirectory_txt+Folder separator:K24:12+$FileName_txt)
				End if 
				PRINT_PdfDest_b:=False:C215
				OPEN PRINTING JOB:C995
				
				If ($Esig_active_b)
					
					Print form:C5([Inspections:27]; "QCQAPrint")
					PAGE BREAK:C6
					
				End if 
				
				Case of 
					: ([Inspections:27]Insp Type:6="DV@")
						
						Print_Dive_F_PDF
						
					: (([Inspections:27]Insp Type:6="RT@"))
						
						PRINT_ROUTINE_F_PDF
						
					: ([Inspections:27]Insp Type:6="CUL")
						
						PRINT_CULVERT_F_PDF
						
					: ([Inspections:27]Insp Type:6="CMI") | ([Inspections:27]Insp Type:6="FCR") | ([Inspections:27]Insp Type:6="OTH")
						
						PRINT_Critical_PDF
						//PRINT_Critical 
					: ([Inspections:27]Insp Type:6="DAM")
						
						PRINT_Damage_PDF
						
						
					: ([Inspections:27]Insp Type:6="FRZ")
						
						PRINT_FREEZE_F_PDF
						
					: ([Inspections:27]Insp Type:6="CLD")
						
						PRINT_Closed_PDF
						
						
					: ([Inspections:27]Insp Type:6="PON")
						
						PRINT_PONTIS_F_PDF
						
					: ([Inspections:27]Insp Type:6="PED")
						
						INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
						PRINT_ROUTINE_F_PDF
						
					: ([Inspections:27]Insp Type:6="RRR")
						
						INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
						PRINT_ROUTINE_F_PDF
						
					: ([Inspections:27]Insp Type:6="PED")  //Pedestrian bridge
						
						INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
						PRINT_ROUTINE_F_PDF
						
					: ([Inspections:27]Insp Type:6="RRA")  //Rail routine arch
						
						INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
						PRINT_ROUTINE_F_PDF
						
					: ([Inspections:27]Insp Type:6="RRC")  //Rail routine culvert
						
						INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
						PRINT_CULVERT_F_PDF
						
					: ([Inspections:27]Insp Type:6="RRS") | ([Inspections:27]Insp Type:6="RRF") | ([Inspections:27]Insp Type:6="RRO")  //Rail special, fract crit, other
						
						INSP_LoadElmLabelsforReport([Inspections:27]BaseType_s:215)
						PRINT_Critical_PDF
						
					: ([Inspections:27]Insp Type:6="RRD")  //Rail damage
						
						INSP_LoadElmLabelsforReport([Inspections:27]BaseType_s:215)
						PRINT_Damage_PDF
						
					: ([Inspections:27]Insp Type:6="TAL")
						
						INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
						QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
						NTI_INIT
						PRINT_TunnelAllItems_F_PDF
						
					: ([Inspections:27]Insp Type:6="TOV")
						
						INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
						QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
						NTI_INIT
						PRINT_TunnelAllItems_F_PDF
						
					: (([Inspections:27]Insp Type:6="TSP") | ([Inspections:27]Insp Type:6="TDA") | ([Inspections:27]Insp Type:6="TOT"))
						
						INSP_LoadElmLabelsforReport("TAL")
						QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
						NTI_INIT
						PRINT_Critical_PDF
				End case 
				
				$ResultFile_txt:=$FinalDirectory_txt+Folder separator:K24:12+$FileName_txt
				
				
				CLOSE PRINTING JOB:C996
				If ($NeedToCombinePdfs_B)
					
					PDF_CombinePdfs(->$Files_atxt; $ResultFile_txt)
					
				End if 
				
				
				
				$ElapsedTickCount_aL{$Loop_L}:=Tickcount:C458-$startTickCount_l
				$FilePath_atxt{$Loop_L}:=$FinalDirectory_txt+Folder separator:K24:12+$FileName_txt
			Else 
				If ($WriteLogFile_B)
					$doc_tm:=Append document:C265($DebugPath_txt)
					SEND PACKET:C103($doc_tm; [Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+\
						[Bridge MHD NBIS:1]BIN:3+Char:C90(Tab:K15:37)+\
						String:C10([Inspections:27]InspID:2)+Char:C90(Tab:K15:37)+\
						[Inspections:27]Insp Type:6+Char:C90(Tab:K15:37)+\
						String:C10([Inspections:27]Insp Date:78)+Char:C90(Tab:K15:37)+"skipped inspection"+Char:C90(Carriage return:K15:38))
					CLOSE DOCUMENT:C267($Doc_tm)
				End if 
			End if 
		End for 
		//SET PRINT OPTION(_o_Hide printing progress option; 0)  // display again
		Progress QUIT(OB Get:C1224($Progress_obj; "progress"; Is longint:K8:6))
		For ($Loop_L; 1; Size of array:C274($FilesSize_aL))
			$FilesSize_aL{$Loop_L}:=Get document size:C479($FilePath_atxt{$Loop_L})
			If ($FilesSize_aL{$Loop_L}=0)
				APPEND TO ARRAY:C911(SQL_InternalDescriptions_atxt; "File size 0 for file "+$FilePath_atxt{$Loop_L})
				
			End if 
		End for 
		$Report_txt:="Inspection ID,Inspection Date,BIN,Inspection Type,Elapsed Tick Count,File Size,Doc Path\n"+\
			ut_ArrayToText_CSV(","; ->$inspIds_al; ->$insp_aD; ->$Bins_atxt; ->$InspType_atxt; ->$ElapsedTickCount_aL; ->$FilesSize_aL; ->$FilePath_atxt)
		$FileName_txt:="ValidInsp_"+$MonthYear_txt+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 8)+".csv"
		TEXT TO DOCUMENT:C1237($DocPath_ptr->+$FileName_txt; $Report_txt; UTF8 text without length:K22:17)
		$PathToOpen_txt:=$DocPath_ptr->+$FileName_txt
		Repeat 
			//IDLE
			DELAY PROCESS:C323(Current process:C322; 20)
		Until (Test path name:C476($PathToOpen_txt)=Is a document:K24:1)
		APPEND TO ARRAY:C911(MAILAttachments_atxt; $DocPath_ptr->+$FileName_txt)
	End if 
Else 
	If ($CallingMethod_txt="INSP_CreateApprovedPDFS")
	Else 
		ALERT:C41("This run failed as either volume not mounted or problem with folder path "+$Directory_txt)
	End if 
End if 

CLOSE DOCUMENT:C267($doc_tm)
Repeat 
	//IDLE
	DELAY PROCESS:C323(Current process:C322; 20)
Until (Test path name:C476($DebugPath_txt)=Is a document:K24:1)
APPEND TO ARRAY:C911(MAILAttachments_atxt; $DebugPath_txt)

//End INSP_PrintToPDF