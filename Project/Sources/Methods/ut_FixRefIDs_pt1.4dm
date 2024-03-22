//%attributes = {"invisible":true}
//Method: ut_FixRefIDs_pt1
//Description
// fixes the "receiving" part where NRC records were received from the server but could not be updated 
// due to duplicates in FileIDres
// Parameters
// $1 : $Table_ptr
// $2 : $KeyField_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/04/16, 13:14:48
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
	
	//Compiler Declarations
	C_POINTER:C301(ut_FixRefIDs_pt1; $1)
	C_POINTER:C301(ut_FixRefIDs_pt1; $2)
	
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
ARRAY TEXT:C222($badpairLocal_atxt; 0)
ARRAY TEXT:C222($badPairRemote_atxt; 0)
ut_StartMessage(3; ("Receive Table "+Table name:C256($Tbl_L)+" "+ut_CreateTimeStamp))

QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$Tbl_L; *)
QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Activity Type:3="NRC")

QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Source:2=<>Destination)

ut_Message(ut_CreateTimeStamp+" : Found "+String:C10(Records in selection:C76([Activity Log:59]))+" Act Log NRC records coming from server "+<>Destination+Char:C90(13))

SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $LocalIds_atxt)
ARRAY LONGINT:C221($SearchIDS_aL; Size of array:C274($LocalIds_atxt))
C_LONGINT:C283($loop_L; $NonNRCCount_L)
For ($loop_L; 1; Size of array:C274($LocalIds_atxt))
	$SearchIDS_aL{$loop_L}:=Num:C11($LocalIds_atxt{$loop_L})
End for 
//work only with records that were actually created - there are NRC records that were actually not created. 
QUERY WITH ARRAY:C644($keyFld_ptr->; $SearchIDS_aL)
ut_Message(ut_CreateTimeStamp+" : Found "+String:C10(Records in selection:C76($tbl_ptr->))+" records in table "+Table name:C256($tbl_ptr)+Char:C90(13))
SELECTION TO ARRAY:C260($keyFld_ptr->; $SearchIDS_aL)
ARRAY TEXT:C222($LocalIds_atxt; 0)
ARRAY TEXT:C222($LocalIds_atxt; Size of array:C274($SearchIDS_aL))

For ($loop_L; 1; Size of array:C274($SearchIDS_aL))
	$LocalIds_atxt{$loop_L}:=String:C10($SearchIDS_aL{$loop_L})
End for 

