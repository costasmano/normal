//%attributes = {"invisible":true}
//Method: ut_FixFileIDRes_pt2
//Description
//  ` Fix the send part - act log records created locally that cannot be sent due to FileIDres errors
// Parameters
// $1 : $Tbl_ptr
// $2 : $KeyField_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/07/16, 12:46:05
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
	// Modified by: Costas Manousakis-(Designer)-(4/4/16 15:38:55)
	Mods_2016_04_bug
	//  `removed all alerts/confirms
	//Compiler Declarations
	C_POINTER:C301(ut_FixFileIDRes_pt2; $1)
	C_POINTER:C301(ut_FixFileIDRes_pt2; $2)
	
End if 
//
//
C_POINTER:C301($1; $2)

C_POINTER:C301($tbl_ptr; $keyFld_ptr)
C_LONGINT:C283($Tbl_L)

$tbl_ptr:=$1
$keyFld_ptr:=$2
$Tbl_L:=Table:C252($tbl_ptr)

ARRAY TEXT:C222($LocalIds_atxt; 0)
ARRAY TEXT:C222($RemotelIds_atxt; 0)
ARRAY TEXT:C222($badpairLocal_atxt; 0)
ARRAY TEXT:C222($badPairRemote_atxt; 0)

ut_StartMessage(3; ("Send Table "+Table name:C256($Tbl_L)+" "+ut_CreateTimeStamp))

QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$Tbl_L; *)
QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3="NRC")

QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Destination:1=<>Destination)

ut_Message(ut_CreateTimeStamp+" : Found "+String:C10(Records in selection:C76([Activity Log:59]))+" Act Log NRC records for destination "+<>Destination+Char:C90(13))

SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $LocalIds_atxt; [Activity Log:59]Dest ID local:19; $RemotelIds_atxt)
ARRAY TEXT:C222($NeedReSendLocalIDS_atxt; 0)
ARRAY TEXT:C222($possibleDestIDS_atxt; 0)
ARRAY TEXT:C222($otherLocalIDS_atxt; 0)
ARRAY TEXT:C222($BadRemoteIDs_atxt; 0)
ARRAY TEXT:C222($BadLocalIDs_atxt; 0)
C_LONGINT:C283($loop_L; $count_L)
C_TEXT:C284($SearchID_txt; $Dest_txt; $RemoteID_txt)
$Dest_txt:=<>Destination

//start the bar
C_LONGINT:C283(<>ProgressPID)
<>ProgressPID:=StartProgress("Remote ID conflict Scan"; "NONE"; "Searching through "+String:C10(Size of array:C274($LocalIds_atxt))+" Local IDs"; "Number of IDs left")
//initialize the bar
UpdateProgress(0; Size of array:C274($LocalIds_atxt))

