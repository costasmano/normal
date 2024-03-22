//%attributes = {"invisible":true}
//Method: LogNewRecordInit
//Description
// Create a single activity log that logs a new record and initializes the fields
// Act Log record type = NRI
// Parameters
//$1  the pointer id of the parent record key field in the parent record
//$2  the pointer id of the parent record foreign key in the local table
//$3  the pointer id of the Key of local table
//$4  the descriptor for the type of id relations
//$5  the name of the sequencing for this record
//$6  number of change stack
// ${7} pointers to fields to be skipped in the changes
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/21, 15:51:54
	// ----------------------------------------------------
	//Created : 
	Mods_2021_02
	
	C_POINTER:C301(LogNewRecordInit; $1; $2; $3)
	C_LONGINT:C283(LogNewRecordInit; $4)
	C_TEXT:C284(LogNewRecordInit; $5)
	C_LONGINT:C283(LogNewRecordInit; $6)
	C_POINTER:C301(LogNewRecordInit; ${7})
	
	Mods_StillWorkingOn
	
End if 
//

//STILLWORKINGONTHIS:=True

C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($4)
C_TEXT:C284($5)
C_LONGINT:C283($6)

ARRAY POINTER:C280($FldsToSkip_aptr; 0)
C_POINTER:C301($Tbl_ptr; $fld_ptr)
C_LONGINT:C283($numFlds_L; $fLoop_L; $pLoop_L; $TblNum_L; $numParams_L; $viFldType; $vlFldLen; $level)
//
//add to the fields to be skipped the foreign and local keys of the table
APPEND TO ARRAY:C911($FldsToSkip_aptr; $2)
APPEND TO ARRAY:C911($FldsToSkip_aptr; $3)
$numParams_L:=Count parameters:C259
//find if there are additional fields to skip in the changes
If ($numParams_L>6)
	C_POINTER:C301(${7})
	For ($pLoop_L; 7; $numParams_L)
		APPEND TO ARRAY:C911($FldsToSkip_aptr; ${$pLoop_L})
	End for 
	
End if 

$TblNum_L:=Table:C252($2)
$level:=$6
$Tbl_ptr:=Table:C252($TblNum_L)
$numFlds_L:=Get last field number:C255($Tbl_ptr)
//do all the fields
For ($fLoop_L; 1; $numFlds_L)
	If (Is field number valid:C1000($Tbl_ptr; $fLoop_L))
		$fld_ptr:=Field:C253($TblNum_L; $fLoop_L)
		GET FIELD PROPERTIES:C258($fld_ptr; $viFldType; $vlFldLen)
		
		Case of 
			: (Find in array:C230($FldsToSkip_aptr; $fld_ptr)>0)  // fields to be skipped
			: (($viFldType=Is alpha field:K8:1) & ($vlFldLen=0))  // a UUID type field
			: (Position:C15("UUID"; Field name:C257($fld_ptr))>0)  // field called UUID
			Else 
				PushChange($level; $fld_ptr)
		End case 
		
	End if 
End for 

C_LONGINT:C283($vType; $vLength)
C_BOOLEAN:C305($vIndex)
C_POINTER:C301($parentfile; $parentid; $localid; $manyfile)
C_LONGINT:C283($keytype)
C_TEXT:C284($SeqName)  // Command Replaced was o_C_STRING length was 80
$parentfile:=$1
$parentid:=$2
$localid:=$3
$keytype:=$4
$SeqName:=$5

CREATE RECORD:C68([Activity Log:59])
Inc_Sequence("Activity Log"; ->[Activity Log:59]RefID:28)  //Get the next sequence
If (<>Transfer=-1)
	//Generate an owner record
	//CREATE RECORD([Owners of Data])
	//[Owners of Data]RefID:=[Activity Log]RefID
	//[Owners of Data]Owner Name:=Current user
	//SAVE RECORD([Owners of Data])
