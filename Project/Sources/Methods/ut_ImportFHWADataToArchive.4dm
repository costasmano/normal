//%attributes = {"invisible":true}
// Method: ut_ImportFHWADataToArchive
// Description
// Read an input text file and load into the Archive tables 
// Parameters
// $1 : $Task ("START";"LOADREC")
// $2 : $SecondtParam_txt - Depends on task
//  `  ` LOADREC : $2 = Record Line
// $3 : $ThirdParma_txt - depends on Task
//  `  ` LOADREC : $3 = Primary or Secondary record
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/06/11, 14:12:30
	// ----------------------------------------------------
	
	Mods_2011_09
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 15:59:28)
	Mods_2017_03
	//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  item 64 is rating factor or MT
	// Modified by: Costas Manousakis-(Designer)-(2023-03-14 13:11:37)
	Mods_2023_03
	//  `use ut_StartMessage, ut_Message for messaging - send log to file also 
	//  `modified searching for existing records to use BIN instead of item8 for both primary and secondary records.
	//  `added confirm whether to update Archive date and FHWARecord field for existing archive records.
	// Modified by: Costas Manousakis-(Designer)-(2023-12-05 19:51:24)
	Mods_2023_12
	//  `modified to use the File object and .getText to read the file
	//  `display progress bar 
	//  `consider 3 different cases of Item8 coding in the NBI tape file
	
