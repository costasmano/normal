//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/15/10, 12:04:25
	// ----------------------------------------------------
	// Method: ReApplyDRC
	// Description
	//   ` ReRun a DRC Activity Log Entry
	
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
	ut_Message("Deleting record…"+<>sCR)
	DELETE RECORD:C58($Idfile->)
	Reapply_MakeNewLogEntry("DRC"; $cLocal; $cParent)
Else 
	ut_Message("Data reference error! Data ignored!"+<>sCR)
End if 