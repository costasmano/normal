//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/13/06, 15:59:04
	// ----------------------------------------------------
	// Method: INV_ApproveRejectInsp
	// Description
	// Approve or reject an Inventory Photo Inspection
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
	Mods_2009_03  //CJM  r001   `03/06/09, 14:39:04`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
If (InvPhotoInspID_aL>0)
	C_BOOLEAN:C305($bOKtoApprove)
	C_LONGINT:C283(vbAccept; vbReject)  //Command Replaced was o_C_INTEGER
	C_TEXT:C284($msg; vTextMsg; vtRevComments; vtPrevRevComments)
	C_LONGINT:C283($SelectedRec; $SelectedListItm)
	ARRAY LONGINT:C221($ListofIDs_aL; 0)
	SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]InvPhotoInspID_L:1; $ListofIDs_aL)
	$SelectedListItm:=InvPhotoInspID_aL
	$SelectedRec:=Find in array:C230($ListofIDs_aL; InvPhotoInspID_aL{InvPhotoInspID_aL})
	GOTO SELECTED RECORD:C245([InventoryPhotoInsp:112]; $SelectedRec)
	LOAD RECORD:C52([InventoryPhotoInsp:112])
	Case of 
		: (Locked:C147([InventoryPhotoInsp:112]))
			C_LONGINT:C283($Process)
			C_TEXT:C284($user; $Machine; $ProcessName)
			LOCKED BY:C353([InventoryPhotoInsp:112]; $Process; $user; $Machine; $ProcessName)
			$msg:="Inventory Photo insp for BIN :"+[InventoryPhotoInsp:112]BIN:2+" Dated "
			$msg:=$msg+String:C10([InventoryPhotoInsp:112]InvPhotoDate_D:3)+" is locked "
			If ($user="")
				$msg:=$msg+" in your local process "+$ProcessName
			Else 
				$msg:=$msg+"by user "+$user+" on station "+$Machine+" in local process "+$ProcessName
			End if 
			ALERT:C41($msg)
			$bOKtoApprove:=False:C215
		: (Not:C34([InventoryPhotoInsp:112]Complete_B:9))
			$bOKtoApprove:=False:C215
			$msg:="Inventory Photo insp for BIN :"+[InventoryPhotoInsp:112]BIN:2+" Dated "
			$msg:=$msg+String:C10([InventoryPhotoInsp:112]InvPhotoDate_D:3)+" is not complete yet!"
			ALERT:C41($msg)
		Else 
			$bOKtoApprove:=True:C214
	End case 
	If ($bOKtoApprove)
		$msg:="Approval for Inventory Photo Inspection"
		$msg:=$msg+<>sCR+"dated : "+String:C10([InventoryPhotoInsp:112]InvPhotoDate_D:3)
		$msg:=$msg+"  for BIN : "+[InventoryPhotoInsp:112]BIN:2+"?"
		$msg:=$msg+<>sCR+"(Make sure date stamp on photos matches Inspection date)"
		vTextMsg:=$msg
		vbAccept:=0
		vbReject:=0
		vtPrevRevComments:=""
		If ([InventoryPhotoInsp:112]ApproveComments_txt:7#"")
			vtPrevRevComments:=vtPrevRevComments+"DBIE Review :"+<>sCR+[InventoryPhotoInsp:112]ApproveComments_txt:7
		End if 
		vtRevComments:=""
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "ApproveInsp"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
		//$tempWin:=Open form window([Dialogs];"ApproveInsp")
		DIALOG:C40([Dialogs:21]; "ApproveInsp")
		CLOSE WINDOW:C154($Win_l)
		Case of 
			: (vbAccept=1)
				InitChangeStack(1)
				[InventoryPhotoInsp:112]ApproveComments_txt:7:=""
				[InventoryPhotoInsp:112]ApproveDate_D:8:=Current date:C33(*)
				[InventoryPhotoInsp:112]Approved_I:6:=BMS Approved
				PushChange(1; ->[InventoryPhotoInsp:112]ApproveComments_txt:7)
				PushChange(1; ->[InventoryPhotoInsp:112]ApproveDate_D:8)
				PushChange(1; ->[InventoryPhotoInsp:112]Approved_I:6)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1)
				SAVE RECORD:C53([InventoryPhotoInsp:112])
			: (vbReject=1)
				InitChangeStack(1)
				If ([InventoryPhotoInsp:112]ApproveComments_txt:7="")
					[InventoryPhotoInsp:112]ApproveComments_txt:7:=Current user:C182+" - "+String:C10(Current date:C33; Internal date short:K1:7)+" : "+vtRevComments  //copy comments
				Else 
					[InventoryPhotoInsp:112]ApproveComments_txt:7:=[InventoryPhotoInsp:112]ApproveComments_txt:7+<>sCR+<>sCR+Current user:C182+" - "+String:C10(Current date:C33; Internal date short:K1:7)+" : "+vtRevComments  //copy comments
				End if 
				[InventoryPhotoInsp:112]Complete_B:9:=False:C215
				[InventoryPhotoInsp:112]Approved_I:6:=BMS Rejected
				PushChange(1; ->[InventoryPhotoInsp:112]ApproveComments_txt:7)
				PushChange(1; ->[InventoryPhotoInsp:112]Complete_B:9)
				PushChange(1; ->[InventoryPhotoInsp:112]Approved_I:6)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1)
				SAVE RECORD:C53([InventoryPhotoInsp:112])
				
		End case 
		INV_DisplayInvInspections(True:C214)  //in review list
		INV_ReDoSort
		If ($SelectedListItm>Size of array:C274(InvPhotoInspID_aL))
			InvPhotoInspID_aL:=Size of array:C274(InvPhotoInspID_aL)
		Else 
			InvPhotoInspID_aL:=$SelectedListItm
		End if 
	End if 
	
End if 