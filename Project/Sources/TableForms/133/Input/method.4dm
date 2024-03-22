Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		C_TEXT:C284(SCPOA_DetBridgeNo_txt; SCPOA_DetLocation_txt; SCPOA_DetTown_txt)
		SCPOA_DetBridgeNo_txt:=""
		SCPOA_DetLocation_txt:=""
		SCPOA_DetTown_txt:=""
		If (Is new record:C668([ScourPOA_DetourBridge:133]))
		Else 
			READ ONLY:C145([Bridge MHD NBIS:1])
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[ScourPOA_DetourBridge:133]DetourBIN:3)
			If (Records in selection:C76([Bridge MHD NBIS:1])=0)
			Else 
				SCPOA_DetBridgeNo_txt:=[Bridge MHD NBIS:1]BDEPT:1
				SCPOA_DetTown_txt:=[Bridge MHD NBIS:1]Town Name:175
				SCPOA_DetLocation_txt:=[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63
			End if 
			
		End if 
		C_BOOLEAN:C305(SCPOA_EditRecord_b)
		C_BOOLEAN:C305($LockedRec_b)
		$LockedRec_b:=Locked:C147([ScourPOA_DetourBridge:133])
		
		If ((SCPOA_EditRecord_b) & Not:C34($LockedRec_b))
			INV_LockUnLockCurrRec(False:C215; Current form table:C627)
			OBJECT SET VISIBLE:C603(SCPOADelImage; True:C214)
		Else 
			INV_LockUnLockCurrRec(True:C214; Current form table:C627)
		End if 
		
End case 