For ($loop_L; 1; Size of array:C274($LocalIds_atxt))
	If (($loop_L%20)=0)
		//update the bar
		UpdateProgress($loop_L; Size of array:C274($LocalIds_atxt))
	End if 
	
	$SearchID_txt:=$LocalIds_atxt{$loop_L}
	Begin SQL
		select [FileIDRes Table].[Destination ID], [FileIDRes Table].[Local ID]
		from
		[FileIDRes Table]
		where
		[FileIDRes Table].[File Number] = :$Tbl_L
		and [FileIDRes Table].[Local ID] = :$SearchID_txt
		and [FileIDRes Table].[Destination] = :$Dest_txt
		into :$possibleDestIDS_atxt , :$otherLocalIDS_atxt ;
	End SQL
	//[FileIDRes Table].[File Number]
	//[FileIDRes Table].[Destination ID]
	//[FileIDRes Table].[Local ID]
	//[FileIDRes Table].[Destination]
	ut_Message("Checking Local ID "+$LocalIds_atxt{$loop_L}+Char:C90(13))
	Case of 
		: (Size of array:C274($possibleDestIDS_atxt)=0)
			ut_Message("!!!! ERROR !!! Did not find a record in RefID"+Char:C90(13))
			
		: (Size of array:C274($possibleDestIDS_atxt)=1)
			//check to see if it matches what's in the NRC record
			
			If ($possibleDestIDS_atxt{1}=$RemotelIds_atxt{$loop_L})
				//need to check if the remote ID is also linked to another localID
				$RemoteID_txt:=$RemotelIds_atxt{$loop_L}
				ARRAY TEXT:C222($possibleDestIDS_atxt; 0)
				ARRAY TEXT:C222($otherLocalIDS_atxt; 0)
				
				Begin SQL
					select [FileIDRes Table].[Destination ID], [FileIDRes Table].[Local ID]
					from
					[FileIDRes Table]
					where
					[FileIDRes Table].[File Number] = :$Tbl_L
					and [FileIDRes Table].[Local ID] <> :$SearchID_txt
					and [FileIDRes Table].[Destination ID] = :$RemoteID_txt
					and [FileIDRes Table].[Destination] = :$Dest_txt
					into :$possibleDestIDS_atxt , :$otherLocalIDS_atxt ;
				End SQL
				If (Size of array:C274($possibleDestIDS_atxt)>0)
					//add these bad pairs 
					C_LONGINT:C283($loop2_L)
					ut_Message("Adding "+String:C10(Size of array:C274($possibleDestIDS_atxt))+" pairs of FileIDRes records to the list of Bad"+Char:C90(13))
					For ($loop2_L; 1; Size of array:C274($possibleDestIDS_atxt))
						APPEND TO ARRAY:C911($BadRemoteIDs_atxt; $possibleDestIDS_atxt{$loop2_L})
						APPEND TO ARRAY:C911($BadLocalIDs_atxt; $otherLocalIDS_atxt{$loop2_L})
					End for 
					//we also have to re-send  act log records for this record-maybe just relog it
					//add it to list to re-send
					APPEND TO ARRAY:C911($NeedReSendLocalIDS_atxt; $LocalIds_atxt{$loop_L})
				End if 
				
			Else 
				ut_Message("!!!! ERROR !!! Entry in FileIDRes "+$possibleDestIDS_atxt{1}+" does not match in ActLog "+$RemotelIds_atxt{$loop_L}+Char:C90(13))
			End if 
		: (Size of array:C274($possibleDestIDS_atxt)>1)
			ut_Message("!!!! ERROR !!! Local ID  points to more than one ("+String:C10(Size of array:C274($possibleDestIDS_atxt))+") Remote ID!!! "+Char:C90(13))
	End case 
	
End for 
//stop the progress bar
POST OUTSIDE CALL:C329(<>ProgressPID)
ut_Message(ut_CreateTimeStamp+" : Found  "+String:C10(Size of array:C274($BadLocalIDs_atxt))+" bad pairs of FileIDRes."+Char:C90(13))
ut_Message(ut_CreateTimeStamp+" : Found  "+String:C10(Size of array:C274($NeedReSendLocalIDS_atxt))+" IDs of records that should be re-sent. "+Char:C90(13))

