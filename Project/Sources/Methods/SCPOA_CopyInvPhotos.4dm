//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/27/09, 09:02:35
	// ----------------------------------------------------
	// Method: SCPOA_CopyInvPhotos
	// Description
	// Copy inventory photos if any to the scour plan of action.
	// 
	// Parameters
	// $1 : $Batch_mode_b (Optional) Default = false
	// ----------------------------------------------------
	
	Mods_2009_05
	Mods_2009_06  //r002 `06/12/09, 15:55:52   `Merge in changes made by Costas
	// Modified by: costasmanousakis-(Designer)-(12/10/09 09:28:05)
	Mods_2009_12
	//Changes/Additions for new version of POA
	// Modified by: Costas Manousakis-(Designer)-(3/23/12 16:21:48)
	Mods_2012_03
	//  `FV Photo changes : can add more than 4 photos
	
End if 
C_BOOLEAN:C305($Batch_mode_b)
$Batch_mode_b:=False:C215
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	$Batch_mode_b:=$1
End if 

C_BOOLEAN:C305($OneRel_b; $ManyRel_b; $InvRO_b; $invPhoRO_b)
GET AUTOMATIC RELATIONS:C899($OneRel_b; $ManyRel_b)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
$InvRO_b:=Read only state:C362([InventoryPhotoInsp:112])
$invPhoRO_b:=Read only state:C362([InventoryPhotos:113])
READ ONLY:C145([InventoryPhotoInsp:112])
READ ONLY:C145([InventoryPhotos:113])
QUERY:C277([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]BIN:2=[ScourPOA:132]BIN:2)
ORDER BY:C49([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]InvPhotoDate_D:3; <)
If (Records in selection:C76([InventoryPhotoInsp:112])>0)
	//get photos if any of current Scour POA
	QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
	QUERY SELECTION:C341([ScourPOA_Images:134]; [ScourPOA_Images:134]ImageType:5="PHOTO")
	ARRAY LONGINT:C221($InvSeq_aL; Records in selection:C76([ScourPOA_Images:134]))
	ARRAY LONGINT:C221($fvSeq_aL; Records in selection:C76([ScourPOA_Images:134]))
	ARRAY LONGINT:C221($scourImgRec_aL; Records in selection:C76([ScourPOA_Images:134]))
	ARRAY TEXT:C222($CurrPhotoDesc_atxt; $CurrentNumPhotos_L)
	SELECTION TO ARRAY:C260([ScourPOA_Images:134]; $scourImgRec_aL; [ScourPOA_Images:134]ImageSeq:6; $InvSeq_aL; [ScourPOA_Images:134]OnPage1:7; $fvSeq_aL; [ScourPOA_Images:134]ImgDescr_txt:4; $CurrPhotoDesc_atxt)
	
	C_LONGINT:C283($CurrentNumPhotos_L; $CurrNumFVPhotos_L)
	$CurrNumFVPhotos_L:=0
	$CurrentNumPhotos_L:=0
	SORT ARRAY:C229($InvSeq_aL; <)
	SORT ARRAY:C229($fvSeq_aL; <)
	
	If (Records in selection:C76([ScourPOA_Images:134])>0)
		$CurrentNumPhotos_L:=$InvSeq_aL{1}
		$CurrNumFVPhotos_L:=$fvSeq_aL{1}
	End if 
	
	FIRST RECORD:C50([InventoryPhotoInsp:112])
	QUERY:C277([InventoryPhotos:113]; [InventoryPhotos:113]InvPhotoInsp_ID:2=[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
	ORDER BY:C49([InventoryPhotos:113]; [InventoryPhotos:113]Sequence_I:5; >; [InventoryPhotos:113]PhotoDescr_txt:3; >)
	FIRST RECORD:C50([InventoryPhotos:113])
	C_LONGINT:C283($photosCopied_L; $ExistDescFound_L; $photosUpdated_L)
	C_BOOLEAN:C305($PhotoToBeCopied_B; $CreateNew_b; $UpdateExist_b)
	$photosCopied_L:=0
	$photosUpdated_L:=0
	If (Not:C34($Batch_mode_b))
		//ALERT("Current list of photos will be updated from inventory photos based on description"+", or new ones will be inserted if they don't exist up to a total of 4 photos!")
		ALERT:C41("Current list of photos will be updated from inventory photos based on description"+", or new ones will be inserted if they don't exist !")
		
	End if 
	
	While (Not:C34(End selection:C36([InventoryPhotos:113])))
		$PhotoToBeCopied_B:=(([InventoryPhotos:113]PhotoDescr_txt:3="@ELEVATION") | ([InventoryPhotos:113]PhotoDescr_txt:3="LOOKING UPSTREAM") | ([InventoryPhotos:113]PhotoDescr_txt:3="LOOKING DOWNSTREAM"))
		
		If ($PhotoToBeCopied_B)
			//Descr Exists?
			$ExistDescFound_L:=Find in array:C230($CurrPhotoDesc_atxt; [InventoryPhotos:113]PhotoDescr_txt:3)
			$CreateNew_b:=False:C215
			$UpdateExist_b:=False:C215
			Case of 
				: ($ExistDescFound_L>0)
					If ($Batch_mode_b)
					Else 
						CONFIRM:C162("There is an existing Photo "+[InventoryPhotos:113]PhotoDescr_txt:3; "Replace"; "Skip")
						$UpdateExist_b:=(OK=1)
					End if 
					
					//: ($CurrentNumPhotos_L>=4)
					//  `we don't do anything
					//If (Not($Batch_mode_b))
					//ALERT("Photo limit of 4 has been reached! Inventory photo "+[InventoryPhotos]PhotoDescr_txt+" will not be copied to this Plan of Action!")
					//End if 
				Else 
					$CreateNew_b:=True:C214
					
			End case 
			
			Case of 
				: ($UpdateExist_b)
					GOTO RECORD:C242([ScourPOA_Images:134]; $scourImgRec_aL{$ExistDescFound_L})
					If (ut_LoadRecordInteractive(->[ScourPOA_Images:134]))
						[ScourPOA_Images:134]Image_x:3:=[InventoryPhotos:113]InvPhoto_X:4
						If (SCPOA_LogChanges_b)
							InitChangeStack(2)
							PushChange(2; ->[ScourPOA_Images:134]Image_x:3)
							FlushGrpChgs(2; ->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2)
						End if 
						SAVE RECORD:C53([ScourPOA_Images:134])
						$photosUpdated_L:=$photosUpdated_L+1
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2  //make validate event go
					End if 
					
				: ($CreateNew_b)
					CREATE RECORD:C68([ScourPOA_Images:134])
					[ScourPOA_Images:134]ScourPOAID:2:=[ScourPOA:132]ScourPOAID:1
					Inc_Sequence("ScourPOA_Images"; ->[ScourPOA_Images:134]ScourPOAImgID:1)
					[ScourPOA_Images:134]ImgDescr_txt:4:=[InventoryPhotos:113]PhotoDescr_txt:3
					[ScourPOA_Images:134]ImageType:5:="Photo"
					$photosCopied_L:=$photosCopied_L+1
					[ScourPOA_Images:134]ImageSeq:6:=$CurrentNumPhotos_L+$photosCopied_L
					[ScourPOA_Images:134]OnPage1:7:=$CurrNumFVPhotos_L+$photosCopied_L
					[ScourPOA_Images:134]Image_x:3:=[InventoryPhotos:113]InvPhoto_X:4
					SAVE RECORD:C53([ScourPOA_Images:134])
					If (SCPOA_LogChanges_b)
						InitChangeStack(2)
						PushChange(2; ->[ScourPOA_Images:134]ImageType:5)
						PushChange(2; ->[ScourPOA_Images:134]Image_x:3)
						PushChange(2; ->[ScourPOA_Images:134]ImgDescr_txt:4)
						PushChange(2; ->[ScourPOA_Images:134]ImageSeq:6)
						PushChange(2; ->[ScourPOA_Images:134]OnPage1:7)
						LogNewRecord(->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2; "ScourPOA_Images")
						FlushGrpChgs(2; ->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2)
					End if 
					[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2  //make validate event go
					
			End case 
			
		End if 
		NEXT RECORD:C51([InventoryPhotos:113])
	End while 
	If (Not:C34($Batch_mode_b))
		ALERT:C41("Copied "+String:C10($photosCopied_L)+" inventory photos, Updated "+String:C10($photosUpdated_L)+" photos")
		//now update lists since we are running on input form
		C_LONGINT:C283($NewNumPhotos_L; $Loop_L; $FindinPrev_L; $NumCurrPhotos)
		$NumCurrPhotos:=Size of array:C274(SCPOA_PhotoIDs_aL)
		QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
		QUERY SELECTION:C341([ScourPOA_Images:134]; [ScourPOA_Images:134]ImageType:5="Photo")
		$NewNumPhotos_L:=Records in selection:C76([ScourPOA_Images:134])
		
		ARRAY LONGINT:C221($NewIds_aL; $NewNumPhotos_L)
		ARRAY LONGINT:C221($NewRecs_aL; $NewNumPhotos_L)
		ARRAY LONGINT:C221($NewSeqs_aL; $NewNumPhotos_L)
		ARRAY LONGINT:C221($NewFVSeqs_aL; $NewNumPhotos_L)
		ARRAY TEXT:C222($NewDesc_atxt; $NewNumPhotos_L)
		SELECTION TO ARRAY:C260([ScourPOA_Images:134]; $NewRecs_aL; [ScourPOA_Images:134]ScourPOAImgID:1; $NewIds_aL; [ScourPOA_Images:134]ImgDescr_txt:4; $NewDesc_atxt; [ScourPOA_Images:134]ImageSeq:6; $NewSeqs_aL; [ScourPOA_Images:134]OnPage1:7; $NewFVSeqs_aL)
		For ($Loop_L; 1; $NewNumPhotos_L)
			$FindinPrev_L:=Find in array:C230(SCPOA_PhotoIDs_aL; $NewIds_aL{$Loop_L})
			If ($FindinPrev_L<=0)
				//This is a new one...
				$NumCurrPhotos:=$NumCurrPhotos+1
				APPEND TO ARRAY:C911(SCPOA_PhotoDesc_atxt; $NewDesc_atxt{$Loop_L})
				APPEND TO ARRAY:C911(SCPOA_PhotoIDs_aL; $NewIds_aL{$Loop_L})
				APPEND TO ARRAY:C911(SCPOA_PhotoSeq_aL; $NewSeqs_aL{$Loop_L})
				If ($NewFVSeqs_aL{$Loop_L}=0)
					$NewFVSeqs_aL{$Loop_L}:=SCPOA_MaxFVPhotoIndx_L
				End if 
				APPEND TO ARRAY:C911(SCPOA_FVPhotoSeq_aL; $NewFVSeqs_aL{$Loop_L})
				APPEND TO ARRAY:C911(SCPOA_PhotoRecs_aL; $NewRecs_aL{$Loop_L})
			End if 
			
		End for 
		ARRAY LONGINT:C221($NewIds_aL; 0)
		ARRAY LONGINT:C221($NewRecs_aL; 0)
		ARRAY LONGINT:C221($NewSeqs_aL; 0)
		ARRAY TEXT:C222($NewDesc_atxt; 0)
		ARRAY LONGINT:C221($NewFVSeqs_aL; 0)
		If (SCPOA_IMAGETYPELIST_L=1)
			SORT ARRAY:C229(SCPOA_PhotoSeq_aL; SCPOA_PhotoRecs_aL; SCPOA_PhotoIDs_aL; SCPOA_PhotoDesc_atxt; SCPOA_FVPhotoSeq_aL)
		Else 
			MULTI SORT ARRAY:C718(SCPOA_FVPhotoSeq_aL; >; SCPOA_PhotoSeq_aL; >; SCPOA_PhotoRecs_aL; SCPOA_PhotoIDs_aL; SCPOA_PhotoDesc_atxt)
		End if 
		//To keep the current order
		CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
		
	End if 
	
Else 
	If (Not:C34($Batch_mode_b))
		ALERT:C41("There are no Inventory Photo inspections on record for BIN "+[ScourPOA:132]BIN:2)
	End if 
	
End if 

If (Not:C34($InvRO_b))
	READ WRITE:C146([InventoryPhotoInsp:112])
End if 
If (Not:C34($invPhoRO_b))
	READ WRITE:C146([InventoryPhotos:113])
End if 
SET AUTOMATIC RELATIONS:C310($OneRel_b; $ManyRel_b)