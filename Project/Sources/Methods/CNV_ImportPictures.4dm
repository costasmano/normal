//%attributes = {"invisible":true}
// Method: CNV_ImportPictures
// Description
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name(OS): administrator
	// Date and time: 06/16/16, 13:13:39
	// ----------------------------------------------------
	Mods_2015_10  // 
	// Modified by: administrator(6/16/16 13:13:42)
	Mods_2017_04
	// Modified by: Costas Manousakis-(Designer)-(2021-09-27T00:00:00 14:04:17)
	Mods_2021_09
	//  `remove hmfree
End if 

READ ONLY:C145(*)
READ WRITE:C146([Parameters:107])
READ WRITE:C146([Standard Photos:36])

Compiler_CNV
C_BLOB:C604($1; $BlobWithArray_BLB)
$BlobWithArray_BLB:=$1
C_LONGINT:C283($Offset_L)
C_DATE:C307($CNV_Start_d; $CNV_End_d)
$Offset_L:=0
C_TEXT:C284(ColumnWidths_txt)
ARRAY LONGINT:C221(CNV_RecordNumber_aL; 0)
C_BOOLEAN:C305($RunAttended_B)
BLOB TO VARIABLE:C533($BlobWithArray_BLB; ColumnWidths_txt; $Offset_L)
BLOB TO VARIABLE:C533($BlobWithArray_BLB; $RunAttended_B; $Offset_L)
BLOB TO VARIABLE:C533($BlobWithArray_BLB; CNV_RecordNumber_aL; $Offset_L)
BLOB TO VARIABLE:C533($BlobWithArray_BLB; $StartingPath_txt; $Offset_L)
BLOB TO VARIABLE:C533($BlobWithArray_BLB; $CNV_Start_d; $Offset_L)
BLOB TO VARIABLE:C533($BlobWithArray_BLB; $CNV_End_d; $Offset_L)
ON ERR CALL:C155("4D_Errors")

C_LONGINT:C283($TableNumber_L; $InnerLoop_L)
$Offset_L:=0
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PictImp_@")
CREATE EMPTY SET:C140([Standard Photos:36]; "ProcessedSet")
For ($Offset_L; 1; Records in selection:C76([Parameters:107]))
	GOTO SELECTED RECORD:C245([Parameters:107]; $Offset_L)
	If ([Parameters:107]Description:2#"")
		ARRAY TEXT:C222($recordnumber_atxt; 0)
		ut_NewTextToArray([Parameters:107]Description:2; ->$recordnumber_atxt; ",")
		ARRAY LONGINT:C221($recordnumber_aL; 0)
		ARRAY LONGINT:C221($recordnumber_aL; Size of array:C274($recordnumber_atxt))
		
		If (Size of array:C274($recordnumber_atxt)>0)
			For ($InnerLoop_L; 1; Size of array:C274($recordnumber_atxt))
				$recordnumber_aL{$InnerLoop_L}:=Num:C11($recordnumber_atxt{$InnerLoop_L})
			End for 
			CREATE SET FROM ARRAY:C641([Standard Photos:36]; $recordnumber_aL; "InterimSet")
			UNION:C120("ProcessedSet"; "InterimSet"; "ProcessedSet")
		End if 
	End if 
End for 
CLEAR SET:C117("InterimSet")
C_TEXT:C284($ParamRecordName_txt)
$ParamRecordName_txt:="PictImp_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)
Repeat 
	QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$ParamRecordName_txt)
	If (Records in selection:C76([Parameters:107])=0)
	Else 
		DELAY PROCESS:C323(Current process:C322; 10)
		$ParamRecordName_txt:="PictImp_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)
	End if 
	
Until (Records in selection:C76([Parameters:107])=0)
CREATE RECORD:C68([Parameters:107])
[Parameters:107]ParamCode:1:=$ParamRecordName_txt
SAVE RECORD:C53([Parameters:107])

