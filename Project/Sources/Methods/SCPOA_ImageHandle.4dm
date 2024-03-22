//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/18/09, 15:45:10
	// ----------------------------------------------------
	// Method: SCPOA_ImageHandle
	// Description
	// 
	// 
	// Parameters
	// $1 : $ImageType_txt : "DETOUR"  | "LOCUS"
	// $2 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2009_05
End if 

C_TEXT:C284($1; $ImageType_txt)
$ImageType_txt:=$1
C_LONGINT:C283($2; $FormEvent_L)
$FormEvent_L:=$2
Case of 
	: ($FormEvent_L=On Load:K2:1)
		C_LONGINT:C283($ImageTypeExist_L)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $ImageTypeExist_L)
		QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1; *)
		QUERY:C277([ScourPOA_Images:134];  & ; [ScourPOA_Images:134]ImageType:5=$ImageType_txt)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		C_BOOLEAN:C305(SCPOA_EditRecord_b)
		If ($ImageTypeExist_L=0)
			If (SCPOA_EditRecord_b)
				OBJECT SET TITLE:C194(*; "SCPOA_"+$ImageType_txt+"Btn"; "Attach "+$ImageType_txt)
				OBJECT SET ENABLED:C1123(*; "SCPOA_"+$ImageType_txt+"Btn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				OBJECT SET TITLE:C194(*; "SCPOA_"+$ImageType_txt+"Btn"; "No "+$ImageType_txt)
				OBJECT SET ENABLED:C1123(*; "SCPOA_"+$ImageType_txt+"Btn"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			End if 
		Else 
			OBJECT SET TITLE:C194(*; "SCPOA_"+$ImageType_txt+"Btn"; "View "+$ImageType_txt)
			OBJECT SET ENABLED:C1123(*; "SCPOA_"+$ImageType_txt+"Btn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
	: ($FormEvent_L=On Clicked:K2:4)
		QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
		QUERY SELECTION:C341([ScourPOA_Images:134]; [ScourPOA_Images:134]ImageType:5=$ImageType_txt)
		FORM SET INPUT:C55([ScourPOA_Images:134]; "Input")
		
		Case of 
			: (Records in selection:C76([ScourPOA_Images:134])=1)
				FIRST RECORD:C50([ScourPOA_Images:134])
				C_LONGINT:C283($loadChoise_L)
				$loadChoise_L:=ut_LoadRecordInteractiveV2(->[ScourPOA_Images:134])
				Case of 
					: ($loadChoise_L=0)
					: ($loadChoise_L=1)
						MODIFY RECORD:C57([ScourPOA_Images:134])
					: ($loadChoise_L=2)
						DIALOG:C40([ScourPOA_Images:134]; "input")
				End case 
				SCPOA_ImageHandle($ImageType_txt; On Load:K2:1)
				
			: (Records in selection:C76([ScourPOA_Images:134])=0)
				C_TEXT:C284(SCPOA_NewImageType_txt)
				SCPOA_NewImageType_txt:=$ImageType_txt
				ADD RECORD:C56([ScourPOA_Images:134])
				SCPOA_ImageHandle($ImageType_txt; On Load:K2:1)
				SCPOA_NewImageType_txt:=""
				
			: (Records in selection:C76([ScourPOA_Images:134])>1)
				
		End case 
		If (Is record loaded:C669([ScourPOA_Images:134]))
			UNLOAD RECORD:C212([ScourPOA_Images:134])
		End if 
		
End case 