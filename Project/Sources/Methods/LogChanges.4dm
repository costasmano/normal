//%attributes = {"invisible":true}
If (False:C215)
	//procedure: LogChanges
	//by: Albert Leung
	//created: 1/29/97
	//modified: 1/29/98 ASL
	//               3/3/2000 CM
	//               3/27/2002 ASL      
	//purpose: send changes to a file cache for a server to update a central database
	//For changes to an existing record.
	//$1 is the pointer to the field that was updated
	//$2 is pointer to the parent record file
	//$3 is the pointer id of the parent record
	//$4 is the pointer id of the child record
	//$5 describes the type of id changes:
	//0 represents a change to a primary record with no resolution on the remote compu
	//1 represents a change to a local record with no resolution in the parent id but 
	//    a resolution needed for the local id
	//2 represents a change to the parent id and local id that needs resolution for bo
	
	// Modified by: costasmanousakis-(Designer)-(9/26/11 10:35:25)
	Mods_2011_09
	//  `Do not create an [Owner] record when ◊Transfer = -1  (No transfer)
	//  `Allows user who created the record to be able to download it as himself from
	//  `his copy of the database
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//Reset To not do updates for LSS Tables
	//If (Table name($parentfile)="LSS@")
	//These methods moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
End if 

C_LONGINT:C283($vType; $vLength)
C_BOOLEAN:C305($vIndex)
C_POINTER:C301($1; $2; $3; $4; $fld; $parentfile; $parentid; $localid)
C_LONGINT:C283($5; $keytype)
C_BLOB:C604($xStore)
C_TEXT:C284($aStore)  // Command Replaced was o_C_STRING length was 255
C_BOOLEAN:C305($bStore)
C_DATE:C307($dStore)
C_LONGINT:C283($iStore)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($lStore)
C_PICTURE:C286($picStore)
C_REAL:C285($rStore)
C_TEXT:C284($txtStore)
C_TIME:C306($tStore)

$fld:=$1
$parentfile:=$2
$parentid:=$3
$localid:=$4
$keytype:=$5
If (Table name:C256($parentfile)="LSS@")
Else 
	
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
	[Activity Log:59]Activity Type:3:="FLD"
	[Activity Log:59]User Name:4:=Current user:C182
	[Activity Log:59]dDate:5:=Current date:C33(*)
	[Activity Log:59]tTime:6:=Current time:C178(*)
	[Activity Log:59]File Number:7:=Table:C252($fld)
	[Activity Log:59]Field Number:8:=Field:C253($fld)
	[Activity Log:59]ActField Name:20:=Field name:C257($fld)
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
	GET FIELD PROPERTIES:C258($fld; $vType; $vLength; $vIndex)
	[Activity Log:59]Data Type:11:=$vType
	Case of 
		: ($vType=Is alpha field:K8:1)  //Alpha
			$aStore:=$fld->
			VARIABLE TO BLOB:C532($aStore; $xStore)
			[Activity Log:59]Data:10:=$xStore
			$aStore:=Old:C35($fld->)
			VARIABLE TO BLOB:C532($aStore; $xStore)
			[Activity Log:59]Old Data:27:=$xStore
		: ($vType=Is real:K8:4)  //Real
			$rStore:=$fld->
			VARIABLE TO BLOB:C532($rStore; $xStore)
			[Activity Log:59]Data:10:=$xStore
			$rStore:=Old:C35($fld->)
			VARIABLE TO BLOB:C532($rStore; $xStore)
			[Activity Log:59]Old Data:27:=$xStore
		: ($vType=Is text:K8:3)  //Text
			$txtStore:=$fld->
			VARIABLE TO BLOB:C532($txtStore; $xStore)
			[Activity Log:59]Data:10:=$xStore
			//Old does not handle text
		: ($vType=Is picture:K8:10)  //Picture
			$picStore:=$fld->
			VARIABLE TO BLOB:C532($picStore; $xStore)
			[Activity Log:59]Data:10:=$xStore
			//Old does not handle pictures
		: ($vType=Is date:K8:7)  //Date
			$dStore:=$fld->
			VARIABLE TO BLOB:C532($dStore; $xStore)
			[Activity Log:59]Data:10:=$xStore
			$dStore:=Old:C35($fld->)
			VARIABLE TO BLOB:C532($dStore; $xStore)
			[Activity Log:59]Old Data:27:=$xStore
		: ($vType=Is boolean:K8:9)  //Boolean
			$bStore:=$fld->
			VARIABLE TO BLOB:C532($bStore; $xStore)
			[Activity Log:59]Data:10:=$xStore
			$bStore:=Old:C35($fld->)
			VARIABLE TO BLOB:C532($bStore; $xStore)
			[Activity Log:59]Old Data:27:=$xStore
		: ($vType=Is integer:K8:5)  //Integer
			$iStore:=$fld->
			VARIABLE TO BLOB:C532($iStore; $xStore)
			[Activity Log:59]Data:10:=$xStore
			$iStore:=Old:C35($fld->)
			VARIABLE TO BLOB:C532($iStore; $xStore)
			[Activity Log:59]Old Data:27:=$xStore
		: ($vType=Is longint:K8:6)  //Longint
			$lStore:=$fld->
			VARIABLE TO BLOB:C532($lStore; $xStore)
			[Activity Log:59]Data:10:=$xStore
			$lStore:=Old:C35($fld->)
			VARIABLE TO BLOB:C532($lStore; $xStore)
			[Activity Log:59]Old Data:27:=$xStore
		: ($vType=Is time:K8:8)  //Time
			$tStore:=$fld->
			VARIABLE TO BLOB:C532($tStore; $xStore)
			[Activity Log:59]Data:10:=$xStore
			$tStore:=Old:C35($fld->)
			VARIABLE TO BLOB:C532($tStore; $xStore)
			[Activity Log:59]Old Data:27:=$xStore
		: ($vType=Is BLOB:K8:12)  //Blob
			[Activity Log:59]Data:10:=$fld->
	End case 
	//clear memory
	$picStore:=$picStore*0
	SET BLOB SIZE:C606($xStore; 0)
	SAVE RECORD:C53([Activity Log:59])
	UNLOAD RECORD:C212([Activity Log:59])
End if 