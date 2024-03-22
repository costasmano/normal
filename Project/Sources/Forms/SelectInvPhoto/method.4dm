//Method: "SelectInvPhoto"
//Description
// dialog to select two inventory photos to be printed with bridge insp reports
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Bridge Section
	//User (4D) : Designer
	//Date and time: 10/25/18, 11:13:21
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
		READ ONLY:C145([InventoryPhotoInsp:112])
		READ ONLY:C145([InventoryPhotos:113])
		
		C_OBJECT:C1216(SelectInvPhotoData_o)
		C_LONGINT:C283(v_113_005_L)  //used for approach photo id
		C_LONGINT:C283(v_113_001_L)  //used for elevation photo id
		
		OB SET:C1220(SelectInvPhotoData_o; "DefApprLabel"; "(No photo selected for Approach)"; \
			"DefElevLabel"; "(No photo selected for Approach)")
		
		v_113_005_L:=Num:C11(OB Get:C1224(SelectInvPhotoData_o; "ApprPhotoID"; Is longint:K8:6))
		v_113_001_L:=Num:C11(OB Get:C1224(SelectInvPhotoData_o; "ElevPhotoID"; Is longint:K8:6))
		
		C_LONGINT:C283($photoId_L; $ApprinvinspID_L; $ElevinvinspID_L)
		C_TEXT:C284($ElevPhotoBIN_txt; $ApprPhotoBIN_txt)
		ARRAY TEXT:C222($errorChecks_atxt; 0)
		//checks :
		//  if they exist
		//  both are from same inv inspecton 
		//  Inv inspection is for current BIN
		
		If (v_113_005_L>0)  //approach
			$photoId_L:=0
			$ApprinvinspID_L:=0
			$ApprPhotoBIN_txt:=""
			Begin SQL
				select 
				[InventoryPhotos].[InvPhoto_ID]
				,[InventoryPhotos].[InvPhotoInsp_ID]
				,[InventoryPhotoInsp].[BIN]
				from [InventoryPhotos], [InventoryPhotoInsp]
				where 
				[InventoryPhotoInsp].[InvPhotoInspID_L] = [InventoryPhotos].[InvPhotoInsp_ID]
				and 
				[InventoryPhotos].[InvPhoto_ID] = :v_113_005_L
				
				into :$photoId_L, :$ApprinvinspID_L , :$ApprPhotoBIN_txt;
				
			End SQL
			
			Case of 
				: ($photoId_L=0)
					APPEND TO ARRAY:C911($errorChecks_atxt; "Selected Approach photo was not found! Photo was cleared!")
					v_113_005_L:=0
					$ApprinvinspID_L:=0
				: ($ApprPhotoBIN_txt#[Inspections:27]BIN:1)
					APPEND TO ARRAY:C911($errorChecks_atxt; "Selected Approach photo is for BIN "+$ApprPhotoBIN_txt+"! Photo was cleared!")
					v_113_005_L:=0
					$ApprinvinspID_L:=0
			End case 
			
		End if 
		
		If (v_113_001_L>0)  //Elevation
			$photoId_L:=0
			$ElevinvinspID_L:=0
			$ElevPhotoBIN_txt:=""
			Begin SQL
				select 
				[InventoryPhotos].[InvPhoto_ID]
				,[InventoryPhotos].[InvPhotoInsp_ID]
				,[InventoryPhotoInsp].[BIN]
				from [InventoryPhotos], [InventoryPhotoInsp]
				where 
				[InventoryPhotoInsp].[InvPhotoInspID_L] = [InventoryPhotos].[InvPhotoInsp_ID]
				and 
				[InventoryPhotos].[InvPhoto_ID] = :v_113_001_L
				
				into :$photoId_L, :$ElevinvinspID_L , :$ElevPhotoBIN_txt;
				
			End SQL
			
			Case of 
				: ($photoId_L=0)
					APPEND TO ARRAY:C911($errorChecks_atxt; "Selected Approach photo was not found! Photo was cleared!")
					v_113_001_L:=0
					$ElevinvinspID_L:=0
				: ($ElevPhotoBIN_txt#[Inspections:27]BIN:1)
					APPEND TO ARRAY:C911($errorChecks_atxt; "Selected Elevation photo is for BIN "+$ElevPhotoBIN_txt+"! Photo was cleared!")
					v_113_001_L:=0
					$ElevinvinspID_L:=0
			End case 
			
		End if 
		
		If (($ElevinvinspID_L>0) & ($ApprinvinspID_L>0) & ($ApprinvinspID_L#$ElevinvinspID_L))
			//Inv insp ids don't match - clear both photos
			APPEND TO ARRAY:C911($errorChecks_atxt; "Selected Approach and Elevation photos are from two different Inventory Inspections! Both Photos were cleared!")
			v_113_001_L:=0
			$ElevinvinspID_L:=0
			v_113_005_L:=0
			$ApprinvinspID_L:=0
		End if 
		
		If (Size of array:C274($errorChecks_atxt)>0)
			ALERT:C41(ut_ArrayToText(->$errorChecks_atxt; "\n"))
		End if 
		
		OBJECT SET FORMAT:C236(v_112_003_ad; Char:C90(System date short:K1:1+Blank if null date:K1:9))
		QUERY:C277([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]BIN:2=[Inspections:27]BIN:1)
		ORDER BY:C49([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]InvPhotoDate_D:3; <)
		SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]InvPhotoDate_D:3; v_112_003_ad; [InventoryPhotoInsp:112]InvPhotoInspID_L:1; v_112_001_aL)
		
		ARRAY TEXT:C222(v_113_003_atxt; 0)
		ARRAY PICTURE:C279(INVPHOTOINSPAPPR_AP; 0)
		ARRAY LONGINT:C221(v_113_001_aL; 0)
		
		If (MaxNum(v_113_005_L; v_113_001_L)>0)
			//there is something already correctly selected - set the interface
			$ApprinvinspID_L:=MaxNum($ApprinvinspID_L; $ElevinvinspID_L)
			If (Size of array:C274(v_112_001_aL)>0)
				C_LONGINT:C283($invIndx_L)
				$invIndx_L:=Find in array:C230(v_112_001_aL; $ApprinvinspID_L)
				//probably do not need to check this due to the checks done previously
				If ($invIndx_L>0)
					v_112_003_ad:=$invIndx_L
					//populate the list box
					QUERY:C277([InventoryPhotos:113]; [InventoryPhotos:113]InvPhotoInsp_ID:2=$ApprinvinspID_L)
					INSP_UpdateSelInvPhotoLB
					//update the selected labels
					C_LONGINT:C283($photoindx_L)
					$photoindx_L:=Find in array:C230(v_113_001_aL; v_113_005_L)
					If ($photoindx_L>0)
						OBJECT SET TITLE:C194(*; "ApproachDescr"; v_113_003_atxt{$photoindx_L})
					End if 
					$photoindx_L:=Find in array:C230(v_113_001_aL; v_113_001_L)
					If ($photoindx_L>0)
						OBJECT SET TITLE:C194(*; "ElevationDescr"; v_113_003_atxt{$photoindx_L})
					End if 
					
				End if 
			Else 
				ALERT:C41("Error : Expected to find Inventory Photo inspections, but did not find any!")
			End if 
			
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Unload:K2:2)
		
		OB SET:C1220(SelectInvPhotoData_o; "ApprPhotoID"; v_113_005_L)
		OB SET:C1220(SelectInvPhotoData_o; "ElevPhotoID"; v_113_001_L)
		CLEAR VARIABLE:C89(v_113_003_atxt)
		CLEAR VARIABLE:C89(INVPHOTOINSPAPPR_AP)
		CLEAR VARIABLE:C89(v_113_001_aL)
		CLEAR VARIABLE:C89(v_113_005_L)
		CLEAR VARIABLE:C89(v_113_001_L)
		
End case 

//End SelectInvPhoto