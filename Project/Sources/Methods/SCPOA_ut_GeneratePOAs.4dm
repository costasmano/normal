//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/08/09, 11:02:10
	// ----------------------------------------------------
	// Method: SCPOA_ut_GeneratePOAs
	// Description
	// Utility to generate POA records and attach necessary information from
	// Inventory photos, and scour comments in inspection reports
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_06
	Mods_2009_06  //r002 `06/12/09, 15:54:07   `Merge in changes made by Costas
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

READ ONLY:C145(*)
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item113:151="0"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item113:151="1"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item113:151="2"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item113:151="3"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item113:151="6"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item113:151="U"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item113:151="D")
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
C_LONGINT:C283($NBIRecs_L; $BlobOffset_l; $NewNumPhotos_L)
C_BOOLEAN:C305($oneRel_b; $manyRel_b)
C_BLOB:C604($Report_Blb)
C_TEXT:C284($Tab_txt; $Eol_txt)
$Tab_txt:=Char:C90(Tab:K15:37)
$Eol_txt:=Char:C90(Carriage return:K15:38)
$BlobOffset_l:=0
$NBIRecs_L:=Records in selection:C76([Bridge MHD NBIS:1])
C_LONGINT:C283($ConfirmChoise_L)
C_BOOLEAN:C305($Generate_b)
$Generate_b:=False:C215
$ConfirmChoise_L:=ut_3Option_Confirm("Initialize Scour Plan of Action for "+String:C10($NBIRecs_L)+" Bridge Records?"; "OK"; "Cancel"; "QuerySelection")
Case of 
	: ($ConfirmChoise_L=1)
		$Generate_b:=True:C214
	: ($ConfirmChoise_L=3)
		QUERY SELECTION:C341([Bridge MHD NBIS:1])
		If (OK=1)
			$NBIRecs_L:=Records in selection:C76([Bridge MHD NBIS:1])
			If ($NBIRecs_L>0)
				CONFIRM:C162("Initialize Scour Plan of Action for "+String:C10($NBIRecs_L)+" Bridge Records?")
				If (OK=1)
					$Generate_b:=True:C214
				End if 
			Else 
				ALERT:C41("No Bridge records found matching criteria!")
			End if 
			
		End if 
		
End case 

If ($Generate_b)
	ARRAY TEXT:C222($BINsToBe_atxt; $NBIRecs_L)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $BINsToBe_atxt)
	GET AUTOMATIC RELATIONS:C899($oneRel_b; $manyRel_b)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	SCPOA_Variables("SETUP")
	C_LONGINT:C283($BinLoop_L)
	NewWindow(300; 200; 0; Plain window:K34:13)
	For ($BinLoop_L; 1; $NBIRecs_L)
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BINsToBe_atxt{$BinLoop_L})
		QUERY:C277([ScourPOA:132]; [ScourPOA:132]BIN:2=[Bridge MHD NBIS:1]BIN:3)
		If (Records in selection:C76([ScourPOA:132])=0)
			CREATE RECORD:C68([ScourPOA:132])
			Inc_Sequence("ScourPOA"; ->[ScourPOA:132]ScourPOAID:1)
			[ScourPOA:132]BIN:2:=[Bridge MHD NBIS:1]BIN:3
			InitChangeStack(1)
			SCPOA_Variables("INIT")
			[ScourPOA:132]DateCreated:3:=Current date:C33(*)
			[ScourPOA:132]CreatedBy:22:=Current user:C182
			Case of 
				: ([Bridge MHD NBIS:1]Item19:91>=199)
				: ([Bridge MHD NBIS:1]Item19:91<=0)
				Else 
					SCPOA_DetourBrgLen_R:=Round:C94(([Bridge MHD NBIS:1]Item19:91*0.621371192); 3)
			End case 
			
			SCPOA_CopyInvPhotos(True:C214)
			QUERY:C277([ScourPOA_Images:134]; [ScourPOA_Images:134]ScourPOAID:2=[ScourPOA:132]ScourPOAID:1)
			QUERY SELECTION:C341([ScourPOA_Images:134]; [ScourPOA_Images:134]ImageType:5="Photo")
			$NewNumPhotos_L:=Records in selection:C76([ScourPOA_Images:134])
			ARRAY LONGINT:C221(SCPOA_PhotoRecs_aL; $NewNumPhotos_L)
			SELECTION TO ARRAY:C260([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
			SCPOA_Descr2_txt:=SCPOA_CopyScourNotes(True:C214)
			VARIABLE TO BLOB:C532(SCPOA_Descr2_txt; [ScourPOA:132]ScourHistory:7)
			COMPRESS BLOB:C534([ScourPOA:132]ScourHistory:7)
			PushChange(1; ->[ScourPOA:132]ScourHistory:7)
			
			PushChange(1; ->[ScourPOA:132]DateCreated:3)
			PushChange(1; ->[ScourPOA:132]CreatedBy:22)
			
			SCPOA_Variables("SAVE")
			
			SAVE RECORD:C53([ScourPOA:132])
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[ScourPOA:132]BIN:2)
			
			If (SCPOA_LogChanges_b)
				LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[ScourPOA:132]BIN:2; ->[ScourPOA:132]ScourPOAID:1; 1; "ScourPOA")
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[ScourPOA:132]BIN:2; ->[ScourPOA:132]ScourPOAID:1; 1)
			End if 
			TEXT TO BLOB:C554($BINsToBe_atxt{$BinLoop_L}+$Tab_txt; $Report_Blb; Mac text without length:K22:10; $BlobOffset_l)
			TEXT TO BLOB:C554([Bridge MHD NBIS:1]Item113:151+$Tab_txt; $Report_Blb; Mac text without length:K22:10; $BlobOffset_l)
			TEXT TO BLOB:C554(String:C10($NewNumPhotos_L)+$Tab_txt; $Report_Blb; Mac text without length:K22:10; $BlobOffset_l)
			TEXT TO BLOB:C554(String:C10(Length:C16(SCPOA_Descr2_txt))+$Tab_txt; $Report_Blb; Mac text without length:K22:10; $BlobOffset_l)
			TEXT TO BLOB:C554($Eol_txt; $Report_Blb; Mac text without length:K22:10; $BlobOffset_l)
			
			UNLOAD RECORD:C212([ScourPOA:132])
			UNLOAD RECORD:C212([ScourPOA_Images:134])
		Else 
			TEXT TO BLOB:C554($BINsToBe_atxt{$BinLoop_L}+$Tab_txt+"POA Exists"+$Eol_txt; $Report_Blb; Mac text without length:K22:10; $BlobOffset_l)
		End if 
		MESSAGE:C88(" Number :"+String:C10($BinLoop_L)+" of "+String:C10($NBIRecs_L)+Char:C90(13))
	End for 
	CLOSE WINDOW:C154
	C_TIME:C306($Doc_tm)
	$Doc_tm:=Create document:C266(""; "TEXT")
	
	CLOSE DOCUMENT:C267($Doc_tm)
	BLOB TO DOCUMENT:C526(document; $Report_Blb)
	//_ O _SET DOCUMENT CREATOR(document;"????")
	//_ O _SET DOCUMENT TYPE(DOCUMENT;"????")
	SET BLOB SIZE:C606($Report_Blb; 0)
End if 
SET AUTOMATIC RELATIONS:C310($oneRel_b; $manyRel_b)
