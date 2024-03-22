//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetUpAvailableBins
// User name (OS): cjmiller
// Date and time: 04/15/08, 14:43:14
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r004 `04/15/08, 14:43:16     
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_BLOB:C604($Blob_blb)
SET BLOB SIZE:C606($Blob_blb; 0)

C_LONGINT:C283($Loop_l; $Position_l; $Count_l)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

$Blob_blb:=ut_ParseTextToArray(Replace string:C233([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; "="; " "))
BLOB TO VARIABLE:C533($Blob_blb; $AvailableBins_atxt)
For ($Loop_l; 1; Size of array:C274($AvailableBins_atxt))
	$AvailableBins_atxt{$Loop_l}:=Substring:C12($AvailableBins_atxt{$Loop_l}; 1; 6)
End for 
QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BDEPT:1; $AvailableBins_atxt)
ARRAY TEXT:C222(PRJ_AvailableBins_atxt; 0)
ARRAY LONGINT:C221(PRJ_AvailableBinRecordNos_al; 0)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; PRJ_AvailableBins_atxt; [Bridge MHD NBIS:1]Item8:206; $Item8_atxt; [Bridge MHD NBIS:1]Item7:65; $Item7_atxt; [Bridge MHD NBIS:1]Item6A:63; $Item6a_atxt)

COPY ARRAY:C226(PRJ_AvailableBins_atxt; $AvailableBins_atxt)
ARRAY LONGINT:C221(PRJ_AvailableBinRecordNos_al; Size of array:C274(PRJ_AvailableBins_atxt))
For ($Loop_l; Size of array:C274(PRJ_AvailableBins_atxt); 1; -1)
	
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2=PRJ_AvailableBins_atxt{$Loop_l})
	If ($Count_l>0) | (NewBin_s=PRJ_AvailableBins_atxt{$Loop_l})
		DELETE FROM ARRAY:C228(PRJ_AvailableBins_atxt; $Loop_l; 1)
		DELETE FROM ARRAY:C228($AvailableBins_atxt; $Loop_l; 1)
		DELETE FROM ARRAY:C228(PRJ_AvailableBinRecordNos_al; $Loop_l; 1)
	Else 
		PRJ_AvailableBinRecordNos_al{$Loop_l}:=-999
		PRJ_AvailableBins_atxt{$Loop_l}:="Avail-"+PRJ_AvailableBins_atxt{$Loop_l}+" - "+f_TrimStr($Item7_atxt{$Loop_l}; True:C214; True:C214)+"/"+f_TrimStr($Item6a_atxt{$Loop_l}; True:C214; True:C214)+" ("+f_TrimStr($Item8_atxt{$Loop_l}; True:C214; True:C214)+")"
	End if 
	
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SORT ARRAY:C229(PRJ_AvailableBins_atxt; PRJ_AvailableBinRecordNos_al; $AvailableBins_atxt; >)

PRJ_PrimaryBin_txt:=""
If ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34#"")
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
	PRJ_PrimaryBin_txt:=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34+" - "+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+"/"+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)+" ("+f_TrimStr([Bridge MHD NBIS:1]Item8:206; True:C214; True:C214)+")"
End if 

//End PRJ_SetUpAvailableBins