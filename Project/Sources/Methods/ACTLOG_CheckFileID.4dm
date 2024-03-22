//%attributes = {"invisible":true}
//Method: ACTLOG_CheckFileID
//Description
//Check the FileIDRes table for duplicates
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/11/16, 12:04:56
	// ----------------------------------------------------
	//Created : 
	Mods_2016_10
	//  `
End if 
//
//Go through all tables in db
// find if any entries in FileIDRes table
//look for duplicates when dest is the remote server
//look for duplicates when dest is local db

C_LONGINT:C283($table_L; $Tables_L)
$Tables_L:=Get last table number:C254
ARRAY LONGINT:C221($DupTable_aL; 0)
ARRAY TEXT:C222($DupTable_atxt; 0)
ARRAY TEXT:C222($DupSourceIDs_atxt; 0)
ARRAY TEXT:C222($DestDups_atxt; 0)
ARRAY TEXT:C222($Dests_atxt; 0)
SHORT_MESSAGE("checking tables...")
For ($table_L; 1; $Tables_L)
	QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$table_L)
	ARRAY TEXT:C222($SourceIDS_atxt; 0)
	ARRAY TEXT:C222($DestIDs_atxt; 0)
	MESSAGE:C88(" #"+String:C10($Table_L)+" "+Table name:C256($Table_L))
	If (Records in selection:C76([FileIDRes Table:60])>0)
		QUERY SELECTION:C341([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4#"here")
		SELECTION TO ARRAY:C260([FileIDRes Table:60]Local ID:2; $SourceIDS_atxt; [FileIDRes Table:60]Destination ID:3; $DestIDs_atxt)
		MESSAGE:C88(" Server:"+String:C10(Records in selection:C76([FileIDRes Table:60])))
		C_LONGINT:C283($loop_L; $search_L)
		For ($loop_L; 1; (Size of array:C274($SourceIDS_atxt)-1))
			$search_L:=Find in array:C230($SourceIDS_atxt; $SourceIDS_atxt{$loop_L}; $loop_L+1)
			If ($search_L>0)
				//add both to list
				APPEND TO ARRAY:C911($DupTable_aL; $table_L)
				APPEND TO ARRAY:C911($DupTable_atxt; Table name:C256($table_L))
				APPEND TO ARRAY:C911($DupSourceIDs_atxt; $SourceIDS_atxt{$loop_L})
				APPEND TO ARRAY:C911($DestDups_atxt; $DestIDs_atxt{$loop_L})
				APPEND TO ARRAY:C911($Dests_atxt; "Server")
				
				APPEND TO ARRAY:C911($DupTable_aL; $table_L)
				APPEND TO ARRAY:C911($DupTable_atxt; Table name:C256($table_L))
				APPEND TO ARRAY:C911($DupSourceIDs_atxt; $SourceIDS_atxt{$loop_L})
				APPEND TO ARRAY:C911($DestDups_atxt; $DestIDs_atxt{$search_L})
				APPEND TO ARRAY:C911($Dests_atxt; "Server")
				Repeat 
					$search_L:=Find in array:C230($SourceIDS_atxt; $SourceIDS_atxt{$loop_L}; $search_L+1)
					If ($search_L>0)
						//add to list
						APPEND TO ARRAY:C911($DupTable_aL; $table_L)
						APPEND TO ARRAY:C911($DupTable_atxt; Table name:C256($table_L))
						APPEND TO ARRAY:C911($DupSourceIDs_atxt; $SourceIDS_atxt{$loop_L})
						APPEND TO ARRAY:C911($DestDups_atxt; $DestIDs_atxt{$search_L})
						APPEND TO ARRAY:C911($Dests_atxt; "Server")
						
					End if 
				Until ($search_L<=1)
				
			End if 
			
		End for 
		
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$table_L)
		QUERY SELECTION:C341([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4="here")
		MESSAGE:C88(" here:"+String:C10(Records in selection:C76([FileIDRes Table:60])))
		
		SELECTION TO ARRAY:C260([FileIDRes Table:60]Local ID:2; $SourceIDS_atxt; [FileIDRes Table:60]Destination ID:3; $DestIDs_atxt)
		For ($loop_L; 1; (Size of array:C274($SourceIDS_atxt)-1))
			$search_L:=Find in array:C230($SourceIDS_atxt; $SourceIDS_atxt{$loop_L}; $loop_L+1)
			If ($search_L>0)
				//add both to list
				APPEND TO ARRAY:C911($DupTable_aL; $table_L)
				APPEND TO ARRAY:C911($DupTable_atxt; Table name:C256($table_L))
				APPEND TO ARRAY:C911($DupSourceIDs_atxt; $SourceIDS_atxt{$loop_L})
				APPEND TO ARRAY:C911($DestDups_atxt; $DestIDs_atxt{$loop_L})
				APPEND TO ARRAY:C911($Dests_atxt; "here")
				
				APPEND TO ARRAY:C911($DupTable_aL; $table_L)
				APPEND TO ARRAY:C911($DupTable_atxt; Table name:C256($table_L))
				APPEND TO ARRAY:C911($DupSourceIDs_atxt; $SourceIDS_atxt{$loop_L})
				APPEND TO ARRAY:C911($DestDups_atxt; $DestIDs_atxt{$search_L})
				APPEND TO ARRAY:C911($Dests_atxt; "here")
				Repeat 
					$search_L:=Find in array:C230($SourceIDS_atxt; $SourceIDS_atxt{$loop_L}; $search_L+1)
					If ($search_L>0)
						//add to list
						APPEND TO ARRAY:C911($DupTable_aL; $table_L)
						APPEND TO ARRAY:C911($DupTable_atxt; Table name:C256($table_L))
						APPEND TO ARRAY:C911($DupSourceIDs_atxt; $SourceIDS_atxt{$loop_L})
						APPEND TO ARRAY:C911($DestDups_atxt; $DestIDs_atxt{$search_L})
						APPEND TO ARRAY:C911($Dests_atxt; "here")
					End if 
				Until ($search_L<=1)
				
			End if 
			
		End for 
		
	End if 
	
End for 
CLOSE WINDOW:C154
If (Size of array:C274($DupTable_aL)>0)
	C_TEXT:C284($Folder_txt; $filename_txt)
	$Folder_txt:=Select folder:C670("Choose folder for output of duplicates")
	If (OK=1)
		
	Else 
		ALERT:C41("Results will be saved in temp folder! If you want to save them, Save the file at a location you prefer!")
		$Folder_txt:=Temporary folder:C486
	End if 
	C_TIME:C306($report_t)
	$filename_txt:=$Folder_txt+"FileIDDuplicatesReport_"+ut_CreateTimeStamp+".txt"
	$report_t:=Create document:C266($filename_txt)
	C_LONGINT:C283($loop_L)
	SEND PACKET:C103($report_t; "TableN"+Char:C90(Tab:K15:37)+"Table"+Char:C90(Tab:K15:37)+"Destination"+Char:C90(Tab:K15:37)+"SourceID"+Char:C90(Tab:K15:37)+"DestID"+Char:C90(13))
	For ($loop_L; 1; Size of array:C274($DupTable_aL))
		SEND PACKET:C103($report_t; String:C10($DupTable_aL{$loop_L})+Char:C90(Tab:K15:37)+$DupTable_atxt{$loop_L}+Char:C90(Tab:K15:37)+$Dests_atxt{$loop_L}+Char:C90(Tab:K15:37)+$DupSourceIDs_atxt{$loop_L}+Char:C90(Tab:K15:37)+$DestDups_atxt{$loop_L}+Char:C90(13))
	End for 
	CLOSE DOCUMENT:C267($report_t)
	ut_OpenDocument($filename_txt)
Else 
	ALERT:C41("No Duplicates found in FileIDRes table!")
End if 

//End ACTLOG_CheckFileID