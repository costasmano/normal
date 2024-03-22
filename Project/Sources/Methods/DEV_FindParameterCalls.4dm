//%attributes = {"invisible":true}
//Method: DEV_FindParameterCalls
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/11/20, 16:36:47
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
End if 
//

ARRAY TEXT:C222($Methods_atxt; 0)
//start the bar
C_OBJECT:C1216($progress_Obj)
//update progress

METHOD GET PATHS:C1163(Path all objects:K72:16; $Methods_atxt)
$progress_Obj:=ProgressNew("Searching for Parameters"; Size of array:C274($Methods_atxt); True:C214; " Methods.. "; 3)

C_LONGINT:C283($loop_L)
C_TEXT:C284($methodCode_txt)
ARRAY TEXT:C222($Sequences_atxt; 0)
ARRAY TEXT:C222($Fields_atxt; 0)
ARRAY TEXT:C222($SeqMethods_atxt; 0)
For ($loop_L; 1; Size of array:C274($Methods_atxt))
	// $loop_L:=Find in array($Methods_atxt;"sc_setranking")
	UpdateProgressNew($progress_Obj; $loop_L)
	ARRAY LONGINT:C221($starts_aL; 0)
	METHOD GET CODE:C1190($Methods_atxt{$loop_L}; $methodCode_txt)
	C_BOOLEAN:C305($incSeq_b)
	C_LONGINT:C283($start_L)
	ARRAY LONGINT:C221($start_aL; 0)
	ARRAY LONGINT:C221($len_aL; 0)
	C_TEXT:C284($seq_txt)
	
	// ut_GetSysParameter with two extra parameters
	$start_L:=1
	Repeat 
		$incSeq_b:=Match regex:C1019("(ut_GetSysParameter \\(\")(.*)(\";\")(.*)(\";\")(.*)(\"\\))(.*)\r"; $methodCode_txt; $start_L; $start_aL; $len_aL)
		If ($incSeq_b)
			APPEND TO ARRAY:C911($starts_aL; $start_aL{1})
			$seq_txt:=Substring:C12($methodCode_txt; $start_aL{2}; $len_aL{2})
			APPEND TO ARRAY:C911($Sequences_atxt; $seq_txt)
			
			If (Substring:C12($methodCode_txt; $start_aL{4}; $len_aL{4})="")
				APPEND TO ARRAY:C911($Fields_atxt; "NoDefault")
			Else 
				APPEND TO ARRAY:C911($Fields_atxt; Substring:C12($methodCode_txt; $start_aL{4}; $len_aL{4}))
			End if   //APPEND TO ARRAY($Fields_atxt;Substring($methodCode_txt;$start_aL{4};$len_aL{4}))
			APPEND TO ARRAY:C911($SeqMethods_atxt; $Methods_atxt{$loop_L})
			$start_L:=$start_aL{6}
		End if 
	Until ((Not:C34($incSeq_b)) | (Progress Stopped(OB Get:C1224($progress_Obj; "progress"; Is longint:K8:6))))
	
	// ut_GetSysParameter with one extra parameters - the default
	$start_L:=1
	Repeat 
		$incSeq_b:=Match regex:C1019("(ut_GetSysParameter \\(\")(.*)(\";\")(.*)(\"\\))(.*)\r"; $methodCode_txt; $start_L; $start_aL; $len_aL)
		If ($incSeq_b)
			If (Find in array:C230($starts_aL; $start_aL{1})>0)
				//occurance has been found already
			Else 
				
				APPEND TO ARRAY:C911($starts_aL; $start_aL{1})
				
				$seq_txt:=Substring:C12($methodCode_txt; $start_aL{2}; $len_aL{2})
				APPEND TO ARRAY:C911($Sequences_atxt; $seq_txt)
				
				If (Substring:C12($methodCode_txt; $start_aL{4}; $len_aL{4})="")
					APPEND TO ARRAY:C911($Fields_atxt; "NoDefault")
				Else 
					APPEND TO ARRAY:C911($Fields_atxt; Substring:C12($methodCode_txt; $start_aL{4}; $len_aL{4}))
				End if 
				APPEND TO ARRAY:C911($SeqMethods_atxt; $Methods_atxt{$loop_L})
				
			End if 
			$start_L:=$start_aL{6}
			
		End if 
	Until ((Not:C34($incSeq_b)) | (Progress Stopped(OB Get:C1224($progress_Obj; "progress"; Is longint:K8:6))))
	
	$start_L:=1
	// ut_GetSysParameter with only parameter
	Repeat 
		$incSeq_b:=Match regex:C1019("(ut_GetSysParameter \\(\")(.*)(\"\\))(.*)\r"; $methodCode_txt; $start_L; $start_aL; $len_aL)
		If ($incSeq_b)
			
			If (Find in array:C230($starts_aL; $start_aL{1})>0)
				
			Else 
				APPEND TO ARRAY:C911($starts_aL; $start_aL{1})
				
				$seq_txt:=Substring:C12($methodCode_txt; $start_aL{2}; $len_aL{2})
				APPEND TO ARRAY:C911($Sequences_atxt; $seq_txt)
				APPEND TO ARRAY:C911($Fields_atxt; "NoDefault")
				APPEND TO ARRAY:C911($SeqMethods_atxt; $Methods_atxt{$loop_L})
			End if 
			
			$start_L:=$start_aL{4}
		End if 
	Until ((Not:C34($incSeq_b)) | (Progress Stopped(OB Get:C1224($progress_Obj; "progress"; Is longint:K8:6))))
	
	$start_L:=1
	// direct query ;[Parameters]ParamCode="
	Repeat 
		$incSeq_b:=Match regex:C1019("(;\\[Parameters\\]ParamCode=\")(.*)(\"\\))(.*)\r"; $methodCode_txt; $start_L; $start_aL; $len_aL)
		If ($incSeq_b)
			
			If (Find in array:C230($starts_aL; $start_aL{1})>0)
				
			Else 
				APPEND TO ARRAY:C911($starts_aL; $start_aL{1})
				
				$seq_txt:=Substring:C12($methodCode_txt; $start_aL{2}; $len_aL{2})
				APPEND TO ARRAY:C911($Sequences_atxt; $seq_txt)
				APPEND TO ARRAY:C911($Fields_atxt; "Direct")
				APPEND TO ARRAY:C911($SeqMethods_atxt; $Methods_atxt{$loop_L})
			End if 
			
			$start_L:=$start_aL{4}
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
MULTI SORT ARRAY:C718($Sequences_atxt; >; $SeqMethods_atxt; $Fields_atxt)
//Build method text
$progress_Obj:=ProgressNew("Building text "; Size of array:C274($Sequences_atxt); True:C214; " Parameters.. "; 3)
C_TEXT:C284($methodCode_txt)
$methodCode_txt:=""
C_LONGINT:C283($loop_L; $DuplField_L)
READ ONLY:C145([Sequences:28])
C_BOOLEAN:C305($missing_seq_b)
For ($loop_L; 1; Size of array:C274($Sequences_atxt))
	UpdateProgressNew($progress_Obj; $loop_L)
	QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$Sequences_atxt{$loop_L})
	$missing_seq_b:=(Records in selection:C76([Parameters:107])=0)
	
	$methodCode_txt:=$methodCode_txt+$Sequences_atxt{$loop_L}+Char:C90(Tab:K15:37)+$Fields_atxt{$loop_L}+Char:C90(Tab:K15:37)+$SeqMethods_atxt{$loop_L}
	If ($missing_seq_b)
		$methodCode_txt:=$methodCode_txt+Char:C90(Tab:K15:37)+"Not found in table!"
	End if 
	$methodCode_txt:=$methodCode_txt+Char:C90(Carriage return:K15:38)
End for 
//quit progress
Progress QUIT(OB Get:C1224($progress_Obj; "progress"; Is longint:K8:6))

SET TEXT TO PASTEBOARD:C523($methodCode_txt)
ALERT:C41("Parameter Text has been placed on the pasteboard!")

//End DEV_FindParameterCalls