End if 
//Fill out the rest
[Activity Log:59]Destination:1:=<>Destination
[Activity Log:59]Source:2:=<>Source
[Activity Log:59]Activity Type:3:="NRI"
[Activity Log:59]User Name:4:=Current user:C182
[Activity Log:59]dDate:5:=Current date:C33(*)
[Activity Log:59]tTime:6:=Current time:C178(*)
[Activity Log:59]File Number:7:=0  //There is no data
[Activity Log:59]Field Number:8:=0
If (<>Transfer<0)
	[Activity Log:59]Status:9:=-1  //Set to no transfer
Else 
	[Activity Log:59]Status:9:=0  //Nothing has been sent yet
End if 
[Activity Log:59]Data Type:11:=0
[Activity Log:59]Transfer:12:=<>Transfer
[Activity Log:59]Forward:13:=vsForward
[Activity Log:59]Dest ID parent:16:=""  //The record on the server does not exist yet
[Activity Log:59]Dest ID local:19:=""  //The record on the server does not exist yet
[Activity Log:59]ActField Name:20:=""
[Activity Log:59]RefIDType:26:=$keytype
[Activity Log:59]FileID Parent:22:=Table:C252($parentfile)
[Activity Log:59]FieldID Parent:23:=Field:C253($parentid)
GET FIELD PROPERTIES:C258($parentid; $vType; $vLength; $vIndex)
[Activity Log:59]Type Parent:17:=$vType
[Activity Log:59]FileID Local:24:=Table:C252($localid)
[Activity Log:59]FieldID Local:25:=Field:C253($localid)
GET FIELD PROPERTIES:C258($localid; $vType; $vLength; $vIndex)
[Activity Log:59]Local Type:18:=$vType
Case of 
	: ($keytype=0)  //Fixed local id. No resolution. No parent id.
		If ([Activity Log:59]Local Type:18=0)
			[Activity Log:59]Local ID:15:=$localid->
		Else 
			[Activity Log:59]Local ID:15:=String:C10($localid->)
		End if 
		[Activity Log:59]Dest ID local:19:=[Activity Log:59]Local ID:15
		[Activity Log:59]Parent ID:14:=""
		[Activity Log:59]Dest ID parent:16:=""
	: ($keytype=1)  //Fixed parent id. Remote local id.
		If ([Activity Log:59]Type Parent:17=0)
			[Activity Log:59]Parent ID:14:=$parentid->
		Else 
			[Activity Log:59]Parent ID:14:=String:C10($parentid->)
		End if 
		If ([Activity Log:59]Local Type:18=0)
			[Activity Log:59]Local ID:15:=$localid->
		Else 
			[Activity Log:59]Local ID:15:=String:C10($localid->)
		End if 
		[Activity Log:59]Dest ID parent:16:=[Activity Log:59]Parent ID:14
		[Activity Log:59]Dest ID local:19:=""  //Unknown right now
		
	: ($keytype=2)  //Remote parent id and remote local id.
		If ([Activity Log:59]Type Parent:17=0)
			[Activity Log:59]Parent ID:14:=$parentid->
		Else 
			[Activity Log:59]Parent ID:14:=String:C10($parentid->)
		End if 
		If ([Activity Log:59]Local Type:18=0)
			[Activity Log:59]Local ID:15:=$localid->
		Else 
			[Activity Log:59]Local ID:15:=String:C10($localid->)
		End if 
		[Activity Log:59]Dest ID parent:16:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; <>Destination)
		[Activity Log:59]Dest ID local:19:=""  //Unknown right now
		
	: ($keytype=3)  //Remote parent id and remote local id both existing.
		//this keytype cannot be used with this method. it is used specifically for creating entries in [field trip] type tables
		
	: ($keytype=4)  //relative local id
		[Activity Log:59]Parent ID:14:=""
		If ([Activity Log:59]Local Type:18=0)
			[Activity Log:59]Local ID:15:=$localid->
		Else 
			[Activity Log:59]Local ID:15:=String:C10($localid->)
		End if 
		[Activity Log:59]Dest ID parent:16:=""
		[Activity Log:59]Dest ID local:19:=""  //Unknown right now
End case 

