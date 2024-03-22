//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/15/10, 12:01:17
	// ----------------------------------------------------
	// Method: ReApplyGRP
	// Description
	//   ` ReRun a GRP Activity Log Entry
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
C_BLOB:C604($xBlob)
C_LONGINT:C283($viBlobCompr)  //Command Replaced was o_C_INTEGER
C_BLOB:C604($xOldStore; $ActData)
ARRAY TEXT:C222(aOwnerNames; 0)  //Command Replaced was o_ARRAY string length was 80

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
		a_RefID:=aLookUpDest(ActFileIDL; ActLocalID; $Dest)
		l_RefID:=Num:C11(a_RefID)
		If (ActTypLocal=0)
			QUERY:C277($Idfile->; $Idfield->=a_RefID)
		Else 
			QUERY:C277($Idfile->; $Idfield->=l_RefID)
		End if 
		$cLocal:=a_RefID
		a_RefID:=aLookUpDest(ActFileIDP; ActParentID; $Dest)
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
	$ActData:=ActData
	BLOB PROPERTIES:C536($ActData; $viBlobCompr)
	If ($viBlobCompr#Is not compressed:K22:11)
		EXPAND BLOB:C535($ActData)
	End if 
	C_LONGINT:C283($NumFlds; $vloffset; $i)
	BLOB TO VARIABLE:C533($ActData; $NumFlds; $vloffset)
	ARRAY INTEGER:C220($aiFldsChanged; 0)
	BLOB TO VARIABLE:C533($ActData; $aiFldsChanged; $vloffset)
	For ($i; 1; $NumFlds)
		BLOB TO VARIABLE:C533($ActData; ActFldNo; $vloffset)
		BLOB TO VARIABLE:C533($ActData; ActFldName; $vloffset)
		BLOB TO VARIABLE:C533($ActData; ActDataTyp; $vloffset)
		$fieldupdate:=Field:C253([Activity Log:59]File Number:7; ActFldNo)  //point to the data
		//for all types except Text Blob and Pict we need to read the var twice
		//once for new data value once for Old data value.
		Case of 
			: (ActDataTyp=Is alpha field:K8:1)  //Alpha
				BLOB TO VARIABLE:C533($ActData; aStuff; $vloffset)
				$fieldupdate->:=aStuff
				aStuff:=Old:C35($fieldupdate->)
				VARIABLE TO BLOB:C532(aStuff; $xOldStore; *)
			: (ActDataTyp=Is real:K8:4)  //Real
				BLOB TO VARIABLE:C533($ActData; rStuff; $vloffset)
				$fieldupdate->:=rStuff
				rStuff:=Old:C35($fieldupdate->)
				VARIABLE TO BLOB:C532(rStuff; $xOldStore; *)
			: (ActDataTyp=Is text:K8:3)  //Text
				BLOB TO VARIABLE:C533($ActData; tStuff; $vloffset)
				$fieldupdate->:=tStuff
				tStuff:=""
				VARIABLE TO BLOB:C532(tStuff; $xOldStore; *)
			: (ActDataTyp=Is picture:K8:10)  //Picture
				BLOB TO VARIABLE:C533($ActData; pictStuff; $vloffset)
				$fieldupdate->:=pictStuff
				pictStuff:=pictStuff*0
				VARIABLE TO BLOB:C532(rStuff; $xOldStore; *)
			: (ActDataTyp=Is date:K8:7)  //Date
				BLOB TO VARIABLE:C533($ActData; dStuff; $vloffset)
				$fieldupdate->:=dStuff
				dStuff:=Old:C35($fieldupdate->)
				VARIABLE TO BLOB:C532(dStuff; $xOldStore; *)
			: (ActDataTyp=Is boolean:K8:9)  //Boolean
				BLOB TO VARIABLE:C533($ActData; bStuff; $vloffset)
				$fieldupdate->:=bStuff
				bStuff:=Old:C35($fieldupdate->)
				VARIABLE TO BLOB:C532(bStuff; $xOldStore; *)
			: (ActDataTyp=Is integer:K8:5)  //Integer
				BLOB TO VARIABLE:C533($ActData; iStuff; $vloffset)
				$fieldupdate->:=iStuff
				iStuff:=Old:C35($fieldupdate->)
				VARIABLE TO BLOB:C532(iStuff; $xOldStore; *)
			: (ActDataTyp=Is longint:K8:6)  //longint
				BLOB TO VARIABLE:C533($ActData; lStuff; $vloffset)
				$fieldupdate->:=lStuff
				lStuff:=Old:C35($fieldupdate->)
				VARIABLE TO BLOB:C532(lStuff; $xOldStore; *)
			: (ActDataTyp=Is time:K8:8)  //Time
				BLOB TO VARIABLE:C533($ActData; timeStuff; $vloffset)
				$fieldupdate->:=timeStuff
				timeStuff:=Old:C35($fieldupdate->)
				VARIABLE TO BLOB:C532(timeStuff; $xOldStore; *)
			: (ActDataTyp=Is BLOB:K8:12)  //Blob
				BLOB TO VARIABLE:C533($ActData; $xBlob; $vloffset)
				$fieldupdate->:=$xBlob
				SET BLOB SIZE:C606($xBlob; 0)
				VARIABLE TO BLOB:C532($xBlob; $xOldStore; *)
		End case 
		ut_Message("Field=["+Table name:C256([Activity Log:59]File Number:7)+"]"+ActFldName+<>sCR)  //No display of data
	End for 
	ut_Message("Updating record…"+<>sCR)
	SAVE RECORD:C53($Idfile->)
	UNLOAD RECORD:C212($Idfile->)
	SET BLOB SIZE:C606($ActData; 0)
	//Log this transaction on the client
	Reapply_MakeNewLogEntry("GRP"; $cLocal; $cParent)
	
Else 
	ut_Message("Data reference error! Data ignored!"+<>sCR)
End if 