SET QUERY DESTINATION:C396(Into set:K19:2; "ACTLOGNONNRC")
QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$Tbl_L; *)
QUERY:C277([Activity Log:59]; [Activity Log:59]Activity Type:3#"NRC")
SET QUERY DESTINATION:C396(Into current selection:K19:1)

ARRAY TEXT:C222($NeedReloadLocalIDS_atxt; 0)
C_TEXT:C284($localID_txt; $ActType_txt)
$ActType_txt:="NRC"
//start the bar
C_LONGINT:C283(<>ProgressPID)
<>ProgressPID:=StartProgress("Scanning Act Log for IDs"; "NONE"; "Searching through "+String:C10(Size of array:C274($LocalIds_atxt))+" IDs"; "Number of IDs left")
//initialize the bar
UpdateProgress(0; Size of array:C274($LocalIds_atxt))

For ($loop_L; 1; Size of array:C274($LocalIds_atxt))
	If (($loop_L%20)=0)
		//update the bar
		UpdateProgress($loop_L; Size of array:C274($LocalIds_atxt))
	End if 
	$localID_txt:=$LocalIds_atxt{$loop_L}
	$NonNRCCount_L:=0
	USE SET:C118("ACTLOGNONNRC")
	SET QUERY DESTINATION:C396(Into variable:K19:4; $NonNRCCount_L)
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Local ID:15=$localID_txt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If (False:C215)
		Begin SQL
			select count(*)
			from [Activity Log]
			where
			[Activity Log].[FileID Local] = :$Tbl_L
			and [Activity Log].[Activity Type]  <> :$ActType_txt
			and [Activity Log].[Local ID] = :$localID_txt
			into :$NonNRCCount_L
			
		End SQL
		
	End if 
	If ($NonNRCCount_L=0)
		ut_Message("Found  Local ID "+$LocalIds_atxt{$loop_L}+" with no other act log records."+Char:C90(13))
		APPEND TO ARRAY:C911($NeedReloadLocalIDS_atxt; $LocalIds_atxt{$loop_L})
	End if 
End for 
//stop the progress bar
POST OUTSIDE CALL:C329(<>ProgressPID)
CLEAR SET:C117("ACTLOGNONNRC")

ut_Message(ut_CreateTimeStamp+" : Found Total "+String:C10(Size of array:C274($NeedReloadLocalIDS_atxt))+" Act Log Records with only NRC."+Char:C90(13))
C_BOOLEAN:C305(SQLError_b; SQLConnectionMade_b)

//clean FileIDRes table first
C_TEXT:C284($remoteID_txt; $Dest_txt)
$Dest_txt:="here"
For ($loop_L; 1; Size of array:C274($NeedReloadLocalIDS_atxt))
	ARRAY TEXT:C222($RemoteIDS_atxt; 0)
	$localID_txt:=$NeedReloadLocalIDS_atxt{$loop_L}
	ut_Message("Checking Local ID "+$localID_txt+Char:C90(13))
	Begin SQL
		select  
		[FileIDRes Table].[Destination ID]
		from
		[FileIDRes Table]
		where
		[FileIDRes Table].[File Number] = :$Tbl_L
		and 
		[FileIDRes Table].[Destination] <> :$Dest_txt
		and [FileIDRes Table].[Local ID] = :$localID_txt
		into :$RemoteIDS_atxt ;
	End SQL
	
	//there should only be one remoteID for this local record
	Case of 
		: (Size of array:C274($RemoteIDS_atxt)=0)
			ut_Message("!!!ERROR !!!!  Could not find Remote IDs for Local ID "+$localID_txt+Char:C90(13))
		: (Size of array:C274($RemoteIDS_atxt)>1)
			ut_Message("!!!ERROR !!!!  Found Multiple Remote IDs "+String:C10(Size of array:C274($RemoteIDS_atxt))+"  for Local ID "+$localID_txt+Char:C90(13))
		: (Size of array:C274($RemoteIDS_atxt)=1)
			//search for other locals matching the same remote
			$remoteID_txt:=$RemoteIDS_atxt{1}
			ARRAY TEXT:C222($OtherLocalIDs_atxt; 0)
			Begin SQL
				select  
				[FileIDRes Table].[Local ID]
				from
				[FileIDRes Table]
				where
				[FileIDRes Table].[File Number] = :$Tbl_L
				and 
				[FileIDRes Table].[Destination] <> :$Dest_txt
				and [FileIDRes Table].[Destination ID] = :$remoteID_txt
				into :$OtherLocalIDs_atxt ;
				
			End SQL
			C_LONGINT:C283($loop2_L; $LocalIDSearch_L)
			For ($loop2_L; 1; Size of array:C274($OtherLocalIDs_atxt))
				//look for records in the table with other local id
				If ($OtherLocalIDs_atxt{$loop2_L}#$localID_txt)
					$LocalIDSearch_L:=Num:C11($OtherLocalIDs_atxt{$loop2_L})
					QUERY:C277($tbl_ptr->; $keyFld_ptr->=$LocalIDSearch_L)
					If (Records in selection:C76($tbl_ptr->)=0)
						//there is no local record in the table :
						//this is a bad pair $OtherLocalIDs_atxt{$loop2_L} / $remoteID_txt
						APPEND TO ARRAY:C911($badpairLocal_atxt; $OtherLocalIDs_atxt{$loop2_L})
						APPEND TO ARRAY:C911($badPairRemote_atxt; $remoteID_txt)
						ut_Message("Found bad pair in File ID res : Local ID="+$OtherLocalIDs_atxt{$loop2_L}+" , Remote ID="+$remoteID_txt+Char:C90(13))
					Else 
						//This is also Bad!!! there are two existing local records that point to same remote record ! Don't know which is the correct one
						ut_Message("!!!ERROR !!!!  Found existing record with ID  "+String:C10($LocalIDSearch_L)+"  which points to same remote ID "+$remoteID_txt+" as record with ID "+$localID_txt+Char:C90(13))
						
					End if 
				End if 
				
			End for 
			
	End case 
	
End for 
//now we have two arrays of bad FileID pairs
ut_Message(ut_CreateTimeStamp+" : Found  "+String:C10(Size of array:C274($badPairRemote_atxt))+"  Bad FileID Res Pairs "+Char:C90(13))

C_BOOLEAN:C305($ApplyFix_b; bStuff)
//CONFIRM("Apply Fixes?";"Apply";"Just log to file")
$ApplyFix_b:=bStuff
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($badpairLocal_atxt))
	QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$Tbl_L; *)
	QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4#"here"; *)
	QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Local ID:2=$badpairLocal_atxt{$loop_L}; *)
	QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination ID:3=$badPairRemote_atxt{$loop_L})
	If (Records in selection:C76([FileIDRes Table:60])=1)
		If ($ApplyFix_b)
			ut_ResetFileIDResRecords
		End if 
		ut_Message("-Cleared FileID res Dest=NOT HERE , LocalID="+$badpairLocal_atxt{$loop_L}+", RemoteID="+$badPairRemote_atxt{$loop_L}+Char:C90(13))
	Else 
		ALERT:C41("  `Why not found?")
		ut_Message("!!!!ERROR!!!  Could not find  pair for Dest=NOT HERE , LocalID="+$badpairLocal_atxt{$loop_L}+", RemoteID="+$badPairRemote_atxt{$loop_L}+Char:C90(13))
	End if 
	
	QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$Tbl_L; *)
	QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4="here"; *)
	QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination ID:3=$badpairLocal_atxt{$loop_L}; *)
	QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Local ID:2=$badPairRemote_atxt{$loop_L})
	If (Records in selection:C76([FileIDRes Table:60])=1)
		If ($ApplyFix_b)
			ut_ResetFileIDResRecords
		End if 
		ut_Message("-Cleared FileID res Dest=HERE , LocalID="+$badpairLocal_atxt{$loop_L}+", RemoteID="+$badPairRemote_atxt{$loop_L}+Char:C90(13))
	Else 
		ALERT:C41("  `Why not found?")
		ut_Message("!!!!ERROR!!!  Could not find  pair for Dest=HERE , LocalID="+$badpairLocal_atxt{$loop_L}+", RemoteID="+$badPairRemote_atxt{$loop_L}+Char:C90(13))
	End if 