C_LONGINT:C283($i; $n; $vlFldNum)
C_TEXT:C284($vsFldname)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($vType; $vLength)
C_BOOLEAN:C305($vIndex)
C_POINTER:C301($fld; $parentfile; $parentid; $localid)
C_BLOB:C604($xStore; $xdatablob)
C_TEXT:C284($aStore)  // Command Replaced was o_C_STRING length was 255
C_BOOLEAN:C305($bStore)
C_DATE:C307($dStore)
C_LONGINT:C283($iStore)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($lStore)
C_PICTURE:C286($picStore)
C_REAL:C285($rStore)
C_TEXT:C284($txtStore)
C_TIME:C306($tStore)

$n:=Size of array:C274(ptr_Changes{$level})

If ($n>0)
	
	//Fill out the rest
	[Activity Log:59]File Number:7:=Table:C252($parentid)
	
	VARIABLE TO BLOB:C532($SeqName; $xStore)  //This the name of the sequence record in the sequence file
	
	//Handle the data
	VARIABLE TO BLOB:C532($n; $xStore; *)  //store num of changes
	ARRAY INTEGER:C220($alChgdFlds; $n)  //build array of fields
	For ($i; 1; $n)
		$fld:=ptr_Changes{$level}{$i}
		$alChgdFlds{$i}:=Field:C253($fld)
	End for 
	VARIABLE TO BLOB:C532($alChgdFlds; $xStore; *)
	For ($i; 1; $n)
		
		$fld:=ptr_Changes{$level}{$i}
		GET FIELD PROPERTIES:C258($fld; $vType; $vLength; $vIndex)
		$vlFldNum:=Field:C253($fld)
		$vsFldName:=Field name:C257($fld)
		VARIABLE TO BLOB:C532($vlFldNum; $xStore; *)
		VARIABLE TO BLOB:C532($vsFldName; $xStore; *)
		VARIABLE TO BLOB:C532($vType; $xStore; *)
		Case of 
			: ($vType=Is alpha field:K8:1)  //Alpha
				$aStore:=$fld->
				VARIABLE TO BLOB:C532($aStore; $xStore; *)
				
			: ($vType=Is real:K8:4)  //Real
				$rStore:=$fld->
				VARIABLE TO BLOB:C532($rStore; $xStore; *)
				
			: ($vType=Is text:K8:3)  //Text
				$txtStore:=$fld->
				VARIABLE TO BLOB:C532($txtStore; $xStore; *)
				
			: ($vType=Is picture:K8:10)  //Picture
				$picStore:=$fld->
				VARIABLE TO BLOB:C532($picStore; $xStore; *)
				
			: ($vType=Is date:K8:7)  //Date
				$dStore:=$fld->
				VARIABLE TO BLOB:C532($dStore; $xStore; *)
				
			: ($vType=Is boolean:K8:9)  //Boolean
				$bStore:=$fld->
				VARIABLE TO BLOB:C532($bStore; $xStore; *)
				
			: ($vType=Is integer:K8:5)  //Integer
				$iStore:=$fld->
				VARIABLE TO BLOB:C532($iStore; $xStore; *)
				
			: ($vType=Is longint:K8:6)  //Longint
				$lStore:=$fld->
				VARIABLE TO BLOB:C532($lStore; $xStore; *)
				
			: ($vType=Is time:K8:8)  //Time
				$tStore:=$fld->
				VARIABLE TO BLOB:C532($tStore; $xStore; *)
				
			: ($vType=Is BLOB:K8:12)  //Blob
				$xDataBlob:=$fld->
				VARIABLE TO BLOB:C532($xDataBlob; $xStore; *)
				
		End case 
		
	End for 
	COMPRESS BLOB:C534($xStore)
	[Activity Log:59]Data:10:=$xStore
	
Else 
	//no changes in data - just add the sequence to the data blob
	VARIABLE TO BLOB:C532($SeqName; [Activity Log:59]Data:10)  //This the name of the sequence record in the sequence file
End if   //if num changes >0

SAVE RECORD:C53([Activity Log:59])
UNLOAD RECORD:C212([Activity Log:59])

ARRAY POINTER:C280(ptr_Changes{$level}; 0)  //free up some memory

If (Not:C34(In transaction:C397))  //only if not in transaction
	FLUSH CACHE:C297  //make sure the changes were made
End if 

//End LogNewRecordInit