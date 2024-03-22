//%attributes = {"invisible":true}
//Method: PON_CollectNBEforBrM
//Description
// Send NBE records to BrM
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/09/19, 16:08:00
	// ----------------------------------------------------
	//Created : 
	Mods_2019_07
	// Modified by: Costas Manousakis-(Designer)-(6/24/20 14:11:19)
	Mods_2020_06
	//  `Cancel out of method if Number of inspections to be grouped is zero or user cancels out of request
End if 
//

READ ONLY:C145(*)  // everything is read only
Progress QUIT(0)

C_TEXT:C284($BRM_DBName_txt)
$BRM_DBName_txt:=ut_GetSysParameter("PON_BRMDBName"; "[BRM53].")
C_DATE:C307($LastBrMUpdate_d; $NBEImplemented_d)
$LastBrMUpdate_d:=!2015-07-05!
C_TEXT:C284($LastBrMNBIUpdate_txt)
$LastBrMNBIUpdate_txt:=ut_GetSysParameter("PON_NBEStartDate"; "07/05/2015")
If (Date:C102($LastBrMNBIUpdate_txt)>!00-00-00!)
	$NBEImplemented_d:=Date:C102($LastBrMNBIUpdate_txt)
End if 

$LastBrMNBIUpdate_txt:=ut_GetSysParameter("PON_LastBrMNBEUpdate"; "07/05/2015")

If (Date:C102($LastBrMNBIUpdate_txt)>!00-00-00!)
	$LastBrMUpdate_d:=Date:C102($LastBrMNBIUpdate_txt)
End if 

C_LONGINT:C283($GroupInspElements_L; $ApproXelemCount_L)
$GroupInspElements_L:=20  // group NBEs for 20 inspections at a time
$GroupInspElements_L:=Num:C11(Request:C163("Number of inspections to be grouped in a single file"; String:C10($GroupInspElements_L)))

If ($GroupInspElements_L=0)
	//Canceled Confirm - stop
