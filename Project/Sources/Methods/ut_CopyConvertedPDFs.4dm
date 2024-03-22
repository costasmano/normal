//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/28/16, 12:10:27
//----------------------------------------------------
//Method: ut_CopyConvertedPDFs
//Description
//
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
Compiler_CNV
C_TEXT:C284($NewDocPath_txt; $FileName_txt; $OriginalsFolderPath_txt; $CopyToPath_txt; $Line_txt; $PL_DirectorySep_s; $ConvertedFolderPath_txt; $ExportFileWithBlob_txt; $SavedPicturesFolderPath_txt; $DocumentName_txt; $NewFolderPath_txt)
C_PICTURE:C286($Picture_pct)
C_BLOB:C604($Blob_blb)

C_LONGINT:C283($Loop_L; $InspectionID_L; $PhotoID_L; $Position_L)
$ConvertedFolderPath_txt:=Select folder:C670("Select folder to that has converted Pictures")
$SavedPicturesFolderPath_txt:=Select folder:C670("Select folder that has previously saved picture files from PDFS")
//$OriginalsFolderPath_txt:=Select folder("Select folder that has Original pictures in blobs")
ARRAY TEXT:C222($Folders_atxt; 0)
FOLDER LIST:C473($SavedPicturesFolderPath_txt; $Folders_atxt)

//$ExportFileWithBlob_txt:=$ConvertedFolderPath_txt+"Export_blob.txt"
ARRAY TEXT:C222($Paths_atxt; 0)
ARRAY TEXT:C222($PictureExtension_atxt; 0)
ARRAY LONGINT:C221($InspectionIDs_aL; 0)
ARRAY LONGINT:C221($PhotoIDs_aL; 0)
C_BLOB:C604($Exported_blb)
C_LONGINT:C283($Offset_L)
//If (Test path name($ExportFileWithBlob_txt)=Is a document )
//DOCUMENT TO BLOB($ExportFileWithBlob_txt;$Exported_blb)
//$Offset_L:=0
//BLOB TO VARIABLE($Exported_blb;$Paths_atxt;$Offset_L)
//BLOB TO VARIABLE($Exported_blb;$InspectionIDs_aL;$Offset_L)
//BLOB TO VARIABLE($Exported_blb;$PhotoIDs_aL;$Offset_L)
//BLOB TO VARIABLE($Exported_blb;$PictureExtension_atxt;$Offset_L)
//
//End if 
//If (Size of array($Paths_atxt)=0)
//ALERT("Can not run without paths")
//Else 

$Line_txt:="Start Process on "+String:C10(Current date:C33; 7)+" at "+String:C10(Current time:C178; HH MM SS:K7:1)+Char:C90(Carriage return:K15:38)
$Line_txt:=$Line_txt+"Photo ID"+Char:C90(Tab:K15:37)+"Inspection ID"+Char:C90(Tab:K15:37)+"Picture Size"+Char:C90(Tab:K15:37)+"Status"+Char:C90(Carriage return:K15:38)
C_TIME:C306($Doc_tm; $Newpct_tm)
$DocumentName_txt:="CopyPictureLog_"+String:C10(Current process:C322)+"_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".txt"

CNV_Doc_tm:=Create document:C266($ConvertedFolderPath_txt+$DocumentName_txt)
SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
$Line_txt:=""

//_O_PLATFORM PROPERTIES($Platform_L)// MassDOT_PS - conversion v19R7
If (Is Windows:C1573)
	$PL_DirectorySep_s:="\\"
Else 
	$PL_DirectorySep_s:=":"
End if 

