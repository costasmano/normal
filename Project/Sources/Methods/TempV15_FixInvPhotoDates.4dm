//%attributes = {"invisible":true}
//Method: TempV15_FixInvPhotoDates
//Description
// Loads 3 tab delim text files
// 1 : from users data list of BIN, InvinspID,Date only for InvPhotinsp for the district
// 2 : from users data file export of FileIDRes for [InventoryPhotoInsp] table (112) and destination = distr bms - 1st col : local ID, 2nd col : Destination ID
// 3 : from distr server data file export of FileIDRes for [InventoryPhotoInsp] table (112) and destination = mhd bms - 1st col : local ID, 2nd col : Destination ID
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/14/17, 17:34:51
	// ----------------------------------------------------
	//Created : 
	Mods_2017_06_bug
End if 
//
C_TEXT:C284($UserInvIDlist_txt; $UserFileIDRes_txt; $ServerFileIDRes_txt)
ARRAY TEXT:C222($SelectedFiles_atxt; 0)
$UserInvIDlist_txt:=Select document:C905(""; ""; "Select File with BIN InvPhotoIDs and Dates"; 0; $SelectedFiles_atxt)

$UserInvIDlist_txt:=$SelectedFiles_atxt{1}

$UserFileIDRes_txt:=Select document:C905(""; ""; "Select File with FileIDRes export for table 112 from user"; 0; $SelectedFiles_atxt)
$UserFileIDRes_txt:=$SelectedFiles_atxt{1}

$ServerFileIDRes_txt:=Select document:C905(""; ""; "Select File with FileIDRes export for table 112 from Distr Server"; 0; $SelectedFiles_atxt)
$ServerFileIDRes_txt:=$SelectedFiles_atxt{1}

ARRAY TEXT:C222($BINs_atxt; 0)
ARRAY LONGINT:C221($UsrInspIDS_aL; 0)
ARRAY DATE:C224($UsrDates_ad; 0)
ARRAY LONGINT:C221($FileID_User_aL; 0)
ARRAY LONGINT:C221($FileID_UserServr_aL; 0)
ARRAY LONGINT:C221($FileID_Server_aL; 0)
ARRAY LONGINT:C221($FileID_ServerBoston_aL; 0)

C_BLOB:C604($Doc_x)
C_TEXT:C284($Doc_txt)
DOCUMENT TO BLOB:C525($UserInvIDlist_txt; $Doc_x)

$Doc_txt:=BLOB to text:C555($Doc_x; Mac text without length:K22:10)

ARRAY TEXT:C222($Lines_atxt; 0)
ut_TextToArray($Doc_txt; ->$Lines_atxt; Char:C90(13))
ARRAY TEXT:C222($BINs_atxt; Size of array:C274($Lines_atxt))
ARRAY LONGINT:C221($UsrInspIDS_aL; Size of array:C274($Lines_atxt))
ARRAY DATE:C224($UsrDates_ad; Size of array:C274($Lines_atxt))

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($Lines_atxt))
	ARRAY TEXT:C222($Parts_atxt; 0)
	ut_TextToArray($Lines_atxt{$loop_L}; ->$Parts_atxt; Char:C90(Tab:K15:37))
	$BINs_atxt{$loop_L}:=$Parts_atxt{1}
	$UsrInspIDS_aL{$loop_L}:=Num:C11($Parts_atxt{2})
	$UsrDates_ad{$loop_L}:=Date:C102($Parts_atxt{3})
End for 

SET BLOB SIZE:C606($Doc_x; 0)
DOCUMENT TO BLOB:C525($UserFileIDRes_txt; $Doc_x)

$Doc_txt:=BLOB to text:C555($Doc_x; Mac text without length:K22:10)

ARRAY TEXT:C222($Lines_atxt; 0)
ut_TextToArray($Doc_txt; ->$Lines_atxt; Char:C90(13))
ARRAY LONGINT:C221($FileID_User_aL; Size of array:C274($Lines_atxt))
ARRAY LONGINT:C221($FileID_UserServr_aL; Size of array:C274($Lines_atxt))

ARRAY TEXT:C222($Parts_atxt; 0)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($Lines_atxt))
	ARRAY TEXT:C222($Parts_atxt; 0)
	ut_TextToArray($Lines_atxt{$loop_L}; ->$Parts_atxt; Char:C90(Tab:K15:37))
	$FileID_User_aL{$loop_L}:=Num:C11($Parts_atxt{1})
	$FileID_UserServr_aL{$loop_L}:=Num:C11($Parts_atxt{2})
End for 

SET BLOB SIZE:C606($Doc_x; 0)
DOCUMENT TO BLOB:C525($ServerFileIDRes_txt; $Doc_x)

$Doc_txt:=BLOB to text:C555($Doc_x; Mac text without length:K22:10)

ARRAY TEXT:C222($Lines_atxt; 0)
ut_TextToArray($Doc_txt; ->$Lines_atxt; Char:C90(13))
ARRAY LONGINT:C221($FileID_Server_aL; Size of array:C274($Lines_atxt))
ARRAY LONGINT:C221($FileID_ServerBoston_aL; Size of array:C274($Lines_atxt))