Else 
	
	ut_SetMessageDir("BMStoBrMTransfers")
	C_TEXT:C284($LogFileName_txt; $TimeStamp_txt)
	$TimeStamp_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
	$LogFileName_txt:="CollectNBEforBrM-"+$TimeStamp_txt
	ut_StartMessage(2; $LogFileName_txt)
	
	// set auto relations
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Start Search of inspections\n")
	
	
	$ApproXelemCount_L:=$GroupInspElements_L*200  // do 200 elements per inspection
	
	C_TEXT:C284($outputFolder_txt; $ProcessedFolder_txt)  //folder where the grouped statement files will be created
	$outputFolder_txt:=System folder:C487(Documents folder:K41:18)+"NBESQLFiles_"+$TimeStamp_txt+Folder separator:K24:12
	If (Test path name:C476($outputFolder_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($outputFolder_txt; *)
	End if 
	
	$ProcessedFolder_txt:=$outputFolder_txt+"Processed"+Folder separator:K24:12
	If (Test path name:C476($ProcessedFolder_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($ProcessedFolder_txt; *)
	End if 
	
	QUERY:C277([Inspections:27]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	
	If (False:C215)
		//for debugging only
		QUERY:C277([Inspections:27])
		
	End if 
	
	//inspections dated after the NBE implementation
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Search for inspections dated on or after NBE implementation "+String:C10($NBEImplemented_d)+"\n")
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Date:78>=$NBEImplemented_d)
	
	//inspections that have been approved since last BrM update
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Search for inspections after "+String:C10($LastBrMUpdate_d)+"\n")
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspDBIE1stApprDate:225>$LastBrMUpdate_d; *)
	QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]InspDBIEApprDate:206>$LastBrMUpdate_d)
	
	//get inspections that do have NBEs
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Search for inspections with NBEs \n")
	QUERY SELECTION:C341([Inspections:27]; [PON_ELEM_INSP:179]INSPID:21>0)  // this works
	
	//get inspections that can have NBEs 
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Search for inspections allowed to have NBEs \n")
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="OTH"; *)
	QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL"; *)
	QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CMI"; *)
	QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="RT@")
	
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Sorting inspections\n")
	ORDER BY:C49([Inspections:27]; [Bridge MHD NBIS:1]BDEPT:1; >; [Inspections:27]Insp Date:78; >)
	
	ARRAY DATE:C224($dbgInspDate_ad; 0)
	ARRAY TEXT:C222($dbgInspBIN_atxt; 0)
	
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Loading inspection data\n")
	SELECTION TO ARRAY:C260([Inspections:27]Insp Date:78; $dbgInspDate_ad; \
		[Inspections:27]BIN:1; $dbgInspBIN_atxt)
	C_LONGINT:C283($InspRecords_L)
	$InspRecords_L:=Records in selection:C76([Inspections:27])
	
	C_TEXT:C284($SingleQuote_s; $QuoteMark_s; $SQLStatement_txt; $Notes_txt)
	$SingleQuote_s:=Char:C90(39)
	$QuoteMark_s:=Char:C90(34)
	
	//ut_Message (String(Current date(*);ISO date;Current time(*))+" : Getting initial estimate of NBE count\n")
	//RELATE MANY SELECTION([PON_ELEM_INSP]INSPID)
	ARRAY TEXT:C222($ElemInspCommands_atxt; $ApproXelemCount_L)  //initialize array
	
	C_LONGINT:C283($inspLoop_L; $NBEElemCount_L)
	C_OBJECT:C1216($NBIBridgeProgress_o)
	$NBIBridgeProgress_o:=ProgressNew("SQL for "+String:C10($InspRecords_L)+" NBE bridge Inspections"; $InspRecords_L; True:C214; " Inspections"; 3)
	$NBEElemCount_L:=0
	C_DATE:C307($LastInspDate_d)
	
	C_TEXT:C284($CompletionStatus_txt)
	$CompletionStatus_txt:="OK"
	
	For ($inspLoop_L; 1; $InspRecords_L)
		
		UpdateProgressNew($NBIBridgeProgress_o; $inspLoop_L)
		
		//load the Bridge record - needed to combine NBEs and to get Item8 for the stored procedure
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$dbgInspBIN_atxt{$inspLoop_L})
		
		$LastInspDate_d:=$dbgInspDate_ad{$inspLoop_L}
		
		ARRAY LONGINT:C221($En_AL; 0)
		ARRAY LONGINT:C221($Env_AL; 0)
		ARRAY LONGINT:C221($ESTRU_AL; 0)
		ARRAY LONGINT:C221($EPN_AL; 0)
		ARRAY LONGINT:C221($EGPPN_AL; 0)
		ARRAY TEXT:C222($EN_Notes_atxt; 0)
		ARRAY REAL:C219($ENScaleF_ar; 0)
		ARRAY REAL:C219($TotQ_Ar; 0)
		ARRAY REAL:C219($CS1_Ar; 0)
		ARRAY REAL:C219($CS2_Ar; 0)
		ARRAY REAL:C219($CS3_Ar; 0)
		ARRAY REAL:C219($CS4_Ar; 0)
		ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Getting elements for BIN "+$dbgInspBIN_atxt{$inspLoop_L}+" Insp date "+String:C10($LastInspDate_d)+"\n")
		
		C_OBJECT:C1216($mergedNBEDs_o)
		$mergedNBEDs_o:=PON_CombineRecent(True:C214; True:C214; Add to date:C393($LastInspDate_d; 0; 0; 1); False:C215)  //add one day to the inspection date - do not show progress
		
		OB GET ARRAY:C1229($mergedNBEDs_o; "keys"; $En_AL)
		OB GET ARRAY:C1229($mergedNBEDs_o; "env"; $Env_AL)
		OB GET ARRAY:C1229($mergedNBEDs_o; "strunit"; $ESTRU_AL)
		OB GET ARRAY:C1229($mergedNBEDs_o; "parent"; $EPN_AL)
		OB GET ARRAY:C1229($mergedNBEDs_o; "grandparent"; $EGPPN_AL)
		OB GET ARRAY:C1229($mergedNBEDs_o; "notes"; $EN_Notes_atxt)
		OB GET ARRAY:C1229($mergedNBEDs_o; "scalef"; $ENScaleF_ar)
		OB GET ARRAY:C1229($mergedNBEDs_o; "totq"; $TotQ_Ar)
		OB GET ARRAY:C1229($mergedNBEDs_o; "q1"; $CS1_Ar)
		OB GET ARRAY:C1229($mergedNBEDs_o; "q2"; $CS2_Ar)
		OB GET ARRAY:C1229($mergedNBEDs_o; "q3"; $CS3_Ar)
		OB GET ARRAY:C1229($mergedNBEDs_o; "q4"; $CS4_Ar)
		
		//Handle element 39 if there is any
		C_LONGINT:C283($Key_39_L)
		$Key_39_L:=Find in array:C230($En_AL; 39)
		If ($key_39_L>0)
			//need to convert 39 to 13 , same stru u, same env
			C_LONGINT:C283($Key_13_L)
			$Key_13_L:=Find in array:C230($En_AL; 13)
			
			If ($Key_13_L>0)
				// in this case - message will be noted in the log
				ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Element 39 found with element 13 in inspection for BIN"+$dbgInspBIN_atxt{$inspLoop_L}+" inspection date "+String:C10($LastInspDate_d)+"\n")
				$CompletionStatus_txt:="ELEM39"
			Else 
				//just change and element, parent, grandparent from 39 to 13
				
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274($En_AL))
					
					If ($En_AL{$loop_L}=39)
						$En_AL{$loop_L}:=13
						ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Replaced 39 Env "+String:C10($Env_AL{$loop_L})+\
							" with element 13 in inspection for BIN"+$dbgInspBIN_atxt{$inspLoop_L}+" inspection date "+String:C10($LastInspDate_d)+"\n")
					End if 
					If ($EPN_AL{$loop_L}=39)
						$EPN_AL{$loop_L}:=13
						ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Replaced Parent 39 for element "+String:C10($En_AL{$loop_L})+\
							" Env "+String:C10($Env_AL{$loop_L})+\
							" with element 13 in inspection for BIN"+$dbgInspBIN_atxt{$inspLoop_L}+" inspection date "+String:C10($LastInspDate_d)+"\n")
					End if 
					If ($EGPPN_AL{$loop_L}=39)
						$EGPPN_AL{$loop_L}:=13
						ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Replaced GrandParent 39 for element "+String:C10($En_AL{$loop_L})+\
							" Env "+String:C10($Env_AL{$loop_L})+\
							" with element 13 in inspection for BIN"+$dbgInspBIN_atxt{$inspLoop_L}+" inspection date "+String:C10($LastInspDate_d)+"\n")
					End if 
					
				End for 
				
			End if 
			
		End if 
		
		//check if the commands array has enough space for these elements
		If ($NBEElemCount_L+Size of array:C274($EN_AL)>Size of array:C274($ElemInspCommands_atxt))
			ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Adding "+String:C10($ApproXelemCount_L)+" lines to ElemInspCommands array\n")
			ARRAY TEXT:C222($ElemInspCommands_atxt; (Size of array:C274($ElemInspCommands_atxt)+$ApproXelemCount_L))  //add $ApproXelemCount_L lines
		End if 
		
		ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Creating SQL for elements for BIN "+$dbgInspBIN_atxt{$inspLoop_L}+" Insp date "+String:C10($LastInspDate_d)+"\n")
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($En_AL))
			
			$SQLStatement_txt:=""
			
			// do not send enything with element 39
			Case of 
				: ($En_AL{$loop_L}=39)
				: ($EPN_AL{$loop_L}=39)
				: ($EGPPN_AL{$loop_L}=39)
				Else 
					
					C_TEXT:C284($Spaces_txt)
					$SQLStatement_txt:=$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item8:206)+$SingleQuote_s+", "
					$SQLStatement_txt:=$SQLStatement_txt+String:C10($ESTRU_AL{$loop_L})+", "
					$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+String:C10($LastInspDate_d; 7)+$SingleQuote_s+", "
					$SQLStatement_txt:=$SQLStatement_txt+String:C10($En_AL{$loop_L})+", "
					Case of 
						: ($Env_AL{$loop_L}<=0)
							$SQLStatement_txt:=$SQLStatement_txt+"2, "
						: ($Env_AL{$loop_L}>4)
							$SQLStatement_txt:=$SQLStatement_txt+"2, "
						Else 
							$SQLStatement_txt:=$SQLStatement_txt+String:C10($Env_AL{$loop_L})+", "
					End case 
					$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($TotQ_Ar{$loop_L}; 7))+", "
					$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($CS1_Ar{$loop_L}; 6))+", "
					$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($CS2_Ar{$loop_L}; 6))+", "
					$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($CS3_Ar{$loop_L}; 6))+", "
					$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($CS4_Ar{$loop_L}; 6))+", "
					
					$Notes_txt:=Substring:C12(SQL_SetUpStrings($EN_Notes_atxt{$loop_L}); 1; 3990)
					$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+$Notes_txt+$SingleQuote_s+" , "
					$SQLStatement_txt:=$SQLStatement_txt+String:C10($EPN_AL{$loop_L})+" , "
					$SQLStatement_txt:=$SQLStatement_txt+String:C10($EGPPN_AL{$loop_L})+"  "
					
					$NBEElemCount_L:=$NBEElemCount_L+1  // increase element count
					$ElemInspCommands_atxt{$NBEElemCount_L}:="Execute "+$BRM_DBName_txt+"[dbo]."+"[sp_pontis_update_eleminsp]"+" "+$SQLStatement_txt
					
			End case 
			
		End for   // end of element loop
		
		//check if progress stopped
		If (Progress Stopped(OB Get:C1224($NBIBridgeProgress_o; "progress"; Is longint:K8:6)))
			//abort loop
			$inspLoop_L:=$InspRecords_L+1
		End if 
		
		If ($inspLoop_L%$GroupInspElements_L=0) | ($inspLoop_L>=$InspRecords_L)
			//put the SQL statements in a file
			C_TEXT:C284($SQLCommands_txt; $SQLFileName_txt)
			C_LONGINT:C283($lines_L)
			$SQLCommands_txt:=""
			For ($lines_L; 1; $NBEElemCount_L)
				$SQLCommands_txt:=$SQLCommands_txt+$ElemInspCommands_atxt{$lines_L}+"\n"
				$ElemInspCommands_atxt{$lines_L}:=""
			End for 
			C_LONGINT:C283($FileCount_L)
			ARRAY TEXT:C222($Files_atxt; 0)
			DOCUMENT LIST:C474($outputFolder_txt; $Files_atxt; Ignore invisible:K24:16)
			$FileCount_L:=Size of array:C274($Files_atxt)
			C_TIME:C306($SQLFile_t)
			$SQLFileName_txt:=$outputFolder_txt+String:C10($FileCount_L+1; "0000000")+".txt"
			
			$SQLFile_t:=Create document:C266($SQLFileName_txt)
			CLOSE DOCUMENT:C267($SQLFile_t)
			TEXT TO DOCUMENT:C1237($SQLFileName_txt; $SQLCommands_txt)
			ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : Created file "+$SQLFileName_txt+" with "+String:C10($NBEElemCount_L)+" NBE Elements\n")
			
			$NBEElemCount_L:=0  // re start the element count
		End if 
		
	End for   //end of inspection loop
	
	//quit progress
	Progress QUIT(OB Get:C1224($NBIBridgeProgress_o; "progress"; Is longint:K8:6))
	
	ut_Message(String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+" : End of generating of SQL commands for "+\
		String:C10($InspRecords_L)+" NBE inspection records"+"\n")
	
	SHOW ON DISK:C922($outputFolder_txt; *)
	
	ut_CloseMessage
	
End if 

//End PON_CollectNBEforBrM