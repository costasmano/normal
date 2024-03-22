//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/11/09, 16:12:45
	// ----------------------------------------------------
	// Method: SCPOA_ImageInput_FM
	// Description
	// Form method for the Input form
	// 
	// Parameters
	// $1 : $FormEvent (Optional)
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(4/24/10 12:04:42)
	Mods_2010_04
	//  `set the sequence when new photo
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
Case of 
	: ($FormEvent_L=On Load:K2:1)
		
		C_PICTURE:C286(SCPOA_Image)
		InitChangeStack(2)
		
		If (Is new record:C668([ScourPOA_Images:134]))
			C_TEXT:C284(SCPOA_NewImageType_txt)
			[ScourPOA_Images:134]ScourPOAID:2:=[ScourPOA:132]ScourPOAID:1
			Inc_Sequence("ScourPOA_Images"; ->[ScourPOA_Images:134]ScourPOAImgID:1)
			If (SCPOA_NewImageType_txt#"")
				[ScourPOA_Images:134]ImageType:5:=SCPOA_NewImageType_txt
			Else 
				[ScourPOA_Images:134]ImageType:5:="Photo"
				C_LONGINT:C283($nextSeq_L)
				C_LONGINT:C283($loop_L)
				$nextSeq_L:=0
				For ($loop_L; 1; Size of array:C274(SCPOA_PhotoSeq_aL))
					If (SCPOA_PhotoSeq_aL{$loop_L}>$nextSeq_L)
						$nextSeq_L:=SCPOA_PhotoSeq_aL{$loop_L}
					End if 
				End for 
				$nextSeq_L:=$nextSeq_L+1
				[ScourPOA_Images:134]ImageSeq:6:=$nextSeq_L
				PushChange(2; ->[ScourPOA_Images:134]ImageSeq:6)
			End if 
			PushChange(2; ->[ScourPOA_Images:134]ImageType:5)
		End if 
		SCPOA_ImgHelpSetup("INIT")
		OBJECT SET VISIBLE:C603(SCPOADelImage; False:C215)
		C_BOOLEAN:C305(SCPOA_EditRecord_b)
		Case of 
			: ([ScourPOA_Images:134]ImageType:5="Photo")
			: ([ScourPOA_Images:134]ImageType:5="Locus")
				OBJECT SET VISIBLE:C603(*; "@ImgDescr@"; False:C215)
			: ([ScourPOA_Images:134]ImageType:5="Detour")
				OBJECT SET VISIBLE:C603(*; "@ImgDescr@"; False:C215)
				
		End case 
		//TRACE
		C_BOOLEAN:C305($LockedRec_b)
		$LockedRec_b:=Locked:C147([ScourPOA_Images:134])
		
		If ((SCPOA_EditRecord_b) & Not:C34($LockedRec_b))
			INV_LockUnLockCurrRec(False:C215; Current form table:C627)
			OBJECT SET VISIBLE:C603(SCPOADelImage; True:C214)
		Else 
			INV_LockUnLockCurrRec(True:C214; Current form table:C627)
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		If (SCPOA_LogChanges_b)
			If (Is new record:C668([ScourPOA_Images:134]))
				LogNewRecord(->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2; "ScourPOA_Images")
			End if 
			FlushGrpChgs(2; ->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2)
			
		End if 
		
	: ($FormEvent_L=On Unload:K2:2)
		SCPOA_Image:=SCPOA_Image*0
		SCPOA_ImgHelpSetup("RESET")
		
End case 