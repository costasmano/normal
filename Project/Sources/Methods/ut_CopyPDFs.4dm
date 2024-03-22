//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/28/16, 12:10:27
//----------------------------------------------------
//Method: ut_CopyPDFs
//Description
//This method will copy pdfs to corrrect folder structure so it can be viewd later. It if the same as
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (6/28/16 12:10:30)
	// Modified by: CJ MIller-(Designer)-(3/16/17 16:32:35)
	Mods_2017_03
	//changes
	//Thisd is the correct one 
End if 
Progress QUIT(0)
Compiler_CNV
C_BOOLEAN:C305(SQLConnectionMade_b; SQLError_b)

Compiler_clone
Compiler_SQL
SQLConnectionMade_b:=False:C215
SQLError_b:=False:C215

clone_ControlConnect

If (SQLConnectionMade_b)
	C_TEXT:C284($CopyToPath_txt; $Line_txt; $PL_DirectorySep_s; $ConvertedFolderPath_txt; $SavedPDFSFolderPath_txt; $DocumentName_txt; $NewFolderPath_txt)
	
	C_LONGINT:C283($Loop_L; $InspectionID_L; $PhotoID_L; $Platform_L)
	$ConvertedFolderPath_txt:=Select folder:C670("Select folder that has converted Pictures [MoveTo]")
	
	If (OK=1)
		$SavedPDFSFolderPath_txt:=Select folder:C670("Select folder that has previously saved PDFs [Originals:PDF_FilesToConvert]")
		If (OK=1)
			FOLDER LIST:C473($SavedPDFSFolderPath_txt; $Folders_atxt)
			
			ARRAY TEXT:C222($Paths_atxt; 0)
			ARRAY TEXT:C222($PictureExtension_atxt; 0)
			ARRAY LONGINT:C221($InspectionIDs_aL; 0)
			ARRAY LONGINT:C221($PhotoIDs_aL; 0)
			
			C_DATE:C307($SqlinspDate_d)
			
			$Line_txt:="Start Process on "+String:C10(Current date:C33; 7)+" at "+String:C10(Current time:C178; HH MM SS:K7:1)+Char:C90(Carriage return:K15:38)
			$Line_txt:=$Line_txt+"Photo ID"+Char:C90(Tab:K15:37)+"Inspection ID"+Char:C90(Tab:K15:37)+"Picture Size"+Char:C90(Tab:K15:37)+"Status"+Char:C90(Carriage return:K15:38)
			C_TIME:C306($Doc_tm)
			$DocumentName_txt:="CopyPDFLog_"+String:C10(Current process:C322)+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
			
			CNV_Doc_tm:=Create document:C266($ConvertedFolderPath_txt+$DocumentName_txt)
			SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
			$Line_txt:=""
			
			//_O_PLATFORM PROPERTIES($Platform_L)// MassDOT_PS - conversion v19R7
			If ($Platform_L=Windows:K25:3)
				$PL_DirectorySep_s:="\\"
			Else 
				$PL_DirectorySep_s:=":"
			End if 
			
			C_LONGINT:C283($FolderLoop_L; $ProgressBar_L; $FolderProgress_L)
			$FolderProgress_L:=Progress New
			For ($FolderLoop_L; 1; Size of array:C274($Folders_atxt))
				Progress SET PROGRESS($FolderProgress_L; $FolderLoop_L/Size of array:C274($Folders_atxt); "Processing documents in "+$Folders_atxt{$FolderLoop_L})
				$NewFolderPath_txt:=$SavedPDFSFolderPath_txt+$Folders_atxt{$FolderLoop_L}+":"
				ARRAY TEXT:C222($Documents_atxt; 0)
				DOCUMENT LIST:C474($NewFolderPath_txt; $Documents_atxt)
				$ProgressBar_L:=Progress New
				
				
				For ($Loop_L; 1; Size of array:C274($Documents_atxt))
					
					If (Position:C15("."; $Documents_atxt{$Loop_L})=1) | ($Documents_atxt{$Loop_L}="thumbs.db")
						
					Else 
						Progress SET PROGRESS($ProgressBar_L; $Loop_L/Size of array:C274($Documents_atxt); "Processing document "+$Documents_atxt{$Loop_L})
						ARRAY TEXT:C222($Parts_atxt; 0)
						ut_NewTextToArray($Documents_atxt{$Loop_L}; ->$Parts_atxt; ".")
						If ($Parts_atxt{2}="PDF")
							ARRAY TEXT:C222($DocParts_atxt; 0)
							ut_NewTextToArray($Parts_atxt{1}; ->$DocParts_atxt; "_")
							
							Case of 
								: (Size of array:C274($DocParts_atxt)=1)
									$PhotoID_L:=Num:C11($Parts_atxt{1})
									QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=$PhotoID_L)
									$InspectionID_L:=[Standard Photos:36]InspID:1
								: (Size of array:C274($DocParts_atxt)=2)
									$InspectionID_L:=Num:C11($DocParts_atxt{1})
									$PhotoID_L:=Num:C11($DocParts_atxt{2})
									
							End case 
							$Line_txt:=String:C10($PhotoID_L)+Char:C90(Tab:K15:37)+String:C10($InspectionID_L)+Char:C90(Tab:K15:37)
							$Line_txt:=$Line_txt+String:C10(Get document size:C479($NewFolderPath_txt+$Documents_atxt{$Loop_L}))+Char:C90(Tab:K15:37)
							C_LONGINT:C283($SqlinspID_L)
							
							QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$InspectionID_L)
							If (Records in selection:C76([Inspections:27])=0)
								
								Begin SQL
									select
									[Inspections].[Insp Date],
									[Inspections].[InspID]
									from
									[Inspections]
									where
									
									[Inspections].[InspID] = :$InspectionID_L
									into
									:$SqlinspDate_d,
									:$SqlinspID_L;
								End SQL
								START TRANSACTION:C239
								
								CREATE RECORD:C68([Inspections:27])
								[Inspections:27]InspID:2:=$InspectionID_L
								[Inspections:27]Insp Date:78:=$SqlinspDate_d
								SAVE RECORD:C53([Inspections:27])
							End if 
							If ([Inspections:27]Insp Date:78=!00-00-00!)
								
								
								If (In transaction:C397)
									If ($SqlinspID_L=0)
										$Line_txt:=$Line_txt+Char:C90(Tab:K15:37)+"Remote Inspection date is !00-00-00! no inspection record found no copy took place"+Char:C90(Tab:K15:37)
									Else 
										$Line_txt:=$Line_txt+Char:C90(Tab:K15:37)+"Remote Inspection date is !00-00-00! no copy took place"+Char:C90(Tab:K15:37)
									End if 
									CANCEL TRANSACTION:C241
								Else 
									$Line_txt:=$Line_txt+Char:C90(Tab:K15:37)+"Local Inspection date is !00-00-00! no copy took place"+Char:C90(Tab:K15:37)
								End if 
								SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
								SEND PACKET:C103(CNV_Doc_tm; Char:C90(Carriage return:K15:38))
							Else 
								$CopyToPath_txt:=CNV_CreateNewPath(String:C10($InspectionID_L); $ConvertedFolderPath_txt)
								//$CopyToPath_txt:=CNV_CreatePath ($PL_DirectorySep_s;$ConvertedFolderPath_txt)
								$Line_txt:=$Line_txt+"Calculated path is "+$CopyToPath_txt+Char:C90(Tab:K15:37)
								If (In transaction:C397)
									CANCEL TRANSACTION:C241
								End if 
								
								SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
								If ($Platform_L=Windows:K25:3)
									$CopyToPath_txt:=Replace string:C233($CopyToPath_txt; ":"; $PL_DirectorySep_s)
								Else 
									$CopyToPath_txt:=Replace string:C233($CopyToPath_txt; "\\"; $PL_DirectorySep_s)
								End if 
								
								Repeat 
									TryAgain_L:=2
									
									ON ERR CALL:C155("CNV_CopyError")
									COPY DOCUMENT:C541($NewFolderPath_txt+$Documents_atxt{$Loop_L}; $CopyToPath_txt+String:C10($PhotoID_L)+"."+$Parts_atxt{2}; *)
									
									ON ERR CALL:C155("")
								Until (TryAgain_L=2) | (TryAgain_L=3) | (TryAgain_L=4)
								If (TryAgain_L=2)
									SEND PACKET:C103(CNV_Doc_tm; String:C10($InspectionID_L)+Char:C90(Tab:K15:37)+$Documents_atxt{$Loop_L}+Char:C90(Tab:K15:37)+$NewFolderPath_txt+Char:C90(Tab:K15:37)+$CopyToPath_txt+Char:C90(Carriage return:K15:38))
								Else 
									SEND PACKET:C103(CNV_Doc_tm; Char:C90(Carriage return:K15:38)+String:C10($InspectionID_L)+Char:C90(Tab:K15:37)+$Documents_atxt{$Loop_L}+Char:C90(Tab:K15:37)+$NewFolderPath_txt+Char:C90(Tab:K15:37)+$CopyToPath_txt+"Unknown error code listed above"+Char:C90(Carriage return:K15:38))
								End if 
								
								SEND PACKET:C103(CNV_Doc_tm; Char:C90(Carriage return:K15:38))
							End if 
						End if 
					End if 
					
					
				End for 
				Progress QUIT($ProgressBar_L)
				
			End for 
			Progress QUIT($FolderProgress_L)
			
		End if 
	End if 
	SQL LOGOUT:C872
	CLOSE DOCUMENT:C267(CNV_Doc_tm)
	ALERT:C41("completing orocessing "+$SavedPDFSFolderPath_txt)
End if 

//End ut_CopyPDFs