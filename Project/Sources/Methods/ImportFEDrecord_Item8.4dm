//%attributes = {"invisible":true}
//proccedure: ImportFEDrecord_Item8
//purpose: import NBI data according to the NBI record format-fixed width
If (False:C215)
	//date created: 9/14/98
	//by: Albert Leung
	//if a new bridge key is found a new record is created otherwise the NBI fields
	//are updated
	//
	// Modified 2-10-2000 : CM
	//    -Changed logic to check whether file has records that are CRLF
	//      delimited or just CR
	//    -Adjusted GOTO XY x param from 6 pixels to 1 character
	//    -Disabled creating new records if Brkey is not found in 4D data
	//    -Fixed error in checking for Y2K date issues for items 93A,B,C
	//      and item 90.  This will need to be revisited in 2050
	
	//  31-Jan-01 : copied from previous version to make changes for new Item 8 coding
	//   left method ImportFEDrecord_old in database just in case
	Mods_2011_06  // CJ Miller`06/13/11, 16:50:12      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(4/5/12 )
	Mods_2012_04
	//  `Switched to ut_StartMessage, ut_Message, ut_CloseMessage
	//  `ut_LoadRecordInteractive
	//  `added unload record commands at the end
	//  `Added PushChange, FlushGrpChgs
	// Modified by: Costas Manousakis-(Designer)-(10/31/16 11:10:08)
	Mods_2016_10
	//  `moved messages where the input file is; open input file in RO mode
	//  `For records not found, write in message file info so they can be located.
End if 

C_TIME:C306($dImportFile)
C_TEXT:C284($tBuffer; $tNBI; $primary)
C_LONGINT:C283($counter; $recnum)
C_TEXT:C284($item8)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284($brkey)  // Command Replaced was o_C_STRING length was 12
C_TEXT:C284($sdate)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283(vBIN_Dec)

//Initialize bridge key array
ALL RECORDS:C47([Bridge MHD NBIS:1])
ARRAY TEXT:C222($aitem8; 0)  //Command Replaced was o_ARRAY string length was 15
ARRAY TEXT:C222($aBrKey; 0)  //Command Replaced was o_ARRAY string length was 12
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item8:206; $aitem8; [Bridge MHD NBIS:1]Bridge Key:2; $aBrKey)
C_BOOLEAN:C305($BlankDB_b)
$BlankDB_b:=(Records in table:C83([Bridge MHD NBIS:1])=0)

$counter:=0
$dImportFile:=Open document:C264(""; "TEXT"; Read mode:K24:5)  //Prompt user

