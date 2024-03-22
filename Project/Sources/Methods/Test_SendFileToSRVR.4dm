//%attributes = {"invisible":true}
//Method: Test_SendFileToSRVR
//Description
// Send a local file to a server - has various tasks for testing
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/18/17, 17:03:49
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
End if 
//
C_TEXT:C284($Doc_txt)
C_BOOLEAN:C305($er_b)
C_BLOB:C604($file_x)
C_TEXT:C284($dest_txt)
C_BLOB:C604($DataBlob_x)
C_BOOLEAN:C305($GetOut_b)
C_LONGINT:C283($Compressed_L)
$GetOut_b:=False:C215
C_TEXT:C284($Task)
ARRAY TEXT:C222($Tasks_atxt; 0)
APPEND TO ARRAY:C911($Tasks_atxt; "GetAFileToLocal")
APPEND TO ARRAY:C911($Tasks_atxt; "SendAFile")
APPEND TO ARRAY:C911($Tasks_atxt; "SendAblob")
APPEND TO ARRAY:C911($Tasks_atxt; "makeAblob")
APPEND TO ARRAY:C911($Tasks_atxt; "chooseFileToblob")
C_LONGINT:C283($Task_L)
Repeat 
	$Task:=""
	$Task_L:=G_PickFromList(->$Tasks_atxt; "Choose a task")
	If ($Task_L>0)
		$Task:=$Tasks_atxt{$Task_L}
	End if 
	Case of 
		: ($Task="GetAFileToLocal")
			Test_SaveSRVRfileLocal
			
		: ($Task="SendAFile")
			$Doc_txt:=Select document:C905(""; ""; "Choose a server resource file to send"; 0)
			DOCUMENT TO BLOB:C525(Document; $file_x)
			$dest_txt:=Test_SelectSRVFile
			
			$er_b:=Test_SaveFileOnSRVR($dest_txt; $file_x)
			
		: ($Task="SendAblob")
			
			$Doc_txt:=Select document:C905(""; ""; "Choose an activity blob to send"; 0)
			C_BLOB:C604($DataBlob_x)
			DOCUMENT TO BLOB:C525(Document; $DataBlob_x)
			BLOB PROPERTIES:C536($DataBlob_x; $Compressed_L)
			If ($Compressed_L#Is not compressed:K22:11)
				EXPAND BLOB:C535($DataBlob_x)
			End if 
			C_LONGINT:C283($offset_L)
			BLOB TO VARIABLE:C533($DataBlob_x; $dest_txt; $offset_L)
			BLOB TO VARIABLE:C533($DataBlob_x; $file_x; $offset_L)
			
			$er_b:=Test_SaveFileOnSRVR($dest_txt; $file_x)
			
		: ($Task="makeAblob")
			$dest_txt:=Test_SelectSRVFile("Select a server resource file to put in a local data blob")
			$File_x:=Test_GetFileFromSRVR($dest_txt)
			BLOB PROPERTIES:C536($File_x; $Compressed_L)
			If ($Compressed_L#Is not compressed:K22:11)
			Else 
				COMPRESS BLOB:C534($File_x)
			End if 
			VARIABLE TO BLOB:C532($dest_txt; $DataBlob_x; *)
			VARIABLE TO BLOB:C532($File_x; $DataBlob_x; *)
			COMPRESS BLOB:C534($DataBlob_x)
			C_TIME:C306($Doc_t)
			$Doc_t:=Create document:C266("")
			CLOSE DOCUMENT:C267($Doc_t)
			BLOB TO DOCUMENT:C526(Document; $DataBlob_x)
			SHOW ON DISK:C922(Document)
			
		: ($Task="chooseFileToblob")
			$Doc_txt:=Select document:C905(""; ""; "Select a local doc to put in a data blob"; 0)
			DOCUMENT TO BLOB:C525(Document; $file_x)
			COMPRESS BLOB:C534($file_x)
			$dest_txt:=Test_SelectSRVFile("Select a server resource file to update with "+Document)
			VARIABLE TO BLOB:C532($dest_txt; $DataBlob_x; *)
			VARIABLE TO BLOB:C532($File_x; $DataBlob_x; *)
			COMPRESS BLOB:C534($DataBlob_x)
			C_TIME:C306($Doc_t)
			$Doc_t:=Create document:C266("")
			CLOSE DOCUMENT:C267($Doc_t)
			BLOB TO DOCUMENT:C526(Document; $DataBlob_x)
			SHOW ON DISK:C922(Document)
			
		Else 
			$GetOut_b:=True:C214
			
	End case 
	
Until ($GetOut_b)

//End Test_SendFileToSRVR