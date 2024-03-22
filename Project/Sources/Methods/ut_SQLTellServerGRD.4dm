//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 05/27/10, 14:15:49
// ----------------------------------------------------
// Method: ut_SQLTellServerGRD
// Description
// This method will control delete of records on remote server
//
// Parameters
// ----------------------------------------------------
//ut_SQLTellServerGRD (ActFileID_l;OwnerFileID_l;OwnerRef_l;OwnerName_l)
// `$1 is the activity log file id
//$2 is the owner file fileid
//$3 is the field id of the owner file index
//$4 is the field id of the owner name in the owner file

// Modified by: Charles Miller (5/27/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:13:28) 
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 11:30:11)
End if 

ARRAY TEXT:C222($RemoteKeys_atxt; 0)

C_LONGINT:C283($Numrec_l; $TableNumber_l; $Loop_l; $j)
SQLError_b:=False:C215
4DError_b:=False:C215
C_TEXT:C284($SQLWhereQuery_txt; $TableName_txt; $SQLSelectQuery_txt)
$TableNumber_l:=[Activity Log:59]FileID Local:24
ARRAY TEXT:C222($asFieldIDs; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY TEXT:C222($asDestFieldIDs; 0)  //Command Replaced was o_ARRAY string length was 80

C_BLOB:C604($Xstuff; $XOldStuff)
C_LONGINT:C283($vlBlobCompr; $vlNumIDs; $vlNumDestIDs)
$Xstuff:=[Activity Log:59]Data:10
BLOB PROPERTIES:C536($Xstuff; $vlBlobCompr)
If ($vlBlobCompr#Is not compressed:K22:11)
	EXPAND BLOB:C535($Xstuff)
End if 
$XOldStuff:=[Activity Log:59]Old Data:27
BLOB PROPERTIES:C536($XOldStuff; $vlBlobCompr)
If ($vlBlobCompr#Is not compressed:K22:11)
	EXPAND BLOB:C535($XOldStuff)
End if 
BLOB TO VARIABLE:C533($Xstuff; $asFieldIDs)
BLOB TO VARIABLE:C533($XOldStuff; $asDestFieldIDs)
$vlNumIDs:=Size of array:C274($asFieldIDs)
ARRAY TEXT:C222($RemoteKeys_atxt; $vlNumIDs)

$vlNumDestIDs:=Size of array:C274($asDestFieldIDs)
SET BLOB SIZE:C606($Xstuff; 0)
SET BLOB SIZE:C606($XOldStuff; 0)
DeletionOK_b:=True:C214
Case of   //start of error checks
	: (($vlNumIDs=0) | ($vlNumIDs#$vlNumDestIDs) | ($vlNumDestIDs=0))
		ut_Message("Error in ActivityID "+String:C10([Activity Log:59]RefID:28)+"  ! Data ignored!"+<>sCR)
		//Set status to transfered so we don't send it again
		[Activity Log:59]Status:9:=1
		SAVE RECORD:C53([Activity Log:59])
	Else 
		
		
		$SQLSelectQuery_txt:=ut_SQLReturnSelect(->$SQLWhereQuery_txt; ->$TableName_txt)
		
		C_LONGINT:C283($NumberDeleted_l)
		
		$NumberDeleted_l:=0
		For ($Loop_l; 1; Size of array:C274($asFieldIDs))  //let's loop through and delete each record in turn
			//reset values of
			Case of 
				: ([Activity Log:59]RefIDType:26=0)  //Global local id.
					
					If ([Activity Log:59]Local Type:18=0)
						RefID_s:=$asFieldIDs{$Loop_l}
					Else 
						RefID_l:=Num:C11($asFieldIDs{$Loop_l})
					End if 
					
				: ([Activity Log:59]RefIDType:26=1) | ([Activity Log:59]RefIDType:26=2) | ([Activity Log:59]RefIDType:26=3)  //Remote Local id
					
					If ($asDestFieldIDs{$Loop_l}#"")
						RefID_s:=$asDestFieldIDs{$Loop_l}
					Else 
						If ([Activity Log:59]RefIDType:26=3)
							RefID_s:=aLookUpDest([Activity Log:59]File Number:7; $asFieldIDs{$Loop_l}; <>Destination)
						Else 
							RefID_s:=aLookUpDest([Activity Log:59]FileID Local:24; $asFieldIDs{$Loop_l}; <>Destination)
						End if 
						//Danger!             
						If (RefID_s="")  //Assume remote and local ids match!
							RefID_s:=$asFieldIDs{$Loop_l}
						End if 
						
						//$asDestFieldIDs{$j}:=RefID_s  `update the DestID array also
					End if 
					
			End case 
			
			RefID_l:=Num:C11(RefID_s)
			$RemoteKeys_atxt{$Loop_l}:=RefID_s
			$Numrec_l:=ut_SQLSelectForLoad($SQLSelectQuery_txt; [Activity Log:59]Local Type:18)
			If (RecordLocked_b) & ($Numrec_l>0)
				
				If (ut_SQLDeleteRecord($Numrec_l; $TableName_txt; $SQLWhereQuery_txt))
					$NumberDeleted_l:=$NumberDeleted_l+1
				Else 
					DeletionOK_b:=False:C215
					$Loop_l:=Size of array:C274($asFieldIDs)+1  //let's get out an error occurred
				End if 
				
			End if 
			
		End for 
		
		CLEAR VARIABLE:C89($Returnvalues_atxt)
		ARRAY TEXT:C222($Returnvalues_atxt; Size of array:C274($asFieldIDs))
		
		Case of 
			: ($NumberDeleted_l>0) & (DeletionOK_b)
				VARIABLE TO BLOB:C532($RemoteKeys_atxt; NewFieldID)
				VARIABLE TO BLOB:C532($Returnvalues_atxt; OldFieldID)
				
				ut_SQLUpdateServerActLog
			: ($NumberDeleted_l=Size of array:C274($asFieldIDs)) & (DeletionOK_b)
				VARIABLE TO BLOB:C532($RemoteKeys_atxt; NewFieldID)
				VARIABLE TO BLOB:C532($Returnvalues_atxt; OldFieldID)
				
				ut_SQLUpdateServerActLog
			Else 
				[Activity Log:59]Status:9:=1
				SAVE RECORD:C53([Activity Log:59])
				DataRefernceError_b:=True:C214
				ut_Message("Data reference error GRD ActivityID "+String:C10([Activity Log:59]RefID:28)+"  ! Data ignored!"+<>sCR)
		End case 
		
End case 



