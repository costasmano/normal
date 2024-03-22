//%attributes = {"invisible":true}
//Method: ut_FixFileIDResTRansfers
//Description
//  ` calls all methods to clean the FileIDRes table and re-receive or re-send the activity log.
//  ` Saves the steps in [Parameters] under parameter "FILEIDRESFIX"
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/11/16, 11:38:44
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
	
	C_TEXT:C284(ut_FixFileIDResTransfers; $1)
End if 
//
//do not run on a client
If ((Application type:C494#4D Remote mode:K5:5) | (User in group:C338(Current user:C182; "Design Access Group")))
	
	If (Count parameters:C259>0)
		C_TIME:C306($start_t; $End_t; $dur_t)
		C_TEXT:C284(TRANSF_DestIP_txt)
		C_BOOLEAN:C305(bStuff)
		TRANSF_DestIP_txt:=<>DestIP
		bStuff:=True:C214
		If (User in group:C338(Current user:C182; "Design Access Group"))
			CONFIRM:C162("Use IP address "+<>DestIP)
			If (OK=0)
				TRANSF_DestIP_txt:=SQL_TestConnection
			End if 
			CONFIRM:C162("Apply Fixes on FileIDRes table to database?"; "Apply"; "Just Log")
			bStuff:=(OK=1)
			
		End if 
		READ WRITE:C146([Parameters:107])
		QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
		If (Records in selection:C76([Parameters:107])=0)
			CREATE RECORD:C68([Parameters:107])
			[Parameters:107]ParamCode:1:="FILEIDRESFIX"
			SAVE RECORD:C53([Parameters:107])
		End if 
		//ALERT("Application will QUIT at the end of this procedure!")
		$start_t:=Current time:C178(*)
		ut_SetMessageDir("TransferLogFix")
		
		If (Position:C15("ut_fix "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_Fix
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_fix "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		
		//
		If (Position:C15("ut_DeleteNoMatchFileIDResRecord "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_DeleteNoMatchFileIDResRecord
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_DeleteNoMatchFileIDResRecord "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		
		If (Position:C15("ut_FixRefIDs_pt1 (->[ElementsSafety]"; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixRefIDs_pt1(->[ElementsSafety:29]; ->[ElementsSafety:29]ElmSafetyID:7)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixRefIDs_pt1 (->[ElementsSafety]  "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		If (Position:C15("ut_FixRefIDs_pt1 (->[Cond Units] "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixRefIDs_pt1(->[Cond Units:45]; ->[Cond Units:45]Cond Unit ID:1)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixRefIDs_pt1 (->[Cond Units] "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		If (Position:C15("ut_FixRefIDs_pt1 (->[Standard Photos] "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixRefIDs_pt1(->[Standard Photos:36]; ->[Standard Photos:36]StdPhotoID:7)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixRefIDs_pt1 (->[Standard Photos] "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		If (Position:C15("ut_FixRefIDs_pt1 (->[TunnelInspection] "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixRefIDs_pt1(->[TunnelInspection:152]; ->[TunnelInspection:152]TunnelInspID_L:15)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixRefIDs_pt1 (->[TunnelInspection] "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		If (Position:C15("ut_FixRefIDs_pt1 (->[PON_ELEM_INSP] "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixRefIDs_pt1(->[PON_ELEM_INSP:179]; ->[PON_ELEM_INSP:179]ELEMID:22)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixRefIDs_pt1 (->[PON_ELEM_INSP] "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		
		
		If (Position:C15("ut_FixFileIDRes_pt2 (->[ElementsSafety] "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixFileIDRes_pt2(->[ElementsSafety:29]; ->[ElementsSafety:29]ElmSafetyID:7)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixFileIDRes_pt2 (->[ElementsSafety] "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		If (Position:C15("ut_FixFileIDRes_pt2 (->[Cond Units] "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixFileIDRes_pt2(->[Cond Units:45]; ->[Cond Units:45]Cond Unit ID:1)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixFileIDRes_pt2 (->[Cond Units] "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		If (Position:C15("ut_FixFileIDRes_pt2 (->[Standard Photos] "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixFileIDRes_pt2(->[Standard Photos:36]; ->[Standard Photos:36]StdPhotoID:7)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixFileIDRes_pt2 (->[Standard Photos] "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		If (Position:C15("ut_FixFileIDRes_pt2 (->[TunnelInspection] "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixFileIDRes_pt2(->[TunnelInspection:152]; ->[TunnelInspection:152]TunnelInspID_L:15)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixFileIDRes_pt2 (->[TunnelInspection] "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		If (Position:C15("ut_FixFileIDRes_pt2 (->[PON_ELEM_INSP] "; [Parameters:107]Description:2)>0)
			//run it already - skip
		Else 
			ut_FixFileIDRes_pt2(->[PON_ELEM_INSP:179]; ->[PON_ELEM_INSP:179]ELEMID:22)
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="FILEIDRESFIX")
			LOAD RECORD:C52([Parameters:107])
			[Parameters:107]Description:2:=[Parameters:107]Description:2+"ut_FixFileIDRes_pt2 (->[PON_ELEM_INSP] "+ut_CreateTimeStamp+Char:C90(13)
			SAVE RECORD:C53([Parameters:107])
		End if 
		
		$End_t:=Current time:C178(*)
		$dur_t:=$End_t-$start_t
		
		ut_MessageDia("Done ... Time elapsed = "+String:C10($dur_t); "Summary Messages"; 2; 2)
		
	Else 
		C_LONGINT:C283($ProcessID_l)
		$ProcessID_l:=LSpawnProcess("ut_FixFileIDResTRansfers"; <>LStackSize; "Data Transfers"; True:C214; False:C215; "RUN")
	End if 
	
End if 
//End ut_FixFileIDResTRansfers