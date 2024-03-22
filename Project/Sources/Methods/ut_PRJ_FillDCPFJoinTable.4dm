//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJ_FillDCPFJoinTable
// User name (OS): charlesmiller
// Date and time: 04/27/09, 15:13:49
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //r003  `04/27/09, 15:13:52 `PRJ Design Contract Changes
	Mods_2009_06  //r002 `06/11/09, 13:19:02   `Merge PRJ Design Contract Changes
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
READ ONLY:C145(*)
ALL RECORDS:C47([PRJ_ProjectFile:117])
ARRAY LONGINT:C221($FileIDs_a; 0)
ARRAY LONGINT:C221($FileNumbers_al; 0)
ARRAY LONGINT:C221($DesignProjectIDs_al; 0)
READ WRITE:C146([PRJ_DCPFJoin:135])
C_LONGINT:C283($Loop_l; $RecordsInSelection_l; $Count_l; $RecordNumber_l; $NumberDuplicates_l)
$RecordsInSelection_l:=Records in selection:C76([PRJ_ProjectFile:117])

ARRAY LONGINT:C221($FileIDs_a; $RecordsInSelection_l)
ARRAY LONGINT:C221($FileNumbers_al; $RecordsInSelection_l)
ARRAY LONGINT:C221($DesignProjectIDs_al; $RecordsInSelection_l)
C_TEXT:C284($Combinedkey_s)  // Command Replaced was o_C_STRING length was 23
SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([PRJ_ProjectFile:117]); [PRJ_ProjectFile:117]PF_FileID_l:1; $FileIDs_al; [PRJ_ProjectFile:117]PF_FileNumber_l:3; $FileNumbers_al; [PRJ_ProjectFile:117]DC_OLDDesignContractID_l:2; $DesignProjectIDs_al)
C_TEXT:C284($Duplicates_txt)
$Duplicates_txt:=""
$NumberDuplicates_l:=0
FIRST RECORD:C50([PRJ_ProjectFile:117])
For ($Loop_l; 1; $RecordsInSelection_l)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($FileNumbers_al{$Loop_l}>0)
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=$DesignProjectIDs_al{$Loop_l})
		If ([PRJ_DesignContracts:123]DC_DesignContractID_l:1>0) & ($FileNumbers_al{$Loop_l}>0)
			
			$Combinedkey_s:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+"-"+String:C10($FileNumbers_al{$Loop_l})
			SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
			QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]DCPF_Contract_FileNo_s:1=$Combinedkey_s)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($Count_l=0)
				CREATE RECORD:C68([PRJ_DCPFJoin:135])
				[PRJ_DCPFJoin:135]DCPF_Contract_FileNo_s:1:=$Combinedkey_s
				[PRJ_DCPFJoin:135]DC_DesignProjectID_l:2:=$DesignProjectIDs_al{$Loop_l}
				[PRJ_DCPFJoin:135]PF_FileID_l:3:=$FileIDs_al{$Loop_l}
				SAVE RECORD:C53([PRJ_DCPFJoin:135])
				UNLOAD RECORD:C212([PRJ_DCPFJoin:135])
			Else 
				$NumberDuplicates_l:=$NumberDuplicates_l+1
				$Duplicates_txt:=$Duplicates_txt+$Combinedkey_s+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
			End if 
		End if 
	End if 
	
End for 
If ($NumberDuplicates_l>0)
	ALERT:C41("There were "+String:C10($NumberDuplicates_l)+" duplicate records found.")
	C_TIME:C306($Doc)
	$Doc:=Create document:C266("")
	
	SEND PACKET:C103($Doc; $Duplicates_txt)
	CLOSE DOCUMENT:C267($Doc)
End if 

//End ut_PRJ_FillDCPFJoinTable