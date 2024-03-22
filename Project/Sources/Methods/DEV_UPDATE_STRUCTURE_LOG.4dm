//%attributes = {"invisible":true}
//  DEV_UPDATE_STRUCTURE_LOG 
// Written (OS): Kirk Brooks  Created: 01/31/13, 12:10:36
// ------------------
// Method: DEV_UPDATE_STRUCTURE_LOG ()
C_BLOB:C604($blob)
C_BOOLEAN:C305($auto1; $autoN; $indexed; $changed)
C_LONGINT:C283($field; $fieldType; $i; $junk; $offset; $oneField; $oneTable; $row; $table)
C_TIME:C306($doc)
C_TEXT:C284($added_txt; $blobPath; $changed_txt; $deleted_txt; $delta_txt; $logPath; $path; $text)
ARRAY TEXT:C222($added_atxt; 0)
ARRAY TEXT:C222($changed_atxt; 0)
ARRAY TEXT:C222($deleted_atxt; 0)

If (False:C215)
	Begin SQL
		/*  Log changes to the structure of the database
		Can run at any time`
		
		creates two files: structure_log  & strucuture_data
		and keeps them in a folder call _structure_log next to the
		database strucutre.
		
		*/
	End SQL
	// Modified by: Costas Manousakis-(Designer)-(2/22/13 16:56:03)
	Mods_2013_02
	// Modified by: Costas Manousakis-(Designer)-(3/17/14 09:01:10)
	Mods_2014_03_Bug
	//  `sending the "header" text to the doc at the end was missing. 
	//  `added some features to compare to a dfferent folde so you can compare two different struct version
	//  `optionaly overwrite the struct data on disk
	// Modified by: Costas Manousakis-(Designer)-(10/30/14 13:19:38)
	Mods_2014_10
	//  `when changes found show doc on disk
	// Modified by: Costas Manousakis-(Designer)-(10/21/15 11:16:14)
	Mods_2015_10_bug
	//  `modified so that a message is written in the log whether the struct blob was updated or this was just a comparison
	// Modified by: Costas Manousakis-(Designer)-(4/10/18 10:10:08)
	Mods_2018_04
	//  `added table_field to the messages; fix a bug when a relation in the current structure does not exist in the saved blob
	// Modified by: Costas Manousakis-(Designer)-(11/26/18 16:12:04)
	Mods_2018_11
	//  `at the end show the log file, not the folder
End if 