C_TEXT:C284($doc_txt; $docFolder_txt; $CurrMsgFolder_txt; MessageDefDir_txt)
If (Ok=1)
	$doc_txt:=Document
	$docFolder_txt:=GetPath($doc_txt)
	$CurrMsgFolder_txt:=MessageDefDir_txt
	MessageDefDir_txt:=$docFolder_txt
	
	ut_StartMessage(3; "ImportingFedRecords"; 500; 200)
	
	ut_Message("Message"+Char:C90(Tab:K15:37)+"Item8"+Char:C90(Tab:K15:37)+"Item4"+Char:C90(Tab:K15:37)+"Town Name"+Char:C90(Tab:K15:37)+"Item7"+Char:C90(Tab:K15:37)+"Item6A"+Char:C90(Tab:K15:37))
	ut_Message("LAT"+Char:C90(Tab:K15:37))
	ut_Message("LON"+Char:C90(Tab:K15:37))
	ut_Message("Item27"+Char:C90(Tab:K15:37)+"Item106"+Char:C90(Tab:K15:37))
	ut_Message("Item28A"+Char:C90(Tab:K15:37)+"Item29"+Char:C90(Tab:K15:37))
	ut_Message("Item49"+Char:C90(Tab:K15:37)+"Item52")
	ut_Message(Char:C90(13))
	
	C_LONGINT:C283($NumBrgFields_L; $loop_L; $TableNum_L; $viFldType)
	$TableNum_L:=Table:C252(->[Bridge MHD NBIS:1])
	$NumBrgFields_L:=Get last field number:C255($TableNum_L)
	ARRAY POINTER:C280($BridgeFields_aptr; $NumBrgFields_L)
	For ($loop_L; 1; $NumBrgFields_L)
		$BridgeFields_aptr{$loop_L}:=Field:C253($TableNum_L; $loop_L)
	End for 
	
	C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
	vsForward:=<>Forward
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
	InitChangeStack(1)
	
	//NewWindow (500;50;0;4;"Importing")
	//read in the first record
	RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
	$tNBI:=$tBuffer
	$counter:=$counter+1
	// 2-10-2000 : CM - Line removed
	//RECEIVE PACKET($dImportFile;$tBuffer;1)  `read in line feed character
	
	While (Ok=1)
		// 2-10-2000 : CM
		// Modification to account for CRLF or just CR records
		If (Substring:C12($tNBI; 1; 1)=<>sLF)
			//if 1st char is a LF then skip it    
			$tNBI:=Substring:C12($tNBI; 2)
		End if 
		
		$item8:=Substring:C12($tNBI; 4; 15)
		$recnum:=Find in array:C230($aitem8; $item8)
		If ($recnum<0)
			If ($Item8="CEPNED@")
				//FED record
				C_LONGINT:C283($k)
				For ($k; 1; Size of array:C274($aBrKey))
					If (Substring:C12($Item8; 10)=Substring:C12($aBrKey{$k}; 7))
						$recnum:=$k
						$k:=Size of array:C274($aBrKey)+1
					End if 
				End for 
			End if 
		End if 
		
		If ($recnum>0)
			GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $recnum)
			
			If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
				ut_Message("Updating record "+$item8+" Item 8 part "+Substring:C12($Item8; 10)+" brkey part "+Substring:C12($aBrKey{$recnum}; 7)+Char:C90(13))
				//     10-10-2000 : CM Else statement that was here moved to bottom of routine
				//     to avoid creating new records
				LoadNBIData($tNBI)
				[Bridge MHD NBIS:1]InspResp:173:="FED"
				[Bridge MHD NBIS:1]FHWARecord:174:=False:C215
				C_TEXT:C284($FieldName)
				For ($loop_L; 1; Size of array:C274($BridgeFields_aptr))
					$FieldName:=Field name:C257($BridgeFields_aptr{$loop_L})
					If (($FieldName#"BIN"))  //Skip BIN 
						GET FIELD PROPERTIES:C258($BridgeFields_aptr{$loop_L}; $viFldType)
						If ($viFldType#Is subtable:K8:11)  //AND subtables
							If (($BridgeFields_aptr{$loop_L}->)#Old:C35($BridgeFields_aptr{$loop_L}->))
								PushChange(1; $BridgeFields_aptr{$loop_L})
							End if 
						End if 
					End if 
					
				End for 
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
				
				SAVE RECORD:C53([Bridge MHD NBIS:1])  //Save record resets the Ok variable so we must read a record
			End if 
			//     10-10-2000 : CM This Else statement moved from  top of IF($recnum>0)
		Else 
			//   10-10-2000 : CM
			ut_Message("Import Record "+String:C10($counter)+" with Bridge Key "+$item8+" not found in Database"+Char:C90(Tab:K15:37))
			$primary:=Substring:C12($tNBI; 19; 1)
			Case of 
				: (Not:C34($BlankDB_b))
					//If it is not a blank DB we don't do anything.
					CREATE RECORD:C68([Bridge MHD NBIS:1])
					LoadNBIData($tNBI)
					QUERY:C277([Town Data:2]; [Town Data:2]Place_Code:5=[Bridge MHD NBIS:1]Item4:62)
					ut_Message($item8+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]Item4:62+Char:C90(Tab:K15:37)+[Town Data:2]Town Name:1+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]Item7:65+Char:C90(Tab:K15:37)+[Bridge MHD NBIS:1]Item6A:63+Char:C90(Tab:K15:37))
					ut_Message(String:C10([Bridge MHD NBIS:1]Item16A:68+([Bridge MHD NBIS:1]Item16B:69/60)+([Bridge MHD NBIS:1]Item16C:109/3600))+Char:C90(Tab:K15:37))
					ut_Message("-"+String:C10([Bridge MHD NBIS:1]Item17A:70+([Bridge MHD NBIS:1]Item17B:71/60)+([Bridge MHD NBIS:1]Item17C:136/3600))+Char:C90(Tab:K15:37))
					ut_Message(String:C10([Bridge MHD NBIS:1]Item27:83)+Char:C90(Tab:K15:37)+String:C10([Bridge MHD NBIS:1]Item106:84)+Char:C90(Tab:K15:37))
					ut_Message(String:C10([Bridge MHD NBIS:1]Item28A:86)+Char:C90(Tab:K15:37)+String:C10([Bridge MHD NBIS:1]Item29:88)+Char:C90(Tab:K15:37))
					ut_Message(String:C10([Bridge MHD NBIS:1]Item49:93)+Char:C90(Tab:K15:37)+String:C10([Bridge MHD NBIS:1]Item52:97))
					ut_Message(Char:C90(13))
					
					UNLOAD RECORD:C212([Bridge MHD NBIS:1])
					
				: (($primary="1") | ($primary=" "))
					//    10-10-2000 : CM   commented out following code ******    
					//GOTO XY(1;1)  ` 2-10-2000 : CM 
					ut_Message("Creating Record "+$item8+Char:C90(13))
					CREATE RECORD:C68([Bridge MHD NBIS:1])
					//    Inc_Sequence ("BIN";->vBIN_Dec)
					[Bridge MHD NBIS:1]BDEPT:1:=Substring:C12($item8; 1; 6)
					[Bridge MHD NBIS:1]BIN:3:=Substring:C12($item8; 7; 3)
					[Bridge MHD NBIS:1]Item8:206:=$item8
					[Bridge MHD NBIS:1]Item8 Owner:208:=Substring:C12($item8; 10; 3)
					[Bridge MHD NBIS:1]Item8 BridgeCat:207:=Substring:C12($item8; 13; 3)
					LoadNBIData($tNBI)
					If (([Bridge MHD NBIS:1]Item8 BridgeCat:207="NBI") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="634"))
						[Bridge MHD NBIS:1]FHWARecord:174:=True:C214
					End if 
					SAVE RECORD:C53([Bridge MHD NBIS:1])  //Save record resets the Ok variable so we must read a record
				Else 
					//Secondary
					//GOTO XY(1;1)  ` 2-10-2000 : CM 
					ut_Message("Creating Secondary Record "+$item8+" -"+$primary+Char:C90(13))
					CREATE RECORD:C68([NBIS Secondary:3])
					[NBIS Secondary:3]BIN:1:=Substring:C12($item8; 7; 3)
					[NBIS Secondary:3]Item8:38:=$item8
					[NBIS Secondary:3]Bridge Key:34:=Substring:C12($item8; 1; 12)
					LoadNBIData($tNBI; "Secondary")
					SAVE RECORD:C53([NBIS Secondary:3])
					
			End case 
			
		End if 
		If ($counter%40=0)
			//FLUSH CACHE
		End if 
		//read in a record-this must follow
		RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
		$tNBI:=$tBuffer
		$counter:=$counter+1
		//  2-10-2000 : CM - Line removed
		//RECEIVE PACKET($dImportFile;$tBuffer;1)  `read in line feed character for a DOS
	End while 
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
	UNLOAD RECORD:C212([NBIS Secondary:3])
	ut_CloseMessage
	CLOSE DOCUMENT:C267($dImportFile)
	$CurrMsgFolder_txt:=MessageDefDir_txt
	
End if 