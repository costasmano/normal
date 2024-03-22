//Method: "SelectInvPhoto".v_112_003_ad
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Bridge Section
	//User (4D) : Designer
	//Date and time: 10/24/18, 17:27:34
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force ob get to return correct type
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($pick_L)
		$pick_L:=v_112_003_ad
		If ($pick_L>0)
			C_BOOLEAN:C305($refresh_b)
			$refresh_b:=True:C214
			//check to see if the current photos are from the inspection that was just selected
			C_LONGINT:C283($photoIDCheck_L)
			$photoIDCheck_L:=MaxNum(v_113_005_L; v_113_001_L)
			If ($photoIDCheck_L>0)
				QUERY:C277([InventoryPhotos:113]; [InventoryPhotos:113]InvPhoto_ID:1=$photoIDCheck_L)
				If ([InventoryPhotos:113]InvPhotoInsp_ID:2=v_112_001_aL{$pick_L})
					//same insp - OK
				Else 
					//warn that things will change
					CONFIRM:C162("The photos currently selected are not from this inventory inspection!"+\
						" If you continue, the selectios will be cleared!"; \
						"Continue"; "Cancel")
					If (OK=1)
						//different inspection - clear current selections
						
						v_113_005_L:=0
						v_113_001_L:=0
						OBJECT SET TITLE:C194(*; "ApproachDescr"; OB Get:C1224(SelectInvPhotoData_o; "DefApprLabel"; Is text:K8:3))
						OBJECT SET TITLE:C194(*; "ElevationDescr"; OB Get:C1224(SelectInvPhotoData_o; "DefElevLabel"; Is text:K8:3))
					Else 
						$refresh_b:=False:C215
						v_112_003_ad:=Find in array:C230(v_112_001_aL; [InventoryPhotos:113]InvPhotoInsp_ID:2)
					End if 
					
				End if 
			End if 
			
			If ($refresh_b)
				QUERY:C277([InventoryPhotos:113]; [InventoryPhotos:113]InvPhotoInsp_ID:2=v_112_001_aL{$pick_L})
				
				If (Records in selection:C76([InventoryPhotos:113])>0)
					INSP_UpdateSelInvPhotoLB
				Else 
					ALERT:C41("Inventory Inspection does not have any photos!")
					//leave arrays and buttons as is
				End if 
				
			End if 
			
		End if 
		
End case 

//End SelectInvPhoto.v_112_003_ad