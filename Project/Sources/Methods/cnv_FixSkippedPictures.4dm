//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 06/18/17, 11:20:19
//----------------------------------------------------
//Method: cnv_FixSkippedPictures
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
Progress QUIT(0)

C_TEXT:C284($File_txt; $Doc_text; $Path_txt; $PDFFolderPath_txt)
ARRAY TEXT:C222($Files_atxt; 0)
$File_txt:=Select document:C905(""; ""; "Select Missing ids Document"; Multiple files:K24:7; $Files_atxt)
$PDFFolderPath_txt:=""
$File_txt:=$files_atxt{1}

$Doc_text:=Document to text:C1236($File_txt)
ARRAY TEXT:C222($Ids_atxt; 0)
ARRAY LONGINT:C221($ids_aL; 0)
CONFIRM:C162("Print sketches and charts to PDF"; "Yes"; "No")
If (ok=1)
	$PDFFolderPath_txt:=Select folder:C670("Select folder to print pdfs to")
End if 
C_LONGINT:C283($loop_L; $Progress_L)
C_PICTURE:C286($Orig; $New)
ut_NewTextToArray($Doc_text; ->$Ids_atxt; Char:C90(Carriage return:K15:38))
ARRAY LONGINT:C221($ids_aL; Size of array:C274($Ids_atxt))
For ($loop_L; 1; Size of array:C274($ids_aL))
	$ids_aL{$loop_L}:=Num:C11($Ids_atxt{$loop_L})
	
End for 
C_TIME:C306($Doc_tm; $Doc_Skipped_tm)
$Path_txt:=GetPath($File_txt)
$Doc_tm:=Create document:C266($Path_txt+"ConvertedPictures"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt")
$Doc_Skipped_tm:=Create document:C266($Path_txt+"SkippedPictures"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt")
$Progress_L:=Progress New
Progress SET TITLE($Progress_L; "Update pictures ")
C_REAL:C285($Interval_R)
READ WRITE:C146([Standard Photos:36])

QUERY WITH ARRAY:C644([Standard Photos:36]StdPhotoID:7; $ids_aL)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Records in selection:C76([Standard Photos:36]))
	GOTO SELECTED RECORD:C245([Standard Photos:36]; $loop_L)
	Progress SET PROGRESS($Progress_L; $Loop_L/Records in selection:C76([Standard Photos:36]); "Processing Photo "+String:C10([Standard Photos:36]StdPhotoID:7))
	//Case of 
	//: ([Standard Photos]PictType="3")
	//If (Ô11999;51Ô (->[Standard Photos]Std Photo)=1)
	
	//$Orig:=[Standard Photos]Std Photo
	//CONVERT PICTURE($Orig;"image/jpeg")
	//$New:=F_CompressPic ($Orig)
	//SEND PACKET($Doc_tm;String([Standard Photos]StdPhotoID)+Char(Tab)+[Standard Photos]PictType+Char(Tab)+String(Picture size($Orig))+Char(Tab)+String(Picture size($New))+Char(Carriage return))
	//[Standard Photos]Std Photo:=$new
	//SAVE RECORD([Standard Photos])
	//Else 
	
	//SEND PACKET($Doc_tm;String([Standard Photos]StdPhotoID)+Char(Tab)+[Standard Photos]PictType+Char(Tab)+Char(Tab)+Char(Tab)+Char(Tab)+"No deprecated"+Char(Carriage return))
	
	//End if 
	
	//Else 
	//SEND PACKET($Doc_Skipped_tm;String([Standard Photos]StdPhotoID)+Char(Tab)+[Standard Photos]PictType+Char(Carriage return))
	//If ($PDFFolderPath_txt#"")
	//CNV_PrintToPDF ($PDFFolderPath_txt)
	//End if 
	
	//End case 
	
End for 
CLOSE DOCUMENT:C267($Doc_tm)
CLOSE DOCUMENT:C267($Doc_Skipped_tm)
Progress QUIT($Progress_L)

//End cnv_FixSkippedPictures