ARRAY LONGINT:C221($PhotoIDs_aL; 0)
ARRAY TEXT:C222($LocalPhotoIDs_atxt; 0)
ARRAY TEXT:C222($RemotePhotoIDs_atxt; 0)
C_TEXT:C284($Status_txt; $StartingPath_txt; $JPGPicturePath_txt; $PNGPicturePath_txt; $TIFPicturePath_txt; $OtherPicturePath_txt; $FileName_txt)
C_LONGINT:C283($JPEGSize_L; $PNGSize_L; $TIFSize_L; $OtherSize_L; $PictW_L; $PictH_L)
If (Test path name:C476($StartingPath_txt)=Is a folder:K24:2)
	OK:=1
Else 
	$StartingPath_txt:=Select folder:C670("Select folder that has Converted Files")
End if 
If (OK=1)
	C_LONGINT:C283($InvalidFormat_L; $imgSize_L)
	//If (hmFree_IsLicensed >=0)
	//Else 
	//$imgSize_L:=hmFree_Register ("rLhAA-YcUAGWAAAAJCAMoBksABRAD+AGtAJbF-+")
	//End if 
	
	C_BOOLEAN:C305($ProcessingDistrict_B; $DoImport_B)
	$ProcessingDistrict_B:=False:C215
	
	C_BOOLEAN:C305($Proceed_B)
	$Proceed_B:=True:C214
	If (Records in table:C83([FileIDRes Table:60])>0)
		$ProcessingDistrict_B:=True:C214
		$TableNumber_L:=Table:C252(->[Standard Photos:36])
		Begin SQL
			select
			[FileIDRes Table].[Destination ID],
			[FileIDRes Table].[Local ID]
			from
			[FileIDRes Table]
			where
			[FileIDRes Table].[File Number] = :$TableNumber_L
			and 
			[FileIDRes Table].[Destination] = 'here'
			into
			:$LocalPhotoIDs_atxt,
			:$RemotePhotoIDs_atxt; 
			
			
			
		End SQL
		C_TEXT:C284($LastID_txt)
		C_LONGINT:C283($LastID_L)
		
	End if 
	$LastID_txt:=""
	$LastID_L:=0
	QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="ConvertLastREFID")
	If (Records in selection:C76([Parameters:107])>0)
		$LastID_txt:=[Parameters:107]Value:3
		UNLOAD RECORD:C212([Parameters:107])
		
	End if 
	$LastID_txt:=Request:C163("Enter Last REFID transferred"; $LastID_txt)
	$LastID_L:=Num:C11($LastID_txt)
	
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "ActivityLogSet")
	
	
	QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28>=$LastID_L; *)
	QUERY:C277([Activity Log:59];  & [Activity Log:59]FileID Local:24=36; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3#"NRC")
	C_BOOLEAN:C305($Proceed_B)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	CONFIRM:C162("Continue with import where there are "+String:C10(Records in set:C195("ActivityLogSet"))+" Activity Log file Records to process")
	$Proceed_B:=(OK=1)
	
	If ($Proceed_B)
		
		C_LONGINT:C283($MissingCount_L; $DeprecatedCount_L; $NotDeprecatedCount_L)
		$MissingCount_L:=0
		$DeprecatedCount_L:=0
		$NotDeprecatedCount_L:=0
		
		ARRAY TEXT:C222($Paths_atxt; 0)
		ARRAY LONGINT:C221($InspectionIDs_aL; 0)
		ARRAY LONGINT:C221($PhotoIDs_aL; 0)
		ARRAY TEXT:C222($PictureExtension_atxt; 0)
		C_BLOB:C604($Exported_blb)
		C_LONGINT:C283($Offset_L)
		
		C_LONGINT:C283($ImportLoop_L; $Position_L; $RemotePosition_L)
		CREATE SET FROM ARRAY:C641([Standard Photos:36]; CNV_RecordNumber_aL; "SelectedSet")
		DIFFERENCE:C122("SelectedSet"; "ProcessedSet"; "SelectedSet")
		READ WRITE:C146([Standard Photos:36])
		USE SET:C118("SelectedSet")
		CLEAR SET:C117("SelectedSet")
		CLEAR SET:C117("ProcessedSet")
		C_TEXT:C284($localID_txt; $RemoteID_txt; $DocName_txt)
		C_BLOB:C604($DataBlob_blb)
		C_LONGINT:C283($ActLogLoop_L; $StdPhotoFieldNumber_L; $BlobOffset_l)
		$StdPhotoFieldNumber_L:=Field:C253(->[Standard Photos:36]Std Photo:3)
		CNV_StopMe_B:=False:C215
		$ImportLoop_L:=1
		C_BLOB:C604($Picture_blb)
		C_TIME:C306($ProcessRpt_tm)
		C_TEXT:C284($ExtraFileName_txt)
		
		$ExtraFileName_txt:=Replace string:C233(G_GetServerTCP; "."; "-"; 99)
		
		$DocName_txt:="ImportedPictures_"+Application version:C493+"_"+$ExtraFileName_txt+"_"+String:C10(Current process:C322)+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
		C_LONGINT:C283($OriginalSize_L; $NewSize_L; $IsBlobCompressed_l; $NumberofFields_l)
		
		CNV_Doc_tm:=Create document:C266($StartingPath_txt+$DocName_txt)
		SEND PACKET:C103(CNV_Doc_tm; "Start date"+Char:C90(Tab:K15:37)+String:C10($CNV_Start_d)+Char:C90(Tab:K15:37)+"End date"+Char:C90(Tab:K15:37)+String:C10($CNV_End_d)+Char:C90(Carriage return:K15:38))
		
		SEND PACKET:C103(CNV_Doc_tm; "Inspection ID"+Char:C90(Tab:K15:37)+"Photo ID"+Char:C90(Tab:K15:37)+"Remote ID"+Char:C90(Tab:K15:37)+"Old size"+Char:C90(Tab:K15:37)+"New Size"+Char:C90(Tab:K15:37)+"Status"+Char:C90(Carriage return:K15:38))
		
		
		C_LONGINT:C283($Size_L; $win)
		$win:=ut_OpenNewWindow(500; 200; 5; 4; "Importing [Standard Photos] "+String:C10(Current process:C322))
		C_TIME:C306($StartTime_tm; $RemainingTime_tm; $Elapsed_tm)
		C_BLOB:C604($NewPicture_blb)
		
		$StartTime_tm:=Current time:C178
		$Size_L:=Records in selection:C76([Standard Photos:36])
		C_BOOLEAN:C305($IsDepracated_B)
		
		
		
		Repeat 
			GOTO SELECTED RECORD:C245([Standard Photos:36]; $importLoop_L)
			$RemoteID_txt:="N/A Is not Deprecated"
			GOTO XY:C161(5; 2)
			MESSAGE:C88("Updating "+String:C10($importLoop_L)+" out of "+String:C10($Size_L))
			GOTO XY:C161(5; 5)
			GOTO XY:C161(5; 6)
			MESSAGE:C88("Processing standard photo ID "+String:C10([Standard Photos:36]StdPhotoID:7))
			
			GOTO XY:C161(5; 7)
			$RemainingTime_tm:=(($Size_L/$importLoop_L)-1)*(Current time:C178-$StartTime_tm)
			MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
			GOTO XY:C161(5; 9)
			
			$Elapsed_tm:=Current time:C178-$StartTime_tm
			MESSAGE:C88("Elapsed time is "+Time string:C180($Elapsed_tm))
			$OriginalSize_L:=Picture size:C356([Standard Photos:36]Std Photo:3)
			$IsDepracated_B:=False:C215
			//ARRAY TEXT($TypesFound_atxt;0)
			//hmFree_GET PICTURE TYPES ([Standard Photos]Std Photo;$TypesFound_atxt)
			//$IsDepracated_B:=(Ô11999;51Ô (->[Standard Photos]Std Photo)=1)
			
			If ($OriginalSize_L>0) & ($IsDepracated_B)
				PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $PictW_L; $PictH_L)
			End if 
			If ($IsDepracated_B)
				
				$DoImport_B:=True:C214
				
				If ($ProcessingDistrict_B) & ($IsDepracated_B)
					USE SET:C118("ActivityLogSet")
					QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Local ID:15=String:C10([Standard Photos:36]StdPhotoID:7))
					
					For ($ActLogLoop_L; 1; Records in selection:C76([Activity Log:59]))
						GOTO SELECTED RECORD:C245([Activity Log:59]; $ActLogLoop_L)
						Case of 
							: ([Activity Log:59]Activity Type:3="DRC")
								$DoImport_B:=False:C215
								
							Else 
								$BlobOffset_l:=0
								SET BLOB SIZE:C606($DataBlob_blb; 0)
								$DataBlob_blb:=[Activity Log:59]Data:10
								BLOB PROPERTIES:C536($DataBlob_blb; $IsBlobCompressed_l)
								If ($IsBlobCompressed_l#Is not compressed:K22:11)
									EXPAND BLOB:C535($DataBlob_blb)
								End if 
								BLOB TO VARIABLE:C533($DataBlob_blb; $NumberofFields_l; $BlobOffset_l)
								ARRAY INTEGER:C220($FieldNumbers_al; 0)
								BLOB TO VARIABLE:C533($DataBlob_blb; $FieldNumbers_al; $BlobOffset_l)  // get the list of field numbers
								If (Find in array:C230($FieldNumbers_al; $StdPhotoFieldNumber_L)>0)
									$DoImport_B:=False:C215
								End if 
						End case 
						
					End for 
					
				End if 
				If ($DoImport_B)
					
					$localID_txt:=String:C10([Standard Photos:36]StdPhotoID:7)
					QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Standard Photos:36]InspID:1)
					
					$Position_L:=Find in array:C230($LocalPhotoIDs_atxt; $localID_txt)
					Case of 
							
						: (Records in table:C83([FileIDRes Table:60])=0)
							$RemoteID_txt:=$localID_txt
						: ($Position_L>0)
							$RemoteID_txt:=$RemotePhotoIDs_atxt{$Position_L}
						Else 
							$RemoteID_txt:=$localID_txt
					End case 
					SET BLOB SIZE:C606($NewPicture_blb; 0)
					SEND PACKET:C103(CNV_Doc_tm; String:C10([Standard Photos:36]InspID:1)+Char:C90(Tab:K15:37)+String:C10([Standard Photos:36]StdPhotoID:7)+Char:C90(Tab:K15:37)+$RemoteID_txt+Char:C90(Tab:K15:37)+String:C10($OriginalSize_L)+Char:C90(Tab:K15:37))
					
					
					Case of 
							
						: (Not:C34($IsDepracated_B)) | ($OriginalSize_L=0)
							
							SEND PACKET:C103(CNV_Doc_tm; Char:C90(Tab:K15:37)+"Picture not Deprecated"+Char:C90(Carriage return:K15:38))
							If ($OriginalSize_L=0)
							Else 
								$NotDeprecatedCount_L:=$NotDeprecatedCount_L+1
							End if 
							
						: ($IsDepracated_B)
							
							$DeprecatedCount_L:=$DeprecatedCount_L+1
							C_TEXT:C284($PicturePath_txt; $Extension_txt)
							
							$PicturePath_txt:=CNV_CreateNewPath(String:C10([Standard Photos:36]InspID:1); $StartingPath_txt)
							//CNV_CreatePath (<>PL_DirectorySep_s;$StartingPath_txt)
							$Extension_txt:=""
							$JPEGSize_L:=0
							$PNGSize_L:=0
							$TIFSize_L:=0
							If (Test path name:C476($PicturePath_txt+$RemoteID_txt+".jpg")=Is a document:K24:1)
								$JPEGSize_L:=Get document size:C479($PicturePath_txt+$RemoteID_txt+".jpg")
							End if 
							If (Test path name:C476($PicturePath_txt+$RemoteID_txt+".png")=Is a document:K24:1)
								$PNGSize_L:=Get document size:C479($PicturePath_txt+$RemoteID_txt+".png")
							End if 
							If (Test path name:C476($PicturePath_txt+$RemoteID_txt+".tif")=Is a document:K24:1)
								$TIFSize_L:=Get document size:C479($PicturePath_txt+$RemoteID_txt+".tif")
							End if 
							ARRAY TEXT:C222($Type_atxt; 0)
							ARRAY LONGINT:C221($Size_al; 0)
							ARRAY LONGINT:C221($Sequence_al; 0)
							
							If ($JPEGSize_L>0)
								APPEND TO ARRAY:C911($Size_al; $JPEGSize_L)
								APPEND TO ARRAY:C911($Type_atxt; ".jpg")
								APPEND TO ARRAY:C911($Sequence_al; 1)
							End if 
							
							If ($TIFSize_L>0)
								APPEND TO ARRAY:C911($Size_al; $TIFSize_L)
								APPEND TO ARRAY:C911($Type_atxt; ".tif")
								APPEND TO ARRAY:C911($Sequence_al; 3)
							End if 
							If ($PNGSize_L>0)
								APPEND TO ARRAY:C911($Size_al; $PNGSize_L)
								APPEND TO ARRAY:C911($Type_atxt; ".png")
								APPEND TO ARRAY:C911($Sequence_al; 2)
							End if 
							
							MULTI SORT ARRAY:C718($Size_al; >; $Sequence_al; >; $Type_atxt)
							
							If (Size of array:C274($Type_atxt)>0)
								$Extension_txt:=$Type_atxt{1}
								READ PICTURE FILE:C678($PicturePath_txt+$RemoteID_txt+$Extension_txt; [Standard Photos:36]Std Photo:3)
								
								$NewSize_L:=Picture size:C356([Standard Photos:36]Std Photo:3)
								SEND PACKET:C103(CNV_Doc_tm; String:C10($NewSize_L)+Char:C90(Tab:K15:37)+"Processed picture from "+$PicturePath_txt+$RemoteID_txt+$Extension_txt+Char:C90(Carriage return:K15:38))
								SAVE RECORD:C53([Standard Photos:36])
							Else 
								$NewSize_L:=0
								$MissingCount_L:=$MissingCount_L+1
								SEND PACKET:C103(CNV_Doc_tm; String:C10($NewSize_L)+Char:C90(Tab:K15:37)+"MISSING Picture from "+$PicturePath_txt+$RemoteID_txt+Char:C90(Carriage return:K15:38))
							End if 
							If (Length:C16([Parameters:107]Description:2)>25000)
								SAVE RECORD:C53([Parameters:107])
								$ParamRecordName_txt:="PictImp_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)
								Repeat 
									QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$ParamRecordName_txt)
									If (Records in selection:C76([Parameters:107])=0)
									Else 
										DELAY PROCESS:C323(Current process:C322; 10)
										$ParamRecordName_txt:="PictImp_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)
									End if 
									
								Until (Records in selection:C76([Parameters:107])=0)
								CREATE RECORD:C68([Parameters:107])
								[Parameters:107]ParamCode:1:=$ParamRecordName_txt
								SAVE RECORD:C53([Parameters:107])
							End if 
							If ([Parameters:107]Description:2#"")
								[Parameters:107]Description:2:=[Parameters:107]Description:2+","+String:C10(Record number:C243([Standard Photos:36]))
							Else 
								[Parameters:107]Description:2:=String:C10(Record number:C243([Standard Photos:36]))
							End if 
							SAVE RECORD:C53([Parameters:107])
							
						Else 
							SEND PACKET:C103(CNV_Doc_tm; "0"+Char:C90(Tab:K15:37)+"Local record not found in export inspection date is "+String:C10([Inspections:27]Insp Date:78)+Char:C90(Carriage return:K15:38))
							
							
					End case 
				Else 
					
				End if 
			Else 
				
				SEND PACKET:C103(CNV_Doc_tm; String:C10([Standard Photos:36]InspID:1)+Char:C90(Tab:K15:37)+String:C10([Standard Photos:36]StdPhotoID:7)+Char:C90(Tab:K15:37)+$RemoteID_txt+Char:C90(Tab:K15:37)+String:C10($OriginalSize_L)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+"Picture not Deprecated"+Char:C90(Carriage return:K15:38))
				$NotDeprecatedCount_L:=$NotDeprecatedCount_L+1
				If (Length:C16([Parameters:107]Description:2)>25000)
					SAVE RECORD:C53([Parameters:107])
					$ParamRecordName_txt:="PictImp_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)
					Repeat 
						QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$ParamRecordName_txt)
						If (Records in selection:C76([Parameters:107])=0)
						Else 
							DELAY PROCESS:C323(Current process:C322; 10)
							$ParamRecordName_txt:="PictImp_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)
						End if 
						
					Until (Records in selection:C76([Parameters:107])=0)
					CREATE RECORD:C68([Parameters:107])
					[Parameters:107]ParamCode:1:=$ParamRecordName_txt
					SAVE RECORD:C53([Parameters:107])
				End if 
				If ([Parameters:107]Description:2#"")
					[Parameters:107]Description:2:=[Parameters:107]Description:2+","+String:C10(Record number:C243([Standard Photos:36]))
				Else 
					[Parameters:107]Description:2:=String:C10(Record number:C243([Standard Photos:36]))
				End if 
				SAVE RECORD:C53([Parameters:107])
				
				
			End if 
			$ImportLoop_L:=$ImportLoop_L+1
		Until (($ImportLoop_L>$Size_L) | (CNV_StopMe_B))
		SEND PACKET:C103(CNV_Doc_tm; "Start time is "+Time string:C180($StartTime_tm)+Char:C90(Carriage return:K15:38))
		SEND PACKET:C103(CNV_Doc_tm; "Elapsed time is "+Time string:C180($elapsed_tm)+Char:C90(Carriage return:K15:38))
		
		SEND PACKET:C103(CNV_Doc_tm; "current time is "+Time string:C180(Current time:C178)+Char:C90(Carriage return:K15:38))
		SEND PACKET:C103(CNV_Doc_tm; "Process count "+String:C10($ImportLoop_L)+Char:C90(Carriage return:K15:38))
		SEND PACKET:C103(CNV_Doc_tm; "Deprecated Count "+String:C10($DeprecatedCount_L)+Char:C90(Carriage return:K15:38))
		SEND PACKET:C103(CNV_Doc_tm; "Missing Count "+String:C10($MissingCount_L)+Char:C90(Carriage return:K15:38))
		SEND PACKET:C103(CNV_Doc_tm; "Not Deprecated Count "+String:C10($NotDeprecatedCount_L)+Char:C90(Carriage return:K15:38))
		
		
		$ImportLoop_L:=Find in array:C230(<>CNV_UpdatePictProcessIDs_aL; Current process:C322)
		If ($ImportLoop_L>0)
			
			DELETE FROM ARRAY:C228(<>CNV_UpdatePictProcessIDs_aL; $ImportLoop_L; 1)
			DELETE FROM ARRAY:C228(<>CNV_ProcessName_atxt; $ImportLoop_L; 1)
			
		End if 
		CLOSE DOCUMENT:C267(CNV_Doc_tm)
		
	End if 
End if 