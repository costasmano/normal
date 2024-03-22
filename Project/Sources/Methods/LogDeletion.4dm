//%attributes = {"invisible":true}
If (False:C215)
	//procedure: LogDeletion
	//by: Albert Leung
	//created: 7/16/97
	//modified: 1/29/98 by ASL
	//purpose: send changes to a file cache for a server to update a central database
	//To delete an existing record.
	//$1 is the pointer id of the local record
	//$2 describes the type of id changes:
	//0 represents a deletion without any id resolution
	//1 represents a deletion with id resolution in the local id
	//2 represents a deletion with id resolution in the parent record
	// & the local record
	
	// Modified by: costasmanousakis-(Designer)-(9/26/11 10:35:25)
	Mods_2011_09
	//  `Do not create an [Owner] record when ◊Transfer = -1  (No transfer)
	//  `Allows user who created the record to be able to download it as himself from
	//  `his copy of the database
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Reset To not do updates for LSS Tables
	//If (Table name($parentfile)="LSS@")
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 

C_LONGINT:C283($vType; $vLength)
C_BOOLEAN:C305($vIndex)
C_POINTER:C301($1; $2; $3; $5; $parentfile; $parentid; $localid; $manyfile)
C_LONGINT:C283($4; $keytype)
C_TEXT:C284($txtVar)
C_BLOB:C604($xVar)

$parentfile:=$1
$parentid:=$2
$localid:=$3
$keytype:=$4
If (Count parameters:C259=5)
	$manyfile:=$5
End if 
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
	End if 
	//Fill out the rest
	[Activity Log:59]Destination:1:=<>Destination
	[Activity Log:59]Source:2:=<>Source
	[Activity Log:59]Transfer:12:=<>Transfer
	[Activity Log:59]Forward:13:=vsForward
	[Activity Log:59]Activity Type:3:="DRC"
	[Activity Log:59]User Name:4:=Current user:C182
	[Activity Log:59]dDate:5:=Current date:C33(*)
	[Activity Log:59]tTime:6:=Current time:C178(*)
	[Activity Log:59]File Number:7:=0
	[Activity Log:59]Field Number:8:=0
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
	If (<>Transfer<0)
		[Activity Log:59]Status:9:=-1  //Set to no transfer
	Else 
		[Activity Log:59]Status:9:=0  //Nothing has been sent yet
	End if 
	Case of 
		: ($keytype=0)  //Fixed local id. No resolution.
			If ([Activity Log:59]Local Type:18=0)
				[Activity Log:59]Local ID:15:=$localid->
			Else 
				[Activity Log:59]Local ID:15:=String:C10($localid->)
			End if 
			[Activity Log:59]Parent ID:14:=""
			[Activity Log:59]Dest ID local:19:=[Activity Log:59]Local ID:15
			[Activity Log:59]Dest ID parent:16:=""
		: ($keytype=1)  //Local id with resolution, Global Parent ID
			If ([Activity Log:59]Local Type:18=0)
				[Activity Log:59]Local ID:15:=$localid->
			Else 
				[Activity Log:59]Local ID:15:=String:C10($localid->)
			End if 
			// [Activity Log]Parent ID:=""
			If ([Activity Log:59]Type Parent:17=0)
				[Activity Log:59]Parent ID:14:=$parentid->
			Else 
				[Activity Log:59]Parent ID:14:=String:C10($parentid->)
			End if 
			[Activity Log:59]Dest ID local:19:=aLookUpDest([Activity Log:59]FileID Local:24; [Activity Log:59]Local ID:15; <>Destination)
			[Activity Log:59]Dest ID parent:16:=""
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
		: ($keytype=3)  //Remote parent id and remote local id both existing.
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
			[Activity Log:59]File Number:7:=Table:C252($manyfile)  //Store the location of the external local file here
			[Activity Log:59]Dest ID parent:16:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; <>Destination)
			[Activity Log:59]Dest ID local:19:=aLookUpDest([Activity Log:59]File Number:7; [Activity Log:59]Local ID:15; <>Destination)
	End case 
	//Handle the data: there is no data
	$txtVar:=""
	VARIABLE TO BLOB:C532($txtVar; $xVar)
	[Activity Log:59]Data Type:11:=0
	[Activity Log:59]Data:10:=$xVar
	[Activity Log:59]Old Data:27:=$xVar
	SAVE RECORD:C53([Activity Log:59])
	UNLOAD RECORD:C212([Activity Log:59])
End if 