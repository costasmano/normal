//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/15/10, 11:35:41
	// ----------------------------------------------------
	// Method: ReApplyNRC
	// Description
	// ReRun a NRC Activity Log Entry
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_03
End if 

C_LONGINT:C283($j)  //Command Replaced was o_C_INTEGER//pass the counter
C_POINTER:C301($Idfile; $Idfield; $idparent)
C_TEXT:C284($cLocal; $cParent)  //<--- Added// Command Replaced was o_C_STRING length was 20
C_TEXT:C284($vsSeqName)  //<--- Added// Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($ErrCode; $ConnID; $BindID; $NewRecBind)
C_LONGINT:C283(l_RefID; vRefID)
C_TEXT:C284(a_RefID)  //<--- Added// Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($numOwner; $numrec)
C_LONGINT:C283($ActFileID; $ActRefID; $OwnerFileID; $OwnerRef; $OwnerName)
C_TEXT:C284($Dest)  //<--- Added// Command Replaced was o_C_STRING length was 80
C_LONGINT:C283(NewRef; l_parentid; l_localid)
C_TEXT:C284(aNewRef; aparentid; alocalid)  //<--- Added// Command Replaced was o_C_STRING length was 80

C_TEXT:C284(aStuff)  //<--- Added// Command Replaced was o_C_STRING length was 80
C_LONGINT:C283(lStuff)

$numrec:=0
$Dest:="REPLAY"  //Entries for download
$Idfile:=Table:C252([Activity Log:59]FileID Local:24)
$Idfield:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25)

Case of 
	: ([Activity Log:59]RefIDType:26=0)  //Global local id.
		a_RefID:=[Activity Log:59]Local ID:15
		l_RefID:=Num:C11(a_RefID)
		CREATE RECORD:C68($Idfile->)
		If (ActTypLocal=0)
			$Idfield->:=a_RefID
		Else 
			$Idfield->:=l_RefID
		End if 
		$cLocal:=a_RefID
		$cParent:=[Activity Log:59]Parent ID:14
		
	: ([Activity Log:59]RefIDType:26=1)  //variable Local id - Global Parent ID
		
		$idparent:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $vsSeqName)
		Inc_Sequence($vsSeqName; ->NewRef)
		aNewRef:=String:C10(NewRef)
		CREATE RECORD:C68($Idfile->)
		If (ActTypPar=0)
			aparentid:=ActParentID
			$idparent->:=aparentid
		Else 
			l_parentid:=Num:C11(ActParentID)
			$idparent->:=l_parentid
		End if 
		If (ActTypLocal=0)
			$Idfield->:=aNewRef
		Else 
			$Idfield->:=NewRef
		End if 
		//Add entries into the file address resolution table
		ReApply_StoreRecRes(ActFileIDL; aNewRef; ActLocalID; $Dest)
		
		$cLocal:=aNewRef
		$cParent:=ActParentID
		
	: ([Activity Log:59]RefIDType:26=2)  //variable Local id - variable parent ID
		
		$idparent:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $vsSeqName)
		Inc_Sequence($vsSeqName; ->NewRef)
		aNewRef:=String:C10(NewRef)
		CREATE RECORD:C68($Idfile->)
		aparentid:=aLookUpDest(ActFileIDP; ActParentID; $Dest)
		If (ActTypPar=0)
			$idparent->:=aparentid
		Else 
			l_parentid:=Num:C11(aparentid)
			$idparent->:=l_parentid
		End if 
		If (ActTypLocal=0)
			$Idfield->:=aNewRef
		Else 
			$Idfield->:=NewRef
		End if 
		//Add entries into the file address resolution table
		ReApply_StoreRecRes(ActFileIDL; aNewRef; ActLocalID; $Dest)
		
		$cLocal:=aNewRef
		$cParent:=aparentid
		
	: ([Activity Log:59]RefIDType:26=3)  //variable Local id - variable parent ID
		$idparent:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		CREATE RECORD:C68($Idfile->)
		aparentid:=aLookUpDest(ActFileIDP; ActParentID; $Dest)
		//Danger!
		//If (aparentid="")  `Assume local id and remote are the same!
		// aparentid:=ActParentID
		//End if 
		If (ActTypPar=0)
			$idparent->:=aparentid
		Else 
			l_parentid:=Num:C11(aparentid)
			$idparent->:=l_parentid
		End if 
		alocalid:=aLookUpDest(ActFileNo; ActLocalID; $Dest)
		If (alocalid="")  //Assume local id and remote are the same!
			alocalid:=ActLocalID
		End if 
		If (ActTypLocal=0)
			$Idfield->:=alocalid
		Else 
			l_localid:=Num:C11(alocalid)
			$Idfield->:=l_localid
		End if 
		
		$cLocal:=alocalid
		$cParent:=aparentid
		
	: ([Activity Log:59]RefIDType:26=4)
		BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $vsSeqName)
		Inc_Sequence($vsSeqName; ->NewRef)
		aNewRef:=String:C10(NewRef)
		CREATE RECORD:C68($Idfile->)
		If (ActTypLocal=0)
			$Idfield->:=aNewRef
		Else 
			$Idfield->:=NewRef
		End if 
		//Put an entry into the file address resolution table
		ReApply_StoreRecRes(ActFileIDL; aNewRef; ActLocalID; $Dest)
		
		$cLocal:=aNewRef
		$cParent:=""
		
End case 
SAVE RECORD:C53($Idfile->)
UNLOAD RECORD:C212($Idfile->)
//Log this transaction on the client
Reapply_MakeNewLogEntry("NRC"; $cLocal; $cParent)