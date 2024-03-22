//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/16/16, 13:13:39
//----------------------------------------------------
//Method: CNV_ImportPictures
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (6/16/16 13:13:42)
	
End if 
Compiler_CNV
C_LONGINT:C283($TableNumber_L)
ARRAY LONGINT:C221($PhotoIDs_aL; 0)
ARRAY TEXT:C222($LocalPhotoIDs_atxt; 0)
ARRAY TEXT:C222($RemotePhotoIDs_atxt; 0)
C_TEXT:C284($Status_txt)

If (Records in table:C83([FileIDRes Table:60])>0)
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
	
	
End if 
ARRAY TEXT:C222($Files_atxt; 0)

C_TEXT:C284($NewFolderPath_txt; $BlobDocumentPath_txt; $ProcessedDocumentPath_txt)
$BlobDocumentPath_txt:=Select document:C905(""; ""; "Select Combined Blob Document"; Multiple files:K24:7; $Files_atxt)
$BlobDocumentPath_txt:=$Files_atxt{1}
If (Test path name:C476($BlobDocumentPath_txt)=Is a document:K24:1)
	
	ARRAY TEXT:C222($Paths_atxt; 0)
	ARRAY LONGINT:C221($InspectionIDs_aL; 0)
	ARRAY LONGINT:C221($PhotoIDs_aL; 0)
	ARRAY TEXT:C222($PictureExtension_atxt; 0)
	C_BLOB:C604($Exported_blb)
	C_LONGINT:C283($Offset_L)
	
	DOCUMENT TO BLOB:C525($BlobDocumentPath_txt; $Exported_blb)
	$Offset_L:=0
	BLOB TO VARIABLE:C533($Exported_blb; $Paths_atxt; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $InspectionIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PhotoIDs_aL; $Offset_L)
	BLOB TO VARIABLE:C533($Exported_blb; $PictureExtension_atxt; $Offset_L)
	C_LONGINT:C283($ImportLoop_L; $Position_L; $RemotePosition_L)
	$ProcessedDocumentPath_txt:=Replace string:C233($BlobDocumentPath_txt; "ALL_Converted"; "ALL_Imported")
	ARRAY TEXT:C222($ProcessedPaths_atxt; 0)
	ARRAY LONGINT:C221($ProcessedInspectionIDs_aL; 0)
	ARRAY LONGINT:C221($ProcessedPhotoIDs_aL; 0)
	ARRAY TEXT:C222($ProcessedPictureExtension_atxt; 0)
	
	If (Test path name:C476($ProcessedDocumentPath_txt)=Is a document:K24:1)
		DOCUMENT TO BLOB:C525($ProcessedDocumentPath_txt; $Exported_blb)
		$Offset_L:=0
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedPaths_atxt; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedInspectionIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedPhotoIDs_aL; $Offset_L)
		BLOB TO VARIABLE:C533($Exported_blb; $ProcessedPictureExtension_atxt; $Offset_L)
	End if 
	
	If (Size of array:C274($ProcessedPhotoIDs_aL)>0)
		SET QUERY DESTINATION:C396(Into set:K19:2; "ProcessedSet")
		QUERY WITH ARRAY:C644([Standard Photos:36]StdPhotoID:7; $ProcessedPhotoIDs_aL)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		ALL RECORDS:C47([Standard Photos:36])
		CREATE SET:C116([Standard Photos:36]; "AllSet")
		DIFFERENCE:C122("AllSet"; "ProcessedSet"; "AllSet")
		USE SET:C118("AllSet")
		CLEAR SET:C117("AllSet")
		CLEAR SET:C117("ProcessedSet")
	Else 
		ALL RECORDS:C47([Standard Photos:36])
	End if 
	READ ONLY:C145(*)
	READ WRITE:C146([Standard Photos:36])
	C_TEXT:C284($localID_txt; $RemoteID_txt; $DocName_txt)
	
	CNV_StopMe_B:=False:C215
	$ImportLoop_L:=1
	C_BLOB:C604($Picture_blb)
	C_TIME:C306($ProcessRpt_tm)
	$DocName_txt:="ImportedPictures_"+String:C10(Current process:C322)+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"
	$NewFolderPath_txt:=Replace string:C233($BlobDocumentPath_txt; "ALL_Converted.txt"; $DocName_txt)
	C_LONGINT:C283($OriginalSize_L; $NewSize_L)
	
	CNV_Doc_tm:=Create document:C266($NewFolderPath_txt)
	
	SEND PACKET:C103(CNV_Doc_tm; "Inspection ID"+Char:C90(Tab:K15:37)+"Photo ID"+Char:C90(Tab:K15:37)+"Remote ID"+Char:C90(Tab:K15:37)+"Old size"+Char:C90(Tab:K15:37)+"New Size"+Char:C90(Tab:K15:37)+"Status"+Char:C90(Carriage return:K15:38))
	APPEND TO ARRAY:C911(<>CNV_UpdatePictProcessIDs_aL; Current process:C322)
	APPEND TO ARRAY:C911(<>CNV_ProcessName_atxt; "Import Pictures"+String:C10(Current process:C322))
	
	ut_LaunchCNVStop
	C_LONGINT:C283($Size_L; $win)
	$win:=ut_OpenNewWindow(500; 200; 5; 4; "Importing [Standard Photos]")
	C_TIME:C306($StartTime_tm; $RemainingTime_tm; $Elapsed_tm)
	C_BLOB:C604($NewPicture_blb)
	
	$StartTime_tm:=Current time:C178
	$Size_L:=Records in selection:C76([Standard Photos:36])
	
	Repeat 
		GOTO SELECTED RECORD:C245([Standard Photos:36]; $importLoop_L)
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
		
		If (Find in array:C230($ProcessedPhotoIDs_aL; [Standard Photos:36]StdPhotoID:7)>0)  // we have processed already
		Else 
			$localID_txt:=String:C10([Standard Photos:36]StdPhotoID:7)
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
			$RemotePosition_L:=Find in array:C230($PhotoIDs_aL; Num:C11($RemoteID_txt))
			SEND PACKET:C103(CNV_Doc_tm; String:C10([Standard Photos:36]InspID:1)+Char:C90(Tab:K15:37)+String:C10([Standard Photos:36]StdPhotoID:7)+Char:C90(Tab:K15:37)+$RemoteID_txt+Char:C90(Tab:K15:37)+String:C10($OriginalSize_L)+Char:C90(Tab:K15:37))
			
			//Case of 
			
			//: (Ô11999;51Ô (->[Standard Photos]Std Photo)=0)
			//APPEND TO ARRAY($ProcessedPaths_atxt;"")
			//APPEND TO ARRAY($ProcessedInspectionIDs_aL;[Standard Photos]InspID)
			//APPEND TO ARRAY($ProcessedPhotoIDs_aL;[Standard Photos]StdPhotoID)
			//APPEND TO ARRAY($ProcessedPictureExtension_atxt;"")
			//SEND PACKET(CNV_Doc_tm;Char(Tab)+"Picture not Deprecated"+Char(Carriage return))
			
			
			//: (Ô11999;51Ô (->[Standard Photos]Std Photo)=1)
			
			//If ($RemotePosition_L>0)
			//SET BLOB SIZE($NewPicture_blb;0)
			//Case of 
			//: (Test path name($Paths_atxt{$RemotePosition_L}+$RemoteID_txt+".txt")=Is a document)
			
			//DOCUMENT TO BLOB($Paths_atxt{$RemotePosition_L}+$RemoteID_txt+".txt";$NewPicture_blb)
			
			//Case of 
			//: ($PictureExtension_atxt{$RemotePosition_L}="JPG")
			//BLOB TO PICTURE($NewPicture_blb;[Standard Photos]Std Photo;"IMAGE/JPG")
			//$Status_txt:="Converted to JPEG from .txt"
			//: ($PictureExtension_atxt{$RemotePosition_L}="PNG")
			//BLOB TO PICTURE($NewPicture_blb;[Standard Photos]Std Photo;"IMAGE/PNG")
			//$Status_txt:="Converted to PNG from .txt"
			//Else 
			//$Status_txt:="Error in that picture extension was not jpg, or png "+$Paths_atxt{$RemotePosition_L}+$RemoteID_txt
			//End case 
			
			//: (Test path name($Paths_atxt{$RemotePosition_L}+$RemoteID_txt+".jpg")=Is a document)
			//  //DOCUMENT TO BLOB($Paths_atxt{$RemotePosition_L}+$RemoteID_txt+".jpg";$NewPicture_blb)
			//  //BLOB TO PICTURE($NewPicture_blb;[Standard Photos]Std Photo;"IMAGE/JPG")
			
			//READ PICTURE FILE($Paths_atxt{$RemotePosition_L}+$RemoteID_txt+".jpg";[Standard Photos]Std Photo)
			//$Status_txt:="Converted to JPEG"
			//: (Test path name($Paths_atxt{$RemotePosition_L}+$RemoteID_txt+".png")=Is a document)
			//  //DOCUMENT TO BLOB($Paths_atxt{$RemotePosition_L}+$RemoteID_txt+".png";$NewPicture_blb)
			//  //BLOB TO PICTURE($NewPicture_blb;[Standard Photos]Std Photo;"IMAGE/PNG")
			
			//READ PICTURE FILE($Paths_atxt{$RemotePosition_L}+$RemoteID_txt+".png";[Standard Photos]Std Photo)
			//$Status_txt:="Converted to PNG"
			//Else 
			//$Status_txt:="No Document found "+$Paths_atxt{$RemotePosition_L}+$RemoteID_txt
			//End case 
			//$NewSize_L:=Picture size([Standard Photos]Std Photo)
			//SEND PACKET(CNV_Doc_tm;String($NewSize_L)+Char(Tab)+"Processed picture from "+$Status_txt+Char(Carriage return))
			//SAVE RECORD([Standard Photos])
			//APPEND TO ARRAY($ProcessedPaths_atxt;$Paths_atxt{$RemotePosition_L})
			//APPEND TO ARRAY($ProcessedInspectionIDs_aL;[Standard Photos]InspID)
			//APPEND TO ARRAY($ProcessedPhotoIDs_aL;[Standard Photos]StdPhotoID)
			//APPEND TO ARRAY($ProcessedPictureExtension_atxt;$PictureExtension_atxt{$RemotePosition_L})
			//Else 
			//APPEND TO ARRAY($ProcessedPaths_atxt;"")
			//APPEND TO ARRAY($ProcessedInspectionIDs_aL;[Standard Photos]InspID)
			//APPEND TO ARRAY($ProcessedPhotoIDs_aL;[Standard Photos]StdPhotoID)
			//APPEND TO ARRAY($ProcessedPictureExtension_atxt;"")
			//QUERY([Inspections];[Inspections]InspID=[Standard Photos]InspID)
			//$Status_txt:="Remote ID not found inspection date is "+String([Inspections]Insp Date)
			//SEND PACKET(CNV_Doc_tm;String($NewSize_L)+Char(Tab)+"Processed picture from "+$Status_txt+Char(Carriage return))
			
			//End if 
			
			
			//Else 
			//QUERY([Inspections];[Inspections]InspID=[Standard Photos]InspID)
			//SEND PACKET(CNV_Doc_tm;"0"+Char(Tab)+"Local record not found in export inspection date is "+String([Inspections]Insp Date)+Char(Carriage return))
			//APPEND TO ARRAY($ProcessedPaths_atxt;"")
			//APPEND TO ARRAY($ProcessedInspectionIDs_aL;[Standard Photos]InspID)
			//APPEND TO ARRAY($ProcessedPhotoIDs_aL;[Standard Photos]StdPhotoID)
			//APPEND TO ARRAY($ProcessedPictureExtension_atxt;"")
			
			
			//End case 
			
			SET BLOB SIZE:C606($Exported_blb; 0)
			VARIABLE TO BLOB:C532($ProcessedPaths_atxt; $Exported_blb; *)
			VARIABLE TO BLOB:C532($ProcessedInspectionIDs_aL; $Exported_blb; *)
			VARIABLE TO BLOB:C532($ProcessedPhotoIDs_aL; $Exported_blb; *)
			VARIABLE TO BLOB:C532($ProcessedPictureExtension_atxt; $Exported_blb; *)
			
			BLOB TO DOCUMENT:C526($ProcessedDocumentPath_txt; $Exported_blb)
			
		End if 
		$ImportLoop_L:=$ImportLoop_L+1
	Until (($ImportLoop_L>$Size_L) | (CNV_StopMe_B))
	SEND PACKET:C103(CNV_Doc_tm; "Start time is "+Time string:C180($StartTime_tm)+Char:C90(Carriage return:K15:38))
	SEND PACKET:C103(CNV_Doc_tm; "Elap[sed time is "+Time string:C180($elapsed_tm)+Char:C90(Carriage return:K15:38))
	
	SEND PACKET:C103(CNV_Doc_tm; "current time is "+Time string:C180(Current time:C178)+Char:C90(Carriage return:K15:38))
	SEND PACKET:C103(CNV_Doc_tm; "Process count "+String:C10($ImportLoop_L)+Char:C90(Carriage return:K15:38))
	
	
	CLOSE DOCUMENT:C267(CNV_Doc_tm)
End if 

