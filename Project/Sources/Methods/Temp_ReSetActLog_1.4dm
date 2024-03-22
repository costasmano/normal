//%attributes = {"invisible":true}
If (False:C215)
	//Temp_ReSetActLog_1
	//Method to fix a problem in activity log where some records
	//were tranfered from the external server with the destination
	//info being in the forward information.
	//searches thru log-fixes destination field,
	//also gets all related records for Inspections and Pontis Insps
	//and deletes records in owners of data, so they can be received
	//again by the districts.
	Mods_2011_06  // CJ Miller`06/14/11, 10:44:11      ` Type all local variables for v11
End if 

Case of 
	: (Not:C34(User in group:C338(Current user:C182; "Design Access Group")))
		
	: (User in group:C338(Current user:C182; "Design Access Group"))
		CONFIRM:C162("Are you sure you want to run this????")
		If (OK=1)
			
			ARRAY TEXT:C222(aLocalIDs_S; 0)  //Command Replaced was o_ARRAY string length was 20
			ARRAY TEXT:C222(aParentIDIDs_S; 0)  //Command Replaced was o_ARRAY string length was 20
			ARRAY TEXT:C222(aInspectionIDs_S; 0)  //Command Replaced was o_ARRAY string length was 20
			ARRAY TEXT:C222(aPontisIDs_S; 0)  //Command Replaced was o_ARRAY string length was 20
			
			ARRAY LONGINT:C221(aLocalTable_L; 0)
			ARRAY LONGINT:C221(aParentTable_L; 0)
			ARRAY LONGINT:C221($aRefIDs_L; 0)
			ARRAY TEXT:C222($aForwardAddr_S; 0)  //Command Replaced was o_ARRAY string length was 80
			C_TEXT:C284($vMasterSet_S; $vTempSet_S; $vStartSet_S; $vOwnerRecsSet_S; $vAllInspRelated_S; $vAllPontisRelated_S)  // Command Replaced was o_C_STRING length was 32
			
			$vStartSet_S:="ActLogRecsWrongF"
			$vMasterSet_S:="ResetLogRecs"
			$vTempSet_S:="LogEntriesFound"
			$vOwnerRecsSet_S:="OwnerRecordsSet"
			$vAllInspRelated_S:="InspRelatedRecords"
			$vAllPontisRelated_S:="PontisRelatedRecords"
			
			QUERY:C277([Activity Log:59]; [Activity Log:59]Forward:13="Distr@")
			CREATE SET:C116([Activity Log:59]; $vStartSet_S)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Activity Type:3="NRC")
			
			SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; aLocalIDs_S; [Activity Log:59]Parent ID:14; aParentIDIDs_S; [Activity Log:59]FileID Local:24; aLocalTable_L; [Activity Log:59]FileID Parent:22; aParentTable_L)
			C_LONGINT:C283($vlNRCRecs; $i; $j; $k)
			$vlNRCRecs:=Records in selection:C76([Activity Log:59])
			CREATE EMPTY SET:C140([Activity Log:59]; $vMasterSet_S)
			For ($i; 1; $vlNRCRecs)
				QUERY:C277([Activity Log:59]; [Activity Log:59]Local ID:15=aLocalIDs_S{$i}; *)
				QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=aParentIDIDs_S{$i}; *)
				QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=aLocalTable_L{$i}; *)
				QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Parent:22=aParentTable_L{$i})
				CREATE SET:C116([Activity Log:59]; $vTempSet_S)
				UNION:C120($vMasterSet_S; $vTempSet_S; $vMasterSet_S)
				CLEAR SET:C117($vTempSet_S)
			End for 
			USE SET:C118($vStartSet_S)
			//Search for new Insp records
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Activity Type:3="NRC"; *)
			QUERY SELECTION:C341([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=Table:C252(->[Inspections:27]))
			SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; aInspectionIDs_S)
			$vlNumInsps:=Size of array:C274(aInspectionIDs_S)
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Parent:22=Table:C252(->[Inspections:27]))
			CREATE SET:C116([Activity Log:59]; "AllInspR")
			C_LONGINT:C283($vlNumInsps)
			CREATE EMPTY SET:C140([Activity Log:59]; $vAllInspRelated_S)
			For ($i; 1; $vlNumInsps)
				USE SET:C118("AllInspR")
				QUERY:C277([Activity Log:59]; [Activity Log:59]Parent ID:14=aInspectionIDs_S{$i})
				CREATE SET:C116([Activity Log:59]; "TempIndInspRel")
				UNION:C120($vAllInspRelated_S; "TempIndInspRel"; $vAllInspRelated_S)
				CLEAR SET:C117("TempIndInspRel")
			End for 
			
			CLEAR SET:C117("AllInspR")
			UNION:C120($vMasterSet_S; $vAllInspRelated_S; $vMasterSet_S)
			USE SET:C118($vStartSet_S)
			//Search for new Pontis records
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Activity Type:3="NRC"; *)
			QUERY SELECTION:C341([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=Table:C252(->[BMS Inspections:44]))
			SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; aInspectionIDs_S)
			$vlNumInsps:=Size of array:C274(aInspectionIDs_S)
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Parent:22=Table:C252(->[BMS Inspections:44]))
			CREATE SET:C116([Activity Log:59]; "AllInspR")
			
			CREATE EMPTY SET:C140([Activity Log:59]; $vAllPontisRelated_S)
			For ($i; 1; $vlNumInsps)
				USE SET:C118("AllInspR")
				QUERY:C277([Activity Log:59]; [Activity Log:59]Parent ID:14=aInspectionIDs_S{$i})
				CREATE SET:C116([Activity Log:59]; "TempIndInspRel")
				UNION:C120($vAllPontisRelated_S; "TempIndInspRel"; $vAllPontisRelated_S)
				CLEAR SET:C117("TempIndInspRel")
			End for 
			
			CLEAR SET:C117("AllInspR")
			UNION:C120($vMasterSet_S; $vAllPontisRelated_S; $vMasterSet_S)
			
			USE SET:C118($vMasterSet_S)
			ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28)
			SELECTION TO ARRAY:C260([Activity Log:59]RefID:28; $aRefIDs_L)
			QUERY WITH ARRAY:C644([Owners of Data:62]RefID:1; $aRefIDs_L)
			QUERY SELECTION:C341([Owners of Data:62]; [Owners of Data:62]Owner Name:2="Distr@")
			
			SELECTION TO ARRAY:C260([Owners of Data:62]RefID:1; $aRefIDs_L)
			CREATE SET:C116([Owners of Data:62]; $vOwnerRecsSet_S)
			QUERY WITH ARRAY:C644([Activity Log:59]RefID:28; $aRefIDs_L)
			
			USE SET:C118($vStartSet_S)
			SELECTION TO ARRAY:C260([Activity Log:59]Forward:13; $aForwardAddr_S)
			START TRANSACTION:C239
			//Step 1 : place the Forward Address in the Destination Address.
			ARRAY TO SELECTION:C261($aForwardAddr_S; [Activity Log:59]Destination:1)
			C_BOOLEAN:C305($vbContinue)
			
			If (Records in set:C195("LockedSet")=0)
				//CANCEL TRANSACTION
				$vbContinue:=True:C214
			Else 
				ALERT:C41("[Activity Log] records locked!!!")
				$vbContinue:=False:C215
			End if 
			
			//Step 2 : Clear Owner Records that are for LogEntries which were downloaded
			//and were related to the Act Log recs that were not downloaded.    
			Case of 
				: ($vbContinue)
					
					USE SET:C118($vOwnerRecsSet_S)
					DELETE SELECTION:C66([Owners of Data:62])
					If (Records in set:C195("LockedSet")=0)
						$vbContinue:=True:C214
					Else 
						ALERT:C41("Cannot delete all records in [Owners of Data]!")
						CANCEL TRANSACTION:C241
						$vbContinue:=False:C215
					End if 
					
			End case 
			
			If ($vbContinue)
				//CANCEL TRANSACTION
				VALIDATE TRANSACTION:C240
				//FLUSH CACHE
			Else 
				CANCEL TRANSACTION:C241
			End if 
			
			//End of method : Clear Sets, arrays 
			
			CLEAR SET:C117($vMasterSet_S)
			CLEAR SET:C117($vStartSet_S)
			CLEAR SET:C117($vTempSet_S)
			CLEAR SET:C117($vOwnerRecsSet_S)
			CLEAR SET:C117($vAllInspRelated_S)
			CLEAR SET:C117($vAllPontisRelated_S)
			
			ARRAY TEXT:C222(aLocalIDs_S; 0)  //Command Replaced was o_ARRAY string length was 20
			ARRAY TEXT:C222(aParentIDIDs_S; 0)  //Command Replaced was o_ARRAY string length was 20
			ARRAY LONGINT:C221(aLocalTable_L; 0)
			ARRAY LONGINT:C221(aParentTable_L; 0)
			ARRAY TEXT:C222(aInspectionIDs_S; 0)  //Command Replaced was o_ARRAY string length was 20
			ARRAY TEXT:C222(aPontisIDs_S; 0)  //Command Replaced was o_ARRAY string length was 20
			
			ARRAY LONGINT:C221($aRefIDs_L; 0)
			ARRAY TEXT:C222($aForwardAddr_S; 0)  //Command Replaced was o_ARRAY string length was 80
			
		End if 
		
End case 