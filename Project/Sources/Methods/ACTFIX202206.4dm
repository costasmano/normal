//%attributes = {"invisible":true}
//Method: ACTFIX202206
//Description
// Fix Activity log transfers by clearing activity refids from Owners of data table.
// Activity log records were not downloaded for the user because they were still 
// reserved in a transaction on the server when a download was executed.
// This method will find which records were missed, and then clear record IDs for 
// downstream activity records that were downloaded.  
// If that is not done, earlier activity will overwrite the later one.
// Keep track of whether the method was completed in parameter ACTFIX202206
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jun 14, 2022, 09:14:45
	
	Mods_2022_06
	
	// ----------------------------------------------------
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-06-17 10:07:09)
	Mods_2022_06
	//  `added log file at the end  and parent id in the RecordSearch array
	// Modified by: Costas Manousakis-(Designer)-(2022-06-27 09:37:30)
	Mods_2022_06
	//  `when saving parameter ACTFIX202206  mark the act log records created with Destination=notransfer and set Status=1
	// Modified by: Costas Manousakis-(Designer)-(2022-06-28 10:18:48)
	Mods_2022_06
	//  `fixed code saving param record; changed vars used in Execute immediate commands to process variables
	// Modified by: Costas Manousakis-(Designer)-(2023-11-28 17:00:58)
	Mods_2023_11
	//  `when clearing OwnerRefIDs , group the $clearOwnRefIds_aL array into groups of 100 to avoid crashing the SQL buffer
