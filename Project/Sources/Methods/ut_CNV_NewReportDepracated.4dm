//%attributes = {"invisible":true}

//End ut_CNV_NewReportDepracated

// >> ----------------------------------------------------
// >> User name(OS): Chuck Miller
// >> Date and time: 04/12/16, 11:53:38
// >> ----------------------------------------------------
// >> Method: ut_CNV_NewReportDepracated

// >> Description
// >> 
// >> Parameters
// >> ----------------------------------------------------
If (False:C215)
	// >> 
	// >> Modified by: Chuck Miller(4/12/16 11:53:40)
	
	
End if 

TRACE:C157
READ ONLY:C145(*)

C_LONGINT:C283(CurrentLoop_L)
C_BOOLEAN:C305(CNV_StopMe_B)
ALL RECORDS:C47([Standard Photos:36])
ARRAY LONGINT:C221(CNV_RecordNumber_aL; 0)
LONGINT ARRAY FROM SELECTION:C647([Standard Photos:36]; CNV_RecordNumber_aL)
C_BOOLEAN:C305($ReportOnly_B; $RunAttended_B)
C_TEXT:C284($PicturesFolderPath_txt)
$PicturesFolderPath_txt:=Select folder:C670("Select folder that has Converted Files")
$ReportOnly_B:=True:C214
$StartTick_L:=Tickcount:C458
//If (Count parameters>0)
//C_BOOLEAN($1)
//$ReportOnly_B:=$1
//End if 
//
//If (Count parameters>1)
//C_BLOB($2;$BlobWithArray_BLB)
//$BlobWithArray_BLB:=$2
//
//C_LONGINT($Offset_L)
//$Offset_L:=0
//C_TEXT(ColumnWidths_txt)
//ARRAY LONGINT(CNV_RecordNumber_aL;0)
//BLOB TO VARIABLE($BlobWithArray_BLB;ColumnWidths_txt;$Offset_L)
//BLOB TO VARIABLE($BlobWithArray_BLB;$RunAttended_B;$Offset_L)
//BLOB TO VARIABLE($BlobWithArray_BLB;CNV_RecordNumber_aL;$Offset_L)
//
//
//End if 
//C_POINTER($Table_ptr)
//If (ColumnWidths_txt="Standard Photos")
//$Table_ptr:=->[Standard Photos]
//
//READ WRITE([Standard Photos])
//Else 
//$Table_ptr:=->[Standard Photos]
//
//READ WRITE([Standard Photos])
//End if 
//$Table_ptr:=->[Standard Photos]
C_TIME:C306(CNV_Doc_tm)
C_TEXT:C284($DocName_txt; $MyDocumentsFolder_txt; $MydocSpec_txt)
//C_LONGINT($Platform_L)
//
//$DocName_txt:="ResetPictureProcessLog_"+String(Current process)+"_"+Substring(ut_ReturnTimeStampFromDate (Current date;Current time);1;12)+".txt"
//$MyDocumentsFolder_txt:=System folder(Desktop )
//_O_PLATFORM PROPERTIES($Platform_L)// MassDOT_PS - conversion v19R7
C_TEXT:C284($PL_DirectorySep_s)

If (Is Windows:C1573)
	$MydocSpec_txt:="My Documents"
	$PL_DirectorySep_s:="\\"
Else 
	$MydocSpec_txt:="Documents"
	$PL_DirectorySep_s:=":"
End if 
//
//$MyDocumentsFolder_txt:=Replace string($MyDocumentsFolder_txt;$PL_DirectorySep_s+"Desktop"+$PL_DirectorySep_s;$PL_DirectorySep_s+$MydocSpec_txt+$PL_DirectorySep_s)
//$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+"ResetPictureLogs"
//If (Test path name($MyDocumentsFolder_txt)=Is a directory )
//Else 
//CREATE FOLDER($MyDocumentsFolder_txt)
//
//End if 
//$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+$PL_DirectorySep_s
//CNV_Doc_tm:=Create document($MyDocumentsFolder_txt+$DocName_txt)
//SEND PACKET(CNV_Doc_tm;"Start prrocess"+Char(Carriage return ))

