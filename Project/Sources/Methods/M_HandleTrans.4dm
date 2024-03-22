//%attributes = {"invisible":true}
If (False:C215)
	//procedure: M_HandleTrans
	//by: Albert Leung
	//date: 1/20/98
	//purpose: Handle transfer settings
	Mods_2004_CM03
	// Modified by: Costas Manousakis-(Designer)-(4/13/12 10:49:44)
	Mods_2012_04
	//  `get the form size of the dialog,; window type and a window title
	Mods_NewDownloadCode  //Replace [Preferences]Protocol with [Preferences]LastRefID_L
	//replace [Preferences]zoneinfo with [Preferences]DistrictInformation_s
	//and update code to reflect changes needed
	//Modified by: Chuck Miller (12/27/21 13:37:10)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	// Modified by: Costas Manousakis-(Designer)-(2023-01-06 16:46:50)
	Mods_2023_01_bug
	//  `use blank text for <>ZoneInfo and $sProtocol when sending packets to file
End if 
C_LONGINT:C283($w_L; $h_L)
FORM GET PROPERTIES:C674([Dialogs:21]; "TransferSet"; $w_L; $h_L)
CENTER_WINDOW($w_L; $h_L; Plain dialog box:K34:4; "Data Transfer Settings")
DIALOG:C40([Dialogs:21]; "TransferSet")
CLOSE WINDOW:C154

If (Ok=1)
	ALL RECORDS:C47([Preferences:57])
	FIRST RECORD:C50([Preferences:57])
	[Preferences:57]Destination:1:=vDest
	<>Destination:=vDest
	Case of 
		: (r1=1)
			[Preferences:57]Transfer Type:2:=0
			<>Transfer:=0
		: (r2=1)
			[Preferences:57]Transfer Type:2:=1
			<>Transfer:=1
		: (r3=1)
			[Preferences:57]Transfer Type:2:=-1
			<>Transfer:=-1
	End case 
	[Preferences:57]Forward:3:=vForward
	<>Forward:=vForward
	//[Preferences]ZoneInfo:=vZoneInfo
	//<>ZoneInfo:=vZoneInfo
	//Case of 
	//: (s1=1)
	//[Preferences]Protocol:=1
	//<>Protocol:=1
	//: (s2=1)
	//[Preferences]Protocol:=2
	//<>Protocol:=2
	//End case 
	[Preferences:57]DestIP:9:=vDestIP
	<>DestIP:=vDestIP
	[Preferences:57]ForwardIP:10:=vForwardIP
	<>ForwardIP:=vForwardIP
	If (CBGetServer=1)
		<>ManualCon:=True:C214
		[Preferences:57]ManualCon:5:=True:C214
	Else 
		<>ManualCon:=False:C215
		[Preferences:57]ManualCon:5:=False:C215
	End if 
	If (CBLockUsrTx=1)
		<>LockUserTx:=True:C214
		[Preferences:57]LockUserTx:11:=True:C214
	Else 
		<>LockUserTx:=False:C215
		[Preferences:57]LockUserTx:11:=False:C215
	End if 
	<>TxUserName:=vTxUserName
	[Preferences:57]TxUserName:12:=vTxUserName
	If (CBAllowTxRx=1)
		<>AllowTxRx:=True:C214
		[Preferences:57]AllowTxRx:13:=True:C214
	Else 
		<>AllowTxRx:=False:C215
		[Preferences:57]AllowTxRx:13:=False:C215
	End if 
	
	[Preferences:57]DataFileKEY_s:14:=DataFileKey_s  //save key in preferences
	
	<>KeyMask_s:=DataFileKey_s+"-"+("0"*(19-Length:C16(DataFileKey_s)))  // make sure it is 20 chars long
	
	SAVE RECORD:C53([Preferences:57])
	UNLOAD RECORD:C212([Preferences:57])
	//Save to preferences file
	C_TIME:C306($tPref_file)
	C_TEXT:C284($fname)  // Command Replaced was o_C_STRING length was 255
	C_TEXT:C284($stransfer; $sManualCon; $sShowPrint; $sProtocol; $sLockUserTx; $sAllowTxRx)  // Command Replaced was o_C_STRING length was 80
	
	$fname:=<>sPrefname
	$tPref_file:=Create document:C266($fname)
	If (Ok=1)
		//write the preferences
		$stransfer:=String:C10(<>Transfer)
		Case of 
			: (<>ManualCon=True:C214)
				$sManualCon:="True"
			: (<>ManualCon=False:C215)
				$sManualCon:="False"
		End case 
		Case of 
			: (<>ShowPrint=True:C214)
				$sShowPrint:="True"
			: (<>ShowPrint=False:C215)
				$sShowPrint:="False"
		End case 
		//$sProtocol:=String(<>Protocol)
		Case of 
			: (<>LockUserTx=True:C214)
				$sLockUserTx:="True"
			: (<>LockUserTx=False:C215)
				$sLockUserTx:="False"
		End case 
		Case of 
			: (<>AllowTxRx=True:C214)
				$sAllowTxRx:="True"
			: (<>AllowTxRx=False:C215)
				$sAllowTxRx:="False"
		End case 
		SEND PACKET:C103($tPref_file; <>Destination+<>sCR)
		SEND PACKET:C103($tPref_file; $stransfer+<>sCR)
		SEND PACKET:C103($tPref_file; <>Forward+<>sCR)
		SEND PACKET:C103($tPref_file; ""+<>sCR)  //<>ZoneInfo not used kept for compatibility
		SEND PACKET:C103($tPref_file; $sManualCon+<>sCR)
		SEND PACKET:C103($tPref_file; $sShowPrint+<>sCR)
		SEND PACKET:C103($tPref_file; ""+<>sCR)  //$sProtocol not used kept for compatibility
		SEND PACKET:C103($tPref_file; <>DestIP+<>sCR)
		SEND PACKET:C103($tPref_file; <>ForwardIP+<>sCR)
		SEND PACKET:C103($tPref_file; $sLockUserTx+<>sCR)
		SEND PACKET:C103($tPref_file; <>TxUserName+<>sCR)
		SEND PACKET:C103($tPref_file; $sAllowTxRx+<>sCR)
		SEND PACKET:C103($tPref_file; DataFileKey_s+<>sCR)
		CLOSE DOCUMENT:C267($tPref_file)
	End if 
	
End if 