//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/28/11, 16:09:58
//----------------------------------------------------
//Method: Object Method: "CloneTables".Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//Ugrade to v11
	//Modified by: Charles Miller (3/28/11 16:09:59)
	Mods_2013_01  //r001 `Change way ut_ReturnKeyFldandVariable is called by adding reindex boolean as 5th parameter
	//It should only be passed as true if re-index will occur later using KeysToReset_aptr array
	//Modified by: Charles Miller (2/5/13 11:23:39)
	Mods_2013_09  //r001 `  Changes in cloning to use arrays whenever possible
	//Modified by: Charles Miller (9/10/13 13:01:58)
	Mods_2013_12  //r002 ` Fix problems in clone with blobs
	//Modified by: Charles Miller (12/3/13 17:08:35)
	Mods_2013_12  //Move clone code that has been fixed into development
	//Modified by: Charles Miller (12/12/13 13:47:37)
	Mods_2018_06  //Modified by: Charles Miller (06/19/18 )
	//Uncomment out line 360 if no more changes made
	Mods_2020_01  //Move changed clone code for new data file changes in from BF
	//Add second progress bar for table loop
	//Modified by: CJ (1/14/20 12:15:12)
	
End if 


If (SQL_TEXT#"") & (KeyValue_txt="")
	ALERT:C41("You may not use custom where with a blank KeyValue_txt")
Else 
	4DError_b:=False:C215
	C_TIME:C306($BegTime; $EndTime)
	$BegTime:=Current time:C178
	C_LONGINT:C283($UniqueFldNumber_l)
	C_TEXT:C284($Variable_txt)
	ARRAY TEXT:C222($RetrivedTables_atxt; 0)
	
	C_TEXT:C284($TableName_txt; $SelectFields_txt; $UpdateFields_txt; SQL_txt; SQLCount_txt)
	C_LONGINT:C283($Loop_l; $TableNumber_l; Offset_l; Count_l; $InnerLoop_l; $UniqueFldNumber_l)
	C_BOOLEAN:C305($QueryAndReplace_b)
	$QueryAndReplace_b:=False:C215
	4DError_b:=False:C215
	SQLError_b:=False:C215
	C_BOOLEAN:C305($Skip_b)
	ARRAY TEXT:C222(clone_TablesWithUniqueKey_atxt; 0)
	ARRAY POINTER:C280(clone_UniqueKeys_aptr; 0)
	ARRAY POINTER:C280(clone_Array_aptr; 0)
	ARRAY POINTER:C280(clone_Table_aPtr; 0)
	ARRAY BOOLEAN:C223($HasPictureOrBlob_ab; 0)
	C_TEXT:C284($Variable_txt)
	
	C_BOOLEAN:C305($HasPictureOrBlob_b)
	For ($TableNumber_l; 1; Get last table number:C254)
		
		$HasPictureOrBlob_b:=clone_ReturnUniqueKeys($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; True:C214)
		
		If ($UniqueFldNumber_l>0)
			APPEND TO ARRAY:C911(clone_Table_aPtr; Table:C252($TableNumber_l))
			APPEND TO ARRAY:C911(clone_TablesWithUniqueKey_atxt; Table name:C256($TableNumber_l))
			APPEND TO ARRAY:C911(clone_UniqueKeys_aptr; Field:C253($TableNumber_l; $UniqueFldNumber_l))
			APPEND TO ARRAY:C911(clone_Array_aptr; Get pointer:C304($Variable_txt))
			APPEND TO ARRAY:C911($HasPictureOrBlob_ab; $HasPictureOrBlob_b)
		End if 
	End for 
	$UniqueFldNumber_l:=0
	C_TIME:C306($TableS_tm; $TableE_tm)
	C_LONGINT:C283($Progress_L; $TableProgress_L)
	
	$TableProgress_L:=Progress New
	For ($Loop_l; 1; Size of array:C274(ProcessTableNames_atxt))
		Progress SET TITLE($TableProgress_L; ProcessTableNames_atxt{$Loop_l}+" "+String:C10($Loop_l)+" / "+String:C10(Size of array:C274(ProcessTableNames_atxt)))
		
		$Progress_L:=Progress New
		SET BLOB SIZE:C606(BlobHoldUpdates_blb; 0)
		
		$TableS_tm:=Current time:C178
		$Skip_b:=False:C215
		$TableNumber_l:=ProcessTableNumber_al{$Loop_l}
		C_TEXT:C284($Variable_txt)
		$TableName_txt:=Table name:C256($TableNumber_l)
		SQL_TEXT:=RemoteCustomQuery_atxt{$Loop_l}
		
		
		C_TEXT:C284($FieldName_txt; SQLKeyValue_txt)
		C_LONGINT:C283($Row_l)
		C_POINTER:C301($Field_ptr)
		
		Case of 
				
			: (SQL_TEXT#"")
				SQLCount_txt:="SELECT Count(*) FROM ["+$TableName_txt+"] "+Char:C90(Carriage return:K15:38)
				SQLCount_txt:=SQLCount_txt+SQL_TEXT
				$QueryAndReplace_b:=True:C214
				rbUpdate_l:=1
			: (RemoteQueryType_atxt{$Loop_l}#"") & (RemoteKey_atxt{$Loop_l}#"")
				SQLKeyValue_txt:=RemoteKey_atxt{$Loop_l}
				SQLCount_txt:="SELECT Count(*) FROM ["+$TableName_txt+"] "+Char:C90(Carriage return:K15:38)
				
				SQLCount_txt:=SQLCount_txt+" Where "+"["+Table name:C256($TableNumber_l)+"].["+RemoteKeyName_atxt{$Loop_l}+"] "+Char:C90(Carriage return:K15:38)
				C_TEXT:C284($RemoteQueryType_txt)
				$RemoteQueryType_txt:=RemoteQueryType_atxt{$Loop_l}
				Case of 
					: (RemoteQueryType_atxt{$Loop_l}="Begins with")
						SQLKeyValue_txt:=SQLKeyValue_txt+"%"
						$RemoteQueryType_txt:=" LIKE "
					: (RemoteQueryType_atxt{$Loop_l}="Ends with")
						SQLKeyValue_txt:="%"+SQLKeyValue_txt
						$RemoteQueryType_txt:=" LIKE "
					: (RemoteQueryType_atxt{$Loop_l}="Contains")
						SQLKeyValue_txt:="%"+SQLKeyValue_txt+"%"
						$RemoteQueryType_txt:=" LIKE "
				End case 
				C_TEXT:C284($RemoteQueryValue_txt)
				$RemoteQueryValue_txt:=""
				Case of 
						
					: (RemoteType_al{$Loop_L}=Is alpha field:K8:1) | (RemoteType_al{$Loop_L}=Is text:K8:3)
						$RemoteQueryValue_txt:=$RemoteQueryType_txt+" :SQLKeyValue_txt "
					: (RemoteType_al{$Loop_L}=Is date:K8:7)
						C_DATE:C307(SQLKeyValue_d)
						SQLKeyValue_d:=Date:C102(SQLKeyValue_txt)
						$RemoteQueryValue_txt:=$RemoteQueryType_txt+" :SQLKeyValue_d "
					: (RemoteType_al{$Loop_L}=Is integer:K8:5) | (RemoteType_al{$Loop_L}=Is longint:K8:6)
						C_LONGINT:C283(SQLKeyValue_L)
						SQLKeyValue_L:=Num:C11(SQLKeyValue_txt)
						$RemoteQueryValue_txt:=$RemoteQueryType_txt+" :SQLKeyValue_L "
					: (RemoteType_al{$Loop_L}=Is boolean:K8:9)
						C_BOOLEAN:C305(SQLKeyValue_b)
						If (SQLKeyValue_txt="true")
							SQLKeyValue_b:=True:C214
						Else 
							SQLKeyValue_b:=False:C215
						End if 
						$RemoteQueryValue_txt:=$RemoteQueryType_txt+" :SQLKeyValue_b "
						
				End case 
				SQLCount_txt:=SQLCount_txt+$RemoteQueryValue_txt+" INTO :Count_l;"
				
				rbUpdate_l:=1
				C_LONGINT:C283($FieldNumber_L)
				$FieldNumber_L:=Clone_ReturnFieldNumber($TableNumber_l; RemoteKeyName_atxt{$Loop_l})
				$Field_ptr:=Field:C253($TableNumber_l; $FieldNumber_L)
				
				$QueryAndReplace_b:=True:C214
			Else 
				If (rbUpdate_l=1)
					$QueryAndReplace_b:=True:C214
				End if 
				SQLCount_txt:="SELECT Count(*) FROM ["+$TableName_txt+"] INTO :Count_l;"
		End case 
		Compiler_FieldVariables($TableNumber_l)
		clone_ClearFieldVariables($TableNumber_l)
		
		Begin SQL
			EXECUTE IMMEDIATE :SQLCount_txt;
		End SQL
		C_BOOLEAN:C305($Reindex_b)
		$Reindex_b:=True:C214
		C_REAL:C285($MinPercentage_r; $Percentage_r)
		
		$MinPercentage_r:=0.1
		$Percentage_r:=Count_l/ProcessLocalCount_al{$Loop_L}
		Case of 
			: (Count_l<1000)
				$Reindex_b:=False:C215
			: (ProcessLocalCount_al{$Loop_L}=0)
				$Reindex_b:=True:C214
			: ((Count_l/ProcessLocalCount_al{$Loop_L})<=$MinPercentage_r)
				$Reindex_b:=False:C215
		End case 
		
		clone_ReturnKeyFldandVariable($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; $Reindex_b)
		
		
		C_POINTER:C301($Variable_ptr; $Table_ptr)
		
		C_LONGINT:C283($FindInTableNames_L)
		$FindInTableNames_L:=Find in array:C230(clone_TablesWithUniqueKey_atxt; Table name:C256($TableNumber_l))
		
		$Table_ptr:=Table:C252($TableNumber_l)
		$Skip_b:=False:C215
		If ($FindInTableNames_L>0)
			$HasPictureOrBlob_b:=$HasPictureOrBlob_ab{$FindInTableNames_L}
		End if 
		If (rbUpdate_l=1)
			If ($QueryAndReplace_b)  //& ($HasPictureOrBlob_b=False)
				
				If ($FindInTableNames_L<1)
					
					If (Read only state:C362($Table_ptr->)=True:C214)
						UNLOAD RECORD:C212($Table_ptr->)
						READ WRITE:C146($Table_ptr->)
					End if 
					REDUCE SELECTION:C351($Table_ptr->; 0)
					SET QUERY DESTINATION:C396(Into set:K19:2; "ToBeDeletedSet")
					
					Case of 
						: (RemoteQueryType_atxt{$Loop_l}="=")
							QUERY:C277($Table_ptr->; $Field_ptr->=KeyValue_txt)
						: (RemoteQueryType_atxt{$Loop_l}=">")
							QUERY:C277($Table_ptr->; $Field_ptr->>KeyValue_txt)
						: (RemoteQueryType_atxt{$Loop_l}="<")
							QUERY:C277($Table_ptr->; $Field_ptr-><KeyValue_txt)
						: (RemoteQueryType_atxt{$Loop_l}=">=")
							QUERY:C277($Table_ptr->; $Field_ptr->>=KeyValue_txt)
						: (RemoteQueryType_atxt{$Loop_l}="<=")
							QUERY:C277($Table_ptr->; $Field_ptr-><=KeyValue_txt)
						: (RemoteQueryType_atxt{$Loop_l}="NOT =")
							QUERY:C277($Table_ptr->; $Field_ptr->#KeyValue_txt)
							
						: (RemoteQueryType_atxt{$Loop_l}="Begins with")
							QUERY:C277($Table_ptr->; $Field_ptr->=KeyValue_txt+"@")
						: (RemoteQueryType_atxt{$Loop_l}="Ends with")
							QUERY:C277($Table_ptr->; $Field_ptr->="@"+KeyValue_txt)
						: (RemoteQueryType_atxt{$Loop_l}="Contains")
							QUERY:C277($Table_ptr->; $Field_ptr->="@"+KeyValue_txt+"@")
					End case 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					
					If (Records in set:C195("ToBeDeletedSet")>0)
						USE SET:C118("ToBeDeletedSet")
						Repeat 
							If (Records in selection:C76($Table_ptr->)=1)
								DELETE RECORD:C58($Table_ptr->)
							Else 
								DELETE SELECTION:C66($Table_ptr->)
							End if 
							If (Records in set:C195("LockedSet")>0)
								USE SET:C118("LockedSet")
							End if 
						Until (Records in set:C195("LockedSet")=0)
						
					End if 
					CLEAR SET:C117("ToBeDeletedSet")
					
				End if 
			Else 
				If ($UniqueFldNumber_l=0)
					
					CONFIRM:C162("No primary key for the selected table "+Table name:C256($TableNumber_l); "Proceed"; "Do not proceed")
					If (OK=1)
						$Skip_b:=False:C215
						rbUpdate_l:=0
						rbReplace_l:=1
					Else 
						$Skip_b:=True:C214
					End if 
				Else 
					$Skip_b:=False:C215
				End if 
				If (rbUpdate_l=0)
					Repeat 
						ON ERR CALL:C155("4D_Errors")
						READ WRITE:C146($Table_ptr->)
						
						TRUNCATE TABLE:C1051($Table_ptr->)
						If (OK=1)
							
						Else 
							
							CONFIRM:C162("Not all records deleted. "; "try again"; "skip")
							If (OK=1)
								$Skip_b:=True:C214
							Else 
								DELAY PROCESS:C323(Current process:C322; 120)
							End if 
						End if 
					Until (OK=1) | ($Skip_b)
				End if 
			End if 
		Else 
			Repeat 
				ON ERR CALL:C155("4D_Errors")
				READ WRITE:C146($Table_ptr->)
				
				TRUNCATE TABLE:C1051($Table_ptr->)
				If (OK=1)
					
				Else 
					
					CONFIRM:C162("Not all records deleted. "; "try again"; "skip")
					If (OK=1)
						$Skip_b:=True:C214
					Else 
						DELAY PROCESS:C323(Current process:C322; 120)
					End if 
				End if 
			Until (OK=1) | ($Skip_b)
		End if 
		
		If (Not:C34(4DError_b)) & (Not:C34(SQLError_b)) & (Not:C34($Skip_b))
			C_BOOLEAN:C305($UseArrays_b)
			//
			//If ($HasPictureOrBlob_b=True)
			//$UseArrays_b:=False
			//Else 
			//$UseArrays_b:=($QueryAndReplace_b) | (rbUpdate_l=0)
			//End if 
			$UseArrays_b:=($QueryAndReplace_b) | (rbUpdate_l=0)
			clone_CloneSetUpSelectInto($TableNumber_l; ->$SelectFields_txt; ->$UpdateFields_txt; $UseArrays_b)
			//SQL_SetSelectInto ($TableNumber_l;->$SelectFields_txt;->$UpdateFields_txt)
			$UpdateFields_txt:=$UpdateFields_txt+";"
			If ($UseArrays_b)
				Offset_l:=0
			Else 
				Offset_l:=1
			End if 
			
			Case of 
				: (RemoteQueryType_atxt{$Loop_l}#"") & (RemoteKey_atxt{$Loop_l}#"")  //& ($UniqueFldNumber_l#0)
					SQL_txt:="SELECT "+$SelectFields_txt+" FROM ["+$TableName_txt+"] "+Char:C90(Carriage return:K15:38)
					SQL_txt:=SQL_txt+" Where ["+RemoteKeyName_atxt{$Loop_l}+"] "+$RemoteQueryValue_txt+Char:C90(Carriage return:K15:38)
					SQL_txt:=SQL_txt+"LIMIT :SQL_Limit_L OFFSET :Offset_l "+Char:C90(Carriage return:K15:38)+" INTO "+$UpdateFields_txt+Char:C90(Carriage return:K15:38)
					Offset_l:=0
					//SET TEXT TO PASTEBOARD(SQL_txt)
					
				: (SQL_TEXT#"")
					SQL_txt:="SELECT "+$SelectFields_txt+" FROM ["+$TableName_txt+"] LIMIT "+String:C10(SQL_Limit_L)+" OFFSET :Offset_l "+Char:C90(Carriage return:K15:38)
					SQL_txt:=SQL_txt+SQL_TEXT+Char:C90(Carriage return:K15:38)
					SQL_txt:=SQL_txt+"INTO "+$UpdateFields_txt
					Offset_l:=0
				Else 
					SQL_txt:="SELECT "+$SelectFields_txt+" FROM ["+$TableName_txt+"] LIMIT "+String:C10(SQL_Limit_L)+"  OFFSET :Offset_l INTO "+$UpdateFields_txt
			End case 
			//C_LONGINT(<>ProgressPID)
			C_TIME:C306($beg; $end)
			
			If (Count_l>0)
				Progress SET TITLE($Progress_L; "Retrieving "+$TableName_txt)
				
				ON ERR CALL:C155("4D_Errors")
				
				$beg:=Current time:C178
				C_REAL:C285($Interval)
				
				//<>ProgressPID:=StartProgress (Substring(ProcessTableNames_atxt{$Loop_l};1;23);"Button";"Retrieving Records")
				C_TEXT:C284($Name_txt; $Name1_txt)
				//C_LONGINT($State_L;$Time_L)
				
				//PROCESS PROPERTIES($Progress_L;$Name_txt;$State_L;$Time_L)
				//UpdateProgress (1;Count_l)
				Repeat 
					Case of 
						: (SQL_Limit_L>=Count_l)
							$Interval:=100
						: ((Offset_l+1)>=Count_l)
							$Interval:=100
						Else 
							$Interval:=(Offset_l+1)/Count_l
							
					End case 
					Progress SET PROGRESS($Progress_L; $Interval)
					
					
					clone_ClearFieldVariables($TableNumber_l)
					ON ERR CALL:C155("SQL_Error")
					Begin SQL
						EXECUTE IMMEDIATE :SQL_txt;
					End SQL
					If (Not:C34(4DError_b)) & (Not:C34(SQLError_b))
						ON ERR CALL:C155("4D_Errors")
						If ($UseArrays_b)
							If (Size of array:C274(Clone_FirstArray_ptr->)>0)
								clone_ResizeMissingArrays(Size of array:C274(Clone_FirstArray_ptr->))
							End if 
							Case of 
								: (rbUpdate_l=1)
									If (Find in array:C230(clone_TablesWithUniqueKey_atxt; Table name:C256($TableNumber_l))<1)
										REDUCE SELECTION:C351($Table_ptr->; 0)
										Clone_ArrayToSelection($TableNumber_l)
									Else 
										Clone_UpdateRecords($TableName_txt)
									End if 
								Else 
									REDUCE SELECTION:C351($Table_ptr->; 0)
									Clone_ArrayToSelection($TableNumber_l)
							End case 
						Else 
							If (rbUpdate_l=1)
								If (Not:C34($QueryAndReplace_b))
									QUERY:C277($Table_ptr->; $Field_ptr->=$Variable_ptr->)
								End if 
								If (Records in selection:C76($Table_ptr->)=1)
									If (ut_LoadRecord($Table_ptr; 1000))
									End if 
								Else 
									CREATE RECORD:C68($Table_ptr->)
									SAVE RECORD:C53($Table_ptr->)
								End if 
								
							Else 
								CREATE RECORD:C68($Table_ptr->)
								SAVE RECORD:C53($Table_ptr->)
							End if 
							ut_SQLUpdateLocalTable($TableNumber_l)
							// Now no difference using array of pointers shows no speed difference at all which us what ut_NewSQLUpdateLocalTable did
							//If (arbNew_l=1)
							//ut_SQLUpdateLocalTable ($TableNumber_l)
							//  //ut_NewSQLUpdateLocalTable ($TableNumber_l)// reset to old version so we copy uuids
							//Else 
							//ut_SQLUpdateLocalTable ($TableNumber_l)
							//End if 
							SAVE RECORD:C53($Table_ptr->)
							UNLOAD RECORD:C212($Table_ptr->)
							Offset_l:=Offset_l+1
						End if 
					End if 
					
				Until (Offset_l=Count_l) | (4DError_b) | (SQLError_b)
				
				//CALL PROCESS(<>ProgressPID)
				//C_LONGINT($State_L)
				
				
				//Repeat 
				//IDLE
				//PROCESS PROPERTIES(<>ProgressPID;$Name1_txt;$State_L;$Time_L)
				
				//DELAY PROCESS(Current process;60)
				//Until ($State_L<1) | ($Name_txt#$Name1_txt)
				
				
				If (BLOB size:C605(BlobHoldUpdates_blb)>0)
					//Progress SET TITLE ($Progress_L;"Retrieving Blobs for "+$TableName_txt)
					
					//<>ProgressPID:=StartProgress (Substring(ProcessTableNames_atxt{$Loop_l};1;23);"Button";"Retrieving Blobs")
					//UpdateProgress (1;Count_l)
					clone_ProcessBlobs($TableNumber_l; $Progress_L)
					//CALL PROCESS(<>ProgressPID)
					//PROCESS PROPERTIES(<>ProgressPID;$Name_txt;$State_L;$Time_L)
					
					//Repeat 
					//IDLE
					//PROCESS PROPERTIES(<>ProgressPID;$Name1_txt;$State_L;$Time_L)
					
					//DELAY PROCESS(Current process;60)
					//Until ($State_L<1) | ($Name_txt#$Name1_txt)
					
				End if 
				
				
				C_LONGINT:C283($IndexLoop_l)
				For ($IndexLoop_l; 1; Size of array:C274(KeysToReset_aptr))
					SET INDEX:C344(KeysToReset_aptr{$IndexLoop_l}->; KeyIndextType_aL{$IndexLoop_l}; *)  //reset index asycnhronously
				End for 
				ARRAY POINTER:C280(KeysToReset_aptr; 0)
				ARRAY LONGINT:C221(KeyIndextType_aL; 0)
				$end:=Current time:C178
				//CALL PROCESS(<>ProgressPID)
			End if 
			If (Not:C34(4DError_b)) & (Not:C34(SQLError_b)) & (Not:C34($Skip_b))
				
			Else 
				ALERT:C41("There was an error processing "+ProcessTableNames_atxt{$Loop_l}+". No further processing will be done!")
				$Loop_l:=Size of array:C274(ProcessTableNames_atxt)
			End if 
		End if 
		$TableE_tm:=Current time:C178
		C_TEXT:C284($Append_txt)
		
		$Append_txt:="Processed "+String:C10(Count_l)+" records for table "+$TableName_txt+" in Elapsed time of: "+String:C10($TableE_tm-$TableS_tm)+Char:C90(Carriage return:K15:38)
		
		APPEND TO ARRAY:C911($RetrivedTables_atxt; $Append_txt)
		Progress QUIT($Progress_L)
	End for 
	
	Progress QUIT(0)
End if 

$EndTime:=Current time:C178


ALERT:C41("Elapsed time is "+String:C10($EndTime-$BegTime))
CONFIRM:C162("Process Create retrieved table and record count document"; "Yes"; "No")

If (OK=1)
	C_TIME:C306($Doc_tm)
	$Doc_tm:=Create document:C266("")
	CLOSE DOCUMENT:C267($Doc_tm)
	C_BLOB:C604($Doocument_blb)
	SET BLOB SIZE:C606($Doocument_blb; 0)
	For ($Loop_L; 1; Size of array:C274($RetrivedTables_atxt))
		TEXT TO BLOB:C554($RetrivedTables_atxt{$Loop_L}; $Doocument_blb; Mac text without length:K22:10; *)
	End for 
	TEXT TO BLOB:C554("Total elapsed time was "+String:C10($EndTime-$BegTime)+Char:C90(Carriage return:K15:38); $Doocument_blb; Mac text without length:K22:10; *)
	BLOB TO DOCUMENT:C526(Document; $Doocument_blb)
	ut_OpenDocument(Document)
	
End if 

//End Object Method: CloneTables.Button1

