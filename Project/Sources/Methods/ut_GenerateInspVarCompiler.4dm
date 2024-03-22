//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/26/10, 09:50:57
	// ----------------------------------------------------
	// Method: Method: ut_GenerateInspVarCompiler
	// Description
	// Generate a text file with compiler directives for all Inspection variables. based on
	// the records in [ElementDict]
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_07
	// Modified by: costasmanousakis-(Designer)-(12/23/10 15:11:46)
	Mods_2010_12
	//  `Added Lines for  variables :Previous Insp Rating for Inspection Evaluation form
	
End if 
READ ONLY:C145([ElementDict:30])
ALL RECORDS:C47([ElementDict:30])
C_LONGINT:C283($NumElem_L)
$NumElem_L:=Records in selection:C76([ElementDict:30])
If ($NumElem_L>0)
	C_TIME:C306($CompFile_tm)
	$CompFile_tm:=Create document:C266("")
	If (OK=1)
		
		ARRAY INTEGER:C220($ElNos_ai; $NumElem_L)
		SELECTION TO ARRAY:C260([ElementDict:30]ElementNo:1; $ElNos_ai)
		SORT ARRAY:C229($ElNos_ai)
		ARRAY TEXT:C222($ElCompDir_atxt; 0)
		ARRAY TEXT:C222($ElVarPref_atxt; 0)
		ARRAY TEXT:C222($ElVarDesc_atxt; 0)
		APPEND TO ARRAY:C911($ElCompDir_atxt; "C_String(1")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vR")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Element Ratings")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(1;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vPR")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Previous Insp Rating for Inspection Evaluation form")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "C_String(1")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vRd")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Element UW Ratings")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "C_String(6")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vD")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Element Deficiencies")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "C_String(50")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vT")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Element Description")
		C_LONGINT:C283($loop_L; $Out_L; $In_L; $NumPerLine_L)
		C_TEXT:C284($Line_txt; $ClipBrd_txt)
		$NumPerLine_L:=13
		$ClipBrd_txt:=""
		For ($loop_L; 1; Size of array:C274($ElVarPref_atxt))
			SEND PACKET:C103($CompFile_tm; ($ElVarDesc_atxt{$loop_L}+Char:C90(13)))
			$ClipBrd_txt:=$ClipBrd_txt+$ElVarDesc_atxt{$loop_L}+Char:C90(13)
			For ($Out_L; 1; $NumElem_L; $NumPerLine_L)
				$Line_txt:=$ElCompDir_atxt{$loop_L}
				
				For ($In_L; $Out_L; MinNum(($Out_L+$NumPerLine_L-1); $NumElem_L))
					$Line_txt:=$Line_txt+";"+$ElVarPref_atxt{$loop_L}+String:C10($ElNos_ai{$In_L})
					
				End for 
				$Line_txt:=$Line_txt+")"+Char:C90(13)
				SEND PACKET:C103($CompFile_tm; $Line_txt)
				$ClipBrd_txt:=$ClipBrd_txt+$Line_txt
			End for 
			SEND PACKET:C103($CompFile_tm; Char:C90(13))
			$ClipBrd_txt:=$ClipBrd_txt+Char:C90(13)
		End for 
		
		ARRAY TEXT:C222($ElCompDir_atxt; 0)
		ARRAY TEXT:C222($ElVarPref_atxt; 0)
		ARRAY TEXT:C222($ElVarDesc_atxt; 0)
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_text(")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vItem")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Item numbers  --  UW Spec memb page")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_text(")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vMember")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Member Description")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_text(")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vRemarks")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Item Comments")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(1;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vprevR")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Prev Rating")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(1;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vR")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Current Rating")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(6;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vDEF")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Deficiency")
		$NumElem_L:=6
		For ($loop_L; 1; Size of array:C274($ElVarPref_atxt))
			SEND PACKET:C103($CompFile_tm; ($ElVarDesc_atxt{$loop_L}+Char:C90(13)))
			$ClipBrd_txt:=$ClipBrd_txt+$ElVarDesc_atxt{$loop_L}+Char:C90(13)
			For ($Out_L; 1; $NumElem_L; $NumPerLine_L)
				$Line_txt:=$ElCompDir_atxt{$loop_L}+$ElVarPref_atxt{$loop_L}+String:C10($Out_L; "00")
				For ($In_L; ($Out_L+1); MinNum(($Out_L+$NumPerLine_L-1); $NumElem_L))
					$Line_txt:=$Line_txt+";"+$ElVarPref_atxt{$loop_L}+String:C10($In_L; "00")
					
				End for 
				$Line_txt:=$Line_txt+")"+Char:C90(13)
				SEND PACKET:C103($CompFile_tm; $Line_txt)
				$ClipBrd_txt:=$ClipBrd_txt+$Line_txt
			End for 
			SEND PACKET:C103($CompFile_tm; Char:C90(13))
			$ClipBrd_txt:=$ClipBrd_txt+Char:C90(13)
			
		End for 
		ARRAY TEXT:C222($ElCompDir_atxt; 0)
		ARRAY TEXT:C222($ElVarPref_atxt; 0)
		ARRAY TEXT:C222($ElVarDesc_atxt; 0)
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_text(")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vLetter")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Item letter -- Second Special Member page")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_text(")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vMember")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Member Description")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_text(")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vRemarks")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Item Comments")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(1;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vprevR")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Prev Rating")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(1;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vR")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Current Rating")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(1;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vPR")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Previous Insp Rating for Inspection Evaluation form")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(6;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vDEF")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Deficiency")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(1;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vCrack")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Crack condition")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(1;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vWeld")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Weld Condition")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(44;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vNotRated_")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Not Rated Text")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(3;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vH20_")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` H20 Rating")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(3;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "vTyp3_")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` Typ3 Rating")
		APPEND TO ARRAY:C911($ElCompDir_atxt; "c_string(3;")
		APPEND TO ARRAY:C911($ElVarPref_atxt; "v3S2_")
		APPEND TO ARRAY:C911($ElVarDesc_atxt; "` 3S2 Rating")
		
		$NumElem_L:=22
		For ($loop_L; 1; Size of array:C274($ElVarPref_atxt))
			SEND PACKET:C103($CompFile_tm; ($ElVarDesc_atxt{$loop_L}+Char:C90(13)))
			$ClipBrd_txt:=$ClipBrd_txt+$ElVarDesc_atxt{$loop_L}+Char:C90(13)
			For ($Out_L; 1; $NumElem_L; $NumPerLine_L)
				$Line_txt:=$ElCompDir_atxt{$loop_L}+$ElVarPref_atxt{$loop_L}+String:C10($Out_L)
				
				For ($In_L; ($Out_L+1); MinNum(($Out_L+$NumPerLine_L-1); $NumElem_L))
					$Line_txt:=$Line_txt+";"+$ElVarPref_atxt{$loop_L}+String:C10($In_L)
					
				End for 
				$Line_txt:=$Line_txt+")"+Char:C90(13)
				SEND PACKET:C103($CompFile_tm; $Line_txt)
				$ClipBrd_txt:=$ClipBrd_txt+$Line_txt
			End for 
			SEND PACKET:C103($CompFile_tm; Char:C90(13))
			$ClipBrd_txt:=$ClipBrd_txt+Char:C90(13)
			
		End for 
		
		CLOSE DOCUMENT:C267($CompFile_tm)
		SET TEXT TO PASTEBOARD:C523($ClipBrd_txt)
		$ClipBrd_txt:=""
		$Line_txt:=""
	End if 
	
Else 
	ALERT:C41("There are no records in table [ElementDict]!!")
End if 