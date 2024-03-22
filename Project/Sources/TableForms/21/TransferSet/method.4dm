
If (False:C215)
	//LO:[Dialogs];"TransferSet"
	// Modified by: Costas Manousakis-(Designer)-(4/13/12 10:56:09)
	Mods_2012_04
	//  `Adjusted form size; disable all entry for non-Application Admin users;
	//  `Now all Field Group users have access to this dialog
	// Modified by: Costas Manousakis-(Designer)-(4/30/15 11:51:12)
	Mods_2015_04
	//  `added Unique File Key variable;  only on load event is needed
	// Modified by: Costas Manousakis-(Designer)-(3/14/16 13:33:47)
	Mods_2016_03_bug
	//  `fixed attributes of Labels with black bkground to migrate correctly to v13 and on.
	Mods_NewDownloadCode  //Replace [Preferences]Protocol with [Preferences]LastRefID_L
	//replace [Preferences]zoneinfo with [Preferences]DistrictInformation_s
	//and update code to reflect changes needed
	//Modified by: Chuck Miller (12/27/21 13:37:10)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	// Modified by: Costas Manousakis-(Designer)-(2022-06-17 17:16:08)
	Mods_2022_06
	//  `added dropdown to select usernames belonging to group "Field Group"; populate the dropdown on lod of form 
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_POINTER:C301($Users_ptr)
		$Users_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Userlist")
		ARRAY TEXT:C222($Users_ptr->; 0)
		ARRAY LONGINT:C221($usernumbers; 0)
		ARRAY TEXT:C222($usernames; 0)
		GET USER LIST:C609($usernames; $usernumbers)
		C_LONGINT:C283($loop_L)
		For ($loop_L; Size of array:C274($usernames); 1; -1)
			
			If (Not:C34(User in group:C338($usernames{$loop_L}; "Field Group")))
				DELETE FROM ARRAY:C228($usernames; $loop_L; 1)
			End if 
			
		End for 
		SORT ARRAY:C229($usernames)
		COPY ARRAY:C226($usernames; $Users_ptr->)
		C_TEXT:C284(vDest; vForward; vDestIP; vForwardIP; vTxUserName)  // Command Replaced was o_C_STRING length was 80
		C_TEXT:C284(DataFileKey_s)  // Command Replaced was o_C_STRING length was 3
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET ENABLED:C1123(bSetVersion; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bSetVersion; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		vDest:=<>Destination
		vForward:=<>Forward
		//vZoneInfo:=<>ZoneInfo
		vDestIP:=<>DestIP
		vForwardIP:=<>ForwardIP
		vTxUserName:=<>TxUserName
		DataFileKey_s:=Substring:C12(<>KeyMask_s; 1; 3)
		
		Case of 
			: (<>Transfer=0)
				r1:=1
				r2:=0
				r3:=0
			: (<>Transfer=1)
				r1:=0
				r2:=1
				r3:=0
			: (<>Transfer=-1)
				r1:=0
				r2:=0
				r3:=1
		End case 
		//Case of 
		//: (<>Protocol=1)
		//s1:=1
		//s2:=0
		//: (<>Protocol=2)
		//s1:=0
		//s2:=1
		//End case 
		If (<>ManualCon=True:C214)
			CBGetServer:=1
		Else 
			CBGetServer:=0
		End if 
		If (<>LockUserTx=True:C214)
			CBLockUsrTx:=1
		Else 
			CBLockUsrTx:=0
		End if 
		If (<>AllowTxRx=True:C214)
			CBAllowTxRx:=1
		Else 
			CBAllowTxRx:=0
		End if 
		
		If (User in group:C338(<>CurrentUser_Name; "Application Admin"))
		Else 
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bCancel"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
End case 