//%attributes = {"invisible":true}
//Method: ut_CheckMissingSeqScans
//Description
//  ` Method to check if there are sequences in the data file that are not in the ut_ScanSequences method
//  `Currently need to place a copy of the ut_ScanSequences in the clipboard , then run this method.
//  `It will place the missing seqs back in the clipboard so they can be pasted in ut_ScanSequences
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/23/14, 16:44:19
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
C_TEXT:C284($scanmethod_txt; $Missing_txt; $fixCommand_txt)
$scanmethod_txt:=Get text from pasteboard:C524
$fixCommand_txt:="ut_FixSequence ("+Char:C90(34)
If (Position:C15($fixCommand_txt; $scanmethod_txt)>0)
	ARRAY TEXT:C222($sequences_atxt; 0)
	
	Begin SQL
		select [Sequences].Name
		from [Sequences]
		into :$sequences_atxt
	End SQL
	$Missing_txt:=""
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($sequences_atxt))
		If ($sequences_atxt{$loop_L}#"")
			
			If (Position:C15((Char:C90(34)+$sequences_atxt{$loop_L}+Char:C90(34)); $scanmethod_txt)>0)
			Else 
				ALERT:C41("Sequence "+$sequences_atxt{$loop_L}+" is missing in the scan method !")
				$Missing_txt:=$Missing_txt+"MESSAGE(Char(13)+"+Char:C90(34)+$sequences_atxt{$loop_L}+" ..."+Char:C90(34)+")"+Char:C90(13)
				$Missing_txt:=$Missing_txt+"ut_FixSequence ("+Char:C90(34)+$sequences_atxt{$loop_L}+Char:C90(34)+";-> FIELDNAMEHere)"+Char:C90(13)
			End if 
			
		End if 
		
	End for 
	
	If ($Missing_txt#"")
		ALERT:C41("Placing missing sequences in clipboard!")
		SET TEXT TO PASTEBOARD:C523($Missing_txt)
	Else 
		ALERT:C41("Nothing missing!")
	End if 
	
Else 
	ALERT:C41("The text in the clipboard is probably not the contents of ut_ScanSequences method! First copy the contents of ut_ScanSequences, and then run this method.")
End if 


//End ut_CheckMissingSeqScans