//%attributes = {"invisible":true}
If (False:C215)
	//procedure: FlushGrpChgs
	//purpose: in the accept phase of the LO changes are saved to a file
	//$1 is the level of the pointer stack
	//$2 is a pointer to the filenumber of the parent id
	//$3 is a pointer to the parent id
	//$4 is a pointer to the local id
	//$5 is the type of id relations
	
	// Modified by: costasmanousakis-(Designer)-(9/26/11 10:35:25)
	Mods_2011_09
	//  `Do not create an [Owner] record when ◊Transfer = -1  (No transfer)
	//  `Allows user who created the record to be able to download it as himself from
	//  `his copy of the database
	Mods_2016_09  // Make sure UUIDs are never sent to activity log
	//Modified by: Chuck Miller (9/1/16 12:55:54)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Reset To not do updates for LSS Tables
	//If (Table name($parentfile)="LSS@")
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 

C_POINTER:C301($2; $3; $4; parentkey; parentid; localid)
C_LONGINT:C283($1; $5; $level; $keytype)
C_LONGINT:C283($i; $n; $vlFldNum)
C_TEXT:C284($vsFldname)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($vType; $vLength)
C_BOOLEAN:C305($vIndex)
C_POINTER:C301($fld; $parentfile; $parentid; $localid)
C_BLOB:C604($xStore; $xOldstore; $xdatablob)
C_TEXT:C284($aStore)  // Command Replaced was o_C_STRING length was 255
C_BOOLEAN:C305($bStore)
C_DATE:C307($dStore)
C_LONGINT:C283($iStore)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($lStore)
C_PICTURE:C286($picStore)
C_REAL:C285($rStore)
C_TEXT:C284($txtStore)
C_TIME:C306($tStore)

$level:=$1



$n:=Size of array:C274(ptr_Changes{$level})
For ($i; $n; 1; -1)
	If (Position:C15("UUID"; Field name:C257(ptr_Changes{$level}{$i}))>0)
		DELETE FROM ARRAY:C228(ptr_Changes{$level}; $i; 1)
	Else 
		
	End if 
End for 
$parentfile:=$2
$parentid:=$3
$localid:=$4
$keytype:=$5
$n:=Size of array:C274(ptr_Changes{$level})
If (Table name:C256($parentfile)="LSS@")
	ARRAY POINTER:C280(Ptr_changes; $level; 0)
