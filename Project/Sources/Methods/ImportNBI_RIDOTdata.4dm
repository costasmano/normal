//%attributes = {"invisible":true}
//Method: ImportNBI_RIDOTdata
//Description
// Import NBI data from RIDOT to update MassDOT records
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 7, 2023, 11:24:02
	Mods_2023_03
	// ----------------------------------------------------
	
End if 
//

C_TIME:C306($dImportFile)
C_TEXT:C284($tBuffer; $tNBI; $primary)
C_LONGINT:C283($counter)
C_TEXT:C284($item8; $item5a)

$counter:=0
$dImportFile:=Open document:C264(""; "TEXT"; Read mode:K24:5)  //Prompt user

C_TEXT:C284($doc_txt; $docFolder_txt; $CurrMsgFolder_txt; MessageDefDir_txt)
If (Ok=1)
	$doc_txt:=Document
	C_OBJECT:C1216($Doc_o)
	$Doc_o:=File:C1566(Document; fk platform path:K87:2)
	
	$docFolder_txt:=$Doc_o.parent.platformPath
	
	//set message output folder to the folder of the import file
	$CurrMsgFolder_txt:=MessageDefDir_txt
	MessageDefDir_txt:=$docFolder_txt
	
	ut_StartMessage(3; "Importing RIDOT Records"; 500; 200)
	
	ut_Message("Message"+Char:C90(Carriage return:K15:38))
	
	C_LONGINT:C283($NumBrgFields_L; $loop_L; $TableNum_L; $viFldType)
	$TableNum_L:=Table:C252(->[Bridge MHD NBIS:1])
	$NumBrgFields_L:=Get last field number:C255($TableNum_L)
	ARRAY POINTER:C280($BridgeFields_aptr; $NumBrgFields_L)
	For ($loop_L; 1; $NumBrgFields_L)
		$BridgeFields_aptr{$loop_L}:=Field:C253($TableNum_L; $loop_L)
	End for 
	
	C_TEXT:C284(vsForward)
	vsForward:=<>Forward
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
	InitChangeStack(1)
	
	//read in the first record
	RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
	$tNBI:=$tBuffer
	$counter:=$counter+1
	
	While (Ok=1)
		If (Substring:C12($tNBI; 1; 1)=<>sLF)
			//if 1st char is a LF then skip it    
			$tNBI:=Substring:C12($tNBI; 2)
		End if 
		
		$item8:=Substring:C12($tNBI; 4; 15)
		$item5a:=Substring:C12($tNBI; 19; 1)
		
		If ($item5a="1")  //we'll skip secondary records
			
			//find our record with the RIDOT struct num in item 99
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item99:74=$item8)
			If (Records in selection:C76([Bridge MHD NBIS:1])=1)
				
				If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
					ut_Message("Updating record "+[Bridge MHD NBIS:1]Item8:206+" - RIDOT Item8 = "+$item8)
					
					UpdateNBIFromBorderState($tNBI)
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
					C_LONGINT:C283($Num_updates)
					$Num_updates:=Size of array:C274(ptr_Changes{1})
					ut_Message(" - Updated "+String:C10($Num_updates)+" fields"+Char:C90(Carriage return:K15:38))
					If ($Num_updates>0)
						C_LONGINT:C283($Count)
						C_POINTER:C301($Fld_ptr)
						C_TEXT:C284($fld_message)
						For ($Count; 1; $Num_updates)
							$Fld_ptr:=ptr_Changes{1}{$Count}
							$fld_message:=" - Field : "+Field name:C257(ptr_Changes{1}{$Count})
							
							Case of 
								: (Type:C295($Fld_ptr->)=Is alpha field:K8:1) | (Type:C295($Fld_ptr->)=Is text:K8:3)
									$fld_message:=$fld_message+" old :"+Old:C35($Fld_ptr->)+" new :"+$Fld_ptr->
								: (Type:C295($Fld_ptr->)=Is integer:K8:5) | \
									(Type:C295($Fld_ptr->)=Is real:K8:4) | \
									(Type:C295($Fld_ptr->)=Is longint:K8:6) | \
									(Type:C295($Fld_ptr->)=Is date:K8:7) | \
									(Type:C295($Fld_ptr->)=Is time:K8:8)
									$fld_message:=$fld_message+" old :"+String:C10(Old:C35($Fld_ptr->))+" new :"+String:C10($Fld_ptr->)
								: (Type:C295($Fld_ptr->)=Is boolean:K8:9)
									$fld_message:=$fld_message+" old :"+Choose:C955(Old:C35($Fld_ptr->); "True"; "False")+" new :"+Choose:C955($Fld_ptr->; "True"; "False")
								Else 
									$fld_message:=$fld_message+" field type ="+fGetDataType(Type:C295($Fld_ptr->))
							End case 
							
							ut_Message($fld_message+Char:C90(Carriage return:K15:38))
						End for 
						//mark the mod date time on [bridge mhd nbis] record
						[Bridge MHD NBIS:1]Modified By:191:=Current user:C182
						[Bridge MHD NBIS:1]DateModified:194:=Current date:C33
						[Bridge MHD NBIS:1]TimeModified:195:=Current time:C178
						//add them to the stack
						PushChange(1; ->[Bridge MHD NBIS:1]Modified By:191)
						PushChange(1; ->[Bridge MHD NBIS:1]DateModified:194)
						PushChange(1; ->[Bridge MHD NBIS:1]TimeModified:195)
						
					Else 
						
						ut_Message(" - No changes made"+Char:C90(Carriage return:K15:38))
						
					End if 
					
					FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
					
					SAVE RECORD:C53([Bridge MHD NBIS:1])
					UNLOAD RECORD:C212([Bridge MHD NBIS:1])
					
				Else 
					ut_Message("Import Record "+String:C10($counter)+" with RIDOT Item 8 "+$item8+" not loaded - [Bridge mhd nbis] record was locked."+Char:C90(Carriage return:K15:38))
					
				End if 
				
			Else 
				
				ut_Message("Import Record "+String:C10($counter)+" with RIDOT Item 8 "+$item8+" not found in Database"+Char:C90(Carriage return:K15:38))
				
			End if 
			
		Else 
			ut_Message("Import Record "+String:C10($counter)+" - Secondary Record (Item5A="+$item5a+") with RIDOT Item 8 "+$item8+" not used"+Char:C90(Carriage return:K15:38))
			
		End if 
		
		//read in a record-this must follow
		RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
		$tNBI:=$tBuffer
		$counter:=$counter+1
	End while 
	
	ut_CloseMessage
	CLOSE DOCUMENT:C267($dImportFile)
	SHOW ON DISK:C922($doc_txt)
	$CurrMsgFolder_txt:=MessageDefDir_txt
	
End if 
//End ImportNBI_RIDOTdata   