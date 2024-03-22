//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/15/10, 11:28:39
	// ----------------------------------------------------
	// Method: ReApplyLNK
	// Description
	// ReRun a LNK Activity Log Entry
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_03
	
End if 
C_LONGINT:C283($j)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($Idfile; $Idfield; $fieldupdate)
C_TEXT:C284($cLocal; $cParent)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($ErrCode; $ConnID; $BindID; $NewRecBind)
C_LONGINT:C283(l_RefID; vRefID)
C_TEXT:C284(a_RefID)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($numrec; $numOwner)
C_LONGINT:C283($ActFileID; $ActRefID; $OwnerFileID; $OwnerRef; $OwnerName)
C_TEXT:C284($Dest)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(aStuff)  // Command Replaced was o_C_STRING length was 80
C_REAL:C285(rStuff)
C_TEXT:C284(tStuff)
C_DATE:C307(dStuff)
C_BOOLEAN:C305(bStuff)
C_LONGINT:C283(iStuff)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(lStuff)
C_TIME:C306(timeStuff)
C_PICTURE:C286(pictStuff)
C_BLOB:C604($xBlob)
C_LONGINT:C283($viBlobCompr)  //Command Replaced was o_C_INTEGER
C_BLOB:C604($OldData_blob)
ARRAY TEXT:C222(aOwnerNames; 0)  //Command Replaced was o_ARRAY string length was 80
C_TEXT:C284($aStore)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($iStore)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($lStore)