//FIx FIleIDDDRes first
C_LONGINT:C283($loop_L)
C_BOOLEAN:C305($ApplyFix_b; bStuff)
If (Size of array:C274($BadLocalIDs_atxt)>0)
	//CONFIRM("Apply Fixes on FileIDRes table to database?";"Apply";"Just Log")
	$ApplyFix_b:=bStuff
	For ($loop_L; 1; Size of array:C274($BadLocalIDs_atxt))
		ut_Message("Pair "+String:C10($loop_L)+" LocalID = "+$BadLocalIDs_atxt{$loop_L}+" RemoteID = "+$BadRemoteIDs_atxt{$loop_L})
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$Tbl_L; *)
		QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4#"here"; *)
		QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Local ID:2=$BadLocalIDs_atxt{$loop_L}; *)
		QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination ID:3=$BadRemoteIDs_atxt{$loop_L})
		If (Records in selection:C76([FileIDRes Table:60])=1)
			If ($ApplyFix_b)
				ut_ResetFileIDResRecords
			End if 
			ut_Message("-Cleared FileID res Dest=NOT HERE , LocalID="+$BadLocalIDs_atxt{$loop_L}+", RemoteID="+$BadRemoteIDs_atxt{$loop_L}+Char:C90(13))
		Else 
			//ALERT("  `Why not found?")
			ut_Message("!!!!ERROR!!!  Could not find  pair for Dest=NOT HERE , LocalID="+$BadLocalIDs_atxt{$loop_L}+", RemoteID="+$BadRemoteIDs_atxt{$loop_L}+Char:C90(13))
		End if 
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$Tbl_L; *)
		QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4="here"; *)
		QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination ID:3=$BadLocalIDs_atxt{$loop_L}; *)
		QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Local ID:2=$BadRemoteIDs_atxt{$loop_L})
		If (Records in selection:C76([FileIDRes Table:60])=1)
			If ($ApplyFix_b)
				ut_ResetFileIDResRecords
			End if 
			ut_Message("-Cleared FileID res Dest=HERE , LocalID="+$BadLocalIDs_atxt{$loop_L}+", RemoteID="+$BadRemoteIDs_atxt{$loop_L}+Char:C90(13))
		Else 
			//ALERT("  `Why not found?")
			ut_Message("!!!!ERROR!!!  Could not find  pair for Dest=HERE , LocalID="+$BadLocalIDs_atxt{$loop_L}+", RemoteID="+$BadRemoteIDs_atxt{$loop_L}+Char:C90(13))
		End if 
		
	End for 
	
End if 