// --------------------------------------------------------
// .......... path to the folder ..........
// --------------------------------------------------------
If (True:C214)
	// path to the log folder - should be next to the strucutre file
	$path:=Replace string:C233(Structure file:C489; GetFileExtension(Structure file:C489); "")  //STR_Chomp(->$path;".")
	//$path:=Replace string(Structure file;GetPath (Structure file);"")
	$path:=Replace string:C233($path; GetPath($path); "")
	// strip the doc type
	
	$path:=Get 4D folder:C485(Database folder:K5:14)+$path+"_struct_log"+<>PL_DirectorySep_s
	
	$text:=Select folder:C670("Compare with another structure folder or leave as is ?["+$path+"]"; $path)
	
	If (Ok=1)
		$path:=$text
	End if 
	
	If (Test path name:C476($path)#Is a folder:K24:2)  // need to create it
		CREATE FOLDER:C475($path)
	End if 
End if 
// --------------------------------------------------------
// .......... init arrays ..........
// --------------------------------------------------------
If (True:C214)
	// these are arrays for current structure
	ARRAY TEXT:C222($aTF; 0)  // table_field         *
	ARRAY TEXT:C222($aName; 0)  // table field name  *
	ARRAY LONGINT:C221($aType; 0)  // field type
	ARRAY LONGINT:C221($aLength; 0)  // field Length
	ARRAY BOOLEAN:C223($aINDX; 0)  // field indexed
	ARRAY LONGINT:C221($rTable; 0)  // index table
	ARRAY LONGINT:C221($rField; 0)  // index field
	ARRAY BOOLEAN:C223($rAuto1; 0)  // auto relation 1
	ARRAY BOOLEAN:C223($rAutoN; 0)  // auto relation many
	
	// these arrays are from the blob - old structure
	ARRAY TEXT:C222($aTF__; 0)  // table_field
	ARRAY TEXT:C222($aName__; 0)  // table field name
	ARRAY LONGINT:C221($aType__; 0)  // field type
	ARRAY LONGINT:C221($aLength__; 0)  // field Length
	ARRAY BOOLEAN:C223($aINDX__; 0)  // field indexed
	ARRAY LONGINT:C221($rTable__; 0)  // index table
	ARRAY LONGINT:C221($rField__; 0)  // index field
	ARRAY BOOLEAN:C223($rAuto1__; 0)  // auto relation 1
	ARRAY BOOLEAN:C223($rAutoN__; 0)  // auto relation many
End if 
// --------------------------------------------------------
// .......... read arrays from blob, if any ..........
// --------------------------------------------------------
$blobPath:=$path+"structData.blob"
If (True:C214)
	If (Test path name:C476($blobPath)=Is a document:K24:1)
		DOCUMENT TO BLOB:C525($blobPath; $blob)  // get the blob
		
		BLOB TO VARIABLE:C533($blob; $aTF__; $offset)
		BLOB TO VARIABLE:C533($blob; $aName__; $offset)
		BLOB TO VARIABLE:C533($blob; $aType__; $offset)
		BLOB TO VARIABLE:C533($blob; $aINDX__; $offset)
		BLOB TO VARIABLE:C533($blob; $rTable__; $offset)
		BLOB TO VARIABLE:C533($blob; $rField__; $offset)
		BLOB TO VARIABLE:C533($blob; $rAuto1__; $offset)
		BLOB TO VARIABLE:C533($blob; $rAutoN__; $offset)
		BLOB TO VARIABLE:C533($blob; $aLength__; $offset)
		
		If (Size of array:C274($aLength__)#Size of array:C274($aType__))
			ARRAY LONGINT:C221($aLength__; Size of array:C274($aType__))
		End if 
		
	End if 
	
End if 
// --------------------------------------------------------
// .......... load the current structure ..........
// --------------------------------------------------------
If (True:C214)
	For ($table; 1; Get last table number:C254)
		If (Is table number valid:C999($table))
			For ($field; 1; Get last field number:C255($table))
				If (Is field number valid:C1000($table; $field))
					// valid table & field
					APPEND TO ARRAY:C911($aTF; String:C10($table)+"_"+String:C10($field))
					APPEND TO ARRAY:C911($aName; "["+Table name:C256($table)+"]"+Field name:C257($table; $field))
					
					GET FIELD PROPERTIES:C258($table; $field; $fieldType; $junk; $indexed)
					
					APPEND TO ARRAY:C911($aType; $fieldType)
					APPEND TO ARRAY:C911($aLength; $junk)
					APPEND TO ARRAY:C911($aINDX; $indexed)
					
					GET RELATION PROPERTIES:C686($table; $field; $oneTable; $oneField; $junk; $auto1; $autoN)
					APPEND TO ARRAY:C911($rTable; $oneTable)
					APPEND TO ARRAY:C911($rField; $oneField)
					APPEND TO ARRAY:C911($rAuto1; $auto1)
					APPEND TO ARRAY:C911($rAutoN; $autoN)
					
				End if 
			End for 
		End if 
	End for 
End if 
// --------------------------------------------------------
// .......... do the comparison ..........
// --------------------------------------------------------
If (True:C214)
	$text:="\rStructure compared: "+String:C10(Current date:C33; System date short:K1:1)+" at "+String:C10(Current time:C178; HH MM AM PM:K7:5)+"\r"
	
	If (Application type:C494=4D Remote mode:K5:5)
		$text:=$text+"Server File: "+Structure file:C489+"\r"+("="*40)+"\r"
	Else 
		$text:=$text+"Local File: "+Structure file:C489+"\r"+("="*40)+"\r"
	End if 
	
	$added_txt:="ADDED FIELDS\r  ----------------------------\r"
	$deleted_txt:="DELETED FIELDS\r  ----------------------------\r"
	$changed_txt:="CHANGED FIELDS\r  ----------------------------\r"
	
	// 1) loop through the current structure
	For ($i; 1; Size of array:C274($aTF))
		
		// does this row exist in the previous strcture?
		$row:=Find in array:C230($aTF__; $aTF{$i})
		
		If ($row=-1)  // this is an added field
			$changed:=True:C214
			// add the name
			$added_txt:=$added_txt+$aTF{$i}+" = "+$aName{$i}
			
			If ($aINDX{$i})  // is it indexed
				$added_txt:=$added_txt+", Indexed"
			End if 
			
			If ($rTable{$i}>0)  // there's a relation
				$added_txt:=$added_txt+", Relation, n->1: ["+Table name:C256($rtable{$i})+"]"+Field name:C257($rtable{$i}; $rfield{$i})+" "
				
				If ($rAuto1{$i})
					$added_txt:=$added_txt+"Auto 1;"
				End if 
				
				If ($rAutoN{$i})
					$added_txt:=$added_txt+"Auto N;"
				End if 
			End if 
			
			$added_txt:=$added_txt+"\r"
			
			If (Length:C16($added_txt)>20000)
				APPEND TO ARRAY:C911($added_atxt; $added_txt)
				$added_txt:=""
			End if 
			
		Else   // it's there
			// current name
			$delta_txt:=$aTF{$i}+" = "+$aName{$i}+": "
			
			// did name change?
			If ($aName{$i}#$aName__{$row})
				$delta_txt:=$delta_txt+"Old: "+$aName__{$row}+"; "
			End if 
			
			// type change?
			If ($aType{$i}#$aType__{$row})
				$delta_txt:=$delta_txt+"Type: "+String:C10($aType__{$row})+" ->"+String:C10($aType{$i})+";"
			End if 
			
			// Length change?
			If ($aLength{$i}#$aLength__{$row})
				$delta_txt:=$delta_txt+"Length: "+String:C10($aLength__{$row})+" ->"+String:C10($aLength{$i})+";"
			End if 
			
			// index change?
			If ($aINDX{$i}#$aINDX__{$row})
				$delta_txt:=$delta_txt+"Index: "+String:C10($aINDX__{$row})+" ->"+String:C10($aINDX{$i})+";"
			End if 
			
			// relation change?
			If ($rTable{$i}#$rTable__{$row})
				
				If ($rTable__{$row}#0)
					$delta_txt:=$delta_txt+"Rel: Table "+Table name:C256($rTable__{$row})+" ->"+String:C10($rTable{$i})+", Field "
					$delta_txt:=$delta_txt+Field name:C257($rTable__{$row}; $rField__{$row})+" ->"+String:C10($rField{$i})+", Auto1 "
					$delta_txt:=$delta_txt+String:C10($rAuto1__{$row})+" ->"+String:C10($rAuto1{$i})+", AutoN "
					$delta_txt:=$delta_txt+String:C10($rAutoN__{$row})+" -> "+String:C10($rAutoN{$i})
				Else 
					$delta_txt:=$delta_txt+"New Rel: Table "+" ->"+String:C10($rTable{$i})+", Field "
					$delta_txt:=$delta_txt+" ->"+String:C10($rField{$i})+", Auto1 "
					$delta_txt:=$delta_txt+" ->"+String:C10($rAuto1{$i})+", AutoN "
					$delta_txt:=$delta_txt+" -> "+String:C10($rAutoN{$i})
				End if 
				
			End if 
			
			If ($delta_txt#($aTF{$i}+" = "+$aName{$i}+": "))
				// this is true if the name or any other charcteristic changed
				$changed:=True:C214
				$changed_txt:=$changed_txt+$delta_txt+"\r"
				
				If (Length:C16($changed_txt)>20000)
					APPEND TO ARRAY:C911($changed_atxt; $changed_txt)
					$changed_txt:=""
				End if 
				
			End if 
			
			// delete the row from the old arrays
			DELETE FROM ARRAY:C228($aTF__; $row)  // table_field
			DELETE FROM ARRAY:C228($aName__; $row)  // table field name
			DELETE FROM ARRAY:C228($aType__; $row)  // field type
			DELETE FROM ARRAY:C228($aLength__; $row)  // field Length
			DELETE FROM ARRAY:C228($aINDX__; $row)  // field indexed
			DELETE FROM ARRAY:C228($rTable__; $row)  // index table
			DELETE FROM ARRAY:C228($rField__; $row)  // index field
			DELETE FROM ARRAY:C228($rAuto1__; $row)  // auto relation 1
			DELETE FROM ARRAY:C228($rAutoN__; $row)  // auto relation many
			
		End if 
	End for 
	
	// ===================================================
	// any fields left in the old arrys have been deleted
	$changed:=($changed | (Size of array:C274($aTF__)>0))
	
	// loop through the deleted fields
	For ($i; 1; Size of array:C274($aTF__))
		$deleted_txt:=$deleted_txt+$aTF__{$i}+" = "+$aName__{$i}
		
		If ($aINDX__{$i})
			$deleted_txt:=$deleted_txt+", Indexed"
		End if 
		
		If ($rTable__{$i}>0)  // there's a relation
			$deleted_txt:=$deleted_txt+", Relation, n->1: ["+Table name:C256($rTable__{$i})+"]"+Field name:C257($rTable__{$i}; $rField__{$i})+" "
			
			If ($rAuto1__{$i})
				$deleted_txt:=$deleted_txt+"Auto 1;"
			End if 
			
			If ($rAutoN__{$i})
				$deleted_txt:=$deleted_txt+"Auto N;"
			End if 
		End if 
		
		$deleted_txt:=$deleted_txt+"\r"
		
		If (Length:C16($deleted_txt)>20000)
			APPEND TO ARRAY:C911($deleted_atxt; $deleted_txt)
			$deleted_txt:=""
		End if 
		
	End for 
End if 

$deleted_txt:=$deleted_txt+"\r\r"

// --------------------------------------------------------
// .......... now append to the log ..........
// --------------------------------------------------------
$logPath:=$path+"stuct_log.txt"

If (Test path name:C476($logPath)#Is a document:K24:1)
	$doc:=Create document:C266($logPath)
	CLOSE DOCUMENT:C267($doc)
End if 

//$text:=$text+$added_txt+$deleted_txt+$changed_txt
APPEND TO ARRAY:C911($added_atxt; $added_txt)
APPEND TO ARRAY:C911($deleted_atxt; $deleted_txt)
APPEND TO ARRAY:C911($changed_atxt; $changed_txt)

$doc:=Append document:C265($logPath)
SEND PACKET:C103($doc; $text)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($added_atxt))
	SEND PACKET:C103($doc; $added_atxt{$loop_L})
End for 
For ($loop_L; 1; Size of array:C274($deleted_atxt))
	SEND PACKET:C103($doc; $deleted_atxt{$loop_L})
End for 
For ($loop_L; 1; Size of array:C274($changed_atxt))
	SEND PACKET:C103($doc; $changed_atxt{$loop_L})
End for 

C_BOOLEAN:C305($updateblob_b)
CONFIRM:C162("Update Structure blob in folder "+$path+"? If this was only for comparison, you do not need to update to see results!"; "Update"; "Leave as is")
$updateblob_b:=(OK=1)

If ($updateblob_b)
	SEND PACKET:C103($doc; "\r\r****** Structure Blob was updated ******\r")
Else 
	SEND PACKET:C103($doc; "\r\r****** End of Comparison Run Only ******\r")
End if 

CLOSE DOCUMENT:C267($doc)

// --------------------------------------------------------
// .......... write the arrays to the blob ..........
// --------------------------------------------------------
If ($updateblob_b)
	SET BLOB SIZE:C606($blob; 0)
	$offset:=0
	VARIABLE TO BLOB:C532($aTF; $blob; $offset)
	VARIABLE TO BLOB:C532($aName; $blob; $offset)
	VARIABLE TO BLOB:C532($aType; $blob; $offset)
	VARIABLE TO BLOB:C532($aINDX; $blob; $offset)
	VARIABLE TO BLOB:C532($rTable; $blob; $offset)
	VARIABLE TO BLOB:C532($rField; $blob; $offset)
	VARIABLE TO BLOB:C532($rAuto1; $blob; $offset)
	VARIABLE TO BLOB:C532($rAutoN; $blob; $offset)
	VARIABLE TO BLOB:C532($aLength; $blob; $offset)
	
	BLOB TO DOCUMENT:C526($blobPath; $blob)
	
	SET BLOB SIZE:C606($blob; 0)
End if 
// --------------------------------------------------------
// .......... alert the user ..........
// --------------------------------------------------------
If ($changed)
	ALERT:C41("The structure has changed. You should look at the structure log.")
	SHOW ON DISK:C922($logPath)
Else 
	ALERT:C41("There were no changes found!")
End if 

//[End DEV_UPDATE_STRUCTURE_LOG ]