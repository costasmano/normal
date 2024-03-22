//%attributes = {"invisible":true}
//Method: INSP_DuplicateInventoryPhotos
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 06/20/13, 13:15:11
	//----------------------------------------------------
	
	Mods_2013_06  //r001 ` Add code to alow for add, delete and duplicate 
	//[InventoryPhotoInsp] and [InventoryPhotos]
	//Modified by: Charles Miller (6/20/13 13:15:13)
	Mods_2013_08  //r001 ` Add confirm to allow designer to either duplicate or blank out pictures
	//Modified by: Charles Miller (8/15/13 14:27:06)
	// Modified by: Costas Manousakis-(Designer)-(8/29/13 17:18:20)
	Mods_2013_08
	//  `
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 12:40:16)
	Mods_2020_04
	//  `when duplicating use LogLink for TL and TM if they are not zero
	//  `also do not log the BIN
	
	// Modified by: Costas Manousakis-(Designer)-(2022-09-15 17:27:23)
	Mods_2022_09_bug
	//  `assign a TL or a TM based on the current user
End if 
C_BOOLEAN:C305($InTransaction_B)
C_LONGINT:C283($row_l; $column_l; $Select_L)

$row_l:=Records in set:C195("LBSetInvInsp")
If ($row_l>0)
	LISTBOX GET CELL POSITION:C971(*; "InventoryPhotos"; $column_l; $row_l)
Else 
	$row_l:=0
End if 


