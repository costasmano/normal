//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/11/11, 15:31:36
	// ----------------------------------------------------
	// Method: ut_ImportDBFToArchive
	// Description
	//  ` Import exported DBF files from Bridge Mhd NBIS table to the [BridgeMHDNBISArchive] table. 
	//  `Import is designed to use form [BridgeMHDNBISArchive];"DBFImport" as a template
	//  `for import. Contains code to set the Archive date and Archive reason fields.
	//  `Will load first the .dbf files, then load text files to update some of the fields that are not
	//  `included in the dbf export. IF a matching series of records in the [BridgeMHDNBISArchive]
	//  `is not found, records will be created.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_02
End if 
C_TEXT:C284(MHDARCHIVEREASON_TXT)
C_DATE:C307(MHDARCHIVEDATE_D)

MHDARCHIVEREASON_TXT:=Request:C163("Enter Archive Reason"; "MONTHLYARCHIVE")
C_TEXT:C284($Importfile_txt; $Y_txt; $M_txt; $D_txt; $ImportProj_txt; $UpdatePart_txt; $UpdateLine_txt; $UpdatePart2_txt)
C_TEXT:C284($Y_txt; $M_txt; $D_txt; $Msg_txt)
ARRAY TEXT:C222($SelectedFiles_atxt; 0)
ARRAY TEXT:C222($SelectImportProj_atxt; 0)
C_LONGINT:C283($loop_L; $Y_L; $M_L; $D_L; $DataHere_L; $CR_L; $offset_L)
C_BLOB:C604($ImportProj_blb)

$Importfile_txt:=Select document:C905(1; "F+DB"; "Pick the DBF Files to Import!!!"; (Multiple files:K24:7+Use sheet window:K24:11); $SelectedFiles_atxt)
If (Size of array:C274($SelectedFiles_atxt)>0)
	$ImportProj_txt:=Select document:C905(0; "4DSI"; "Select Import Project"; Use sheet window:K24:11; $SelectImportProj_atxt)
	If (Size of array:C274($SelectImportProj_atxt)>0)
		DOCUMENT TO BLOB:C525($SelectImportProj_atxt{1}; $ImportProj_blb)
	End if 
	
	For ($loop_L; 1; Size of array:C274($SelectedFiles_atxt))
		$Importfile_txt:=$SelectedFiles_atxt{$loop_L}
		$Importfile_txt:=Replace string:C233($Importfile_txt; GetPath($Importfile_txt); "")
		$Y_txt:=Substring:C12($Importfile_txt; 1; 4)
		$M_txt:=Replace string:C233($Importfile_txt; $Y_txt; "")
		$M_txt:=Substring:C12($M_txt; 2)
		$M_txt:=Substring:C12($M_txt; 1; (Position:C15("_"; $M_txt)-1))
		$D_txt:=Replace string:C233($Importfile_txt; ($Y_txt+"_"+$M_txt+"_"); "")
		$D_txt:=Substring:C12($D_txt; 1; (Position:C15("."; $D_txt)-1))
		MHDARCHIVEDATE_D:=Date:C102($M_txt+"/"+$D_txt+"/"+$Y_txt)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $DataHere_L)
		QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=MHDARCHIVEREASON_TXT; *)
		QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=MHDARCHIVEDATE_D)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$Msg_txt:=" for file "+String:C10($loop_L)+" of "+String:C10(Size of array:C274($SelectedFiles_atxt))+" selected files!"
		If ($DataHere_L=0)
			//do import
			ALERT:C41("Inporting archive data for date "+String:C10(MHDARCHIVEDATE_D; Internal date short:K1:7)+$Msg_txt)
			IMPORT DATA:C665($SelectedFiles_atxt{$loop_L}; $ImportProj_blb; *)
			//FLUSH CACHE
		Else 
			ALERT:C41("There are already "+String:C10($DataHere_L)+" archived records for "+MHDARCHIVEREASON_TXT+" date "+String:C10(MHDARCHIVEDATE_D; Internal date short:K1:7)+$Msg_txt)
		End if 
		
	End for 
	
End if 

