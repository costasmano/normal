//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_StructureNumberChangeReport
// User name (OS): charlesmiller
// Date and time: 03/04/10, 10:30:39
// ----------------------------------------------------
// Description
// Produce a report for the FHWA annual submission indicating the changes to Item8.
// Reads Last Years 'tape' and compares old Item8 with the current ones.
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_03  //r002 CJ Miller`03/04/10, 10:30:41      `
	// Modified by: costasmanousakis-(Designer)-(12/3/10 15:06:31)
	Mods_2010_12
	//  `Do the Item8 check only for records currently in the NBI category (FHWARecord=True);
	//  `No need to include bridges that have been taken off the NBI
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_BOOLEAN:C305($Complete_b; $ItemFiveError_b)
$Complete_b:=False:C215
C_LONGINT:C283($Size_l; $ProcessCount_l; $SkipCount_l; $ErrorSize_l; $NumberofErrors_l; $LineCount_l; $innerLoop_l)
$Size_l:=1
$ErrorSize_l:=1
$NumberofErrors_l:=0
$LineCount_l:=0
C_TEXT:C284($Remainder_txt; $Code_txt; $OldItem8_txt; $Bin_txt)
ARRAY TEXT:C222($Report_atxt; 0)
ARRAY TEXT:C222($Report_atxt; 1)
//EOL text contains the explanation for the name change
C_TEXT:C284($DateChange_txt; $ChangeReason_txt; $Eol_txt)
C_DATE:C307($DateChange_d)
$DateChange_txt:="110109"
$DateChange_txt:=Request:C163("Enter Date of Item 8 change (MMDDYY)"; $DateChange_txt)

$ChangeReason_txt:="Mult. Agency Re-Org."
C_BOOLEAN:C305($ChangeReasonOK_b)

Repeat 
	$ChangeReason_txt:=f_TrimStr(Request:C163("Enter Reason for Change"; $ChangeReason_txt); True:C214; True:C214)
	If (Length:C16($ChangeReason_txt)>25)
		ALERT:C41("Reason more than 25 characters - Please verify")
		$ChangeReason_txt:=Substring:C12($ChangeReason_txt; 1; 25)
		$ChangeReasonOK_b:=False:C215
	Else 
		$ChangeReasonOK_b:=True:C214
	End if 
	
Until ($ChangeReasonOK_b)
//Pad the Reason to 25 chars
If (Length:C16($ChangeReason_txt)<25)
	$ChangeReason_txt:=$ChangeReason_txt+(" "*(25-Length:C16($ChangeReason_txt)))
End if 

$Eol_txt:=(" "*3)+$DateChange_txt+(" "*3)+$ChangeReason_txt+(" "*2)+Char:C90(Carriage return:K15:38)
READ ONLY:C145([Bridge MHD NBIS:1])
READ ONLY:C145([NBIS Secondary:3])
ARRAY TEXT:C222($ErrorReport_atxt; 0)
ARRAY TEXT:C222($ErrorReport_atxt; 1)
C_TIME:C306($doc)

