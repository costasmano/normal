//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/13/05, 12:13:35
	// ----------------------------------------------------
	// Method: G_GetDirList_Client
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM18
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_TEXT:C284($filetoGet)
$filetoGet:=Request:C163("Enter Folder to get list from server")
If (OK=1)
	C_LONGINT:C283($ServerPID)
	$ServerPID:=Execute on server:C373("G_GetDirList_Server"; 0; "G_GetDirList_Server"; $filetoGet)
	If ($ServerPID#0)
		C_BOOLEAN:C305($ServerProcDone)
		$ServerProcDone:=False:C215
		C_LONGINT:C283($waitCount)  //Command Replaced was o_C_INTEGER
		$waitCount:=0
		Repeat 
			DELAY PROCESS:C323(Current process:C322; 120)
			//Check if document found
			GET PROCESS VARIABLE:C371($ServerPID; spErrCode; spErrCode)
			If (Type:C295(spErrCode)=Is undefined:K8:13)
				spErrCode:=1
			End if 
		Until (spErrCode<=0)
		//Get document
		If (spErrCode=0)
			C_BLOB:C604(vBlob_Document)
			C_LONGINT:C283($vlBobSize)
			GET PROCESS VARIABLE:C371($ServerPID; vl_DocSize; $vlBobSize)
			GET PROCESS VARIABLE:C371($ServerPID; vBlob_Document; vBlob_Document)
			//Say we are done
			//ALERT("Got list "+String(BLOB size(vBlob_Document))+" bytes")
			spErrCode:=1
			SET PROCESS VARIABLE:C370($ServerPID; spErrCode; spErrCode)
			ARRAY TEXT:C222($arr_FileList_txt; 0)
			C_LONGINT:C283($vBlob_compressed_L)
			BLOB PROPERTIES:C536(vBlob_Document; $vBlob_compressed_L)
			If ($vBlob_compressed_L=1)
				EXPAND BLOB:C535(vBlob_Document)
			End if 
			BLOB TO VARIABLE:C533(vBlob_Document; $arr_FileList_txt)
			C_LONGINT:C283($NumFiles_i; $i)  //Command Replaced was o_C_INTEGER
			$NumFiles_i:=Size of array:C274($arr_FileList_txt)
			ARRAY TEXT:C222(arrTab; $NumFiles_i)
			For ($i; 1; $NumFiles_i)
				arrTab{$i}:=Substring:C12($arr_FileList_txt{$i}; 1; 32)
			End for 
			C_LONGINT:C283($FileNo)
			$FileNo:=G_PickFromList
			If (($FileNo)>0)
				G_GetServerDoc_Client(($arr_FileList_txt{($FileNo)}); $filetoGet)
			End if 
			
		Else 
			C_LONGINT:C283($retCode)
			$retCode:=spErrCode
			spErrCode:=1
			SET PROCESS VARIABLE:C370($ServerPID; spErrCode; spErrCode)
			Case of 
				: ($retCode=-1)
					ALERT:C41("Folder "+$filetoGet+" not found!")
				: ($retCode=-2)
					ALERT:C41("Document "+$filetoGet+" could not be read!")
				Else 
					ALERT:C41("What??!??!?!?!?")
			End case 
			
		End if 
	Else 
		ALERT:C41("Cannot create Server process")
	End if 
	
End if 