Else 
	If ($n>0)
		CREATE RECORD:C68([Activity Log:59])
		Inc_Sequence("Activity Log"; ->[Activity Log:59]RefID:28)  //Get the next sequence
		If (<>Transfer=-1)
			//Generate an owner record
			//CREATE RECORD([Owners of Data])
			//[Owners of Data]RefID:=[Activity Log]RefID
			//[Owners of Data]Owner Name:=Current user
			//SAVE RECORD([Owners of Data])
			//UNLOAD RECORD([Owners of Data])
		End if 
		//Fill out the rest
		[Activity Log:59]Destination:1:=<>Destination
		[Activity Log:59]Source:2:=<>Source
		[Activity Log:59]Transfer:12:=<>Transfer
		[Activity Log:59]Forward:13:=vsForward
		[Activity Log:59]Activity Type:3:="GRP"
		[Activity Log:59]User Name:4:=Current user:C182
		[Activity Log:59]dDate:5:=Current date:C33(*)
		[Activity Log:59]tTime:6:=Current time:C178(*)
		[Activity Log:59]File Number:7:=Table:C252($parentid)
		//[Activity Log]Field Number:=Field($fld)
		//[Activity Log]ActField Name:=Field name($fld)
		[Activity Log:59]RefIDType:26:=$keytype
		[Activity Log:59]FileID Parent:22:=Table:C252($parentfile)
		[Activity Log:59]FieldID Parent:23:=Field:C253($parentid)
		GET FIELD PROPERTIES:C258($parentid; $vType; $vLength; $vIndex)
		[Activity Log:59]Type Parent:17:=$vType
		[Activity Log:59]FileID Local:24:=Table:C252($localid)
		[Activity Log:59]FieldID Local:25:=Field:C253($localid)
		GET FIELD PROPERTIES:C258($localid; $vType; $vLength; $vIndex)
		[Activity Log:59]Local Type:18:=$vType
		If (<>Transfer<0)
			[Activity Log:59]Status:9:=-1  //Set to no transfer
		Else 
			[Activity Log:59]Status:9:=0  //Nothing has been sent yet
		End if 
		Case of 
			: ($keytype=0)  //Fixed local id. No resolution. No parent id.
				If ([Activity Log:59]Local Type:18=0)
					[Activity Log:59]Local ID:15:=$localid->
				Else 
					[Activity Log:59]Local ID:15:=String:C10($localid->)
				End if 
				[Activity Log:59]Parent ID:14:=""
				[Activity Log:59]Dest ID local:19:=[Activity Log:59]Local ID:15
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
				[Activity Log:59]Dest ID local:19:=aLookUpDest([Activity Log:59]FileID Local:24; [Activity Log:59]Local ID:15; <>Destination)
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
				[Activity Log:59]Dest ID local:19:=aLookUpDest([Activity Log:59]FileID Local:24; [Activity Log:59]Local ID:15; <>Destination)
		End case 
		//Handle the data
		VARIABLE TO BLOB:C532($n; $xStore)  //store num of changes
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
					$aStore:=Old:C35($fld->)
					VARIABLE TO BLOB:C532($aStore; $xOldstore; *)
				: ($vType=Is real:K8:4)  //Real
					$rStore:=$fld->
					VARIABLE TO BLOB:C532($rStore; $xStore; *)
					$rStore:=Old:C35($fld->)
					VARIABLE TO BLOB:C532($rStore; $xOldstore; *)
				: ($vType=Is text:K8:3)  //Text
					$txtStore:=$fld->
					VARIABLE TO BLOB:C532($txtStore; $xStore; *)
					$txtStore:=""  //Old does not handle text
					VARIABLE TO BLOB:C532($txtStore; $xOldstore; *)
				: ($vType=Is picture:K8:10)  //Picture
					$picStore:=$fld->
					VARIABLE TO BLOB:C532($picStore; $xStore; *)
					$picStore:=$picstore*0  //Old does not handle pictures
					VARIABLE TO BLOB:C532($picStore; $xOldstore; *)
				: ($vType=Is date:K8:7)  //Date
					$dStore:=$fld->
					VARIABLE TO BLOB:C532($dStore; $xStore; *)
					$dStore:=Old:C35($fld->)
					VARIABLE TO BLOB:C532($dStore; $xOldstore; *)
				: ($vType=Is boolean:K8:9)  //Boolean
					$bStore:=$fld->
					VARIABLE TO BLOB:C532($bStore; $xStore; *)
					$bStore:=Old:C35($fld->)
					VARIABLE TO BLOB:C532($bStore; $xOldstore; *)
				: ($vType=Is integer:K8:5)  //Integer
					$iStore:=$fld->
					VARIABLE TO BLOB:C532($iStore; $xStore; *)
					$iStore:=Old:C35($fld->)
					VARIABLE TO BLOB:C532($iStore; $xOldstore; *)
				: ($vType=Is longint:K8:6)  //Longint
					$lStore:=$fld->
					VARIABLE TO BLOB:C532($lStore; $xStore; *)
					$lStore:=Old:C35($fld->)
					VARIABLE TO BLOB:C532($lStore; $xOldstore; *)
				: ($vType=Is time:K8:8)  //Time
					$tStore:=$fld->
					VARIABLE TO BLOB:C532($tStore; $xStore; *)
					$tStore:=Old:C35($fld->)
					VARIABLE TO BLOB:C532($tStore; $xOldstore; *)
				: ($vType=Is BLOB:K8:12)  //Blob
					$xDataBlob:=$fld->
					VARIABLE TO BLOB:C532($xDataBlob; $xStore; *)
					SET BLOB SIZE:C606($xDataBlob; 0)  //Old does not handle Blobs
					VARIABLE TO BLOB:C532($xDataBlob; $xOldstore; *)
			End case 
			
		End for 
		COMPRESS BLOB:C534($xStore)
		[Activity Log:59]Data:10:=$xStore
		COMPRESS BLOB:C534($xOldStore)
		[Activity Log:59]Old Data:27:=$xOldStore
		SAVE RECORD:C53([Activity Log:59])
		UNLOAD RECORD:C212([Activity Log:59])
	End if   //if num changes >0
	ARRAY POINTER:C280(ptr_Changes{$level}; 0)  //free up some memory
	If (Not:C34(In transaction:C397))  //only if not in transaction
		FLUSH CACHE:C297  //make sure the changes were made
	End if 
	
End if 