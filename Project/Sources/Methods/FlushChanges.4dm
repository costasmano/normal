//%attributes = {"invisible":true}
If (False:C215)
	//procedure: FlushChanges
	//by: Albert Leung
	//created: 1/29/97
	//purpose: in the accept phase of the LO changes are saved to a file
	//$1 is the level of the pointer stack
	//$2 is a pointer to the filenumber of the parent id
	//$3 is a pointer to the parent id
	//$4 is a pointer to the local id
	//$5 is the type of id relations
	
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
C_LONGINT:C283($i; $n)

$level:=$1
parentkey:=$2
parentid:=$3
localid:=$4
$keytype:=$5
If (Table name:C256(parentkey)="LSS@")
	ARRAY POINTER:C280(Ptr_changes; $level; 0)
Else 
	$n:=Size of array:C274(ptr_Changes{$level})
	For ($i; $n; 1; -1)
		If (Position:C15("UUID"; Field name:C257(ptr_Changes{$level}{$i}))>0)
			DELETE FROM ARRAY:C228(ptr_Changes{$level}; $i; 1)
		Else 
			
		End if 
	End for 
	$n:=Size of array:C274(ptr_Changes{$level})
	
	For ($i; 1; $n)
		
		LogChanges(ptr_Changes{$level}{$i}; parentkey; parentid; localid; $keytype)
		
	End for 
	ARRAY POINTER:C280(ptr_Changes{$level}; 0)  //free up some memory
	If (Not:C34(In transaction:C397))  //only if not in transaction
		FLUSH CACHE:C297  //make sure the changes were made
	End if 
End if 
