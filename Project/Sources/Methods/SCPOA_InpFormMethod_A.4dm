//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/27/12, 21:04:46
// ----------------------------------------------------
//Method: SCPOA_InpFormMethod_A
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : copied from SCPOA_InpFormMethod
	Mods_2012_02
	//excluded call to SCPOA_Variables ("SETVERSION")
	// Modified by: Costas Manousakis-(Designer)-(3/16/12 10:01:49)
	Mods_2012_03
	//  `added CALL PROCESS(SCPOA_EvalTextProcess_L) to close  any window opened
	// Modified by: Costas Manousakis-(Designer)-(3/23/12 14:44:00)
	Mods_2012_03
	//  `FV Photo changes : can add more than 4 photos
	//  `removed on load event from photo listbox
	//  `removed calls to Object methods not in use in this form
	// Modified by: Costas Manousakis-(Designer)-(4/19/12 16:19:56)
	Mods_2012_04
	//  `increased the SCPOA_Approve@ wildcard to avoid "grabbing" other variables
	// Modified by: Costas Manousakis-(Designer)-(10/23/14 11:52:37)
	Mods_2014_10
	//  `General POA modifications Oct 2014
	// Modified by: Costas Manousakis-(Designer)-(2/23/15 14:53:33)
	Mods_2015_02
	//  `added  datemodified to the changes in on validate. this is to track for any auto fill
	//  ` which should not be done continually
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
//