ARRAY TEXT:C222($Parts_atxt; 0)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($Lines_atxt))
	ARRAY TEXT:C222($Parts_atxt; 0)
	ut_TextToArray($Lines_atxt{$loop_L}; ->$Parts_atxt; Char:C90(Tab:K15:37))
	$FileID_Server_aL{$loop_L}:=Num:C11($Parts_atxt{1})
	$FileID_ServerBoston_aL{$loop_L}:=Num:C11($Parts_atxt{2})
End for 

//this is run on the boston data
C_TEXT:C284($logFileName_txt)
$logFileName_txt:=GetPath($UserInvIDlist_txt)+"InvPhotoDateFix"+ut_CreateTimeStamp+".txt"
C_TIME:C306($logFileName_t)
$logFileName_t:=Create document:C266($logFileName_txt)
SEND PACKET:C103($logFileName_t; "BINs"+Char:C90(Tab:K15:37)+"UsrInspIDS_aL"+Char:C90(Tab:K15:37)+"UsrDates_ad")
SEND PACKET:C103($logFileName_t; Char:C90(Tab:K15:37)+"$DistrMatchIndx_L"+Char:C90(Tab:K15:37)+"$DistrServID_L"+Char:C90(Tab:K15:37)+"$BostMatchIndx_L"+Char:C90(Tab:K15:37)+"$BostonID_L")
SEND PACKET:C103($logFileName_t; Char:C90(Tab:K15:37)+"Message"+Char:C90(Carriage return:K15:38))
READ ONLY:C145(*)

C_LONGINT:C283($loop_L; $DistrMatchIndx_L; $BostMatchIndx_L; $DistrServID_L; $BostonID_L)
For ($loop_L; 1; Size of array:C274($BINs_atxt))
	SEND PACKET:C103($logFileName_t; $BINs_atxt{$loop_L}+Char:C90(Tab:K15:37)+String:C10($UsrInspIDS_aL{$loop_L})+Char:C90(Tab:K15:37)+String:C10($UsrDates_ad{$loop_L}))
	//check if BIN is Valid
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BINs_atxt{$loop_L})
	
	If (Records in selection:C76([Bridge MHD NBIS:1])=1)
		//try to match insp ID to distr server
		$DistrMatchIndx_L:=Find in array:C230($FileID_User_aL; $UsrInspIDS_aL{$loop_L})
		If ($DistrMatchIndx_L>0)
			$DistrServID_L:=$FileID_UserServr_aL{$DistrMatchIndx_L}
		Else 
			$DistrServID_L:=$UsrInspIDS_aL{$loop_L}
		End if 
		//try to match distr insp ID to boston server
		$BostMatchIndx_L:=Find in array:C230($FileID_Server_aL; $DistrServID_L)
		
		If ($BostMatchIndx_L>0)
			$BostonID_L:=$FileID_ServerBoston_aL{$BostMatchIndx_L}
		Else 
			$BostonID_L:=$DistrServID_L
		End if 
		//write results
		SEND PACKET:C103($logFileName_t; Char:C90(Tab:K15:37)+String:C10($DistrMatchIndx_L)+Char:C90(Tab:K15:37)+String:C10($DistrServID_L)+Char:C90(Tab:K15:37)+String:C10($BostMatchIndx_L)+Char:C90(Tab:K15:37)+String:C10($BostonID_L))
		//now check if BINS match
		
		QUERY:C277([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]InvPhotoInspID_L:1=$BostonID_L)
		
		If (Records in selection:C76([InventoryPhotoInsp:112])>0)
			
			If ([InventoryPhotoInsp:112]BIN:2=$BINs_atxt{$loop_L})
				//match - check date
				
				If ([InventoryPhotoInsp:112]InvPhotoDate_D:3#$UsrDates_ad{$loop_L})
					
					If (ut_LoadRecordInteractive(->[InventoryPhotoInsp:112]))
						[InventoryPhotoInsp:112]InvPhotoDate_D:3:=$UsrDates_ad{$loop_L}
						SAVE RECORD:C53([InventoryPhotoInsp:112])
						UNLOAD RECORD:C212([InventoryPhotoInsp:112])
						SEND PACKET:C103($logFileName_t; Char:C90(Tab:K15:37)+"Record updated and saved!"+Char:C90(Carriage return:K15:38))
					Else 
						SEND PACKET:C103($logFileName_t; Char:C90(Tab:K15:37)+"Record could not be loaded!"+Char:C90(Carriage return:K15:38))
						
					End if 
					
				Else 
					SEND PACKET:C103($logFileName_t; Char:C90(Tab:K15:37)+"Dates match!"+Char:C90(Carriage return:K15:38))
				End if 
				
			Else 
				SEND PACKET:C103($logFileName_t; Char:C90(Tab:K15:37)+"Non matching BIN "+$BINs_atxt{$loop_L}+Char:C90(Carriage return:K15:38))
			End if 
			
			
		Else 
			SEND PACKET:C103($logFileName_t; Char:C90(Tab:K15:37)+"Inv photo ID Not Found!"+Char:C90(Carriage return:K15:38))
		End if 
		
	Else 
		SEND PACKET:C103($logFileName_t; Char:C90(Tab:K15:37)+"BIN Not Found!"+Char:C90(Carriage return:K15:38))
	End if 
	
	
End for 

CLOSE DOCUMENT:C267($logFileName_t)

//End TempV15_FixInvPhotoDates