//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/28/06, 13:58:21
	// ----------------------------------------------------
	// Method: INV_InvInspListObjM
	// Description
	// 
	// 
	// Parameters
	// $1 : InReviewList (optional) : boolean
	// ----------------------------------------------------
	Mods_2007_CM02
	// Modified by: costasmanousakis-(Designer)-(1/31/2007 14:19:05)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(4/13/2007 08:55:26)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(4/19/2007 11:17:37)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/11/10 11:25:24)
	Mods_2010_06
	//  `Modified code to go to the record that was exited from and scroll the listbox to that row.
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can not double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 
C_BOOLEAN:C305($1; $InReviewList_b)
C_LONGINT:C283($2; $FormEvent_L)
If (Count parameters:C259>0)
	$InReviewList_b:=$1
Else 
	$InReviewList_b:=False:C215
End if 
If (Count parameters:C259>1)
	$FormEvent_L:=$2
Else 
	$FormEvent_L:=Form event code:C388
End if 

C_BOOLEAN:C305(InDoubleClick_B)

Case of 
	: ($FormEvent_L=On Load:K2:1)
		InDoubleClick_B:=False:C215
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			FORM SET INPUT:C55([InventoryPhotoInsp:112]; "Input")
			START TRANSACTION:C239
			If (InvPhotoInspID_aL>0)
				C_LONGINT:C283($SelectedRec; $SelectedListItm; $ExitID_L)
				ARRAY LONGINT:C221($ListofIDs_aL; 0)
				SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]InvPhotoInspID_L:1; $ListofIDs_aL)
				$SelectedListItm:=InvPhotoInspID_aL
				$SelectedRec:=Find in array:C230($ListofIDs_aL; InvPhotoInspID_aL{InvPhotoInspID_aL})
				GOTO SELECTED RECORD:C245([InventoryPhotoInsp:112]; $SelectedRec)
				If (ut_LoadRecordInteractive(->[InventoryPhotoInsp:112]))
					MODIFY RECORD:C57([InventoryPhotoInsp:112])
					
					$ExitID_L:=[InventoryPhotoInsp:112]InvPhotoInspID_L:1
					If ($InReviewList_b)
						//INV_UpdateReviewList (invPhotoInspDate_aD)
						INV_DisplayInvInspections($InReviewList_b)
						INV_ReDoSort
						If ($SelectedListItm>Size of array:C274(InvPhotoInspID_aL))
							InvPhotoInspID_aL:=Size of array:C274(InvPhotoInspID_aL)
						Else 
							InvPhotoInspID_aL:=$SelectedListItm
						End if 
						$SelectedRec:=Find in array:C230(InvPhotoInspID_aL; $ExitID_L)
						If ($SelectedRec>0)
							
						Else 
							If ($SelectedListItm>Size of array:C274(InvPhotoInspID_aL))
								$SelectedRec:=Size of array:C274(InvPhotoInspID_aL)
							Else 
								$SelectedRec:=$SelectedListItm
							End if 
						End if 
						LISTBOX SELECT ROW:C912(INVListBox_LB; $SelectedRec; lk replace selection:K53:1)
						OBJECT SET SCROLL POSITION:C906(INVListBox_LB; $SelectedRec)
						
					Else 
						INV_GetBINInventoryPhotos([Bridge MHD NBIS:1]BIN:3)
						INV_DisplayInvInspections($InReviewList_b)
					End if 
				End if 
				InDoubleClick_B:=False:C215
				UNLOAD RECORD:C212([InventoryPhotoInsp:112])
				UNLOAD RECORD:C212([InventoryPhotos:113])
			Else 
				If ($InReviewList_b)
				Else 
					If (INV_InvInspRWAccess)
						ADD RECORD:C56([InventoryPhotoInsp:112])
						INV_GetBINInventoryPhotos([Bridge MHD NBIS:1]BIN:3)
						INV_DisplayInvInspections($InReviewList_b)
						UNLOAD RECORD:C212([InventoryPhotoInsp:112])
						UNLOAD RECORD:C212([InventoryPhotos:113])
					End if 
					
				End if 
				
			End if 
			If (In transaction:C397)
				CANCEL TRANSACTION:C241
			End if 
			INV_SetHelpMsg_List
			
		End if 
		
		
End case 