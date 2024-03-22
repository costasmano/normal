//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_CreateMachineNameExport
// User name (OS): charlesmiller
// Date and time: 04/01/11, 11:43:31
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_03  //r002 CJ Miller`04/01/11, 11:43:33     
End if 
ARRAY TEXT:C222($Names_atxt; 0)
ARRAY LONGINT:C221($Numbers_al; 0)
ARRAY TEXT:C222($Employer_atxt; 0)

GET USER LIST:C609($Names_atxt; $Numbers_al)
ARRAY TEXT:C222($Report_atxt; 0)
ARRAY TEXT:C222($Report_atxt; 1)
C_LONGINT:C283($ReportArraySize_l)
$ReportArraySize_l:=1
ARRAY TEXT:C222($PersonnelMachines_atxt; 0)
ARRAY LONGINT:C221($PersonnelIDs_al; 0)
QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12#0)
C_LONGINT:C283($RecordCount_l)
$RecordCount_l:=Records in selection:C76([Personnel:42])
ARRAY TEXT:C222($PersonnelMachines_atxt; $RecordCount_l)
ARRAY LONGINT:C221($PersonnelIDs_al; $RecordCount_l)
ARRAY TEXT:C222($Employer_atxt; $RecordCount_l)
SELECTION RANGE TO ARRAY:C368(1; $RecordCount_l; [Personnel:42]UserID_4D:12; $PersonnelIDs_al; [Personnel:42]MachineName_txt:18; $PersonnelMachines_atxt; [Personnel:42]Employer:9; $Employer_atxt)
C_LONGINT:C283($Loop_l; $Position_l)
C_TEXT:C284($CR_txt; $Tab_txt)

$CR_txt:=Char:C90(Carriage return:K15:38)
$Tab_txt:=Char:C90(Tab:K15:37)

For ($Loop_l; 1; $RecordCount_l)
	If (Length:C16($Report_atxt{$ReportArraySize_l})>25000)
		APPEND TO ARRAY:C911($Report_atxt; "")
		$ReportArraySize_l:=$ReportArraySize_l+1
	End if 
	$Position_l:=Find in array:C230($Numbers_al; $PersonnelIDs_al{$Loop_l})
	
	If ($Position_l>0)
		$Report_atxt{$ReportArraySize_l}:=$Report_atxt{$ReportArraySize_l}+$Names_atxt{$Position_l}
	Else 
		$Report_atxt{$ReportArraySize_l}:=$Report_atxt{$ReportArraySize_l}+String:C10($PersonnelIDs_al{$Loop_l})+" unknown user"
	End if 
	$Report_atxt{$ReportArraySize_l}:=$Report_atxt{$ReportArraySize_l}+$Tab_txt+$Employer_atxt{$Loop_l}+$Tab_txt+$PersonnelMachines_atxt{$Loop_l}+$CR_txt
End for 
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266("")
For ($Loop_l; 1; $ReportArraySize_l)
	SEND PACKET:C103($Doc_tm; $Report_atxt{$Loop_l})
End for 
CLOSE DOCUMENT:C267($Doc_tm)
ARRAY TEXT:C222($Names_atxt; 0)
ARRAY LONGINT:C221($Numbers_al; 0)
ARRAY TEXT:C222($Employer_atxt; 0)
ARRAY TEXT:C222($Report_atxt; 0)

//End ut_CreateMachineNameExport