End for 
//now we need to  get back the records from the server or just refresh the record from the server???

C_LONGINT:C283($remoteID_L)
If (Size of array:C274($NeedReloadLocalIDS_atxt)>0)
	ut_Message(ut_CreateTimeStamp+" : Resetting act log records in server"+Char:C90(13))
	//connect to  server
	//$IPAddress_txt:=SQL_TestConnection 
	C_TEXT:C284($IPAddress_txt; TRANSF_DestIP_txt)
	If (TRANSF_DestIP_txt#"")
		
		$IPAddress_txt:=TRANSF_DestIP_txt
	Else 
		$IPAddress_txt:=<>DestIP
		CONFIRM:C162("Use IP address "+<>DestIP)
		If (OK=0)
			$IPAddress_txt:=SQL_TestConnection
		End if 
	End if 
	C_BOOLEAN:C305(SQLConnectionMade_b)
	ut_Message("Connecting to server at "+$IPAddress_txt+Char:C90(13))
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	If (SQLConnectionMade_b)
		ut_Message("Connected to server at "+$IPAddress_txt+Char:C90(13))
		
		For ($loop_L; 1; Size of array:C274($NeedReloadLocalIDS_atxt))
			//find the remote  ID
			ut_Message("working on local ID  "+$NeedReloadLocalIDS_atxt{$loop_L}+Char:C90(13))
			QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$Tbl_L; *)
			QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4#"here"; *)
			QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Local ID:2=$NeedReloadLocalIDS_atxt{$loop_L})
			$remoteID_txt:=[FileIDRes Table:60]Destination ID:3
			ut_Message("Remote ID ="+$remoteID_txt+Char:C90(13))
			$remoteID_L:=Num:C11($remoteID_txt)
			ARRAY LONGINT:C221($RemoteActLogIDs_aL; 0)
			$ActType_txt:="NRC"
			Begin SQL
				select
				[Activity Log].[RefID]
				from
				[Activity Log]
				where
				[Activity Log].[FileID Local] = :$tbl_L
				and [Activity Log].[Activity Type] <> :$ActType_txt
				and [Activity Log].[Local ID] = :$remoteID_txt
				into :$RemoteActLogIDs_aL ;
			End SQL
			ut_Message("There are "+String:C10(Size of array:C274($RemoteActLogIDs_aL))+" Act Log NOT NRC records for RemoteID="+$remoteID_txt+Char:C90(13))
			
			If (Size of array:C274($RemoteActLogIDs_aL)>0)
				
				C_LONGINT:C283($loop2_L; $RefID_L)
				C_TEXT:C284($moduser_txt; $user_txt)
				$user_txt:=<>TxUserName
				$moduser_txt:=Substring:C12("NOT "+<>TxUserName; 1; 80)
				For ($loop2_L; 1; Size of array:C274($RemoteActLogIDs_aL))
					ut_Message("Resetting OwnersOfData for ActLog RefID="+String:C10($RemoteActLogIDs_aL{$loop2_L})+Char:C90(13))
					$RefID_L:=$RemoteActLogIDs_aL{$loop2_L}
					If ($ApplyFix_b)
						Begin SQL
							update [Owners of Data]
							set [Owner Name] = :$moduser_txt
							where
							[Owners of Data].[Owner Name] = :$user_txt
							and 
							[Owners of Data].[RefID] = :$RefID_L ;
						End SQL
						
					End if 
					
				End for 
				
			End if 
			
		End for 
		
		ut_SQLLogout
	End if 
End if 

ut_Message(ut_CreateTimeStamp+" : Scan complete!"+Char:C90(13))

ut_CloseMessage

//End ut_FixRefIDs_pt1