C_BLOB:C604(\
Report_blb)\

SET BLOB SIZE:C606(Report_blb; 0)
C_BOOLEAN:C305($IsDepracated_B; $IsPDF_B)
TEXT TO BLOB:C554("BIN"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Insp ID"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Insp Date"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Insp Type"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Std Ph ID"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Photo Type"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Original Size"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Width"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Height"+Char:C90(Tab:K15:37); Report_blb; *)
//TEXT TO BLOB("Scale"+Char(Tab );Report_blb;*)
//TEXT TO BLOB("New Size"+Char(Tab );Report_blb;*)
//
//TEXT TO BLOB("Size Difference [New - original]"+Char(Tab );Report_blb;*)
//TEXT TO BLOB("Percentage Change"+Char(Tab );Report_blb;*)
//
//TEXT TO BLOB("Deprecated"+Char(Tab );Report_blb;*)
TEXT TO BLOB:C554("Pict Sequence"+Char:C90(Tab:K15:37); Report_blb; *)
TEXT TO BLOB:C554("Picture types"+Char:C90(Carriage return:K15:38); Report_blb; *)



C_LONGINT:C283(\
CurrentLoop_L; \
$TypeLoop_L; \
$RecordCount_L)\

//If (hmFree_IsLicensed >=0)

//Else 

//$RecordCount_L:=hmFree_Register ("rLhAA-YcUAGWAAAAJCAMoBksABRAD+AGtAJbF-+")

C_BOOLEAN:C305($Locked_B; $Invisible_B)
C_DATE:C307($Created_d; $ModifiedOn_d)
C_TIME:C306($Created_tm; $ModifiedOn_tm)
//End if 
C_LONGINT:C283($ProgressID_L)
// $ProgressID_L:=Progress New
C_REAL:C285($Complete_R)
C_LONGINT:C283($NextUpdate_L; $Width_L; $Height_L; $OriginalSize_L; $NewSize_L; $RecordCount_L; $StartLocation_L)
C_BOOLEAN:C305($ResetUpdate_B)
$ResetUpdate_B:=False:C215
$NextUpdate_L:=500
// Progress SET MESSAGE($ProgressID_L;"Checking standard photo types";True)
$RecordCount_L:=Size of array:C274(CNV_RecordNumber_aL)
//C_TEXT(CNV_ProcessDocument_txt)
//CNV_ProcessDocument_txt:=$MyDocumentsFolder_txt+$DocName_txt

C_LONGINT:C283(\
$StartTick_L; \
$EndTick_L; \
$ProcessCount_L)\

