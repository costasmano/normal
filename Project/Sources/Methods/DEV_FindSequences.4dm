//%attributes = {"invisible":true}
//Method: DEV_FindSequences
//Description
// Scan all methods for calls to Inc_Sequence, extract the sequence name and field used ; 
// create code to utilize ut_ScanSequences to correct the sequences; puts the code in the pasteboard.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/05/18, 14:50:15
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09_bug
End if 
//
ARRAY TEXT:C222($Methods_atxt; 0)
//start the bar
C_OBJECT:C1216($progress_Obj)
//update progress

METHOD GET PATHS:C1163(Path all objects:K72:16; $Methods_atxt)
$progress_Obj:=ProgressNew("Searching for Sequences"; Size of array:C274($Methods_atxt); True:C214; " Methods.. "; 3)

C_LONGINT:C283($loop_L)
C_TEXT:C284($methodCode_txt)
ARRAY TEXT:C222($Sequences_atxt; 0)
ARRAY TEXT:C222($Fields_atxt; 0)
ARRAY TEXT:C222($SeqMethods_atxt; 0)
For ($loop_L; 1; Size of array:C274($Methods_atxt))
	// $loop_L:=Find in array($Methods_atxt;"ADD_COMBINED_INSPECT")
	UpdateProgressNew($progress_Obj; $loop_L)
	
	METHOD GET CODE:C1190($Methods_atxt{$loop_L}; $methodCode_txt)
	C_BOOLEAN:C305($incSeq_b)
	C_LONGINT:C283($start_L)
	ARRAY LONGINT:C221($start_aL; 0)
	ARRAY LONGINT:C221($len_aL; 0)
	$start_L:=1
	C_TEXT:C284($seq_txt)
	Repeat 
		$incSeq_b:=Match regex:C1019("\r(Inc_Sequence \\(\")(.*)(\";)(.*)(\\))(.*)\r"; $methodCode_txt; $start_L; $start_aL; $len_aL)
		If ($incSeq_b)
			$seq_txt:=Substring:C12($methodCode_txt; $start_aL{2}; $len_aL{2})
			APPEND TO ARRAY:C911($Sequences_atxt; $seq_txt)
			APPEND TO ARRAY:C911($Fields_atxt; Substring:C12($methodCode_txt; $start_aL{4}; $len_aL{4}))
			APPEND TO ARRAY:C911($SeqMethods_atxt; $Methods_atxt{$loop_L})
			$start_L:=$start_aL{6}
		End if 
	Until ((Not:C34($incSeq_b)) | (Progress Stopped(OB Get:C1224($progress_Obj; "progress"; Is longint:K8:6))))
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($progress_Obj; "progress"; Is longint:K8:6)))
		//abort loop
		$loop_L:=Size of array:C274($Methods_atxt)+1
	End if 
	
End for 
//quit progress
Progress QUIT(OB Get:C1224($progress_Obj; "progress"; Is longint:K8:6))

//SORT ARRAY($Sequences_atxt;$Fields_atxt;$SeqMethods_atxt;>)
MULTI SORT ARRAY:C718($Sequences_atxt; >; $Fields_atxt; >; $SeqMethods_atxt)
//Build method text
C_TEXT:C284($methodCode_txt)
$methodCode_txt:=""
C_LONGINT:C283($loop_L; $DuplField_L)
READ ONLY:C145([Sequences:28])
C_BOOLEAN:C305($missing_seq_b)
For ($loop_L; 1; Size of array:C274($Sequences_atxt))
	If ($Sequences_atxt{$loop_L}#$Sequences_atxt{$loop_L-1}) & ($Fields_atxt{$loop_L}#$Fields_atxt{$loop_L-1})
		//check if sequence exists in table 
		QUERY:C277([Sequences:28]; [Sequences:28]Name:1=$Sequences_atxt{$loop_L})
		$missing_seq_b:=(Records in selection:C76([Sequences:28])=0)
		
		$methodCode_txt:=$methodCode_txt+"MESSAGE(Char(13)+\""+Replace string:C233($Sequences_atxt{$loop_L}; "\""; "")+" ...\")"+"` "+$SeqMethods_atxt{$loop_L}+Char:C90(13)
		If ($missing_seq_b)
			$methodCode_txt:=$methodCode_txt+"` ****  Sequence "+$Sequences_atxt{$loop_L}+" Not found in table ! ****"+Char:C90(13)
		End if 
		If ($Fields_atxt{$loop_L}="->[@")
			//Field is a pointer to a table field
			//check if the field is used elsewhere too
			$DuplField_L:=Find in array:C230($Fields_atxt; $Fields_atxt{$loop_L})
			
			If ($DuplField_L#$loop_L)
				//found it - before this one!
				$methodCode_txt:=$methodCode_txt+"ut_FixSequence ( \""+$Sequences_atxt{$loop_L}+"\";"+$Fields_atxt{$loop_L}+") ` **** Field is used also for sequence "+$Sequences_atxt{$DuplField_L}+Char:C90(13)+Char:C90(13)
			Else 
				//not found - ok
				$methodCode_txt:=$methodCode_txt+"ut_FixSequence ( \""+$Sequences_atxt{$loop_L}+"\";"+$Fields_atxt{$loop_L}+")"+Char:C90(13)+Char:C90(13)
			End if 
			
		Else 
			// points to Something else - comment line and add alert!
			$methodCode_txt:=$methodCode_txt+"` ut_FixSequence ( \""+$Sequences_atxt{$loop_L}+"\";"+$Fields_atxt{$loop_L}+") ` ****  Investigate this one!"+Char:C90(13)+Char:C90(13)
		End if 
		
	End if 
End for 

SET TEXT TO PASTEBOARD:C523($methodCode_txt)
ALERT:C41("Code Text has been placed on the pasteboard!  check for comments with **** ")
//End DEV_FindSequences