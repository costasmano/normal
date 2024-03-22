//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/06/05, 16:19:11
	// ----------------------------------------------------
	// Method: G_GetServerDoc_Client
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(3/7/11 09:00:31)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_TEXT:C284($1; $2)
C_TEXT:C284($filetoGet; $Path)
C_BOOLEAN:C305($GoOn_B)
If (Count parameters:C259>=1)
	$filetoGet:=$1
	$GoOn_B:=True:C214
Else 
	$filetoGet:=Request:C163("Enter Filename to get from server")
	$GoOn_B:=(OK=1)
End if 
If (Count parameters:C259>=2)
	$Path:=$2
Else 
	$Path:=""
End if 

If ($GoOn_B)
	C_LONGINT:C283($ServerPID)
	C_BOOLEAN:C305($resForc)
	CONFIRM:C162("Get the resource fork?")
	$resForc:=(OK=1)
	$ServerPID:=Execute on server:C373("G_GetServerDoc_Server"; 0; "G_GetServerDoc_Server"; $filetoGet; $Path; $resForc)
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
			//ALERT("Got document "+String(BLOB size(vBlob_Document))+" bytes")
			spErrCode:=1
			SET PROCESS VARIABLE:C370($ServerPID; spErrCode; spErrCode)
			C_TEXT:C284($DestFolder)
			$DestFolder:=Select folder:C670("Select Location to save File")
			C_TIME:C306($Tempdoc)
			If (OK=1)
				$Tempdoc:=Create document:C266($DestFolder+$filetoGet; "")
				If (OK=1)
					CLOSE DOCUMENT:C267($Tempdoc)
					If ($resForc)
						BLOB TO DOCUMENT:C526(Document; vBlob_Document; *)
					Else 
						BLOB TO DOCUMENT:C526(Document; vBlob_Document)
						//_ O _SET DOCUMENT CREATOR(Document;"")
						ut_OpenDocument(Document)
					End if 
				End if 
			End if 
			SET BLOB SIZE:C606(vBlob_Document; 0)
		Else 
			C_LONGINT:C283($retCode)
			$retCode:=spErrCode
			spErrCode:=1
			SET PROCESS VARIABLE:C370($ServerPID; spErrCode; spErrCode)
			Case of 
				: ($retCode=-1)
					ALERT:C41("Document "+$filetoGet+" not found!")
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