C_TEXT:C284($Item5_s; $SourceItem5_s)  // Command Replaced was o_C_STRING length was 1
ALERT:C41("Select FHWA submittal file to compare current Item 8 values.")
$doc:=Open document:C264("")
If (OK=1)
	SHORT_MESSAGE("Scanning Input File for Item 8 Renames.......")
	Repeat 
		RECEIVE PACKET:C104($Doc; $Remainder_txt; Char:C90(Carriage return:K15:38))
		$Remainder_txt:=Replace string:C233($Remainder_txt; Char:C90(Line feed:K15:40); "")
		If (OK=1)
			
			$LineCount_l:=$LineCount_l+1
			$OldItem8_txt:=Substring:C12($Remainder_txt; 4; 15)
			$SourceItem5_s:=Substring:C12($Remainder_txt; 19; 1)
			$Bin_txt:=Substring:C12($OldItem8_txt; 7; 3)
			If (($LineCount_l%100)=0)
				MESSAGE:C88(Char:C90(13)+"Line "+String:C10($LineCount_l)+"-"+$OldItem8_txt+"-"+$SourceItem5_s)
			End if 
			
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$Bin_txt)
			
			If ([Bridge MHD NBIS:1]FHWARecord:174)  //Only do this for FHWA (NBI) records
				
				If ($OldItem8_txt=[Bridge MHD NBIS:1]Item8:206)
					$SkipCount_l:=$SkipCount_l+1
				Else 
					$ProcessCount_l:=$ProcessCount_l+1
					If (Length:C16($Report_atxt{$Size_l})>30000)
						APPEND TO ARRAY:C911($Report_atxt; "")
						$Size_l:=$Size_l+1
					End if 
					$Item5_s:=Substring:C12([Bridge MHD NBIS:1]Item5:59; 1; 1)
					
					If ($SourceItem5_s#"1")  //Not primary record - just make sure we have a current secondary with the same Item5A
						QUERY:C277([NBIS Secondary:3]; [NBIS Secondary:3]BIN:1=$Bin_txt)
						ARRAY TEXT:C222($Secondary5s_as; 0)  //Command Replaced was o_ARRAY string length was 9
						ARRAY TEXT:C222($Secondary5s_as; Records in selection:C76([NBIS Secondary:3]))  //Command Replaced was o_ARRAY string length was 9
						SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([NBIS Secondary:3]); [NBIS Secondary:3]Item5:4; $Secondary5s_as)
						
						$ItemFiveError_b:=True:C214
						For ($innerLoop_l; 1; Size of array:C274($Secondary5s_as))
							If (Substring:C12($Secondary5s_as{$innerLoop_l}; 1; 1)=$SourceItem5_s)
								$ItemFiveError_b:=False:C215
								$innerLoop_l:=Size of array:C274($Secondary5s_as)+10
							End if 
						End for 
					Else 
						$ItemFiveError_b:=False:C215
					End if 
					If (Not:C34($ItemFiveError_b))
						$Report_atxt{$Size_l}:=$Report_atxt{$Size_l}+"251"+[Bridge MHD NBIS:1]Item8:206+$SourceItem5_s+"   251"+$OldItem8_txt+$SourceItem5_s+$Eol_txt
					Else 
						$NumberofErrors_l:=$NumberofErrors_l+1
						If (Length:C16($ErrorReport_atxt{$ErrorSize_l})>30000)
							APPEND TO ARRAY:C911($ErrorReport_atxt; "")
							$ErrorSize_l:=$ErrorSize_l+1
						End if 
						$ErrorReport_atxt{$ErrorSize_l}:=$ErrorReport_atxt{$ErrorSize_l}+"Error in input line "+String:C10($LineCount_l)+" No match for input item 5A "+$SourceItem5_s+" for BIN "+$Bin_txt+" in  "+String:C10(Size of array:C274($Secondary5s_as))+" Secondary records"+Char:C90(Carriage return:K15:38)
					End if 
				End if 
			Else 
				$SkipCount_l:=$SkipCount_l+1
			End if 
		Else 
			
			$Complete_b:=True:C214
		End if 
		
	Until ($Complete_b)
	CLOSE WINDOW:C154
	CLOSE DOCUMENT:C267($doc)
	If ($Size_l>1) | (Length:C16($Report_atxt{$Size_l})>0)
		ALERT:C41("Saving Item8 Renaming Report!")
		$doc:=Create document:C266("")
		For ($Size_l; 1; Size of array:C274($Report_atxt))
			SEND PACKET:C103($doc; $Report_atxt{$Size_l})
		End for 
		CLOSE DOCUMENT:C267($doc)
	End if 
	If ($ErrorSize_l>1) | (Length:C16($ErrorReport_atxt{$ErrorSize_l})>0)
		ALERT:C41("Saving Item5A error Report!")
		$doc:=Create document:C266("")
		SEND PACKET:C103($doc; "There were "+String:C10($NumberofErrors_l)+" errors found. Data can be found below on each error"+Char:C90(Carriage return:K15:38))
		For ($Size_l; 1; Size of array:C274($ErrorReport_atxt))
			SEND PACKET:C103($doc; $ErrorReport_atxt{$Size_l})
		End for 
		CLOSE DOCUMENT:C267($doc)
	End if 
	
End if 