C_LONGINT:C283($FolderLoop_L)
For ($FolderLoop_L; 1; Size of array:C274($Folders_atxt))
	$NewFolderPath_txt:=$SavedPicturesFolderPath_txt+$Folders_atxt{$FolderLoop_L}+":"
	ARRAY TEXT:C222($Documents_atxt; 0)
	DOCUMENT LIST:C474($NewFolderPath_txt; $Documents_atxt)
	For ($Loop_L; 1; Size of array:C274($Documents_atxt))
		If (Position:C15("."; $Documents_atxt{$Loop_L})=1) | ($Documents_atxt{$Loop_L}="thumbs.db")
			
		Else 
			//If (Position(".PNG";$Documents_atxt{$Loop_L})>0)
			
			ARRAY TEXT:C222($Parts_atxt; 0)
			ut_NewTextToArray($Documents_atxt{$Loop_L}; ->$Parts_atxt; ".")
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
			//$Position_L:=Find in array($PhotoIDs_aL;$PhotoID_L)
			//READ PICTURE FILE($SavedPicturesFolderPath_txt+$Documents_atxt{$Loop_L};$Picture_pct)
			$Line_txt:=$Line_txt+String:C10(Get document size:C479($NewFolderPath_txt+$Documents_atxt{$Loop_L}))+Char:C90(Tab:K15:37)
			
			//If ($Position_L>0)
			//$CopyToPath_txt:=$Paths_atxt{$Position_L}
			//
			//Else 
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$InspectionID_L)
			$CopyToPath_txt:=CNV_CreateNewPath(String:C10($InspectionID_L); $ConvertedFolderPath_txt)
			
			//$CopyToPath_txt:=CNV_CreatePath ($PL_DirectorySep_s;$ConvertedFolderPath_txt)
			$Line_txt:=$Line_txt+"Calculated path is "+$CopyToPath_txt+Char:C90(Tab:K15:37)
			//End if 
			
			
			
			SEND PACKET:C103(CNV_Doc_tm; $Line_txt)
			If (Is Windows:C1573)
				$CopyToPath_txt:=Replace string:C233($CopyToPath_txt; ":"; $PL_DirectorySep_s; 999)
			Else 
				$CopyToPath_txt:=Replace string:C233($CopyToPath_txt; "\\"; $PL_DirectorySep_s; 999)
			End if 
			ON ERR CALL:C155("CNV_CopyError")
			Repeat 
				TryAgain_L:=2
				//CNV_Doc_tm:=$Errordoc_tm
				ON ERR CALL:C155("CNV_CopyError")
				COPY DOCUMENT:C541($NewFolderPath_txt+$Documents_atxt{$Loop_L}; $CopyToPath_txt+String:C10($PhotoID_L)+"."+$Parts_atxt{2}; *)
				ON ERR CALL:C155("")
			Until (TryAgain_L=2) | (TryAgain_L=3) | (TryAgain_L=4)
			If (TryAgain_L=2)
				SEND PACKET:C103(CNV_Doc_tm; String:C10($InspectionID_L)+Char:C90(Tab:K15:37)+$Documents_atxt{$Loop_L}+Char:C90(Tab:K15:37)+$NewFolderPath_txt+Char:C90(Tab:K15:37)+$CopyToPath_txt+Char:C90(Carriage return:K15:38))
			Else 
				SEND PACKET:C103(CNV_Doc_tm; Char:C90(Carriage return:K15:38)+String:C10($InspectionID_L)+Char:C90(Tab:K15:37)+$Documents_atxt{$Loop_L}+Char:C90(Tab:K15:37)+$NewFolderPath_txt+Char:C90(Tab:K15:37)+$CopyToPath_txt+"Unknown error code listed above"+Char:C90(Carriage return:K15:38))
			End if 
			
			//$NewDocPath_txt:=$CopyToPath_txt+$Parts_atxt{2}+".txt"
			//?`$doc_tm:=Create document($NewDocPath_txt)
			//?`CLOSE DOCUMENT($doc_tm)
			//SET BLOB SIZE($Blob_blb;0)
			//VARIABLE TO BLOB($Picture_pct;$Blob_blb;*)
			//
			//BLOB TO DOCUMENT($NewDocPath_txt;$Blob_blb)
			
			ON ERR CALL:C155("")
			SEND PACKET:C103(CNV_Doc_tm; Char:C90(Carriage return:K15:38))
		End if 
		//End if 
		
	End for 
End for 
CLOSE DOCUMENT:C267($Doc_tm)
//
//End if 
//End ut_CopyConvertedPDFs