//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 06/21/17, 10:21:58
//----------------------------------------------------
//Method: ut_ImportUpdatedPictures
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 


C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
vsForward:=<>Forward
READ ONLY:C145(*)
READ WRITE:C146([Standard Photos:36])
READ WRITE:C146([Activity Log:59])
Compiler_CNV
ARRAY TEXT:C222($ExtensionsToCopy_atxt; 0)
APPEND TO ARRAY:C911($ExtensionsToCopy_atxt; "png")
APPEND TO ARRAY:C911($ExtensionsToCopy_atxt; "tif")
APPEND TO ARRAY:C911($ExtensionsToCopy_atxt; "jpg")

C_TEXT:C284($SelectFolder_txt; $PhotoID_txt)
$SelectFolder_txt:=Select folder:C670("Select folder with converted PDFs to import"; "")
If (OK=1)
	ARRAY TEXT:C222($Documents_atxt; 0)
	ARRAY TEXT:C222($UniqueNames_atxt; 0)
	ARRAY TEXT:C222($FullName_atxt; 0)
	
	ARRAY LONGINT:C221($Count_aL; 0)
	ARRAY TEXT:C222($Extension_atxt; 0)
	ARRAY LONGINT:C221($Size_aL; 0)
	C_LONGINT:C283($Loop_l; $Size_L; $Pos_L)
	DOCUMENT LIST:C474($SelectFolder_txt; $Documents_atxt)
	For ($Loop_l; 1; Size of array:C274($Documents_atxt))
		
		ARRAY TEXT:C222($Parts_atxt; 0)
		ut_NewTextToArray($Documents_atxt{$Loop_L}; ->$Parts_atxt; ".")
		If (Find in array:C230($ExtensionsToCopy_atxt; $Parts_atxt{2})>0)
			ARRAY TEXT:C222($DocParts_atxt; 0)
			ut_NewTextToArray($Parts_atxt{1}; ->$DocParts_atxt; "_")
			
			Case of 
				: (Size of array:C274($DocParts_atxt)=1)
					$PhotoID_txt:=$Parts_atxt{1}
					
				: (Size of array:C274($DocParts_atxt)=2)
					$PhotoID_txt:=$DocParts_atxt{2}
					
			End case 
			$Pos_L:=Find in array:C230($UniqueNames_atxt; $PhotoID_txt)
			If ($Pos_L>0)
				$Count_aL{$Pos_L}:=$Count_aL{$Pos_L}+1
				$Size_L:=Get document size:C479($SelectFolder_txt+$Documents_atxt{$Loop_L})
				If ($Size_L<$Size_aL{$Pos_L})
					$Extension_atxt{$Pos_L}:=$Parts_atxt{2}
					$FullName_atxt{$Pos_L}:=$Documents_atxt{$Loop_L}
				End if 
			Else 
				APPEND TO ARRAY:C911($UniqueNames_atxt; $PhotoID_txt)
				APPEND TO ARRAY:C911($Count_aL; 1)
				APPEND TO ARRAY:C911($Size_aL; Get document size:C479($SelectFolder_txt+$Documents_atxt{$Loop_l}))
				APPEND TO ARRAY:C911($Extension_atxt; $Parts_atxt{2})
				APPEND TO ARRAY:C911($FullName_atxt; $Documents_atxt{$Loop_l})
			End if 
			
		End if 
	End for 
	C_TIME:C306($Doc_tm)
	C_TEXT:C284($DocumentName_txt)
	
	C_LONGINT:C283($HowManyToProcess_L; $ProcessedCount_L; $Loop_L; $ProgressBar_L; $PhotoID_L; $InspectionID_L)
	C_TEXT:C284($HowMany_txt)
	Repeat 
		$HowMany_txt:=Request:C163("Enter the number of pictures to process"; "25"; "Process"; "Cancel")
		If ($HowMany_txt="ALL")
			$HowManyToProcess_L:=Size of array:C274($FullName_atxt)
		Else 
			$HowManyToProcess_L:=Num:C11($HowMany_txt)
		End if 
	Until ($HowManyToProcess_L>0) | (OK=0)
	$Loop_L:=0
	If (OK=1)
		$Doc_tm:=Create document:C266($SelectFolder_txt+"FixedPicture"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt")
		SEND PACKET:C103($Doc_tm; "Photo ID"+Char:C90(Tab:K15:37)+"Inspection Id"+Char:C90(Tab:K15:37)+"Inspection Date"+Char:C90(Tab:K15:37)+"Inspection Type"+Char:C90(Tab:K15:37)+"BIN"+Char:C90(Tab:K15:37)+"Original Size"+Char:C90(Tab:K15:37)+"New size"+Char:C90(Carriage return:K15:38))
		
		$ProgressBar_L:=Progress New
		Repeat 
			$Loop_L:=$Loop_L+1
			
			$PhotoID_L:=Num:C11($UniqueNames_atxt{$Loop_l})
			
			QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=$PhotoID_L)
			C_BOOLEAN:C305($Complete_B)
			//If (Ô11999;51Ô (->[Standard Photos]Std Photo)=1)
			//If ($ProcessedCount_L>0)
			//Progress SET PROGRESS ($ProgressBar_L;$ProcessedCount_L/$HowManyToProcess_L;"Processing document "+$FullName_atxt{$Loop_L})
			//End if 
			//$InspectionID_L:=[Standard Photos]InspID
			//QUERY([Inspections];[Inspections]InspID=[Standard Photos]InspID)
			//QUERY([Bridge MHD NBIS];[Bridge MHD NBIS]BIN=[Inspections]BIN)
			//SEND PACKET($Doc_tm;String([Standard Photos]StdPhotoID)+Char(Tab))
			//SEND PACKET($Doc_tm;String([Standard Photos]InspID)+Char(Tab))
			//SEND PACKET($Doc_tm;String([Inspections]Insp Date)+Char(Tab))
			//SEND PACKET($Doc_tm;[Inspections]Insp Type+Char(Tab))
			//SEND PACKET($Doc_tm;[Inspections]BIN+Char(Tab))
			//SEND PACKET($Doc_tm;String(Picture size([Standard Photos]Std Photo))+Char(Tab))
			
			//READ PICTURE FILE($SelectFolder_txt+$FullName_atxt{$Loop_L};[Standard Photos]Std Photo)
			//SEND PACKET($Doc_tm;String(Picture size([Standard Photos]Std Photo))+Char(Carriage return))
			
			//ARRAY POINTER(Ptr_changes;0;0)
			//InitChangeStack (1)
			//PushChange (1;->[Standard Photos]Std Photo)
			//FlushGrpChgs (1;->[Inspections]InspID;->[Standard Photos]InspID;->[Standard Photos]StdPhotoID;2)
			//SAVE RECORD([Standard Photos])
			//UNLOAD RECORD([Standard Photos])
			//$ProcessedCount_L:=$ProcessedCount_L+1
			//End if 
			
		Until ($ProcessedCount_L=$HowManyToProcess_L) | ($Loop_L=Size of array:C274($Documents_atxt))
		
		CLOSE DOCUMENT:C267($Doc_tm)
		
		Progress QUIT($ProgressBar_L)
		
	End if 
End if 
//End ut_ImportUpdatedPictures