$numrec:=0
$Dest:="REPLAY"  //Entries for download
$Idfile:=Table:C252([Activity Log:59]FileID Local:24)
$Idfield:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25)
Case of 
	: ([Activity Log:59]RefIDType:26=0)  //Global local id.
		a_RefID:=[Activity Log:59]Local ID:15
		l_RefID:=Num:C11(a_RefID)
		If ([Activity Log:59]Local Type:18=0)
			QUERY:C277($Idfile->; $Idfield->=a_RefID)
		Else 
			QUERY:C277($Idfile->; $Idfield->=l_RefID)
		End if 
		$cLocal:=a_RefID
		$cParent:=[Activity Log:59]Parent ID:14
		
	: ([Activity Log:59]RefIDType:26=1)  //Remote Local id - Global Parent ID
		a_RefID:=aLookUpDest(ActFileIDL; ActLocalID; $Dest)
		l_RefID:=Num:C11(a_RefID)
		If (ActTypLocal=0)
			QUERY:C277($Idfile->; $Idfield->=a_RefID)
		Else 
			QUERY:C277($Idfile->; $Idfield->=l_RefID)
		End if 
		$cLocal:=a_RefID
		$cParent:=ActParentID
		//We don't need to check ParentID if the ParentID field 
		//  is same as the Local ID field
		If (ActFieldIDP#ActFieldIDL)
			l_RefID:=Num:C11(ActParentID)
			$Idfield:=Field:C253(ActFileIDL; ActFieldIDP)
			If (ActTypPar=0)
				QUERY SELECTION:C341($Idfile->; $Idfield->=ActParentID)
			Else 
				QUERY SELECTION:C341($Idfile->; $Idfield->=l_RefID)
			End if 
		Else 
			$cParent:=$cLocal  //the parent is the same as local
		End if 
		
	: ([Activity Log:59]RefIDType:26=2)  //Remote Local id - remote parent ID
		a_RefID:=aLookUpDest(ActFileIDL; ActLocalID; $Dest)  //Can not rely on the destination id
		l_RefID:=Num:C11(a_RefID)
		If (ActTypLocal=0)
			QUERY:C277($Idfile->; $Idfield->=a_RefID)
		Else 
			QUERY:C277($Idfile->; $Idfield->=l_RefID)
		End if 
		$cLocal:=a_RefID
		a_RefID:=aLookUpDest(ActFileIDP; ActParentID; $Dest)  //Can not rely on the destination id
		$cParent:=a_RefID
		l_RefID:=Num:C11(a_RefID)
		$Idfield:=Field:C253(ActFileIDL; ActFieldIDP)
		If (ActTypPar=0)
			QUERY SELECTION:C341($Idfile->; $Idfield->=a_RefID)
		Else 
			QUERY SELECTION:C341($Idfile->; $Idfield->=l_RefID)
		End if 
		
	: ([Activity Log:59]RefIDType:26=3)
		a_RefID:=[Activity Log:59]Local ID:15  //Can not rely on the destination id
		a_RefID:=aLookUpDest(ActFileIDL; ActLocalID; $Dest)  //Can not rely on the destination id
		If (a_RefID="")  //Assume remote and local ids match!
			a_RefID:=ActLocalID
		End if 
		l_RefID:=Num:C11(a_RefID)
		If (ActTypLocal=0)
			QUERY:C277($Idfile->; $Idfield->=a_RefID)
		Else 
			QUERY:C277($Idfile->; $Idfield->=l_RefID)
		End if 
		$cLocal:=a_RefID
		a_RefID:=aLookUpDest(ActFileIDP; ActParentID; $Dest)  //Can not rely on the destination id
		//Danger!             
		If (a_RefID="")  //Assume remote and local ids match!
			a_RefID:=ActParentID
		End if 
		l_RefID:=Num:C11(a_RefID)
		$Idfield:=Field:C253(ActFileIDL; ActFieldIDP)
		If (ActTypPar=0)
			QUERY SELECTION:C341($Idfile->; $Idfield->=a_RefID)
		Else 
			QUERY SELECTION:C341($Idfile->; $Idfield->=l_RefID)
		End if 
		$cParent:=a_RefID
		
End case 
$numrec:=Records in selection:C76($Idfile->)
If ($numrec=1)  //Make sure we just found one record!
	//Convert data   
	$fieldupdate:=Field:C253(ActFileNo; ActFldNo)  //point to the data
	//The data is link so it can only be Alpha, Integer or LongInt
	//The data is pointing to a record id that is relative
	C_LONGINT:C283($vlOffset)
	C_LONGINT:C283($Tablenumber)
	C_TEXT:C284($vLookupValue_S)  // Command Replaced was o_C_STRING length was 80
	
	Case of   //first case to get the Linked ID 
		: (ActDataTyp=Is alpha field:K8:1)  //Alpha
			BLOB TO VARIABLE:C533(ActData; aStuff; $vlOffset)
			$vLookupValue_S:=aStuff
		: (ActDataTyp=Is integer:K8:5)  //Integer
			BLOB TO VARIABLE:C533(ActData; iStuff; $vlOffset)
			$vLookupValue_S:=String:C10(iStuff)
		: (ActDataTyp=Is longint:K8:6)  //longint
			BLOB TO VARIABLE:C533(ActData; lStuff; $vlOffset)
			$vLookupValue_S:=String:C10(lStuff)
	End case 
	//get the Linked table number
	BLOB TO VARIABLE:C533(ActData; $Tablenumber; $vlOffset)
	If (($Tablenumber=0) | (OK=0))
		$Tablenumber:=ActFileNo
		Case of 
			: (ActFldName="NBISInspID")
				$Tablenumber:=Table:C252(->[Inspections:27])
			: (ActFldName="BMSInspID")
				$Tablenumber:=Table:C252(->[BMS Inspections:44])
		End case 
	End if 
	//find the remote related ID
	$vLookupValue_S:=aDblLookUpDest($Tablenumber; $vLookupValue_S; $Dest; <>Destination)
	//if found values - assign them
	If ($vLookupValue_S="")
	Else 
		
		Case of 
			: (ActDataTyp=Is alpha field:K8:1)  //Alpha
				aStuff:=$vLookupValue_S
			: (ActDataTyp=Is integer:K8:5)  //Integer
				iStuff:=Num:C11($vLookupValue_S)
			: (ActDataTyp=Is longint:K8:6)  //longint
				lStuff:=Num:C11($vLookupValue_S)
		End case 
		
	End if 
	
	//assign values to the field
	Case of 
		: (ActDataTyp=Is alpha field:K8:1)  //Alpha
			$aStore:=$fieldupdate->
			VARIABLE TO BLOB:C532($aStore; $OldData_blob)
			$fieldupdate->:=aStuff
			VARIABLE TO BLOB:C532(aStuff; ActData)
		: (ActDataTyp=Is integer:K8:5)  //Integer
			$iStore:=$fieldupdate->
			VARIABLE TO BLOB:C532($iStore; $OldData_blob)
			$fieldupdate->:=iStuff
			VARIABLE TO BLOB:C532(iStuff; ActData)
		: (ActDataTyp=Is longint:K8:6)  //longint
			$LStore:=$fieldupdate->
			VARIABLE TO BLOB:C532($LStore; $OldData_blob)
			$fieldupdate->:=lStuff
			VARIABLE TO BLOB:C532(lStuff; ActData)
	End case 
	VARIABLE TO BLOB:C532($Tablenumber; ActData; *)
	
	MESSAGE:C88("Linked Field=["+Table name:C256(ActFileNo)+"]"+ActFldName+<>sCR)  //No display of data
	MESSAGE:C88("Updating record…"+<>sCR)
	SAVE RECORD:C53($Idfile->)
	UNLOAD RECORD:C212($Idfile->)
	//Log this transaction on the client
	Reapply_MakeNewLogEntry("LNK"; $cLocal; $cParent)
	
Else 
	MESSAGE:C88("Data reference error! Data ignored!"+<>sCR)
End if 