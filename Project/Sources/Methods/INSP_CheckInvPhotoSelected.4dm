//%attributes = {"invisible":true}
//Method: INSP_CheckInvPhotoSelected
//Description
// check if the two inventory photos have been selected and if they exist.
// returns description of what is missing if anything
// Parameters
// $0 : $InvPhotoOK_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/29/18, 11:58:15
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
	
	C_TEXT:C284(INSP_CheckInvPhotoSelected; $0)
	
End if 
//
C_TEXT:C284($0; $InvPhotoOK_txt)
$InvPhotoOK_txt:=""
C_LONGINT:C283($ApprIdFound_L; $ElevIdFound_L; $ApprPhotoID_L; $ElevPhotoID_L)
ARRAY TEXT:C222($InvPhotoOK_atxt; 0)

//also both must be from same inv photo inspection
If (($ElevPhotoID_L>0) | ($ApprPhotoID_L>0))
	ARRAY LONGINT:C221($InvInspIDs_aL; 0)
	ARRAY LONGINT:C221($InvPhotoIDs_aL; 0)
	ARRAY TEXT:C222($invBins_atxt; 0)
	Begin SQL
		select 
		[InventoryPhotos].[InvPhoto_ID]
		,[InventoryPhotos].[InvPhotoInsp_ID]
		,[InventoryPhotoInsp].[BIN]
		from [InventoryPhotos], InventoryPhotoInsp]
		where 
		[InventoryPhotoInsp].[InvPhotoInsp_ID]= [InventoryPhotos].[InvPhotoInsp_ID]
		and (
		[InventoryPhotos].[InvPhoto_ID] = :$ElevPhotoID_L
		or
		[InventoryPhotos].[InvPhoto_ID] = :$ApprPhotoID_L
		)
		into :$InvPhotoIDs_aL, :$InvInspIDs_aL , :$invBins_atxt;
		
	End SQL
	
	If ($ApprPhotoID_L>0)
		
		$ApprIdFound_L:=Find in array:C230($InvPhotoIDs_aL; $ApprPhotoID_L)
		If ($ApprIdFound_L>0)
			//check if BIN of appr photo is the current BIN
			If ($invBins_atxt{$ApprIdFound_L}#[Inspections:27]BIN:1)
				APPEND TO ARRAY:C911($InvPhotoOK_atxt; "Selected Inventory Photo for Approach is for BIN "+$invBins_atxt{$ApprIdFound_L}+", NOT for the current BIN "+[Inspections:27]BIN:1+" !")
			End if 
		Else 
			APPEND TO ARRAY:C911($InvPhotoOK_atxt; "Selected Inventory Photo for Approach does not exist!")
		End if 
	Else 
		APPEND TO ARRAY:C911($InvPhotoOK_atxt; "Inventory Photo for Approach has not been selected!")
		
	End if 
	
	If ($ElevPhotoID_L>0)
		
		$ElevIdFound_L:=Find in array:C230($InvPhotoIDs_aL; $ElevPhotoID_L)
		If ($ElevIdFound_L>0)
			If ($invBins_atxt{$ElevIdFound_L}#[Inspections:27]BIN:1)
				APPEND TO ARRAY:C911($InvPhotoOK_atxt; "Selected Inventory Photo for Elevation is for BIN "+$invBins_atxt{$ApprIdFound_L}+", NOT for the current BIN "+[Inspections:27]BIN:1+" !")
			End if 
		Else 
			APPEND TO ARRAY:C911($InvPhotoOK_atxt; "Selected Inventory Photo for Approach does not exist!")
		End if 
		
	Else 
		APPEND TO ARRAY:C911($InvPhotoOK_atxt; "Inventory Photo for Elevation has not been selected!")
		
	End if 
	
	If (Size of array:C274($InvInspIDs_aL)=2)
		If ($InvInspIDs_aL{1}#$InvInspIDs_aL{2})
			APPEND TO ARRAY:C911($InvPhotoOK_atxt; "The two inventory photos selected are not from the same Inventory photo ispection!")
			
		End if 
		
	End if 
	
	If (Size of array:C274($InvPhotoOK_atxt)>0)
		$InvPhotoOK_txt:=ut_ArrayToText(->$InvPhotoOK_atxt; "\n")
		
	End if 
	
Else 
	
	$InvPhotoOK_txt:="Inventory Photos for this report have not been selected!"
	
End if 

$0:=$InvPhotoOK_txt
//End INSP_CheckInvPhotoSelected