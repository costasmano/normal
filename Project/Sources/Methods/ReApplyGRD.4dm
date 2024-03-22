//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/15/10, 11:28:39
	// ----------------------------------------------------
	// Method: ReApplyGRD
	// Description
	// ReRun a GRD type Activity log entry
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
C_BLOB:C604($xOldStore; $ActData)
ARRAY TEXT:C222(aOwnerNames; 0)  //Command Replaced was o_ARRAY string length was 80

$numrec:=0
$Dest:="REPLAY"  //Entries for download
$Idfile:=Table:C252([Activity Log:59]FileID Local:24)
$Idfield:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25)

BLOB PROPERTIES:C536(ActData; $viBlobCompr)
If ($viBlobCompr#Is not compressed:K22:11)
	EXPAND BLOB:C535(ActData)
End if 
C_LONGINT:C283($NumRecIDs; $i)
ARRAY TEXT:C222($asRecIDsDeleted; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY LONGINT:C221($alRecIDsDeleted; 0)
BLOB TO VARIABLE:C533(ActData; $asRecIDsDeleted)
$NumRecIDs:=Size of array:C274($asRecIDsDeleted)
For ($i; 1; $NumRecIDs)
	a_RefID:=aLookUpDest(ActFileIDL; $asRecIDsDeleted{$i}; $Dest)
	$asRecIDsDeleted{$i}:=a_RefID
End for 

If (ActTypLocal#0)  //convert to longint if necessary  
	ARRAY LONGINT:C221($alRecIDsDeleted; $NumRecIDs)
	For ($i; 1; $NumRecIDs)
		$alRecIDsDeleted{$i}:=Num:C11($asRecIDsDeleted{$i})
	End for 
End if 
ut_Message("Searching for "+String:C10($NumRecIDs)+" records in table "+Table name:C256($Idfile)+"..."+<>sCR)
If (ActTypLocal=0)
	QUERY WITH ARRAY:C644($Idfield->; $asRecIDsDeleted)
Else 
	QUERY WITH ARRAY:C644($Idfield->; $alRecIDsDeleted)
End if 
//clear arrays
ARRAY TEXT:C222($asRecIDsDeleted; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY LONGINT:C221($alRecIDsDeleted; 0)

//Since information has already been transferred seek local ids not destination id
Case of 
	: (ActRefIDTyp=0)  //Global local id.
		
	: (ActRefIDTyp=1)  //Remote Local id - Global Parent ID
		$cParent:=ActParentID
		l_RefID:=Num:C11(ActParentID)
		$Idfield:=Field:C253(ActFileIDL; ActFieldIDP)
		If (ActTypPar=0)
			QUERY SELECTION:C341($Idfile->; $Idfield->=ActParentID)
		Else 
			QUERY SELECTION:C341($Idfile->; $Idfield->=l_RefID)
		End if 
		
	: (ActRefIDTyp=2)  //Remote Local id - Remote Parent ID
		a_RefID:=aLookUpDest(ActFileIDP; ActParentID; $Dest)
		$cParent:=a_RefID
		l_RefID:=Num:C11(a_RefID)
		$Idfield:=Field:C253(ActFileIDL; ActFieldIDP)
		If (ActTypPar=0)
			QUERY SELECTION:C341($Idfile->; $Idfield->=a_RefID)
		Else 
			QUERY SELECTION:C341($Idfile->; $Idfield->=l_RefID)
		End if 
		
	: (ActRefIDTyp=3)
		a_RefID:=aLookUpDest(ActFileIDP; ActParentID; $Dest)
		$cParent:=a_RefID
		l_RefID:=Num:C11(a_RefID)
		$Idfield:=Field:C253(ActFileIDL; ActFieldIDP)
		If (ActTypPar=0)
			QUERY SELECTION:C341($Idfile->; $Idfield->=a_RefID)
		Else 
			QUERY SELECTION:C341($Idfile->; $Idfield->=l_RefID)
		End if 
End case 

$numrec:=Records in selection:C76($Idfile->)
ut_Message("Found "+String:C10($numrec)+" Records.."+<>sCR)
If ($numrec<=$NumRecIDs)  //Make sure we just at least as many as we wanted
	//`````
	//save IDs we are about to delete
	$Idfield:=Field:C253(ActFileIDL; ActFieldIDL)
	If (ActTypLocal=0)
		SELECTION TO ARRAY:C260($Idfield->; $asRecIDsDeleted)
	Else 
		SELECTION TO ARRAY:C260($Idfield->; $alRecIDsDeleted)
		ARRAY TEXT:C222($asRecIDsDeleted; $NumRecIDs)  //Command Replaced was o_ARRAY string length was 80
		For ($i; 1; $numrec)
			$asRecIDsDeleted{$i}:=String:C10($alRecIDsDeleted{$i})
		End for 
	End if 
	
	SET BLOB SIZE:C606(ActData; 0)  //zero blobs
	SET BLOB SIZE:C606(ActOldData; 0)
	VARIABLE TO BLOB:C532($asRecIDsDeleted; ActData)  //stuff array of deleted IDs
	COMPRESS BLOB:C534(ActData)
	ARRAY TEXT:C222($asRecIDsDeleted; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY TEXT:C222($asRecIDsDeleted; $numrec)  //make a blank array//Command Replaced was o_ARRAY string length was 80
	VARIABLE TO BLOB:C532($asRecIDsDeleted; ActOldData)  // stuff it in destination part.
	COMPRESS BLOB:C534(ActOldData)
	
	START TRANSACTION:C239
	DELETE SELECTION:C66($IdFile->)
	C_BOOLEAN:C305($DeletionOK)
	$DeletionOK:=False:C215
	If (Records in set:C195("LockedSet")>0)
		ut_Message("Some records in table "+Table name:C256($Idfile)+" are locked. Canceling Deletion.."+<>sCR)
		CANCEL TRANSACTION:C241
	Else 
		ut_Message("Deleting "+String:C10($numrec)+" Records in table "+Table name:C256($Idfile)+" .."+<>sCR)
		VALIDATE TRANSACTION:C240
		$DeletionOK:=True:C214
	End if 
	
	//``````
	//Log this transaction on the local client
	If ($DeletionOK)
		Reapply_MakeNewLogEntry("GRD"; $cLocal; $cParent)
		
	End if   //($DeletionOK)
	SET BLOB SIZE:C606(ActData; 0)
	SET BLOB SIZE:C606(ActOldData; 0)
	ARRAY TEXT:C222($asRecIDsDeleted; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY LONGINT:C221($alRecIDsDeleted; 0)
Else 
	ut_Message("Data reference error! Data ignored!"+<>sCR)
End if 