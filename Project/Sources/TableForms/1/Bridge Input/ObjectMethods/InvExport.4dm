//Method: [Bridge MHD NBIS];"Bridge Input".InvExport
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/01/18, 13:59:10
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11  //ADD ability to export and then import
	//[InventoryPhotos]
	//Modified by: Chuck Miller (11/1/18 16:05:50)
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 12:07:27)
	Mods_2020_04
	//  `added the BDEPT_BIN in the name of export file
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(*; "InvExport"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "InvExport"; False:C215)
		End if 
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($row_l; $column_l; $Select_L; $InvPhotoInspID_L; $loop_L)
		C_TEXT:C284($SelectedFolder_txt; $ExportFile_txt; $ExportHeader_txt; $Bin_txt; $Date_txt)
		
		LISTBOX GET CELL POSITION:C971(*; "InventoryPhotos"; $column_l; $row_l)
		If ($row_l>0)
			GOTO SELECTED RECORD:C245([InventoryPhotoInsp:112]; $ROW_L)
			QUERY:C277([InventoryPhotos:113]; [InventoryPhotos:113]InvPhotoInsp_ID:2=[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
			$Select_L:=Records in selection:C76([InventoryPhotos:113])
			If ($Select_L>0)
				CONFIRM:C162("Are you sure you wish to export inventory photo records for date "+String:C10([InventoryPhotoInsp:112]InvPhotoDate_D:3); "Export"; "Do NOT Export")
				If (OK=1)
					$SelectedFolder_txt:=Select folder:C670("Select folder save inventory photo records to"; "")
					If (OK=1)
						$Date_txt:=String:C10(Year of:C25([InventoryPhotoInsp:112]InvPhotoDate_D:3))+"_"+String:C10(Month of:C24([InventoryPhotoInsp:112]InvPhotoDate_D:3))+"_"+String:C10(Day of:C23([InventoryPhotoInsp:112]InvPhotoDate_D:3))
						$ExportFile_txt:="InventoryPhoto_"+String:C10([InventoryPhotoInsp:112]InvPhotoInspID_L:1)+"_"+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Bridge MHD NBIS:1]BIN:3+"_"+$Date_txt+".txt"
						SET CHANNEL:C77(10; $SelectedFolder_txt+$ExportFile_txt)  //Open a channel for a document
						$Bin_txt:=[Bridge MHD NBIS:1]BIN:3
						$ExportHeader_txt:="InventoryPhotosExport"
						SEND VARIABLE:C80($ExportHeader_txt)
						SEND VARIABLE:C80($Bin_txt)
						SEND VARIABLE:C80($Select_L)
						SEND RECORD:C78([InventoryPhotoInsp:112])
						C_LONGINT:C283($Progress_L)
						$Progress_L:=Progress New
						
						For ($loop_L; 1; Records in selection:C76([InventoryPhotos:113]))
							Progress SET TITLE($Progress_L; "Exporting "+String:C10($loop_l)+" out of "+String:C10($Select_L)+" Inventory Photos")
							Progress SET PROGRESS($Progress_L; $Loop_l/$Select_L)
							
							GOTO SELECTED RECORD:C245([InventoryPhotos:113]; $loop_L)
							LOAD RECORD:C52([InventoryPhotos:113])
							SEND RECORD:C78([InventoryPhotos:113])
						End for 
						SET CHANNEL:C77(11)
						Progress QUIT($Progress_L)
					End if 
					
				End if 
				
			End if 
		End if 
		
End case 

//End [Bridge MHD NBIS];"Bridge Input".Button