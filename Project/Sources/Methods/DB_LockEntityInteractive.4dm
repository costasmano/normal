//%attributes = {"invisible":true}
//Method: DB_LockEntityInteractive
//Description
// lock an entity in interactive mode  will keep trying until user cancels.
// Similar to ut_LoadRecordInteractive but using entity
// Parameters
// $0 : $Locked_b
// $1 : $entity
// $2 : $entityDescr_txt (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 19, 2024, 12:11:58
	Mods_2024_01
	// ----------------------------------------------------
	
	C_BOOLEAN:C305(DB_LockEntityInteractive; $0)
	C_OBJECT:C1216(DB_LockEntityInteractive; $1)
	C_TEXT:C284(DB_LockEntityInteractive; $2)
	
End if 

C_BOOLEAN:C305($0; $locked_b)
C_OBJECT:C1216($1; $entity_o)
$entity_o:=$1
C_TEXT:C284($entityDescr_txt)
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$entityDescr_txt:=$2
Else 
	$entityDescr_txt:="in table "+$entity_o.getDataClass().getInfo().name
End if 
C_OBJECT:C1216($lockstatus_o)
C_BOOLEAN:C305($done_b)
$done_b:=False:C215

Repeat 
	$lockstatus_o:=$entity_o.lock()
	
	If ($lockstatus_o.success)
		$done_b:=True:C214
	Else 
		DB_ReturnLockStatusInfo($lockstatus_o)
		CONFIRM:C162("Required record "+$entityDescr_txt+\
			" is locked: "+$lockstatus_o.dblockstatusinfo+" Wait 10 seconds and try again?"; "Wait"; "Cancel")
		If (OK=1)
			DELAY PROCESS:C323(Current process:C322; (10*60))
		Else 
			$done_b:=True:C214
		End if 
		
	End if 
	
Until ($done_b)

$0:=$lockstatus_o.success
//
//End DB_LockEntityInteractive   