$StartTick_L:=Tickcount:C458
C_TIME:C306($Start_tm)
$ProcessCount_L:=0
C_PICTURE:C286($Converted_pic; $ThumbConverted_pic)
$Start_tm:=Current time:C178
ON ERR CALL:C155("CNV_Error")
C_TEXT:C284($RecordNumbers_txt)
C_LONGINT:C283($SendPacketCount_L)
$SendPacketCount_L:=0
C_TEXT:C284($NewPath_txt)
CurrentLoop_L:=\
1
//For (CurrentLoop_L;1;$RecordCount_L)
Repeat 
	
	$IsDepracated_B:=False:C215
	
	//SEND PACKET(CNV_Doc_tm;String(CNV_RecordNumber_aL{CurrentLoop_L})+Char(Carriage return ))
	
	GOTO RECORD:C242([Standard Photos:36]; CNV_RecordNumber_aL{CurrentLoop_L})\
		
	
	ARRAY TEXT:C222(\
		$TypesFound_atxt; \
		0)\
		
	If (Picture size:C356([Standard Photos:36]Std Photo:3)>0)
		
		RELATE ONE:C42([Standard Photos:36]InspID:1)\
			
		//  //If ([Inspections]BIN="0X8")
		//hmFree_GET PICTURE TYPES ([Standard Photos]Std Photo;$TypesFound_atxt)
		//If (Position("PICT";$TypesFound_atxt{1})>0)
		//$IsDepracated_B:=True
		//End if 
		//$IsPDF_B:=False
		//If (Position("pdf";$TypesFound_atxt{1})>0)
		//$IsDepracated_B:=True
		//$IsPDF_B:=True
		//End if 
		//If ($IsDepracated_B)
		
		//If (Ô11999;51Ô (->[Standard Photos]Std Photo)=1)
		//TEXT TO BLOB([Inspections]BIN+Char(Tab);Report_blb;Mac text without length;*)
		//TEXT TO BLOB(String([Standard Photos]InspID)+Char(Tab);Report_blb;Mac text without length;*)
		//TEXT TO BLOB(String([Inspections]Insp Date)+Char(Tab);Report_blb;Mac text without length;*)
		//TEXT TO BLOB([Inspections]Insp Type+Char(Tab);Report_blb;Mac text without length;*)
		//TEXT TO BLOB(String([Standard Photos]StdPhotoID)+Char(Tab);Report_blb;Mac text without length;*)
		//TEXT TO BLOB([Standard Photos]PictType+Char(Tab);Report_blb;Mac text without length;*)
		
		//$OriginalSize_L:=\
						Picture size(\
						[Standard Photos]Std Photo)\
						
		//TEXT TO BLOB(String($OriginalSize_L)+Char(Tab);Report_blb;Mac text without length;*)
		//PICTURE PROPERTIES([Standard Photos]Std Photo;$Width_L;$Height_L)
		//TEXT TO BLOB(String($Width_L)+Char(Tab);Report_blb;Mac text without length;*)
		//TEXT TO BLOB(String($Height_L)+Char(Tab);Report_blb;Mac text without length;*)
		//TEXT TO BLOB(String([Standard Photos]SeqNum)+Char(Tab);Report_blb;Mac text without length;*)
		//$NewPath_txt:=CNV_CreateNewPath (String([Standard Photos]InspID);$PicturesFolderPath_txt)
		//  //$NewPath_txt:=CNV_CreatePath (":";$PicturesFolderPath_txt)
		//ARRAY TEXT($PreviousFiles_atxt;0)
		//DOCUMENT LIST($NewPath_txt;$PreviousFiles_atxt)
		//C_LONGINT($Pos_L)
		//$StartLocation_L:=0
		//C_TEXT($NamesFound_txt;$FileName_txt)
		//$NamesFound_txt:="No File Found"+Char(Carriage return)
		//$FileName_txt:=String([Standard Photos]StdPhotoID)
		//Repeat 
		//$Pos_L:=Find in array($PreviousFiles_atxt;$FileName_txt;$StartLocation_L)
		
		
		//If ($Pos_L>0)
		//$StartLocation_L:=$Pos_L+1
		//$NewSize_L:=Get document size($PicturesFolderPath_txt+$PreviousFiles_atxt{$Pos_L})
		//GET DOCUMENT PROPERTIES($PicturesFolderPath_txt+$PreviousFiles_atxt{$Pos_L};$Locked_B;$Invisible_B;$Created_d;$Created_tm;$ModifiedOn_d;$ModifiedOn_tm)
		
		//TEXT TO BLOB($FileName_txt+Char(Tab)+String($NewSize_L)+Char(Tab)+String($Created_d)+Char(Tab)+String($ModifiedOn_d);Report_blb;Mac text without length;*)
		
		//$NamesFound_txt:=Char(Carriage return)
		//End if 
		
		//Until ($Pos_L<1)
		//TEXT TO BLOB($FileName_txt;Report_blb;Mac text without length;*)
		
		//  //End if 
		
		//End if 
		
		$ProcessCount_L:=$ProcessCount_L+1
		If (CNV_StopMe_B)
			CurrentLoop_L:=$RecordCount_L+10
		End if 
	End if 
	CurrentLoop_L:=CurrentLoop_L+1
	