C_LONGINT:C283($FormEvent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 
Case of 
	: ($FormEvent=On Load:K2:1)
		InDoubleClick_B:=False:C215
		ut_getFormVariables(Current method name:C684)
		If ([Bridge MHD NBIS:1]BIN:3#[ScourPOA:132]BIN:2)
			C_BOOLEAN:C305($Autoone; $AutoMany)
			GET AUTOMATIC RELATIONS:C899($Autoone; $AutoMany)
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[ScourPOA:132]BIN:2)
			SET AUTOMATIC RELATIONS:C310($Autoone; $AutoMany)
		End if 
		
		ut_UnloadRecord(->[Bridge MHD NBIS:1])
		InitChangeStack(1)
		SCPOA_Variables("INIT")
		SCPOA_Variables("CLEAR")
		SCPOA_InputHelpSetup("INIT")
		C_BOOLEAN:C305($ContinueLoad_b)
		$ContinueLoad_b:=True:C214
		If (Is new record:C668([ScourPOA:132]))
			//Must have a current BIN record
			If ([Bridge MHD NBIS:1]BIN:3="")
				$ContinueLoad_b:=False:C215
			Else 
				Inc_Sequence("ScourPOA"; ->[ScourPOA:132]ScourPOAID:1)
				[ScourPOA:132]BIN:2:=[Bridge MHD NBIS:1]BIN:3
			End if 
			
		End if 
		C_LONGINT:C283(SCPOA_INPUTMODE_L)
		
		C_LONGINT:C283($lockProc_L)
		C_TEXT:C284($Lock4dUser_txt; $LockSessUsr_txt; $LockProcNm_txt)
		LOCKED BY:C353([ScourPOA:132]; $lockProc_L; $Lock4dUser_txt; $LockSessUsr_txt; $LockProcNm_txt)
		If ($lockProc_L=-1)
			//Record has been deleted!
			ALERT:C41("Record has been deleted!")
			$ContinueLoad_b:=False:C215
		End if 
		
		If ($ContinueLoad_b)
			SCPOA_Variables("LOAD")
			C_BOOLEAN:C305(SCPOA_EditRecord_b)
			SCPOA_EditRecord_b:=(Not:C34(Locked:C147([ScourPOA:132])) & (SCPOA_INPUTMODE_L=1))
			If (SCPOA_EditRecord_b)
				//edit mode
				SCPOA_SetEnterable_Name("SCPOA_@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "SCPOA_@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				
				OBJECT SET VISIBLE:C603(*; "SCPOA_PMLockButton_L@"; False:C215)
				
				If (GRP_UserInGroup("SCPOA_ProjManager")=1)
					SCPOA_SetEnterable_Name("SCPOA_PM@"; True:C214)
					OBJECT SET ENABLED:C1123(*; "SCPOA_PM@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				Else 
					SCPOA_SetEnterable_Name("SCPOA_PM@"; False:C215)
					OBJECT SET ENABLED:C1123(*; "SCPOA_PM@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				End if 
				If (GRP_UserInGroup("SCPOA_ApproveEngnr")=1)
					SCPOA_SetEnterable_Name("SCPOA_Approve@"; True:C214)
					OBJECT SET ENABLED:C1123(*; "SCPOA_Approve@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				Else 
					SCPOA_SetEnterable_Name("SCPOA_Approve@"; False:C215)
					OBJECT SET ENABLED:C1123(*; "SCPOA_Approve@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				End if 
				//added checks to make sure monitoring and struc counters are checked
				SCPOA_Variables("VERIFYRECACTIONS")
				
			Else 
				//view mode
				ut_UnloadRecord(->[ScourPOA:132])
				SCPOA_SetEnterable_Name("SCPOA_@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "SCPOA_@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET VISIBLE:C603(*; "@Delete@"; False:C215)
				If (GRP_UserInGroup("SCPOA_ProjManager")=1)
					OBJECT SET VISIBLE:C603(*; "SCPOA_PMLockButton_L@"; True:C214)
					OBJECT SET ENABLED:C1123(*; "SCPOA_PMLockButton_L@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					SCPOA_PMLockButton_L:=0
				Else 
					OBJECT SET VISIBLE:C603(*; "SCPOA_PMLockButton_L@"; False:C215)
				End if 
				
			End if 
			SCPOA_Footing_OM($FormEvent)
			SCPOA_FootingMatl_OM($FormEvent)
			SCPOA_OthMonInstrOth_OM($FormEvent)
			//SCPOA_MonitSampl_OM ($FormEvent)
			//SCPOA_DataLogFreq_OM ($FormEvent)
			//SCPOA_OthMonInstrType_OM ($FormEvent)
			//SCPOA_OthFldMonFreq_OM ($FormEvent)
			SCPOA_PhotoListBox_OM($FormEvent)
			SCPOA_AbutElvRef_OM($FormEvent)
			SCPOA_PierElvRef_OM($FormEvent)
			C_POINTER:C301($Dummy_ptr)
			$Dummy_ptr:=->$Dummy_ptr
			SCPOA_2CSamplCkBx_OM($Dummy_ptr; $FormEvent)
			SCPOA_2CFreqCkBx_OM($Dummy_ptr; $FormEvent)
			SCPOA_EvtSamplCkBx_OM($Dummy_ptr; $FormEvent)
			SCPOA_EvtFreqCkBx_OM($Dummy_ptr; $FormEvent)
			SCPOA_2dFreqCkBx_OM($Dummy_ptr; $FormEvent)
			SCPOA_ImageHandle("Locus"; $FormEvent)
			SCPOA_ImageHandle("Detour"; $FormEvent)
			C_TEXT:C284($curruser_txt)
			$curruser_txt:=<>CurrentUser_Name
			If (User in group:C338($curruser_txt; "SCOURPOAINIT") | User in group:C338($curruser_txt; "Design Access Group"))
				OBJECT SET VISIBLE:C603(*; "SCPOA_Consultant_@"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "SCPOA_Consultant_@"; False:C215)
			End if 
			POPUPMENUC(->SCPOA_Consultant_atxt; ->SCPOA_Consultant_atxt; ->[ScourPOA:132]Consultant:26)
			
			If (SCPOA_ScCritDisch_txt="")
				If (SCPOA_ScCritDisch_R>0)
					SCPOA_ScCritDisch_txt:=String:C10(SCPOA_ScCritDisch_R)
					If (SCPOA_EditRecord_b)
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
					End if 
				End if 
			End if 
			If (SCPOA_OthScCritElev_txt="")
				If (SCPOA_OthScCritElev_R>0)
					SCPOA_OthScCritElev_txt:=String:C10(SCPOA_OthScCritElev_R)
					If (SCPOA_EditRecord_b)
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
					End if 
				End if 
			End if 
			If (SCPOA_DischOvrFeet_txt="")
				If (SCPOA_DischOvrFeet_L>0)
					SCPOA_DischOvrFeet_txt:=String:C10(SCPOA_DischOvrFeet_L)
					If (SCPOA_EditRecord_b)
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
					End if 
				End if 
			End if 
			If (SCPOA_BrgCloStreamElNo_txt="")
				If (SCPOA_BrgCloStreamElNo_L>0)
					SCPOA_BrgCloStreamElNo_txt:=String:C10(SCPOA_BrgCloStreamElNo_L)+" Ft"
					If (SCPOA_EditRecord_b)
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
					End if 
				End if 
			End if 
			If (SCPOA_BrgCloStreamElAbNo_txt="")
				If (SCPOA_BrgCloStreamElAbNo_L>0)
					SCPOA_BrgCloStreamElAbNo_txt:=String:C10(SCPOA_BrgCloStreamElAbNo_L)+" Ft"
					If (SCPOA_EditRecord_b)
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
					End if 
				End if 
			End if 
			
			QUERY:C277([ScourPOA_DetourBridge:133]; [ScourPOA_DetourBridge:133]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
			SCPOA_Variables("DETOURBRIDGES")
			
			FORM GOTO PAGE:C247(SCPOA_SectionPage_aL{1})
			//SCPOA_UpdateDetourAvgs 
		Else 
			CANCEL:C270
		End if 
		
	: ($FormEvent=On Unload:K2:2)
		If (SCPOA_EvalTextProcess_L>0)
			POST OUTSIDE CALL:C329(SCPOA_EvalTextProcess_L)  //to close  any window opened 
		End if 
		SCPOA_Variables("CLEAR")
		SCPOA_Variables("CLEARDETOURBRIDGES")
		SCPOA_InputHelpSetup("RESET")
		
	: ($FormEvent=On Data Change:K2:15)
		[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
		
	: ($FormEvent=On Validate:K2:3)
		SCPOA_Variables("SAVE")
		//'Renumber photos if needed
		C_LONGINT:C283($loop_L)
		READ WRITE:C146([ScourPOA_Images:134])
		SORT ARRAY:C229(SCPOA_PhotoSeq_aL; SCPOA_PhotoRecs_aL; SCPOA_FVPhotoSeq_aL)
		For ($loop_L; 1; Size of array:C274(SCPOA_PhotoRecs_aL))
			GOTO RECORD:C242([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL{$loop_L})
			LOAD RECORD:C52([ScourPOA_Images:134])
			If ([ScourPOA_Images:134]ImageSeq:6#$loop_L)
				[ScourPOA_Images:134]ImageSeq:6:=$loop_L
				If (SCPOA_LogChanges_b)
					LogChanges(->[ScourPOA_Images:134]ImageSeq:6; ->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2)
				End if 
				SAVE RECORD:C53([ScourPOA_Images:134])
				UNLOAD RECORD:C212([ScourPOA_Images:134])
			End if 
			
		End for 
		MULTI SORT ARRAY:C718(SCPOA_FVPhotoSeq_aL; >; SCPOA_PhotoSeq_aL; >; SCPOA_PhotoRecs_aL)
		For ($loop_L; 1; Size of array:C274(SCPOA_PhotoRecs_aL))
			GOTO RECORD:C242([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL{$loop_L})
			LOAD RECORD:C52([ScourPOA_Images:134])
			If ([ScourPOA_Images:134]OnPage1:7#$loop_L)
				If (ut_LoadRecordInteractive(->[ScourPOA_Images:134]))
					[ScourPOA_Images:134]OnPage1:7:=$loop_L
					If (SCPOA_LogChanges_b)
						LogChanges(->[ScourPOA_Images:134]OnPage1:7; ->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2)
					End if 
					SAVE RECORD:C53([ScourPOA_Images:134])
					UNLOAD RECORD:C212([ScourPOA_Images:134])
				End if 
				
			End if 
			
		End for 
		
		If (SCPOA_LogChanges_b)
			[ScourPOA:132]DateModified:4:=Current date:C33(*)
			PushChange(1; ->[ScourPOA:132]DateModified:4)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[ScourPOA:132]BIN:2; ->[ScourPOA:132]ScourPOAID:1; 1)
		End if 
		
	: ($FormEvent=On Close Detail:K2:24)
		C_LONGINT:C283($CurrPage_L)
		$CurrPage_L:=SectionSCPOASelect_atxt
		Case of 
			: (SectionSCPOASelect_atxt{$CurrPage_L}="@Photo@")
				QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
				QUERY SELECTION:C341([ScourPOA_Images:134]; [ScourPOA_Images:134]ImageType:5="Photo")
				ORDER BY:C49([ScourPOA_Images:134]; [ScourPOA_Images:134]ImgDescr_txt:4)
			: (SectionSCPOASelect_atxt{$CurrPage_L}="@Detour@")
				QUERY:C277([ScourPOA_DetourBridge:133]; [ScourPOA_DetourBridge:133]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
				SCPOA_Variables("DETOURBRIDGES")
		End case 
		
End case 
//End SCPOA_InpFormMethod_A