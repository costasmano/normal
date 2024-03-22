//%attributes = {"invisible":true}
//Method: INSP_ImportInventoryPhotos
//Description
// import inventory inspection exported from
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/01/18, 14:25:03
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11  //ADD ability to export and then import.
	//[InventoryPhotos]
	//Modified by: Chuck Miller (11/1/18 16:05:50)
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 12:11:40)
	Mods_2020_04
	//  `added Set channel(11) at the end to close the file
	//  `Added BIN to the fields to skip for the Inspection - use LogLink for TM and TL if not zero
	//  `Added InvPhotInspID to fields to skip for the photos
End if 
//
C_LONGINT:C283($Select_L; $InvPhotoInspID_L; $loop_L)
C_DATE:C307($InvPhoto_d)
C_TEXT:C284($CurrBIN_txt; $ExportHeader_txt; $Bin_txt)
C_BOOLEAN:C305($DoImport_b; $InTransaction_B)
$CurrBIN_txt:=[Bridge MHD NBIS:1]BIN:3
SET CHANNEL:C77(10; "")
If (ok=1)
	RECEIVE VARIABLE:C81($ExportHeader_txt)
	If ($ExportHeader_txt#"InventoryPhotosExport")
		ALERT:C41("File <"+Document+"> NOT A VALID MHD Inventory Photo Export data file!!")
	Else 
		RECEIVE VARIABLE:C81($Bin_txt)
		RECEIVE VARIABLE:C81($Select_L)
		C_BOOLEAN:C305($DoImport_b)
		
		If ([Bridge MHD NBIS:1]BIN:3=$Bin_txt)
			$DoImport_b:=True:C214
			
		Else 
			CONFIRM:C162("Import Inventory photos from BIN "+$Bin_txt+" to BIN "+[Bridge MHD NBIS:1]BIN:3; "Import"; "Do NOT Import")
			If (OK=1)
				//will switch inspection to the current BIN
				$DoImport_b:=True:C214
			Else 
				
			End if 
		End if 
		4DError_b:=False:C215
		If ($DoImport_b)
			If (In transaction:C397)
				$InTransaction_B:=True:C214
			Else 
				START TRANSACTION:C239
				C_TEXT:C284($MethodCalledOnError_txt)
				$MethodCalledOnError_txt:=Method called on error:C704
				ON ERR CALL:C155("4D_Errors")
				
				ARRAY POINTER:C280(ptr_Changes; 0; 0)
				
				InitChangeStack(1)
				RECEIVE RECORD:C79([InventoryPhotoInsp:112])
				Inc_Sequence("InventoryPhotoInsp"; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
				[InventoryPhotoInsp:112]BIN:2:=[Bridge MHD NBIS:1]BIN:3
				[InventoryPhotoInsp:112]InventoryPhotoInsp_UUIDKey_s:11:=Generate UUID:C1066
				LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; "InventoryPhotoInsp")
				ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
				
				APPEND TO ARRAY:C911($FieldsToSkip_atxt; "InvPhotoInspID_L")
				APPEND TO ARRAY:C911($FieldsToSkip_atxt; "BIN")
				APPEND TO ARRAY:C911($FieldsToSkip_atxt; "InventoryPhotoInsp_UUIDKey_s")
				
				If (ACT_PushGroupChanges(Table:C252(->[InventoryPhotoInsp:112]); 1; ->$FieldsToSkip_atxt))
					FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1)
					
					If ([InventoryPhotoInsp:112]TeamLeader_I:5#0)
						LogLink(->[InventoryPhotoInsp:112]TeamLeader_I:5; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; ->[Personnel:42]Person ID:1)
						
					End if 
					If ([InventoryPhotoInsp:112]TeamMember_I:10#0)
						LogLink(->[InventoryPhotoInsp:112]TeamMember_I:10; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; ->[Personnel:42]Person ID:1)
					End if 
					
					SAVE RECORD:C53([InventoryPhotoInsp:112])
				End if 
				ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
				APPEND TO ARRAY:C911($FieldsToSkip_atxt; "InvPhoto_ID")
				APPEND TO ARRAY:C911($FieldsToSkip_atxt; "InvPhotoInspID_L")
				APPEND TO ARRAY:C911($FieldsToSkip_atxt; "InventoryPhotos_UUIDKey_s")
				C_LONGINT:C283($Progress_L)
				$Progress_L:=Progress New
				
				For ($loop_L; 1; $Select_L)
					Progress SET TITLE($Progress_L; "Importing "+String:C10($loop_l)+" out of "+String:C10($Select_L)+" Inventory Photos")
					Progress SET PROGRESS($Progress_L; $Loop_l/$Select_L)
					
					InitChangeStack(1)
					
					RECEIVE RECORD:C79([InventoryPhotos:113])
					[InventoryPhotos:113]InvPhotoInsp_ID:2:=[InventoryPhotoInsp:112]InvPhotoInspID_L:1
					Inc_Sequence("InventoryPhoto"; ->[InventoryPhotos:113]InvPhoto_ID:1)
					[InventoryPhotos:113]InventoryPhotos_UUIDKey_s:6:=Generate UUID:C1066
					
					LogNewRecord(->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2; "InventoryPhoto")
					PushChange(1; ->[InventoryPhotos:113]InvPhoto_X:4)
					
					If (ACT_PushGroupChanges(Table:C252(->[InventoryPhotos:113]); 1; ->$FieldsToSkip_atxt))
						FlushGrpChgs(1; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2)
						SAVE RECORD:C53([InventoryPhotos:113])
						UNLOAD RECORD:C212([InventoryPhotos:113])
					End if 
					
				End for 
				UNLOAD RECORD:C212([InventoryPhotoInsp:112])
				INV_GetBINInventoryPhotos
				REDRAW:C174(InventoryPhotos)
				If (Not:C34(4DError_b))
					VALIDATE TRANSACTION:C240
				Else 
					CANCEL TRANSACTION:C241
					C_TEXT:C284($message_txt)
					$message_txt:="The following errors occurred during import. Notify MADOT BMS Support!"+Char:C90(Carriage return:K15:38)
					For ($loop_L; 1; Size of array:C274(SQL_InternalDescriptions_atxt))
						$message_txt:=$message_txt+SQL_InternalDescriptions_atxt{$loop_L}+Char:C90(Carriage return:K15:38)
					End for 
					ut_BigAlert($message_txt)
					
				End if 
				ON ERR CALL:C155($MethodCalledOnError_txt)
				CONFIRM:C162("Delete the import file "+Document; "Delete"; "Do NOT Delete")
				If (OK=1)
					DELETE DOCUMENT:C159(Document)
				End if 
				Progress QUIT($Progress_L)
			End if 
		End if 
	End if 
	SET CHANNEL:C77(11)  //close the file
End if 
//End INSP_ImportInventoryPhotos