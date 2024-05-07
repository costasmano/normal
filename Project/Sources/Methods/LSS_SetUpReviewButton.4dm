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
	// Modified by: Costas Manousakis-(Designer)-(2024-04-24 14:16:47)
	Mods_2024_04
	//  `use ds. queries to avoid changing current selections
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
				
				// start of Mods_2024_04
				C_OBJECT:C1216($pers_o; $inv_o)
				$pers_o:=ds:C1482.Personnel.query("\"Person ID\" = :1"; <>CURRENTUSER_PID).first()
				$inv_o:=ds:C1482.LSS_Inventory.query("LSS_InventoryId_s = :1"; [LSS_Inspection:164]LSS_InventoryId_s:2).first()
				C_BOOLEAN:C305($vis_b)
				$vis_b:=False:C215
				
				Case of 
					: ($pers_o=Null:C1517)
					: ($inv_o=Null:C1517)
					: (Num:C11(Substring:C12($pers_o["Division No"]; 4; 1))=$inv_o.LSS_District_L)
						$vis_b:=True:C214
				End case 
				OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; $vis_b)
				
				// end of Mods_2024_04
				
			End if 
			
		End if 
		
	End if 
Else 
	OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
End if 
//End LSS_SetUpReviewButton