//Relog the records that need to be re-sent - if not found means they are deleted. 
//check if there is a drc record and just enable it - what to do with GRP ? or get the NRC , get the parentID from NRC record and create a DRC?
C_POINTER:C301($parentTbl_ptr; $ParentkeyFld_ptr; $LocalFK_ptr)
C_LONGINT:C283($LocalID_L; $ParentID_L)
C_TEXT:C284($ParentID_txt)
If (Size of array:C274($NeedReSendLocalIDS_atxt)>0)
	//CONFIRM("Set "+String(Size of array($NeedReSendLocalIDS_atxt))+" ActLog records to send  again?";"SetToSend";"Just Log")
	//$ApplyFix_b:=(OK=1)
	For ($loop_L; 1; Size of array:C274($NeedReSendLocalIDS_atxt))
		$LocalID_L:=Num:C11($NeedReSendLocalIDS_atxt{$loop_L})
		//Find NRC record - will give info on the fields
		//QUERY([Activity Log];[Activity Log]Local ID=$NeedReSendLocalIDS_atxt{$loop_L};*)
		//QUERY([Activity Log]; & ;[Activity Log]FileID Local=$Tbl_L)
		//$parentTbl_ptr:=Table([Activity Log]FileID Parent)
		//$LocalFK_ptr:=Field($Tbl_L;[Activity Log]FieldID Parent)
		//$ParentID_L:=Num([Activity Log]Parent ID)
		
		//search for record
		QUERY:C277($tbl_ptr->; $keyFld_ptr->=$LocalID_L)
		READ WRITE:C146([Activity Log:59])
		
		If (Records in selection:C76($tbl_ptr->)=1)
			ut_Message("Record exists for ID "+$NeedReSendLocalIDS_atxt{$loop_L}+Char:C90(13))
			
			//find act log records not NRC that belong to this ID
			QUERY:C277([Activity Log:59]; [Activity Log:59]Local ID:15=$NeedReSendLocalIDS_atxt{$loop_L}; *)
			QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=$Tbl_L; *)
			QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3#"NRC")
			
			If (Records in selection:C76([Activity Log:59])>0)
				ut_Message("For ID "+$NeedReSendLocalIDS_atxt{$loop_L}+" found "+String:C10(Records in selection:C76([Activity Log:59]))+" non-NRC Act log records."+Char:C90(13))
				FIRST RECORD:C50([Activity Log:59])
				While (Not:C34(End selection:C36([Activity Log:59])))
					ut_Message("found RefID "+String:C10([Activity Log:59]RefID:28)+" Type :"+[Activity Log:59]Activity Type:3+" record"+Char:C90(13))
					If ($ApplyFix_b)
						[Activity Log:59]Status:9:=0
						SAVE RECORD:C53([Activity Log:59])
					End if 
					NEXT RECORD:C51([Activity Log:59])
				End while 
				
			Else 
				ut_Message("!!! ERROR !!! For ID "+$NeedReSendLocalIDS_atxt{$loop_L}+" did not find any non-NRC Act log records."+Char:C90(13))
			End if 
			
		Else 
			ut_Message("Record does not exist for ID "+$NeedReSendLocalIDS_atxt{$loop_L}+Char:C90(13))
			
			//delete it 
			//look for a DRC first
			QUERY:C277([Activity Log:59]; [Activity Log:59]Local ID:15=$NeedReSendLocalIDS_atxt{$loop_L}; *)
			QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=$Tbl_L; *)
			QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3="DRC")
			If (Records in selection:C76([Activity Log:59])>0)
				//only need to do first one
				ut_Message("For ID "+$NeedReSendLocalIDS_atxt{$loop_L}+" found "+String:C10(Records in selection:C76([Activity Log:59]))+" DRC Act log records."+Char:C90(13))
				FIRST RECORD:C50([Activity Log:59])
				ut_Message("found  RefID "+String:C10([Activity Log:59]RefID:28)+" Type :"+[Activity Log:59]Activity Type:3+" record"+Char:C90(13))
				
				If ($ApplyFix_b)
					[Activity Log:59]Status:9:=0
					SAVE RECORD:C53([Activity Log:59])
				End if 
				UNLOAD RECORD:C212([Activity Log:59])
			Else 
				//look for GRD records for parent
				QUERY:C277([Activity Log:59]; [Activity Log:59]Local ID:15=$NeedReSendLocalIDS_atxt{$loop_L}; *)
				QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=$Tbl_L; *)
				QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3="NRC")
				$ParentID_txt:=[Activity Log:59]Parent ID:14
				QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$Tbl_L; *)
				QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3="GRD"; *)
				QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=$ParentID_txt)
				
				If (Records in selection:C76([Activity Log:59])>0)
					//check if this ID is in there
					ut_Message("Found "+String:C10(Records in selection:C76([Activity Log:59]))+" GRD Act log records."+Char:C90(13))
					C_BLOB:C604($data_x)
					C_LONGINT:C283($offset_L; $FoundInArr_L)
					$offset_L:=0
					$FoundInArr_L:=0
					ARRAY LONGINT:C221($DeletedIDs_aL; 0)
					FIRST RECORD:C50([Activity Log:59])
					
					C_LONGINT:C283($loop2_L)
					For ($loop2_L; 1; Records in selection:C76([Activity Log:59]))
						$data_x:=[Activity Log:59]Data:10
						BLOB TO VARIABLE:C533($data_x; $DeletedIDs_aL; $offset_L)
						$FoundInArr_L:=Find in array:C230($DeletedIDs_aL; Num:C11($NeedReSendLocalIDS_atxt{$loop_L}))
						If ($FoundInArr_L>0)
							//the ID is in there - just resend this one and done searching
							ut_Message("found RefID "+String:C10([Activity Log:59]RefID:28)+" Type :"+[Activity Log:59]Activity Type:3+" record with local id "+$NeedReSendLocalIDS_atxt{$loop_L}+Char:C90(13))
							If ($ApplyFix_b)
								[Activity Log:59]Status:9:=0
								SAVE RECORD:C53([Activity Log:59])
							End if 
							$loop2_L:=Records in selection:C76([Activity Log:59])+1
						End if 
						NEXT RECORD:C51([Activity Log:59])
					End for 
					If ($FoundInArr_L>0)
					Else 
						//did not find a GRD record !!!!
						ut_Message("!!! ERROR !!! For ID "+$NeedReSendLocalIDS_atxt{$loop_L}+" did not find a reference in any GRD Act log records."+Char:C90(13))
					End if 
				Else 
					//did not find a GRD record !either !!!
					ut_Message("!!! ERROR !!! For ID "+$NeedReSendLocalIDS_atxt{$loop_L}+" did not find any DRC or  GRD  Act log records."+Char:C90(13))
				End if 
				
			End if 
			
		End if 
		
	End for 
	
End if 

ut_CloseMessage

//End ut_FixFileIDRes_pt2