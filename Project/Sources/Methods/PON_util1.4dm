//%attributes = {"invisible":true}
//Method: PON_util1
//Description
//  ` load notes from a tab delimited file into the notes field for an element
//  ` the columns in the tab delimited file are:
//  ` key Description QuantityCalc CommentaryParag1 CommentaryParag2 CommentaryParag3 CommentaryParag4
//  ` the notes field will be formatted as :
//  ` Description<br><b>Quantity Calculations :<b>QuantityCalc <Commentary>CommentaryParag1<br>CommentaryParag2<br>CommentaryParag3<br>CommentaryParag4
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/29/16, 23:06:14
	// ----------------------------------------------------
	//Created : 
	Mods_2016_01_bug
	// Modified by: Costas Manousakis-(Designer)-(2/23/16 15:01:37)
	Mods_2016_02_bug
	//  `fixed wrong <b> (bold) marker after quantity calc label - should have been </b>
End if 
//
C_TIME:C306($importDoc_t)
$importDoc_t:=Open document:C264(""; ""; Read mode:K24:5)
If (OK=1)
	C_TEXT:C284($tbuffer_txt)
	C_LONGINT:C283($linecount_L; $validKeys_L; $FoundKeys_L; $Updated_L; $locked_L; $NoUpdates_L; $NoData_L)
	$linecount_L:=0
	$validKeys_L:=0
	$FoundKeys_L:=0
	$Updated_L:=0
	$locked_L:=0
	$NoUpdates_L:=0
	$NoData_L:=0
	SHORT_MESSAGE("Scanning text file...")
	While (OK=1)
		RECEIVE PACKET:C104($importDoc_t; $tbuffer_txt; <>sCR)
		$linecount_L:=$linecount_L+1
		MESSAGE:C88("Line "+String:C10($linecount_L)+"...")
		
		If (Substring:C12($tbuffer_txt; 1; 1)=<>sLF)
			//if 1st char is a LF then skip it    
			$tbuffer_txt:=Substring:C12($tbuffer_txt; 2)
		End if 
		//exclude blank lines
		If ($tbuffer_txt#"")
			//skip fisrt line
			//MESSAGE(" tBuffer "+$tBuffer)
			ARRAY TEXT:C222($LineParts_atxt; 0)
			ut_TextToArray($tbuffer_txt; ->$LineParts_atxt; <>sTab)
			If (Size of array:C274($LineParts_atxt)>0)
				//Get the key
				C_LONGINT:C283($Key_L)
				$Key_L:=Num:C11($LineParts_atxt{1})
				QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=$Key_L)
				C_TEXT:C284($elemNotes_txt)
				$elemNotes_txt:=""
				If (Records in selection:C76([PON_ELEM_DEFS:178])>0)
					$FoundKeys_L:=$FoundKeys_L+1
					C_LONGINT:C283($loop_L)
					For ($loop_L; 2; Size of array:C274($LineParts_atxt))
						//remove any beginning or trainling quotes
						If (Length:C16($LineParts_atxt{$loop_L})>0)
							If (Substring:C12($LineParts_atxt{$loop_L}; Length:C16($LineParts_atxt{$loop_L}); 1)=Char:C90(Double quote:K15:41))
								$LineParts_atxt{$loop_L}:=Substring:C12($LineParts_atxt{$loop_L}; 1; (Length:C16($LineParts_atxt{$loop_L})-1))
							End if 
						End if 
						If (Length:C16($LineParts_atxt{$loop_L})>0)
							If (Substring:C12($LineParts_atxt{$loop_L}; 1; 1)=Char:C90(Double quote:K15:41))
								$LineParts_atxt{$loop_L}:=Substring:C12($LineParts_atxt{$loop_L}; 2)
							End if 
							
						End if 
						$LineParts_atxt{$loop_L}:=f_TrimStr($LineParts_atxt{$loop_L}; True:C214; True:C214)
						Case of 
							: ($loop_L=2)
								If ($LineParts_atxt{$loop_L}#"")
									$elemNotes_txt:=$LineParts_atxt{$loop_L}
								End if 
							: ($loop_L=3)
								If ($LineParts_atxt{$loop_L}#"")
									$elemNotes_txt:=$elemNotes_txt+"<br><b>Quantity Calculation :</b> "+$LineParts_atxt{$loop_L}
								End if 
							: ($loop_L=4)
								If ($LineParts_atxt{$loop_L}#"")
									$elemNotes_txt:=$elemNotes_txt+"<Commentary>"+$LineParts_atxt{$loop_L}
								End if 
							: ($loop_L>4)
								If ($LineParts_atxt{$loop_L}#"")
									$elemNotes_txt:=$elemNotes_txt+"<br>"+$LineParts_atxt{$loop_L}
								End if 
								
						End case 
						
					End for 
					
					If ($elemNotes_txt#"")
						
						If ($elemNotes_txt#[PON_ELEM_DEFS:178]ELEM_NOTES:19)
							If (ut_LoadRecordInteractive(->[PON_ELEM_DEFS:178]))
								[PON_ELEM_DEFS:178]ELEM_NOTES:19:=$elemNotes_txt
								LogChanges(->[PON_ELEM_DEFS:178]ELEM_NOTES:19; ->[PON_ELEM_DEFS:178]ELEM_KEY:1; ->[PON_ELEM_DEFS:178]ELEM_KEY:1; ->[PON_ELEM_DEFS:178]ELEM_KEY:1; 0)
								SAVE RECORD:C53([PON_ELEM_DEFS:178])
								$Updated_L:=$Updated_L+1
							Else 
								ALERT:C41("Key "+String:C10($Key_L)+" could not be modified - record is locked!")
								$locked_L:=$locked_L+1
							End if 
						Else 
							//no update
							$NoUpdates_L:=$NoUpdates_L+1
						End if 
					Else 
						$NoData_L:=$NoData_L+1
					End if 
				Else 
				End if 
				
			End if 
		End if 
		
	End while 
	
	CLOSE DOCUMENT:C267($importDoc_t)
	CLOSE WINDOW:C154
	C_TEXT:C284($msg_txt)
	
	$msg_txt:="Read  "+String:C10($linecount_L)+" lines"+Char:C90(13)+"Found "+String:C10($FoundKeys_L)+" valid keys"+Char:C90(13)
	$msg_txt:=$msg_txt+"No Note data in "+String:C10($NoData_L)+" Lines read"+Char:C90(13)
	$msg_txt:=$msg_txt+"Updated "+String:C10($Updated_L)+" records"+Char:C90(13)
	$msg_txt:=$msg_txt+"No Updates needed for "+String:C10($NoUpdates_L)+" records"+Char:C90(13)
	$msg_txt:=$msg_txt+String:C10($locked_L)+" records were locked."
	
	ALERT:C41($msg_txt)
End if 

//End PON_util1