End if 
//
C_BOOLEAN:C305($RunFix_b)
C_TEXT:C284($savedPAram_txt)
$savedPAram_txt:=ut_GetSysParameter("ACTFIX202206")
$RunFix_b:=($savedPAram_txt#"DONE")

If ($RunFix_b)
	ARRAY LONGINT:C221(v_59_028_aL; 0)  //v_59_028_aL
	ARRAY LONGINT:C221(v_62_001_aL; 0)  //v_62_001_aL
	ARRAY LONGINT:C221(v_59_024_aL; 0)  //v_59_024_aL
	ARRAY TEXT:C222(v_59_015_atxt; 0)  //v_59_015_atxt
	ARRAY TEXT:C222(v_59_014_atxt; 0)  //v_59_014_atxt
	ARRAY TEXT:C222(v_59_003_atxt; 0)  //v_59_003_atxt
	C_TEXT:C284($distr; $user; $myforward; $sql_txt; $end_txt; $where_txt)
	
	$myforward:=<>Forward
	$user:=<>TxUserName
	//start the bar
	C_OBJECT:C1216($Progress_o)
	$Progress_o:=ProgressNew("Downloads fix for "+$user+" , "+$myforward; 1; False:C215; ""; 0)
	
	Progress SET PROGRESS($Progress_o.progress; -1; "Connecting to Server"; False:C215)  //moving bar with -1
	C_TEXT:C284($loginuser; $password)
	$loginuser:=Char:C90(Character code:C91("f"))+\
		Char:C90(Character code:C91("h"))+\
		Char:C90(Character code:C91("w"))+\
		Char:C90(Character code:C91("a"))
	
	$password:=Char:C90(Character code:C91("d"))+\
		Char:C90(Character code:C91("e"))+\
		Char:C90(Character code:C91("l"))+\
		Char:C90(Character code:C91("p"))+\
		Char:C90(Character code:C91("h"))+\
		Char:C90(Character code:C91("i"))
	
	SQL LOGIN:C817("IP:"+<>DestIP; "fhwa"; $password; *)
	
	ARRAY TEXT:C222($Distr_atxt; 0)
	ut_TextToArray($myforward; ->$Distr_atxt; ",")
	
	$sql_txt:="select RefID, [FileID Local], [Local ID], [Parent ID], [Activity Type] "+\
		"from [Activity Log] where "
	
	$where_txt:="[Activity Log].[Forward] like  '%"+$Distr_atxt{1}+"%' "
	C_LONGINT:C283($loop_L)
	For ($loop_L; 2; Size of array:C274($Distr_atxt))
		$where_txt:=$where_txt+" OR [Activity Log].[Forward] like  '%"+$Distr_atxt{$loop_L}+"%' "
	End for 
	$end_txt:="order by RefID ASC into :v_59_028_aL , :v_59_024_aL ,:v_59_015_atxt, :v_59_014_atxt, :v_59_003_atxt ; "
	C_LONGINT:C283($startMS; $endMs)
	$sql_txt:=$sql_txt+$where_txt+$end_txt
	
	//**** Retrieve server act log data for my Forward setting
	
	Progress SET MESSAGE($Progress_o.progress; "Getting Activity log records..")
	$startMS:=Milliseconds:C459
	Begin SQL
		
		execute IMMEDIATE :$sql_txt
		
	End SQL
	
	$endMs:=Milliseconds:C459
	Progress SET MESSAGE($Progress_o.progress; "Got "+String:C10(Size of array:C274(v_59_028_aL); "###,###,###,###")+" Activitylog data for "+$myforward+" "+String:C10($endMs-$startMS; "###,###,###,###,### ms"))
	
	
	//**** Build a search array
	
	$startMS:=Milliseconds:C459
	ARRAY TEXT:C222($RecSearch_atxt; Size of array:C274(v_59_028_aL))
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274(v_59_028_aL))
		$RecSearch_atxt{$loop_L}:="T:"+String:C10(v_59_024_aL{$loop_L})+" ID:"+v_59_015_atxt{$loop_L}+" PID:"+v_59_014_atxt{$loop_L}
	End for 
	$endMs:=Milliseconds:C459
	Progress SET MESSAGE($Progress_o.progress; "Fill "+String:C10(Size of array:C274(v_59_028_aL); "###,###,###,###")+" search array "+String:C10($endMs-$startMS; "###,###,###,###,### ms"))
	
	//**** Retrieve server Owners of Data records for current user
	
	$startMS:=Milliseconds:C459
	Progress SET MESSAGE($Progress_o.progress; "Getting downloaded Ids..")
	
	Begin SQL
		select 
		[Owners of Data].[RefID]
		from
		[Owners of Data] /*, [Activity Log] */
		where [Owners of Data].[Owner Name] = :$user
		/*
		and  [Activity Log].[Status] = -1
		and [Activity Log].RefID= [Owners of Data].RefID
		*/
		order by [Owners of Data].[RefID] ASC
		into :v_62_001_aL ;
		
	End SQL
	$endMs:=Milliseconds:C459
	Progress SET MESSAGE($Progress_o.progress; "Get "+String:C10(Size of array:C274(v_62_001_aL); "###,###,###,###;0;0")+" downloaded entries for "+$user+" "+String:C10($endMs-$startMS; "###,###,###,###,### ms"))
	//ALERT("Get "+String(Size of array(v_62_001_aL);"###,###,###,###;0;0")+" downloaded entries for "+$user+" "+String($endMs-$startMS;"###,###,###,###,### ms"))
	
	If (Size of array:C274(v_62_001_aL)>0)
		$startMS:=Milliseconds:C459
		
		C_LONGINT:C283($lastOwnedID)
		$lastOwnedID:=v_62_001_aL{Size of array:C274(v_62_001_aL)}
		ARRAY LONGINT:C221($missingRefIDs_aL; 0)
		ARRAY TEXT:C222($missingRecSearch_atxt; 0)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(v_59_028_aL))
			If (v_59_028_aL{$loop_L}>$lastOwnedID)
				$loop_L:=Size of array:C274(v_59_028_aL)+1
			Else 
				If (Find in array:C230(v_62_001_aL; v_59_028_aL{$loop_L})>0)
					
				Else 
					APPEND TO ARRAY:C911($missingRecSearch_atxt; $RecSearch_atxt{$loop_L})
					APPEND TO ARRAY:C911($missingRefIDs_aL; v_59_028_aL{$loop_L})
				End if 
				
			End if 
		End for 
		
		SORT ARRAY:C229($missingRefIDs_aL)
		
		$endMs:=Milliseconds:C459
		Progress SET MESSAGE($Progress_o.progress; "Get "+String:C10(Size of array:C274($missingRefIDs_aL); "###,###,###,###;0;0")+" missing records "+String:C10($endMs-$startMS; "###,###,###,###,### ms"))
		//ALERT("Get "+String(Size of array($missingRefIDs_aL);"###,###,###,###;0;0")+" missing records "+String($endMs-$startMS;"###,###,###,###,### ms"))
		
		If (Size of array:C274($missingRefIDs_aL)>0)
			ARRAY LONGINT:C221($clearOwnRefIds_aL; 0)
			ARRAY TEXT:C222($RecordKeys_atxt; 0)  // array to hold table# and recordIDs which are downstream from the missing act log records
			$startMS:=Milliseconds:C459
			
			C_LONGINT:C283($loop_L; $actLog1; $next)
			C_TEXT:C284($match_txt)
			For ($loop_L; 1; Size of array:C274($missingRefIDs_aL))
				$actLog1:=Find in array:C230(v_59_028_aL; $missingRefIDs_aL{$loop_L})
				$match_txt:=$RecSearch_atxt{$actLog1}
				$next:=Find in array:C230($RecSearch_atxt; $match_txt; ($actLog1+1))
				
				If ($next>0)
					Repeat 
						
						If (Find in array:C230($missingRefIDs_aL; v_59_028_aL{$next})>0)
							//one of the missing refIDS
						Else 
							//check if it is one that we downloaded
							
							If (Find in array:C230(v_62_001_aL; v_59_028_aL{$next})>0)
								//we have downloaded it, should clear it if it's not marked to be cleared yet
								If (Find in array:C230($clearOwnRefIds_aL; v_59_028_aL{$next})<0)
									
									APPEND TO ARRAY:C911($RecordKeys_atxt; $match_txt)
									APPEND TO ARRAY:C911($clearOwnRefIds_aL; v_59_028_aL{$next})
								End if 
								
							End if 
							
						End if 
						$actLog1:=$next
						$next:=Find in array:C230($RecSearch_atxt; $match_txt; ($actLog1+1))
					Until ($next<0)
					
				End if 
				
			End for 
			
			$endMs:=Milliseconds:C459
			Progress SET MESSAGE($Progress_o.progress; "Find "+String:C10(Size of array:C274($clearOwnRefIds_aL); "###,###,###,###;0;0")+" Ids to clear "+String:C10($endMs-$startMS; "###,###,###,###,### ms"))
			//ALERT("Find "+String(Size of array($clearOwnRefIds_aL);"###,###,###,###;0;0")+" Ids to clear "+String($endMs-$startMS;"###,###,###,###,### ms"))
			
			
			If (Size of array:C274($clearOwnRefIds_aL)>0)
				
				Progress SET MESSAGE($Progress_o.progress; "Checking "+String:C10(Size of array:C274($clearOwnRefIds_aL); "###,###,###,###;0;0")+" Ids to be cleared")
				
				// start of Mods_2023_11
				
				C_TEXT:C284(v_62_002_txt)
				v_62_002_txt:=$user
				
				//split in groups of $groupBy_L
				C_LONGINT:C283($group_L; $groupBy_L)
				$groupBy_L:=100
				ARRAY LONGINT:C221($temp_aL; 0)
				$group_L:=0  //initialize group counter
				Repeat 
					$group_L:=$group_L+1
					COPY ARRAY:C226($clearOwnRefIds_aL; $temp_aL)
					If ($group_L>1)
						DELETE FROM ARRAY:C228($temp_aL; 1; (($group_L-1)*$groupBy_L))  // delete from top
					End if 
					If (Size of array:C274($temp_aL)>$groupBy_L)
						DELETE FROM ARRAY:C228($temp_aL; ($groupBy_L+1); Size of array:C274($temp_aL))  // delete trailing
					End if 
					
					C_TEXT:C284($in_txt)
					$in_txt:=ut_ArrayToText(->$temp_aL; ",")
					
					// verify how many records will be deleted
					C_LONGINT:C283(v_62_001_L)
					$sql_txt:="select count(*) from [Owners of Data] where RefID in ("+$in_txt+\
						") and [Owners of Data].[Owner Name] = :v_62_002_txt into :v_62_001_L ;"
					Begin SQL
						execute IMMEDIATE :$sql_txt
					End SQL
					
					
					$sql_txt:="delete from [Owners of Data] where RefID in ("+$in_txt+\
						") and [Owners of Data].[Owner Name] = :v_62_002_txt ;"
					
					Progress SET MESSAGE($Progress_o.progress; \
						"Deleting "+String:C10(Size of array:C274($temp_aL); "###,###,###,###;0;0")+" downloaded Ids for user "+$user)
					$startMS:=Milliseconds:C459
					Begin SQL
						execute IMMEDIATE :$sql_txt
					End SQL
					$endMs:=Milliseconds:C459
					Progress SET MESSAGE($Progress_o.progress; "Deleted "+String:C10(Size of array:C274($temp_aL); "###,###,###,###;0;0")+" downloaded Ids"+String:C10($endMs-$startMS; "###,###,###,###,### ms"))
					
				Until (($group_L*$groupBy_L)>=Size of array:C274($clearOwnRefIds_aL))
				
				// end of Mods_2023_11
				
				//save data to a log file next to the data file
				C_TEXT:C284($missing_txt; $RecordKeys_txt; $clearOwnRefIds_txt)
				//change arrays to lines of text
				$missing_txt:=ut_ArraysToText(Char:C90(Tab:K15:37); ->$missingRefIDs_aL; ->$missingRecSearch_atxt)
				$clearOwnRefIds_txt:=ut_ArraysToText(Char:C90(Tab:K15:37); ->$clearOwnRefIds_aL; ->$RecordKeys_atxt)
				C_TEXT:C284($logFile_txt)
				$logFile_txt:=Get 4D folder:C485(Data folder:K5:33)+"ACTFIX202206-"+ut_CreateTimeStamp+".log"
				$missing_txt:="Missing ActLog RefIDs , Tbl#, LocalID, Parent ID"+Char:C90(Carriage return:K15:38)+\
					$missing_txt+Char:C90(Carriage return:K15:38)+\
					"Activity log RefIDs , Tbl#, LocalID, Parent ID to be cleared from Owners of data for user "+$user+Char:C90(Carriage return:K15:38)+\
					$clearOwnRefIds_txt
				C_BLOB:C604($docBlob)
				TEXT TO BLOB:C554($missing_txt; $docBlob; UTF8 text without length:K22:17)
				BLOB TO DOCUMENT:C526($logFile_txt; $docBlob)
				//SHOW ON DISK($logFile_txt)
			End if 
			
		End if 
		
	End if 
	
	SQL LOGOUT:C872
	
	C_TEXT:C284($SaveDest_txt)
	$SaveDest_txt:=<>Destination
	<>Destination:="NOTRANSFER"
	ut_SaveSysParam("ACTFIX202206"; "DONE")  //mark that we run this once
	<>Destination:=$SaveDest_txt
	QUERY:C277([Activity Log:59]; [Activity Log:59]Local ID:15="ACTFIX202206")
	If (Records in selection:C76([Activity Log:59])>0)
		FIRST RECORD:C50([Activity Log:59])
		While (Not:C34(End selection:C36([Activity Log:59])))
			If (ut_LoadRecordInteractive(->[Activity Log:59]))
				[Activity Log:59]Status:9:=1
				SAVE RECORD:C53([Activity Log:59])
			End if 
			NEXT RECORD:C51([Activity Log:59])
		End while 
		
	End if 
	
	//quit progress
	Progress QUIT($Progress_o.progress)
	
Else 
	//it has been done - check to see if we need to fix the destination in activity log
	QUERY:C277([Activity Log:59]; [Activity Log:59]Local ID:15="ACTFIX202206"; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Destination:1=<>Destination)
	If (Records in selection:C76([Activity Log:59])>0)
		FIRST RECORD:C50([Activity Log:59])
		While (Not:C34(End selection:C36([Activity Log:59])))
			If (ut_LoadRecordInteractive(->[Activity Log:59]))
				[Activity Log:59]Destination:1:="NOTRANSFER"
				[Activity Log:59]Status:9:=1
				SAVE RECORD:C53([Activity Log:59])
			End if 
			NEXT RECORD:C51([Activity Log:59])
		End while 
		
	End if 
	
End if 

//End ACTFIX202206