Until ((CNV_StopMe_B) | (CurrentLoop_L>$RecordCount_L))
//end for

//CLOSE DOCUMENT(CNV_Doc_tm)

C_TIME:C306(\
$End_tm)\

$End_tm:=Current time:C178

$EndTick_L:=\
Tickcount:C458
TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(String:C10($StartTick_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(String:C10($EndTick_L)+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554("Elapsed Tick count"+Char:C90(Tab:K15:37); Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(String:C10($EndTick_L-$StartTick_L)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)

TEXT TO BLOB:C554(\
"Elapsed time"+\
Char:C90(\
Tab:K15:37)\
; \
Report_blb; \
Mac text without length:K22:10; \
*\
)\

TEXT TO BLOB:C554(Time string:C180($End_tm-$Start_tm)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)

TEXT TO BLOB:C554(\
"Number processed"+\
Char:C90(\
Tab:K15:37)\
; \
Report_blb; \
Mac text without length:K22:10; \
*\
)\

TEXT TO BLOB:C554(String:C10($ProcessCount_L)+Char:C90(Carriage return:K15:38); Report_blb; Mac text without length:K22:10; *)

If (\
Not:C34(\
$RunAttended_B)\
)\

	
	C_TEXT:C284(\
		$DocName_txt; \
		$MyDocumentsFolder_txt; \
		$MydocSpec_txt)\
		
	
	$DocName_txt:=\
		"DeprecatedPictures_"+\
		String:C10(\
		Current process:C322)\
		+\
		"_"+\
		Substring:C12(\
		ut_ReturnTimeStampFromDate(\
		Current date:C33; \
		Current time:C178)\
		; \
		1; \
		12)\
		+\
		".txt"
	$MyDocumentsFolder_txt:=System folder:C487(Desktop:K41:16)
	//_O_PLATFORM PROPERTIES($Platform_L)// MassDOT_PS - conversion v19R7
	C_TEXT:C284($PL_DirectorySep_s)
	
	If (Is Windows:C1573)
		
		$MydocSpec_txt:="My Documents"
		$PL_DirectorySep_s:="\\"
	Else 
		$MydocSpec_txt:="Documents"
		$PL_DirectorySep_s:=":"
	End if 
	
	$MyDocumentsFolder_txt:=\
		Replace string:C233(\
		$MyDocumentsFolder_txt; \
		$PL_DirectorySep_s+\
		"Desktop"+\
		$PL_DirectorySep_s; \
		$PL_DirectorySep_s+\
		$MydocSpec_txt+\
		$PL_DirectorySep_s)\
		
	
	If (\
		Test path name:C476(\
		$MyDocumentsFolder_txt)\
		=\
		Is a folder:K24:2)\
		
	Else 
		$MyDocumentsFolder_txt:=System folder:C487(Desktop:K41:16)  //set to desktop if something not correct
	End if 
	$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+"ResetPictureLogs"
	If (Test path name:C476($MyDocumentsFolder_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($MyDocumentsFolder_txt)
		
	End if 
	$MyDocumentsFolder_txt:=$MyDocumentsFolder_txt+$PL_DirectorySep_s
	CNV_Doc_tm:=Create document:C266($MyDocumentsFolder_txt+$DocName_txt)
	CLOSE DOCUMENT:C267(CNV_Doc_tm)
	BLOB TO DOCUMENT:C526(Document; Report_blb)
End if 
CurrentLoop_L:=-99999
Repeat 
	
	DELAY PROCESS:C323(\
		Current process:C322; \
		120)\
		
	
	
Until (\
CurrentLoop_L=\
-\
8888)\

//Progress QUIT($ProgressID_L)

// End ut_CheckPictures
