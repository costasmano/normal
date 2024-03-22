//%attributes = {"invisible":true}
If (False:C215)
	//FlushGrpDeletions 
	//Log in Activity log a group of deletions of records from the same table,
	//with the same parent relation. 
	//These changes are received by connected databases.
	//Created  : 2003-12-12
	//Parameters :
	//$1 : pointer to field id of parent table
	//$2 : pointer to parent id field of current table
	//$3 : pointer to local id field of current table
	//$4 : type of id relations
	//Uses pre-defined array of LocalID values = arr_DeletedIDs
	//This arr_DeletedIDs array is a string(80) array to hold both 
	//string and longint IDs.
	
	Mods_2005_CM04
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(9/26/11 10:35:25)
	Mods_2011_09
	//  `Do not create an [Owner] record when ◊Transfer = -1  (No transfer)
	//  `Allows user who created the record to be able to download it as himself from
	//  `his copy of the database
	// Modified by: Costas Manousakis-(Designer)-(6/27/17 16:51:07)
	Mods_2017_06_bug
	//  `arr_DeletedIDs can be text array
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Reset To not do updates for LSS Tables
	//If (Table name($parentfile)="LSS@")
	//Modified by: Chuck Miller (1/11/22 10:57:26)
End if 

C_POINTER:C301($1; $2; $3; $5; $parentfile; $parentid; $localid; $manyfile)
C_LONGINT:C283($4; $keytype)
C_LONGINT:C283($n; $i)
C_LONGINT:C283($vType; $vLength)
C_BLOB:C604($xStore; $xOldStore)
C_BOOLEAN:C305($vIndex)

SET BLOB SIZE:C606($xStore; 0)
SET BLOB SIZE:C606($xOldStore; 0)

If ((Type:C295(arr_DeletedIDs)=String array:K8:15) | (Type:C295(arr_DeletedIDs)=Text array:K8:16))
	$n:=Size of array:C274(arr_DeletedIDs)  // we have an array defined  
	If ($n>0)  // there are some deletions
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
				//UNLOAD RECORD([Owners of Data])
			End if 
			//Fill out the rest
			[Activity Log:59]Destination:1:=<>Destination
			[Activity Log:59]Source:2:=<>Source
			[Activity Log:59]Transfer:12:=<>Transfer
			[Activity Log:59]Forward:13:=vsForward
			[Activity Log:59]Activity Type:3:="GRD"
			[Activity Log:59]User Name:4:=Current user:C182
			[Activity Log:59]dDate:5:=Current date:C33(*)
			[Activity Log:59]tTime:6:=Current time:C178(*)
			[Activity Log:59]File Number:7:=Table:C252($parentid)
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
					//load in the data blod the array of IDs to be deleted
					VARIABLE TO BLOB:C532(arr_DeletedIDs; $xStore)
					VARIABLE TO BLOB:C532(arr_DeletedIDs; $xOldStore)
					[Activity Log:59]Parent ID:14:=""
					[Activity Log:59]Dest ID parent:16:=""
				: ($keytype=1)  //Local id with resolution, Global Parent ID
					VARIABLE TO BLOB:C532(arr_DeletedIDs; $xStore)
					If ([Activity Log:59]Type Parent:17=0)
						[Activity Log:59]Parent ID:14:=$parentfile->
					Else 
						[Activity Log:59]Parent ID:14:=String:C10($parentfile->)
					End if 
					//need to build up destination IDs array
					ARRAY TEXT:C222($aDestIDs; $n)  //Command Replaced was o_ARRAY string length was 80
					For ($i; 1; $n)
						$aDestIDs{$i}:=aLookUpDest([Activity Log:59]FileID Local:24; arr_DeletedIDs{$i}; <>Destination)
					End for 
					VARIABLE TO BLOB:C532($aDestIDs; $xOldStore)
					[Activity Log:59]Dest ID parent:16:=""
				: ($keytype=2)  //Remote parent id and remote local id.        
					If ([Activity Log:59]Type Parent:17=0)
						[Activity Log:59]Parent ID:14:=$parentfile->
					Else 
						[Activity Log:59]Parent ID:14:=String:C10($parentfile->)
					End if 
					VARIABLE TO BLOB:C532(arr_DeletedIDs; $xStore)
					[Activity Log:59]Dest ID parent:16:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; <>Destination)
					//need to build up destination IDs array
					ARRAY TEXT:C222($aDestIDs; $n)  //Command Replaced was o_ARRAY string length was 80
					For ($i; 1; $n)
						$aDestIDs{$i}:=aLookUpDest([Activity Log:59]FileID Local:24; arr_DeletedIDs{$i}; <>Destination)
					End for 
					VARIABLE TO BLOB:C532($aDestIDs; $xOldStore)
				: ($keytype=3)  //Remote parent id and remote local id both existing.
					If ([Activity Log:59]Type Parent:17=0)
						[Activity Log:59]Parent ID:14:=$parentfile->
					Else 
						[Activity Log:59]Parent ID:14:=String:C10($parentfile->)
					End if 
					VARIABLE TO BLOB:C532(arr_DeletedIDs; $xStore)
					[Activity Log:59]File Number:7:=Table:C252($manyfile)  //Store the location of the external local file here
					[Activity Log:59]Dest ID parent:16:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; <>Destination)
					//need to build up destination IDs array
					ARRAY TEXT:C222($aDestIDs; $n)  //Command Replaced was o_ARRAY string length was 80
					For ($i; 1; $n)
						$aDestIDs{$i}:=aLookUpDest([Activity Log:59]FileID Local:24; arr_DeletedIDs{$i}; <>Destination)
					End for 
					VARIABLE TO BLOB:C532($aDestIDs; $xOldStore)
					
			End case 
			[Activity Log:59]Data Type:11:=0
			COMPRESS BLOB:C534($xStore)
			[Activity Log:59]Data:10:=$xStore
			COMPRESS BLOB:C534($xOldStore)
			[Activity Log:59]Old Data:27:=$xOldStore
			SAVE RECORD:C53([Activity Log:59])
			UNLOAD RECORD:C212([Activity Log:59])
		End if 
	End if   //if ID array has entries
	
End if   //if ID array defined

//reset array
ARRAY TEXT:C222(arr_DeletedIDs; 0)  //Command Replaced was o_ARRAY string length was 80

SET BLOB SIZE:C606($xStore; 0)
SET BLOB SIZE:C606($xOldStore; 0)

If (Not:C34(In transaction:C397))  //only if not in transaction
	FLUSH CACHE:C297  //make sure the changes were made
End if 