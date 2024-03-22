//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetUpBinArrays
// User name (OS): cjmiller
// Date and time: 03/23/06, 13:29:32
// ----------------------------------------------------
// Description
// This method will set up available bin array for first input page
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //12/14/06, 11:57:17`Fix new or existing by changing desc to des in searching item 8
	Mods_2006_CJMv2  //03/29/07, 10:42:01  `03/29/07, 10:39:25`Modify to use new method for selecting new / existing bins
End if 
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
ARRAY TEXT:C222(PRJ_AvailableBins_atxt; 0)
ARRAY LONGINT:C221(PRJ_AvailableBinRecordNos_al; 0)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; PRJ_AvailableBins_atxt; [Bridge MHD NBIS:1]Item8:206; $Item8_atxt; [Bridge MHD NBIS:1]Item7:65; $Item7_atxt; [Bridge MHD NBIS:1]Item6A:63; $Item6a_atxt)
C_LONGINT:C283($Loop_l)
COPY ARRAY:C226(PRJ_AvailableBins_atxt; $AvailableBins_atxt)
ARRAY LONGINT:C221(PRJ_AvailableBinRecordNos_al; Size of array:C274(PRJ_AvailableBins_atxt))
For ($Loop_l; 1; Size of array:C274(PRJ_AvailableBins_atxt))
	PRJ_AvailableBins_atxt{$Loop_l}:=PRJ_AvailableBins_atxt{$Loop_l}+" - "+f_TrimStr($Item7_atxt{$Loop_l}; True:C214; True:C214)+"/"+f_TrimStr($Item6a_atxt{$Loop_l}; True:C214; True:C214)+" ("+f_TrimStr($Item8_atxt{$Loop_l}; True:C214; True:C214)+")"
End for 
SORT ARRAY:C229(PRJ_AvailableBins_atxt; PRJ_AvailableBinRecordNos_al; $AvailableBins_atxt; >)
C_LONGINT:C283($Position_l)
ARRAY TEXT:C222(PRJ_ExistSelectedBins_atxt; 0)
ARRAY LONGINT:C221(PRJ_ExstSelectedBinRecordNos_al; 0)
ARRAY TEXT:C222(PRJ_NewSelectedBins_atxt; 0)
ARRAY LONGINT:C221(PRJ_NewSelectedBinRecordNos_al; 0)
//Lets fill selected exist
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=False:C215)
SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_ExstSelectedBinRecordNos_al; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3; $BDepts_atxt; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; PRJ_ExistSelectedBins_atxt)
COPY ARRAY:C226(PRJ_ExistSelectedBins_atxt; $ExistSelectedBins_atxt)
C_LONGINT:C283($Location_l)
$Location_l:=-999
C_TEXT:C284(PRJ_PrimaryBin_txt)
PRJ_PrimaryBin_txt:=""
For ($Loop_l; 1; Size of array:C274(PRJ_ExistSelectedBins_atxt))
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=PRJ_ExistSelectedBins_atxt{$Loop_l})
	$Position_l:=Find in array:C230($AvailableBins_atxt; PRJ_ExistSelectedBins_atxt{$Loop_l})
	If ($Position_l>0)
		DELETE FROM ARRAY:C228(PRJ_AvailableBins_atxt; $Position_l; 1)
		DELETE FROM ARRAY:C228($AvailableBins_atxt; $Position_l; 1)
		DELETE FROM ARRAY:C228(PRJ_AvailableBinRecordNos_al; $Position_l; 1)
		
	End if 
	If (PRJ_ExistSelectedBins_atxt{$Loop_l}=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
		$Location_l:=$Loop_l
	Else 
		PRJ_ExistSelectedBins_atxt{$Loop_l}:=PRJ_ExistSelectedBins_atxt{$Loop_l}+"-"+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+"/"+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)+" ("+f_TrimStr([Bridge MHD NBIS:1]Item8:206; True:C214; True:C214)+")"
	End if 
End for 
If ($Location_l>0)
	PRJ_PrimaryBin_txt:=PRJ_ExistSelectedBins_atxt{$Location_l}+"-"+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+"/"+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)+" ("+f_TrimStr([Bridge MHD NBIS:1]Item8:206; True:C214; True:C214)+")"
	DELETE FROM ARRAY:C228(PRJ_ExistSelectedBins_atxt; $Location_l; 1)
	DELETE FROM ARRAY:C228(PRJ_ExstSelectedBinRecordNos_al; $Location_l; 1)
End if 

QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=True:C214)
SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]; PRJ_NewSelectedBinRecordNos_al; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3; $BDepts_atxt; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; PRJ_NewSelectedBins_atxt)
COPY ARRAY:C226(PRJ_ExistSelectedBins_atxt; $NewSelectedBins_atxt)
C_LONGINT:C283($Location_l)
$Location_l:=-999

For ($Loop_l; 1; Size of array:C274(PRJ_NewSelectedBins_atxt))
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=PRJ_NewSelectedBins_atxt{$Loop_l})
	$Position_l:=Find in array:C230($AvailableBins_atxt; PRJ_NewSelectedBins_atxt{$Loop_l})
	If ($Position_l>0)
		DELETE FROM ARRAY:C228(PRJ_AvailableBins_atxt; $Position_l; 1)
		DELETE FROM ARRAY:C228($AvailableBins_atxt; $Position_l; 1)
		DELETE FROM ARRAY:C228(PRJ_AvailableBinRecordNos_al; $Position_l; 1)
		
	End if 
	If (PRJ_NewSelectedBins_atxt{$Loop_l}=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
		$Location_l:=$Loop_l
	Else 
		PRJ_NewSelectedBins_atxt{$Loop_l}:=PRJ_NewSelectedBins_atxt{$Loop_l}+"-"+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+"/"+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)+" ("+f_TrimStr([Bridge MHD NBIS:1]Item8:206; True:C214; True:C214)+")"
	End if 
End for 
If ($Location_l>0)
	PRJ_PrimaryBin_txt:=PRJ_NewSelectedBins_atxt{$Location_l}+"-"+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+"/"+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)+" ("+f_TrimStr([Bridge MHD NBIS:1]Item8:206; True:C214; True:C214)+")"
	DELETE FROM ARRAY:C228(PRJ_NewSelectedBins_atxt; $Location_l; 1)
	DELETE FROM ARRAY:C228(PRJ_NewSelectedBinRecordNos_al; $Location_l; 1)
End if 

For ($Loop_l; 1; Size of array:C274(PRJ_AvailableBinRecordNos_al))
	PRJ_AvailableBinRecordNos_al{$Loop_l}:=-99
End for 



//End PRJ_SetUpBinArrays