End if 
C_TEXT:C284($Task_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Task_txt:=$1
Else 
	$Task_txt:="START"
End if 

Case of 
	: ($Task_txt="START")
		
		C_TIME:C306($dImportFile)
		C_TEXT:C284($tBuffer; $tNBI; $primary)
		C_LONGINT:C283($counter; $recnum)
		C_TEXT:C284($item8; $BIN)
		C_TEXT:C284($sdate)
		C_TEXT:C284($Reason_txt; $doc_txt; $Year_txt)
		C_DATE:C307($ArchiveDate_d)
		
		// start of Mods_2023_12 
		//$counter:=0
		$doc_txt:=Select document:C905(100; ".txt"; "Select the FHWA tape file"; 0)  //Prompt user
		If (Ok=1)
			C_OBJECT:C1216($Doc_o)
			$Doc_o:=File:C1566(Document; fk platform path:K87:2)
			C_TEXT:C284($FileContents_txt)
			$FileContents_txt:=$Doc_o.getText()
			C_COLLECTION:C1488($lines_c)
			$lines_c:=Split string:C1554($FileContents_txt; "\n")
			// end of Mods_2023_12 
			
			C_TEXT:C284($CurrMsgFolder_txt)
			
			//set message output folder to the folder of the import file
			$CurrMsgFolder_txt:=MessageDefDir_txt
			MessageDefDir_txt:=$Doc_o.parent.platformPath
			
			ut_StartMessage(3; "Importing "+String:C10($lines_c.length)+" FHWA Records to Bridge Archive"; 520; 200)
			
			$Year_txt:=Request:C163("Enter Year of FHWA Data for file "+$Doc_o.fullName+" (YYYY)")
			If (Num:C11($Year_txt)#0)
				$Reason_txt:="NBI TAPE "+$Year_txt
				QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$Reason_txt)
				ARRAY TEXT:C222($aitem8; Records in selection:C76([BridgeMHDNBISArchive:139]))
				ARRAY TEXT:C222($aBrKey; Records in selection:C76([BridgeMHDNBISArchive:139]))  // brkey used when importing FED records
				ARRAY TEXT:C222($aBIN; Records in selection:C76([BridgeMHDNBISArchive:139]))
				C_BOOLEAN:C305($UpdateNBIstatus_b)
				If (Records in selection:C76([BridgeMHDNBISArchive:139])>0)
					$ArchiveDate_d:=Date:C102(Request:C163("Specify new archive date"; String:C10([BridgeMHDNBISArchive:139]ArchiveDate_d:224)))  //get date from 1st rec in selection
					If ($ArchiveDate_d#!00-00-00!)
						SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item8:203; $aitem8; [BridgeMHDNBISArchive:139]Bridge Key:2; $aBrKey; [BridgeMHDNBISArchive:139]BIN:3; $aBIN)
						CONFIRM:C162("Update/change FHWARecord status and Archive date/reason?"; "Update"; "Keep as is")
						$UpdateNBIstatus_b:=(OK=1)
						
					End if 
				Else 
					$ArchiveDate_d:=Date:C102(Request:C163("Specify new archive date for file "+$Doc_o.fullName; "4/1/"+$Year_txt))
				End if 
			End if 
			
			Case of 
				: ($Reason_txt="")
					ALERT:C41("Archive Reason was blank! File will not be imported!")
				: ($ArchiveDate_d=!00-00-00!)
					ALERT:C41("Archive Date was blank! File will not be imported!")
					
				Else 
					
					C_BOOLEAN:C305($BlankDB_b)  // archive set not found
					$BlankDB_b:=(Records in selection:C76([BridgeMHDNBISArchive:139])=0)
					
					QUERY:C277([NBISSecondaryArchive:140]; [NBISSecondaryArchive:140]ArchiveReason_s:39=$Reason_txt)
					ARRAY TEXT:C222($a2nditem8; Records in selection:C76([NBISSecondaryArchive:140]))
					ARRAY TEXT:C222($a2ndBrKey; Records in selection:C76([NBISSecondaryArchive:140]))  //Command Replaced was o_ARRAY string length was 12
					ARRAY TEXT:C222($a2ndItem5; Records in selection:C76([NBISSecondaryArchive:140]))
					ARRAY TEXT:C222($a2ndBIN; Records in selection:C76([NBISSecondaryArchive:140]))
					SELECTION TO ARRAY:C260([NBISSecondaryArchive:140]Item8:38; $a2nditem8; [NBISSecondaryArchive:140]Bridge Key:34; $a2ndBrKey; \
						[NBISSecondaryArchive:140]Item5:4; $a2ndItem5; [NBISSecondaryArchive:140]BIN:1; $a2ndBIN)
					
					C_LONGINT:C283($loop_L)
					//combine BIN with item5a for searching
					For ($loop_L; 1; Size of array:C274($a2ndBIN))
						$a2ndBIN{$loop_L}:=$a2ndBIN{$loop_L}+Substring:C12($a2ndItem5{$loop_L}; 1; 1)
					End for 
					
					C_BOOLEAN:C305($Blank2nDB_b)
					$Blank2nDB_b:=(Records in selection:C76([NBISSecondaryArchive:140])=0)
					
					// start of Mods_2023_12 
					//read in the first record
					//RECEIVE PACKET($dImportFile;$tNBI;<>sCR)
					//$counter:=$counter+1  // line counter
					// end of Mods_2023_12 
					
					C_TEXT:C284($BIN; $BDEPT; $Item8Owner; $Item8Cat)
					
					C_OBJECT:C1216($Modified_o)
					
					// start of Mods_2023_12 
					C_LONGINT:C283($Item8Type_L)
					$Item8Type_L:=0  // identify what is the format of Item 8 on the tape
					// 1 : Current format BDEPT+BIN+OWNER+Category
					// 2 : BIN+Bridge Key
					// 3 : Bridge Key only
					
					
					//start the bar
					C_OBJECT:C1216($progress_o)
					$progress_o:=ProgressNew("Loading FHWA NBI Tape"; $lines_c.length; True:C214; " lines"; 3)
					
					//While (Ok=1)
					C_LONGINT:C283($linesLoaded_L)
					For ($counter; 1; $lines_c.length)
						
						//update progress
						UpdateProgressNew($progress_o; $counter)
						
						$tNBI:=$lines_c[$counter-1]
						// end of Mods_2023_12 
						
						If (Substring:C12($tNBI; 1; 1)=<>sLF)
							//if 1st char is a LF then skip it    
							$tNBI:=Substring:C12($tNBI; 2)
						End if 
						
						$item8:=Substring:C12($tNBI; 4; 15)
						$primary:=Substring:C12($tNBI; 19; 1)  // item 5a
						
						If ($Item8Type_L=0)
							//if we have not determined what Item8 type is
							$Item8Type_L:=ut_3Option_Confirm("Sample Item 8 \n<"+$item8+">\nWhich option should be used to process?\n"+\
								" 1 : Current format BDEPT+BIN+OWNER+Category\n"+\
								" 2 : BIN+Bridge Key\n"+\
								" 3 : Bridge Key only"; \
								"1"; "2"; "3")
						End if 
						
						//start of Mods_2023_12
						$BIN:=""
						$BDEPT:=""
						$Item8Owner:=""
						$Item8Cat:=""
						C_OBJECT:C1216($Bridge_o)
						
						Case of 
							: ($item8="CEPNED@")
								//FED record - match last 5 characters of item8 in tape with last 5 of Bridge key in Bridge MHD NBIS 
								$Bridge_o:=ds:C1482["Bridge MHD NBIS"].query("\"Bridge Key\" = :1"; "NED@"+Substring:C12($item8; 11))
								
								Case of 
									: ($Bridge_o.length=1)
										$BDEPT:=$Bridge_o[0].BDEPT
										$BIN:=$Bridge_o[0].BIN
										$Item8Owner:="FED"
										$Item8Cat:="NBI"
									: ($Bridge_o.length>1)
										ut_Message("Line "+String:C10($counter; "00000")+" - Item 8 = <"+$item8+"> 5A = <"+$primary+"> multiple matching Bridge keys <@"+Substring:C12($item8; 11)+"> !"+<>sCR)
									Else 
										ut_Message("Line "+String:C10($counter; "00000")+" - Item 8 = <"+$item8+"> 5A = <"+$primary+"> could not find matching Bridge key <@"+Substring:C12($item8; 11)+"> record!"+<>sCR)
								End case 
								
							: ($Item8Type_L=1)
								
								$BIN:=Substring:C12($item8; 7; 3)
								$BDEPT:=Substring:C12($item8; 1; 6)
								$Item8Owner:=Substring:C12($item8; 10; 3)
								$Item8Cat:=Substring:C12($item8; 13; 3)
								
							: ($Item8Type_L=2)
								//find bdept from current data
								$Bridge_o:=ds:C1482["Bridge MHD NBIS"].query("BIN = :1"; Substring:C12($item8; 1; 3))
								
								Case of 
									: ($Bridge_o.length=1)
										//for our records we cannot assume owner and category
										$BDEPT:=$Bridge_o[0].BDEPT
										$BIN:=$Bridge_o[0].BIN
									Else 
										//try records in the [BridgeMHDNBISArchive] table
										$Bridge_o:=ds:C1482.BridgeMHDNBISArchive.query("BIN = :1"; Substring:C12($item8; 1; 3)).orderBy("ArchiveDate_d ASC")
										
										If ($Bridge_o.length>1)
											//found at least one record in the archive table
											$BDEPT:=$Bridge_o[0].BDEPT
											$BIN:=$Bridge_o[0].BIN
										Else 
											//error finding BIN - do not create
											ut_Message("Line "+String:C10($counter; "00000")+" - Item 8 = <"+$item8+"> 5A = <"+$primary+"> , BIN = "+Substring:C12($item8; 1; 3)+" could not find Bridge record!"+<>sCR)
										End if 
										
								End case 
								
							: ($Item8Type_L=3)
								
								// find BIN BDEPT from current data based on Bridge Key
								$Bridge_o:=ds:C1482["Bridge MHD NBIS"].query("\"Bridge Key\" = :1"; f_TrimStr($item8; True:C214; True:C214))
								
								Case of 
									: ($Bridge_o.length=1)
										$BIN:=$Bridge_o[0].BIN
										$BDEPT:=$Bridge_o[0].BDEPT
										
									: ($Bridge_o.length>1)
										ut_Message("Line "+String:C10($counter; "00000")+" - Item 8 = <"+$item8+"> 5A = <"+$primary+"> Multiple Bridge Key records found!"+<>sCR)
										
									Else 
										// could not find Bridge key - do not create
										ut_Message("Line "+String:C10($counter; "00000")+" - Item 8 = <"+$item8+"> 5A = <"+$primary+"> could not find Bridge Key record!"+<>sCR)
								End case 
								
						End case 
						
						If ($BIN#"")  // try to add records only if we have a BIN
							//end of Mods_2023_12
							
							If (($primary="1") | ($primary=" "))
								//Primary Record
								$recnum:=Find in array:C230($aBIN; $BIN)
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
									GOTO SELECTED RECORD:C245([BridgeMHDNBISArchive:139]; $recnum)
									ut_Message(String:C10($counter)+" Updating primary record Item8 "+$item8+Char:C90(Carriage return:K15:38))
									ut_ImportFHWADataToArchive("LOADREC"; $tNBI)
									//[BridgeMHDNBISArchive]InspResp:="FED"
									If ($UpdateNBIstatus_b)
										[BridgeMHDNBISArchive:139]FHWARecord:173:=True:C214
										[BridgeMHDNBISArchive:139]ArchiveReason_s:223:=$Reason_txt
										[BridgeMHDNBISArchive:139]ArchiveDate_d:224:=$ArchiveDate_d
										
									End if 
									
									$Modified_o:=DB_ModifiedRecord(->[BridgeMHDNBISArchive:139])
									If ($Modified_o.Modified)
										ut_Message(String:C10($counter)+" Fields modified "+$Modified_o.AllFieldNames+Char:C90(Carriage return:K15:38))
										
									End if 
									
									SAVE RECORD:C53([BridgeMHDNBISArchive:139])  //Save record resets the OK variable so we must read a record
								Else 
									ut_Message("Import Record "+String:C10($counter)+" with Item 8 <"+$item8+"> not found in Database"+<>sCR)
									Case of 
										: (Not:C34($BlankDB_b))
											//If the archive set exists and record is not found we don't do anything.
											ut_Message("Record not created <"+$item8+">"+<>sCR)
											
										: (($primary="1") | ($primary=" "))
											ut_Message("Creating Record <"+$item8+">"+<>sCR)
											CREATE RECORD:C68([BridgeMHDNBISArchive:139])
											[BridgeMHDNBISArchive:139]BDEPT:1:=$BDEPT
											[BridgeMHDNBISArchive:139]BIN:3:=$BIN
											[BridgeMHDNBISArchive:139]Item8:203:=$item8
											[BridgeMHDNBISArchive:139]FHWAItem8:228:=$item8
											[BridgeMHDNBISArchive:139]Item8 Owner:205:=$Item8Owner
											[BridgeMHDNBISArchive:139]Item8 BridgeCat:204:=$Item8Cat
											ut_ImportFHWADataToArchive("LOADREC"; $tNBI)
											[BridgeMHDNBISArchive:139]FHWARecord:173:=True:C214
											[BridgeMHDNBISArchive:139]ArchiveReason_s:223:=$Reason_txt
											[BridgeMHDNBISArchive:139]ArchiveDate_d:224:=$ArchiveDate_d
											SAVE RECORD:C53([BridgeMHDNBISArchive:139])  //Save record resets the Ok variable so we must read a record
										Else 
											//Secondary
											ut_Message("Creating Secondary Record "+$item8+" -"+$primary+Char:C90(Carriage return:K15:38))
											CREATE RECORD:C68([NBISSecondaryArchive:140])
											[NBISSecondaryArchive:140]BIN:1:=$BIN
											[NBISSecondaryArchive:140]Item8:38:=$item8
											[NBISSecondaryArchive:140]Bridge Key:34:=Substring:C12($item8; 1; 12)
											ut_ImportFHWADataToArchive("LOADREC"; $tNBI; "Secondary")
											[NBISSecondaryArchive:140]ArchiveReason_s:39:=$Reason_txt
											[NBISSecondaryArchive:140]ArchiveDate_d:40:=$ArchiveDate_d
											SAVE RECORD:C53([NBISSecondaryArchive:140])
											
									End case 
									
								End if 
								
							Else 
								//Secondary Record
								
								$recnum:=Find in array:C230($a2ndBIN; ($BIN+$primary))
								If ($recnum<0)
									If ($Item8="CEPNED@")
										//FED record
										C_LONGINT:C283($k)
										For ($k; 1; Size of array:C274($a2ndBrKey))
											If (Substring:C12($Item8; 10)=Substring:C12($a2ndBrKey{$k}; 7))
												If ($primary=Substring:C12($a2ndItem5{$k}; 1; 1))
													$recnum:=$k
													$k:=Size of array:C274($a2ndBrKey)+1
												End if 
											End if 
										End for 
									End if 
								End if 
								
								If ($recnum>0)
									GOTO SELECTED RECORD:C245([NBISSecondaryArchive:140]; $recnum)
									ut_Message(String:C10($counter)+" Updating Secondary record ["+$primary+"]  "+$item8+Char:C90(Carriage return:K15:38))
									ut_ImportFHWADataToArchive("LOADREC"; $tNBI; "Secondary")
									
									If ($UpdateNBIstatus_b)
										[NBISSecondaryArchive:140]ArchiveReason_s:39:=$Reason_txt
										[NBISSecondaryArchive:140]ArchiveDate_d:40:=$ArchiveDate_d
									End if 
									$Modified_o:=DB_ModifiedRecord(->[NBISSecondaryArchive:140])
									If ($Modified_o.Modified)
										ut_Message(String:C10($counter)+" Fields modified "+$Modified_o.AllFieldNames+Char:C90(Carriage return:K15:38))
									End if 
									
									SAVE RECORD:C53([NBISSecondaryArchive:140])  //Save record resets the Ok variable so we must read a record
								Else 
									ut_Message("Import Record "+String:C10($counter)+" with Item 8 "+$item8+" Item5a ["+$primary+"]  not found in Database"+Char:C90(Carriage return:K15:38))
									Case of 
										: (Not:C34($Blank2nDB_b))
											//If the archive set exists and record is not found we don't do anything.
											ut_Message("Record not created "+$item8+" Item5a ["+$primary+"]"+Char:C90(Carriage return:K15:38))
											
										Else 
											//Secondary
											ut_Message("Creating Secondary Record "+$item8+" -"+$primary+Char:C90(Carriage return:K15:38))
											CREATE RECORD:C68([NBISSecondaryArchive:140])
											[NBISSecondaryArchive:140]BIN:1:=$BIN
											[NBISSecondaryArchive:140]Item8:38:=$item8
											[NBISSecondaryArchive:140]Bridge Key:34:=Substring:C12($item8; 1; 12)
											ut_ImportFHWADataToArchive("LOADREC"; $tNBI; "Secondary")
											[NBISSecondaryArchive:140]ArchiveReason_s:39:=$Reason_txt
											[NBISSecondaryArchive:140]ArchiveDate_d:40:=$ArchiveDate_d
											SAVE RECORD:C53([NBISSecondaryArchive:140])
											
									End case 
									
								End if 
								
							End if 
							
							//start of Mods_2023_12
							
						End if 
						
						//If ($counter%40=0)
						//  //FLUSH CACHE
						//End if 
						//  //read in a record-this must follow to set OK variable
						//RECEIVE PACKET($dImportFile;$tNBI;<>sCR)
						//$counter:=$counter+1
						
						$linesLoaded_L:=$counter
						//check if progress stopped
						If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
							$counter:=$lines_c.length+1
						End if 
						
					End for 
					
					//End while 
					
					//quit progress
					Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
					
					ALERT:C41("Finished Loading "+String:C10($linesLoaded_L)+" records from file")
					
					// end of Mods_2023_12 
					
			End case 
			
			ut_CloseMessage
			CLOSE DOCUMENT:C267($dImportFile)
			MessageDefDir_txt:=$CurrMsgFolder_txt  // reset the default messages folder
			
		End if 
		
	: ($Task_txt="LOADREC")
		C_TEXT:C284($2; $tNBI; $RecType)
		$tNBI:=$2
		If (Count parameters:C259>2)
			C_TEXT:C284($3)
			$RecType:=$3
		Else 
			$RecType:="Primary"
		End if 
		C_TEXT:C284($sdate)  // Command Replaced was o_C_STRING length was 255
		Case of 
			: ($RecType="Primary")
				C_TEXT:C284($tempOld; $tempNew)
				[BridgeMHDNBISArchive:139]Item5:58:=Substring:C12($tNBI; 19; 9)
				[BridgeMHDNBISArchive:139]Item2:59:=Substring:C12($tNBI; 28; 2)
				[BridgeMHDNBISArchive:139]Item3:60:=Substring:C12($tNBI; 30; 3)
				[BridgeMHDNBISArchive:139]Item4:61:=Substring:C12($tNBI; 33; 5)
				
				SIA_UpdateAlphaField(->[BridgeMHDNBISArchive:139]Item6A:62; Substring:C12($tNBI; 38; 24))
				
				[BridgeMHDNBISArchive:139]Item6B:63:=(Substring:C12($tNBI; 62; 1)="*")
				
				SIA_UpdateAlphaField(->[BridgeMHDNBISArchive:139]Item7:64; Substring:C12($tNBI; 63; 18))
				
				SIA_UpdateAlphaField(->[BridgeMHDNBISArchive:139]Item9:65; Substring:C12($tNBI; 81; 25))
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item10:101; Substring:C12($tNBI; 106; 4); 2)
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item11:66; Substring:C12($tNBI; 110; 7); 3)
				[BridgeMHDNBISArchive:139]Item12:193:=(Substring:C12($tNBI; 117; 1)="1")
				[BridgeMHDNBISArchive:139]Item 13A:194:=Substring:C12($tNBI; 118; 10)
				[BridgeMHDNBISArchive:139]Item 13B:195:=Substring:C12($tNBI; 128; 2)
				[BridgeMHDNBISArchive:139]Item16A:67:=Num:C11(Substring:C12($tNBI; 130; 2))
				[BridgeMHDNBISArchive:139]Item16B:68:=Num:C11(Substring:C12($tNBI; 132; 2))
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item16C:108; Substring:C12($tNBI; 134; 4); 2)
				
				[BridgeMHDNBISArchive:139]Item17A:69:=Num:C11(Substring:C12($tNBI; 138; 3))
				[BridgeMHDNBISArchive:139]Item17B:70:=Num:C11(Substring:C12($tNBI; 141; 2))
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item17C:135; Substring:C12($tNBI; 143; 4); 2)
				
				[BridgeMHDNBISArchive:139]Item19:90:=Num:C11(Substring:C12($tNBI; 147; 3))
				[BridgeMHDNBISArchive:139]Item20:125:=Substring:C12($tNBI; 150; 1)
				[BridgeMHDNBISArchive:139]Item21:126:=Substring:C12($tNBI; 151; 2)
				[BridgeMHDNBISArchive:139]Item22:127:=Substring:C12($tNBI; 153; 2)
				[BridgeMHDNBISArchive:139]Item26:119:=Substring:C12($tNBI; 155; 2)
				[BridgeMHDNBISArchive:139]Item27:82:=Num:C11(Substring:C12($tNBI; 157; 4))
				[BridgeMHDNBISArchive:139]Item28A:85:=Num:C11(Substring:C12($tNBI; 161; 2))
				[BridgeMHDNBISArchive:139]Item28B:86:=Num:C11(Substring:C12($tNBI; 163; 2))
				[BridgeMHDNBISArchive:139]Item29:87:=Num:C11(Substring:C12($tNBI; 165; 6))
				[BridgeMHDNBISArchive:139]Item30:88:=Num:C11(Substring:C12($tNBI; 171; 4))
				[BridgeMHDNBISArchive:139]Item31:134:=Substring:C12($tNBI; 175; 1)
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item32:97; Substring:C12($tNBI; 176; 4); 1)
				[BridgeMHDNBISArchive:139]Item33:98:=Substring:C12($tNBI; 180; 1)
				[BridgeMHDNBISArchive:139]Item34:99:=Num:C11(Substring:C12($tNBI; 181; 2))
				[BridgeMHDNBISArchive:139]Item35:100:=(Substring:C12($tNBI; 183; 1)="1")
				[BridgeMHDNBISArchive:139]Item36A:146:=Substring:C12($tNBI; 184; 1)
				[BridgeMHDNBISArchive:139]Item36B:147:=Substring:C12($tNBI; 185; 1)
				[BridgeMHDNBISArchive:139]Item36C:148:=Substring:C12($tNBI; 186; 1)
				[BridgeMHDNBISArchive:139]Item36D:149:=Substring:C12($tNBI; 187; 1)
				SIA_UpdateItem37(->[BridgeMHDNBISArchive:139]Item37:128; Substring:C12($tNBI; 188; 1))
				[BridgeMHDNBISArchive:139]Item38:112:=Substring:C12($tNBI; 189; 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item39:114; Substring:C12($tNBI; 190; 4); 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item40:116; Substring:C12($tNBI; 194; 5); 1)
				
				[BridgeMHDNBISArchive:139]Item41:140:=Substring:C12($tNBI; 199; 1)
				[BridgeMHDNBISArchive:139]Item42:84:=Substring:C12($tNBI; 200; 2)
				[BridgeMHDNBISArchive:139]Item43:74:=Substring:C12($tNBI; 202; 3)
				[BridgeMHDNBISArchive:139]Item44:75:=Substring:C12($tNBI; 205; 3)
				[BridgeMHDNBISArchive:139]Item45:76:=Num:C11(Substring:C12($tNBI; 208; 3))
				[BridgeMHDNBISArchive:139]Item46:77:=Num:C11(Substring:C12($tNBI; 211; 4))
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item47:103; Substring:C12($tNBI; 215; 3); 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item48:91; Substring:C12($tNBI; 218; 5); 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item49:92; Substring:C12($tNBI; 223; 6); 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item50A:93; Substring:C12($tNBI; 229; 3); 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item50B:94; Substring:C12($tNBI; 232; 3); 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item51:95; Substring:C12($tNBI; 235; 4); 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item52:96; Substring:C12($tNBI; 239; 4); 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item53:104; Substring:C12($tNBI; 243; 4); 2)
				
				[BridgeMHDNBISArchive:139]Item54A:106:=Substring:C12($tNBI; 247; 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item54B:107; Substring:C12($tNBI; 248; 4); 2)
				[BridgeMHDNBISArchive:139]Item55A:109:=Substring:C12($tNBI; 252; 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item55B:110; Substring:C12($tNBI; 253; 3); 1)
				
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item56:111; Substring:C12($tNBI; 256; 3); 1)
				
				[BridgeMHDNBISArchive:139]Item58:129:=Substring:C12($tNBI; 259; 1)
				[BridgeMHDNBISArchive:139]Item59:130:=Substring:C12($tNBI; 260; 1)
				[BridgeMHDNBISArchive:139]Item60:131:=Substring:C12($tNBI; 261; 1)
				[BridgeMHDNBISArchive:139]Item61:132:=Substring:C12($tNBI; 262; 1)
				[BridgeMHDNBISArchive:139]Item62:133:=Substring:C12($tNBI; 263; 1)
				[BridgeMHDNBISArchive:139]Item 63:196:=Substring:C12($tNBI; 264; 1)
				
				If (Position:C15([BridgeMHDNBISArchive:139]Item 63:196; <>SIA_LoadRtg_63_RF_txt)>0)
					SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item64:136; Substring:C12($tNBI; 265; 3); 2)
				Else 
					SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item64:136; Substring:C12($tNBI; 265; 3); 1)
				End if 
				
				[BridgeMHDNBISArchive:139]Item 65:197:=Substring:C12($tNBI; 268; 1)
				
				If (Position:C15([BridgeMHDNBISArchive:139]Item 65:197; <>SIA_LoadRtg_63_RF_txt)>0)
					SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item66:138; Substring:C12($tNBI; 269; 3); 2)
				Else 
					SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item66:138; Substring:C12($tNBI; 269; 3); 1)
				End if 
				
				[BridgeMHDNBISArchive:139]Item67:141:=Substring:C12($tNBI; 272; 1)
				[BridgeMHDNBISArchive:139]Item68:142:=Substring:C12($tNBI; 273; 1)
				[BridgeMHDNBISArchive:139]Item69:143:=Substring:C12($tNBI; 274; 1)
				[BridgeMHDNBISArchive:139]Item70:139:=Substring:C12($tNBI; 275; 1)
				[BridgeMHDNBISArchive:139]Item71:144:=Substring:C12($tNBI; 276; 1)
				[BridgeMHDNBISArchive:139]Item72:145:=Substring:C12($tNBI; 277; 1)
				[BridgeMHDNBISArchive:139]Item75A:151:=Substring:C12($tNBI; 278; 2)
				[BridgeMHDNBISArchive:139]Item75B:152:=Substring:C12($tNBI; 280; 1)
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item76:153; Substring:C12($tNBI; 281; 6); 1)
				
				SIA_UpdateDateField(->[BridgeMHDNBISArchive:139]Item90:160; Substring:C12($tNBI; 287; 4))
				
				[BridgeMHDNBISArchive:139]Item91:161:=Num:C11(Substring:C12($tNBI; 291; 2))
				[BridgeMHDNBISArchive:139]Item92AA:162:=(Substring:C12($tNBI; 293; 1)="Y")
				[BridgeMHDNBISArchive:139]Item92AB:163:=Num:C11(Substring:C12($tNBI; 294; 2))
				[BridgeMHDNBISArchive:139]Item92BA:164:=(Substring:C12($tNBI; 296; 1)="Y")
				[BridgeMHDNBISArchive:139]Item92BB:165:=Num:C11(Substring:C12($tNBI; 297; 2))
				[BridgeMHDNBISArchive:139]Item92CA:166:=(Substring:C12($tNBI; 299; 1)="Y")
				[BridgeMHDNBISArchive:139]Item92CB:167:=Num:C11(Substring:C12($tNBI; 300; 2))
				
				SIA_UpdateDateField(->[BridgeMHDNBISArchive:139]Item93A:168; Substring:C12($tNBI; 302; 4))
				
				SIA_UpdateDateField(->[BridgeMHDNBISArchive:139]Item93B:169; Substring:C12($tNBI; 306; 4))
				
				SIA_UpdateDateField(->[BridgeMHDNBISArchive:139]Item93C:170; Substring:C12($tNBI; 310; 4))
				
				[BridgeMHDNBISArchive:139]Item94:154:=Num:C11(Substring:C12($tNBI; 314; 6))
				[BridgeMHDNBISArchive:139]Item95:155:=Num:C11(Substring:C12($tNBI; 320; 6))
				[BridgeMHDNBISArchive:139]Item96:156:=Num:C11(Substring:C12($tNBI; 326; 6))
				[BridgeMHDNBISArchive:139]Item97:157:=Num:C11(Substring:C12($tNBI; 332; 4))
				[BridgeMHDNBISArchive:139]Item98A:71:=Substring:C12($tNBI; 336; 3)
				[BridgeMHDNBISArchive:139]Item98B:72:=Substring:C12($tNBI; 339; 2)
				[BridgeMHDNBISArchive:139]Item99:73:=Substring:C12($tNBI; 341; 15)
				[BridgeMHDNBISArchive:139]Item100:120:=Substring:C12($tNBI; 356; 1)
				[BridgeMHDNBISArchive:139]Item101:121:=Substring:C12($tNBI; 357; 1)
				[BridgeMHDNBISArchive:139]Item102:122:=Substring:C12($tNBI; 358; 1)
				[BridgeMHDNBISArchive:139]Item103:123:=(Substring:C12($tNBI; 359; 1)="T")
				[BridgeMHDNBISArchive:139]Item104:118:=(Substring:C12($tNBI; 360; 1)="1")
				[BridgeMHDNBISArchive:139]Item 105:198:=Substring:C12($tNBI; 361; 1)
				[BridgeMHDNBISArchive:139]Item106:83:=Num:C11(Substring:C12($tNBI; 362; 4))
				[BridgeMHDNBISArchive:139]Item107:78:=Substring:C12($tNBI; 366; 1)
				[BridgeMHDNBISArchive:139]Item108A:79:=Substring:C12($tNBI; 367; 1)
				[BridgeMHDNBISArchive:139]Item108B:80:=Substring:C12($tNBI; 368; 1)
				[BridgeMHDNBISArchive:139]Item108C:81:=Substring:C12($tNBI; 369; 1)
				[BridgeMHDNBISArchive:139]Item109:89:=Num:C11(Substring:C12($tNBI; 370; 2))
				[BridgeMHDNBISArchive:139]Item110:124:=(Substring:C12($tNBI; 372; 1)="1")
				[BridgeMHDNBISArchive:139]Item111:113:=Substring:C12($tNBI; 373; 1)
				[BridgeMHDNBISArchive:139]Item112:117:=(Substring:C12($tNBI; 374; 1)="Y")
				[BridgeMHDNBISArchive:139]Item113:150:=Substring:C12($tNBI; 375; 1)
				[BridgeMHDNBISArchive:139]Item114:158:=Num:C11(Substring:C12($tNBI; 376; 6))
				[BridgeMHDNBISArchive:139]Item115:159:=Num:C11(Substring:C12($tNBI; 382; 4))
				SIA_UpdateRealField(->[BridgeMHDNBISArchive:139]Item116:115; Substring:C12($tNBI; 386; 4); 1)
				
			: ($RecType="Secondary")
				
				[NBISSecondaryArchive:140]Item5:4:=Substring:C12($tNBI; 19; 9)
				[NBISSecondaryArchive:140]Item3:2:=Substring:C12($tNBI; 30; 3)
				[NBISSecondaryArchive:140]Item4:3:=Substring:C12($tNBI; 33; 5)
				SIA_UpdateAlphaField(->[NBISSecondaryArchive:140]Item6A:5; Substring:C12($tNBI; 38; 24))
				[NBISSecondaryArchive:140]Item6B:6:=(Substring:C12($tNBI; 62; 1)="*")
				SIA_UpdateAlphaField(->[NBISSecondaryArchive:140]Item7:7; Substring:C12($tNBI; 63; 18))
				SIA_UpdateAlphaField(->[NBISSecondaryArchive:140]Item9:8; Substring:C12($tNBI; 81; 25))
				SIA_UpdateRealField(->[NBISSecondaryArchive:140]Item10:9; Substring:C12($tNBI; 106; 4); 2)
				SIA_UpdateRealField(->[NBISSecondaryArchive:140]Item11:11; Substring:C12($tNBI; 110; 7); 3)
				[NBISSecondaryArchive:140]Item16A:12:=Num:C11(Substring:C12($tNBI; 130; 2))
				[NBISSecondaryArchive:140]Item16B:13:=Num:C11(Substring:C12($tNBI; 132; 2))
				SIA_UpdateRealField(->[NBISSecondaryArchive:140]Item16C:35; Substring:C12($tNBI; 134; 4); 2)
				[NBISSecondaryArchive:140]Item17A:14:=Num:C11(Substring:C12($tNBI; 138; 3))
				[NBISSecondaryArchive:140]Item17B:15:=Num:C11(Substring:C12($tNBI; 141; 2))
				SIA_UpdateRealField(->[NBISSecondaryArchive:140]Item17C:36; Substring:C12($tNBI; 143; 4); 2)
				[NBISSecondaryArchive:140]Item19:16:=Num:C11(Substring:C12($tNBI; 147; 3))
				[NBISSecondaryArchive:140]Item20:17:=Substring:C12($tNBI; 150; 1)
				[NBISSecondaryArchive:140]Item26:18:=Substring:C12($tNBI; 155; 2)
				[NBISSecondaryArchive:140]Item27:19:=Num:C11(Substring:C12($tNBI; 157; 4))
				[NBISSecondaryArchive:140]Item28A:20:=Num:C11(Substring:C12($tNBI; 161; 2))
				[NBISSecondaryArchive:140]Item28B:21:=Num:C11(Substring:C12($tNBI; 163; 2))
				[NBISSecondaryArchive:140]Item29:22:=Num:C11(Substring:C12($tNBI; 165; 6))
				[NBISSecondaryArchive:140]Item30:37:=Num:C11(Substring:C12($tNBI; 171; 4))
				[NBISSecondaryArchive:140]Item42:23:=Substring:C12($tNBI; 200; 2)
				[NBISSecondaryArchive:140]Item43:24:=Substring:C12($tNBI; 202; 3)
				SIA_UpdateRealField(->[NBISSecondaryArchive:140]Item47:25; Substring:C12($tNBI; 215; 3); 1)
				SIA_UpdateRealField(->[NBISSecondaryArchive:140]Item48:26; Substring:C12($tNBI; 218; 5); 1)
				SIA_UpdateRealField(->[NBISSecondaryArchive:140]Item49:27; Substring:C12($tNBI; 223; 6); 1)
				[NBISSecondaryArchive:140]Item100:28:=Substring:C12($tNBI; 356; 1)
				[NBISSecondaryArchive:140]Item101:29:=Substring:C12($tNBI; 357; 1)
				[NBISSecondaryArchive:140]Item102:30:=Substring:C12($tNBI; 358; 1)
				[NBISSecondaryArchive:140]Item103:31:=(Substring:C12($tNBI; 359; 1)="T")
				[NBISSecondaryArchive:140]Item104:32:=(Substring:C12($tNBI; 360; 1)="1")
				[NBISSecondaryArchive:140]Item109:10:=Num:C11(Substring:C12($tNBI; 370; 2))
				[NBISSecondaryArchive:140]Item110:33:=(Substring:C12($tNBI; 372; 1)="1")
				
		End case 
End case 