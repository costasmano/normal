//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/15/10, 11:28:39
	// ----------------------------------------------------
	// Method: ReApplyFLD
	// Description
	//   ` ReRun a FLD Activity Log Entry
	
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_03
End if 


C_LONGINT:C283($j)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($Idfile; $Idfield; $fieldupdate)
C_TEXT:C284($cLocal; $cParent)  //<--- Added// Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($ErrCode; $ConnID; $BindID; $NewRecBind)
C_LONGINT:C283(l_RefID; vRefID)
C_TEXT:C284(a_RefID)  //<--- Added// Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($numrec; $numOwner)
C_LONGINT:C283($ActFileID; $ActRefID; $OwnerFileID; $OwnerRef; $OwnerName)
C_TEXT:C284($Dest)  //<--- Added// Command Replaced was o_C_STRING length was 80

C_TEXT:C284(aStuff)  //<--- Added// Command Replaced was o_C_STRING length was 80
C_REAL:C285(rStuff)
C_TEXT:C284(tStuff)
C_DATE:C307(dStuff)
C_BOOLEAN:C305(bStuff)
C_LONGINT:C283(iStuff)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(lStuff)
C_TIME:C306(timeStuff)
C_PICTURE:C286(pictStuff)

$numrec:=0
$Idfield:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25)
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
	$fieldupdate:=Field:C253([Activity Log:59]File Number:7; [Activity Log:59]Field Number:8)  //point to the data
	Case of 
		: ([Activity Log:59]Data Type:11=Is alpha field:K8:1)  //Alpha
			BLOB TO VARIABLE:C533(ActData; aStuff)
			$fieldupdate->:=aStuff
		: ([Activity Log:59]Data Type:11=Is real:K8:4)  //Real
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; rStuff)
			$fieldupdate->:=rStuff
		: ([Activity Log:59]Data Type:11=Is text:K8:3)  //Text
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; tStuff)
			$fieldupdate->:=tStuff
		: ([Activity Log:59]Data Type:11=Is picture:K8:10)  //Picture
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; pictStuff)
			$fieldupdate->:=pictStuff
		: ([Activity Log:59]Data Type:11=Is date:K8:7)  //Date
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; dStuff)
			$fieldupdate->:=dStuff
		: ([Activity Log:59]Data Type:11=Is boolean:K8:9)  //Boolean
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; bStuff)
			$fieldupdate->:=bStuff
		: ([Activity Log:59]Data Type:11=Is integer:K8:5)  //Integer
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; iStuff)
			$fieldupdate->:=iStuff
		: ([Activity Log:59]Data Type:11=Is longint:K8:6)  //longint
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; lStuff)
			$fieldupdate->:=lStuff
		: ([Activity Log:59]Data Type:11=Is time:K8:8)  //Time
			BLOB TO VARIABLE:C533([Activity Log:59]Data:10; timeStuff)
			$fieldupdate->:=timeStuff
		: ([Activity Log:59]Data Type:11=Is BLOB:K8:12)  //Blob
			$fieldupdate->:=[Activity Log:59]Data:10
	End case 
	ut_Message("Field=["+Table name:C256([Activity Log:59]File Number:7)+"]"+[Activity Log:59]ActField Name:20+<>sCR)  //No display of data
	ut_Message("Updating record…"+<>sCR)
	SAVE RECORD:C53($Idfile->)
	UNLOAD RECORD:C212($Idfile->)
	
	Reapply_MakeNewLogEntry("FLD"; $cLocal; $cParent)
	
Else 
	ut_Message("Data reference error! Data ignored!"+<>sCR)
End if 