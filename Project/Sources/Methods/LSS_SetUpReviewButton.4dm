//%attributes = {"invisible":true}
//Method: LSS_SetUpReviewButton
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/27/18, 12:42:57
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
	// Modified by: Costas Manousakis-(Designer)-(11/29/18 14:27:06)
	Mods_2018_11
	//  `modified to allow MassDOTReps belonging to the same district as the inventory record to do a review
End if 
//
If ([LSS_Inspection:164]LSS_Complete_b:39)
	If ((User in group:C338(<>CurrentUser_Name; "Design Access Group")))
		OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; True:C214)
	Else 
		C_LONGINT:C283($Pos_L)
		
		If (<>CURRENTUSER_PID=[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5)
			OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; True:C214)
		Else 
			//check if user is a MassDOT rep. 
			$Pos_L:=Find in array:C230(LSS_MassDOTRepIDs_aL; <>CURRENTUSER_PID)
			If ($Pos_L>0)
				//now check if the district matches the inventory district
				READ ONLY:C145([Personnel:42])
				READ ONLY:C145([LSS_Inventory:165])
				QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=[LSS_Inspection:164]LSS_InventoryId_s:2)
				QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=<>CURRENTUSER_PID)
				C_LONGINT:C283($myDistr_L)
				$myDistr_L:=Num:C11(Substring:C12([Personnel:42]Division No:7; 4; 1))
				
				If ($myDistr_L=[LSS_Inventory:165]LSS_District_L:3)
					OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; True:C214)
					
				End if 
			End if 
			
		End if 
		
	End if 
Else 
	OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
End if 
//End LSS_SetUpReviewButton