$Importfile_txt:=Select document:C905(1; "TEXT"; "Pick the text Files to Update with!!!"; (Multiple files:K24:7+Use sheet window:K24:11); $SelectedFiles_atxt)
READ WRITE:C146([BridgeMHDNBISArchive:139])

If (Size of array:C274($SelectedFiles_atxt)>0)
	For ($loop_L; 1; Size of array:C274($SelectedFiles_atxt))
		$Importfile_txt:=$SelectedFiles_atxt{$loop_L}
		$Importfile_txt:=Replace string:C233($Importfile_txt; GetPath($Importfile_txt); "")
		$Y_txt:=Substring:C12($Importfile_txt; 1; 4)
		$M_txt:=Replace string:C233($Importfile_txt; $Y_txt; "")
		$M_txt:=Substring:C12($M_txt; 2)
		$M_txt:=Substring:C12($M_txt; 1; (Position:C15("."; $M_txt)-1))
		MHDARCHIVEDATE_D:=Date:C102($M_txt+"/01/"+$Y_txt)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $DataHere_L)
		QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=MHDARCHIVEREASON_TXT; *)
		QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=MHDARCHIVEDATE_D)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$Msg_txt:=" ("+String:C10($loop_L)+" of "+String:C10(Size of array:C274($SelectedFiles_atxt))+")"
		C_BOOLEAN:C305($CreateNew_b; $LoadFile_b)
		$CreateNew_b:=False:C215
		If ($DataHere_L>0)
			SHORT_MESSAGE("Updating archives "+MHDARCHIVEREASON_TXT+" date "+String:C10(MHDARCHIVEDATE_D; Internal date short:K1:7))
			$LoadFile_b:=True:C214
		Else 
			CONFIRM:C162("There are no archived records for "+MHDARCHIVEREASON_TXT+" date "+String:C10(MHDARCHIVEDATE_D; Internal date short:K1:7)+$Msg_txt+"!!  Add to the Archive?"; "ADD"; "Cancel")
			$CreateNew_b:=(OK=1)
			$LoadFile_b:=(OK=1)
			If ($LoadFile_b)
				SHORT_MESSAGE("Loading archives "+MHDARCHIVEREASON_TXT+" date "+String:C10(MHDARCHIVEDATE_D; Internal date short:K1:7))
			End if 
			
		End if 
		If ($LoadFile_b)
			$offset_L:=0
			C_BOOLEAN:C305($Done_b)
			$Done_b:=False:C215
			DOCUMENT TO BLOB:C525($SelectedFiles_atxt{$loop_L}; $ImportProj_blb)
			$UpdatePart_txt:=BLOB to text:C555($ImportProj_blb; Mac text without length:K22:10; $offset_L)
			$CR_L:=Position:C15(<>sCR; $UpdatePart_txt)
			$UpdatePart_txt:=Substring:C12($UpdatePart_txt; ($CR_L+1))
			While (Not:C34($Done_b))
				$CR_L:=Position:C15(<>sCR; $UpdatePart_txt)
				If ($CR_L<=0)
					//see if we can load more
					$UpdatePart2_txt:=BLOB to text:C555($ImportProj_blb; Mac text without length:K22:10; $offset_L)
					If (Length:C16($UpdatePart2_txt)=0)
						$Done_b:=True:C214
					Else 
						$UpdatePart_txt:=$UpdatePart_txt+$UpdatePart2_txt
						$CR_L:=Position:C15(<>sCR; $UpdatePart_txt)
						If ($CR_L<=0)
							//still no CR - done
							$Done_b:=True:C214
						End if 
						
					End if 
					
				Else 
					ARRAY TEXT:C222(TextVals_atxt; 0)
					$UpdateLine_txt:=Substring:C12($UpdatePart_txt; 1; ($CR_L-1))
					$UpdatePart_txt:=Substring:C12($UpdatePart_txt; ($CR_L+1))
					$UpdateLine_txt:=Replace string:C233($UpdateLine_txt; "'"; "")
					ut_TextToArray($UpdateLine_txt; ->TextVals_atxt; <>sTab)
					If (Size of array:C274(TextVals_atxt)=13)
						MESSAGE:C88(TextVals_atxt{3}+"...")
						If ($CreateNew_b)
							CREATE RECORD:C68([BridgeMHDNBISArchive:139])
							[BridgeMHDNBISArchive:139]ArchiveReason_s:223:=MHDARCHIVEREASON_TXT
							[BridgeMHDNBISArchive:139]ArchiveDate_d:224:=MHDARCHIVEDATE_D
							[BridgeMHDNBISArchive:139]BDEPT:1:=TextVals_atxt{1}
							[BridgeMHDNBISArchive:139]Town Name:174:=TextVals_atxt{2}
							[BridgeMHDNBISArchive:139]BIN:3:=TextVals_atxt{3}
							[BridgeMHDNBISArchive:139]Item8:203:=TextVals_atxt{4}
							[BridgeMHDNBISArchive:139]Item7:64:=TextVals_atxt{5}
							[BridgeMHDNBISArchive:139]Item6A:62:=TextVals_atxt{6}
							[BridgeMHDNBISArchive:139]Item58:129:=TextVals_atxt{7}
							[BridgeMHDNBISArchive:139]Item59:130:=TextVals_atxt{8}
							[BridgeMHDNBISArchive:139]Item60:131:=TextVals_atxt{9}
							[BridgeMHDNBISArchive:139]Item2:59:=TextVals_atxt{10}
							[BridgeMHDNBISArchive:139]AASHTO:5:=Num:C11(TextVals_atxt{11})
							[BridgeMHDNBISArchive:139]Item21:126:=TextVals_atxt{12}
							[BridgeMHDNBISArchive:139]Item41:140:=TextVals_atxt{13}
							[BridgeMHDNBISArchive:139]Item8 BridgeCat:204:=Substring:C12([BridgeMHDNBISArchive:139]Item8:203; 13)
							[BridgeMHDNBISArchive:139]Item8 Owner:205:=Substring:C12([BridgeMHDNBISArchive:139]Item8:203; 10; 3)
							[BridgeMHDNBISArchive:139]FHWARecord:173:=True:C214
							[BridgeMHDNBISArchive:139]StructDef:102:=True:C214
							SAVE RECORD:C53([BridgeMHDNBISArchive:139])
						Else 
							QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=MHDARCHIVEREASON_TXT; *)
							QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=MHDARCHIVEDATE_D; *)
							QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]BIN:3=TextVals_atxt{3})
							If (Records in selection:C76([BridgeMHDNBISArchive:139])=1)
								LOAD RECORD:C52([BridgeMHDNBISArchive:139])
								If ([BridgeMHDNBISArchive:139]Town Name:174#TextVals_atxt{2})
									[BridgeMHDNBISArchive:139]Town Name:174:=TextVals_atxt{2}
								End if 
								If ([BridgeMHDNBISArchive:139]Item7:64#TextVals_atxt{5})
									[BridgeMHDNBISArchive:139]Item7:64:=TextVals_atxt{5}
								End if 
								If ([BridgeMHDNBISArchive:139]Item6A:62#TextVals_atxt{6})
									[BridgeMHDNBISArchive:139]Item6A:62:=TextVals_atxt{6}
								End if 
								If ([BridgeMHDNBISArchive:139]Item2:59#TextVals_atxt{10})
									[BridgeMHDNBISArchive:139]Item2:59:=TextVals_atxt{10}
								End if 
								If ([BridgeMHDNBISArchive:139]AASHTO:5#Num:C11(TextVals_atxt{11}))
									[BridgeMHDNBISArchive:139]AASHTO:5:=Num:C11(TextVals_atxt{11})
								End if 
								If ([BridgeMHDNBISArchive:139]Item21:126#TextVals_atxt{12})
									[BridgeMHDNBISArchive:139]Item21:126:=TextVals_atxt{12}
								End if 
								
								SAVE RECORD:C53([BridgeMHDNBISArchive:139])
							End if 
							
						End if 
						
					End if 
					
				End if 
				
			End while 
			CLOSE WINDOW:C154
			
		End if 
		
	End for 
	
End if 