Case of 
	: (ButtonpopupText="")  // this means a straight click on the ADD button
		FORM SET INPUT:C55([InventoryPhotoInsp:112]; "Input")
		ADD RECORD:C56([InventoryPhotoInsp:112]; *)
	Else 
		If (($row_l<1) | ($row_l>Records in selection:C76([InventoryPhotoInsp:112])))  //for right click do nothing if no record selected
			//maybe if it is a click on the ADD button need to just add again - maybe focus object
			
		Else 
			ARRAY TEXT:C222($PopUpChoices_atxt; 0)
			ARRAY TEXT:C222($PopUpChoices_atxt; 2)
			$PopUpChoices_atxt{1}:="Add"
			$PopUpChoices_atxt{2}:="Duplicate"
			
			C_TEXT:C284($currUser_txt)
			$currUser_txt:=<>CurrentUser_Name
			GOTO SELECTED RECORD:C245([InventoryPhotoInsp:112]; $row_l)
			If ($currUser_txt="Designer")
				ButtonpopupText:=ButtonpopupText+"Delete;"
				APPEND TO ARRAY:C911($PopUpChoices_atxt; "Delete")
			End if 
			$Select_L:=Pop up menu:C542(ButtonpopupText)
			
			Case of 
				: ($PopUpChoices_atxt{$Select_L}="Duplicate")  //Duplicate
					If (Not:C34(In transaction:C397))
						$InTransaction_B:=False:C215
						START TRANSACTION:C239
					Else 
						$InTransaction_B:=True:C214
					End if 
					ARRAY POINTER:C280(ptr_Changes; 0; 0)
					
					InitChangeStack(1)
					QUERY:C277([InventoryPhotos:113]; [InventoryPhotos:113]InvPhotoInsp_ID:2=[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
					ARRAY LONGINT:C221($InventoryPhotoRecordNo_aL; 0)
					LONGINT ARRAY FROM SELECTION:C647([InventoryPhotos:113]; $InventoryPhotoRecordNo_aL)
					DUPLICATE RECORD:C225([InventoryPhotoInsp:112])
					Inc_Sequence("InventoryPhotoInsp"; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
					LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; "InventoryPhotoInsp")
					C_BOOLEAN:C305($DuplicatePictures_b)
					$DuplicatePictures_b:=False:C215
					If (User in group:C338($currUser_txt; "Design Access Group"))
						CONFIRM:C162("Do you want to make exact duplicate or create empty pictures?"; "Exact Duplicate"; "Blank")
						$DuplicatePictures_b:=(OK=1)
					End if 
					
					If ($DuplicatePictures_b)
						
					Else 
						[InventoryPhotoInsp:112]InvPhotoDate_D:3:=Current date:C33(*)
						[InventoryPhotoInsp:112]TeamLeader_I:5:=0
						[InventoryPhotoInsp:112]TeamMember_I:10:=0
						[InventoryPhotoInsp:112]Approved_I:6:=0
						[InventoryPhotoInsp:112]ApproveDate_D:8:=!00-00-00!
						[InventoryPhotoInsp:112]Complete_B:9:=False:C215
						[InventoryPhotoInsp:112]ApproveComments_txt:7:=""
						
					End if 
					
					PushChange(1; ->[InventoryPhotoInsp:112]InvPhotoDate_D:3)
					PushChange(1; ->[InventoryPhotoInsp:112]ApproveComments_txt:7)
					PushChange(1; ->[InventoryPhotoInsp:112]Approved_I:6)
					PushChange(1; ->[InventoryPhotoInsp:112]ApproveDate_D:8)
					PushChange(1; ->[InventoryPhotoInsp:112]Complete_B:9)
					PushChange(1; ->[InventoryPhotoInsp:112]OrientationNS_b:4)
					
					
					Case of 
						: (GRP_UserInGroup("INV_TeamLeaders")=1)
							[InventoryPhotoInsp:112]TeamLeader_I:5:=<>CURRENTUSER_PID
						: (<>PERS_MyJobCode_i=2) | (<>PERS_MyJobCode_i=1)  // team leader or DBIE
							[InventoryPhotoInsp:112]TeamLeader_I:5:=<>CURRENTUSER_PID
						Else 
							[InventoryPhotoInsp:112]TeamMember_I:10:=<>CURRENTUSER_PID
					End case 
					
					If ([InventoryPhotoInsp:112]TeamLeader_I:5#0)
						LogLink(->[InventoryPhotoInsp:112]TeamLeader_I:5; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; ->[Personnel:42]Person ID:1)
					Else 
						PushChange(1; ->[InventoryPhotoInsp:112]TeamLeader_I:5)
					End if 
					If ([InventoryPhotoInsp:112]TeamMember_I:10#0)
						LogLink(->[InventoryPhotoInsp:112]TeamMember_I:10; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; ->[Personnel:42]Person ID:1)
					Else 
						PushChange(1; ->[InventoryPhotoInsp:112]TeamMember_I:10)
					End if 
					
					C_LONGINT:C283($NewID_L)
					$NewID_L:=[InventoryPhotoInsp:112]InvPhotoInspID_L:1
					FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1)
					SAVE RECORD:C53([InventoryPhotoInsp:112])
					C_LONGINT:C283($Loop_L)
					
					For ($Loop_L; 1; Size of array:C274($InventoryPhotoRecordNo_aL))
						
						GOTO RECORD:C242([InventoryPhotos:113]; $InventoryPhotoRecordNo_aL{$Loop_L})
						DUPLICATE RECORD:C225([InventoryPhotos:113])
						Inc_Sequence("InventoryPhoto"; ->[InventoryPhotos:113]InvPhoto_ID:1)
						[InventoryPhotos:113]InvPhotoInsp_ID:2:=$NewID_L
						If ($DuplicatePictures_b)
						Else 
							SET BLOB SIZE:C606([InventoryPhotos:113]InvPhoto_X:4; 0)
						End if 
						LogNewRecord(->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2; "InventoryPhoto")
						InitChangeStack(2)
						PushChange(2; ->[InventoryPhotos:113]PhotoDescr_txt:3)
						PushChange(2; ->[InventoryPhotos:113]InvPhoto_X:4)
						PushChange(2; ->[InventoryPhotos:113]Sequence_I:5)
						
						FlushGrpChgs(2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2)
						
						SAVE RECORD:C53([InventoryPhotos:113])
					End for 
					UNLOAD RECORD:C212([InventoryPhotos:113])
					UNLOAD RECORD:C212([InventoryPhotoInsp:112])
					VALIDATE TRANSACTION:C240
					
					If ($InTransaction_B)
						START TRANSACTION:C239
					End if 
					
				: ($PopUpChoices_atxt{$Select_L}="Add")
					FORM SET INPUT:C55([InventoryPhotoInsp:112]; "Input")
					ADD RECORD:C56([InventoryPhotoInsp:112]; *)
				: ($PopUpChoices_atxt{$Select_L}="Delete")
					
					INV_DeleteInsp(False:C215)
			End case 
			ARRAY POINTER:C280(ptr_Changes; 0; 0)
			
		End if 
		
End case 

INV_GetBINInventoryPhotos([Bridge MHD NBIS:1]BIN:3)
//End INSP_DuplicateInventoryPhotos