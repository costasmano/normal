//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// ut_UpgradeBINGroups
	// User name (OS): cjmiller
	// Date and time: 06/02/08, 15:31:59
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2008_v55  //r010 06/02/08, 15:32:01     
	// Modified by: costasmanousakis-(Designer)-(6/20/08 16:18:53)
	Mods_2008_CM_5404  // ("NEWBINS")  `Also assign the exist bins to a group i  `f there is one
	// Modified by: costasmanousakis-(Designer)-(6/25/08 11:34:55)
	Mods_2008_CM_5404  // ("NEWBINS")  `assign new bins each to a different group
	// Modified by: costasmanousakis-(Designer)-(6/26/08 13:01:04)
	Mods_2008_CM_5404  //Added code to set to New records that are DES or have corresponding "REM" records
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

READ ONLY:C145([Bridge MHD NBIS:1])

QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=False:C215)
FIRST RECORD:C50([PRJ_ProjectDetailsIncludedBINS:122])
While (Not:C34(End selection:C36([PRJ_ProjectDetailsIncludedBINS:122])))
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2)
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=True:C214
		SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
	End if 
	NEXT RECORD:C51([PRJ_ProjectDetailsIncludedBINS:122])
End while 

QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=False:C215)
ARRAY LONGINT:C221($InclBINs_aL; 0)

SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]; $InclBINs_aL)
C_LONGINT:C283($i; $numrecs; $prjID_L)
C_TEXT:C284($curBin_s)  // Command Replaced was o_C_STRING length was 3
$numrecs:=Size of array:C274($InclBINs_aL)
ARRAY TEXT:C222($otherBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($OtherItem8s_as; 0)  //Command Replaced was o_ARRAY string length was 3

For ($i; 1; $numrecs)
	GOTO RECORD:C242([PRJ_ProjectDetailsIncludedBINS:122]; $InclBINs_aL{$i})
	$prjID_L:=[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1
	$curBin_s:=[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$curBin_s)
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207#"REM")
		QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=$prjID_L; *)
		QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & ; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2#$curBin_s)
		If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])>0)
			SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $otherBINs_as)
			QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $otherBINs_as)
			SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item8 BridgeCat:207; $OtherItem8s_as)
			If (Find in array:C230($OtherItem8s_as; "REM")>0)
				GOTO RECORD:C242([PRJ_ProjectDetailsIncludedBINS:122]; $InclBINs_aL{$i})
				If (ut_LoadRecordInteractive(->[PRJ_ProjectDetailsIncludedBINS:122]))
					[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=True:C214
					SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
				Else 
					ALERT:C41("Could not load for editing record for proj id "+String:C10($prjID_L)+"  BIN "+$curBin_s)
				End if 
				
			End if 
		End if 
	End if 
End for 
READ WRITE:C146([Bridge MHD NBIS:1])

REDUCE SELECTION:C351([PRJ_ProjectDetailsIncludedBINS:122]; 0)
READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])

QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=True:C214; *)
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & ; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6=0)
C_LONGINT:C283($NextGrp_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $NewBinsFound_L)
FIRST RECORD:C50([PRJ_ProjectDetailsIncludedBINS:122])
C_BOOLEAN:C305($FoundGrp_b)
While (Not:C34(End selection:C36([PRJ_ProjectDetailsIncludedBINS:122])))
	$NextGrp_L:=1
	$FoundGrp_b:=False:C215
	
	Repeat 
		QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; *)
		QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & ; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=True:C214; *)
		QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & ; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6=$NextGrp_L)
		If ($NewBinsFound_L=0)
			$FoundGrp_b:=True:C214
		Else 
			$NextGrp_L:=$NextGrp_L+1
		End if 
	Until ($FoundGrp_b)
	[PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=$NextGrp_L
	SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
	NEXT RECORD:C51([PRJ_ProjectDetailsIncludedBINS:122])
End while 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If (False:C215)
	
	Repeat 
		APPLY TO SELECTION:C70([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=1)
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
		End if 
	Until (Records in set:C195("LockedSet")=0)
	
End if 

QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=False:C215; *)
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & ; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6=0)
C_LONGINT:C283($NewBinsFound_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $NewBinsFound_L)
FIRST RECORD:C50([PRJ_ProjectDetailsIncludedBINS:122])
While (Not:C34(End selection:C36([PRJ_ProjectDetailsIncludedBINS:122])))
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; *)
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & ; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=True:C214)
	Case of 
		: ($NewBinsFound_L>=1)
			[PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=1
			SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
			
	End case 
	NEXT RECORD:C51([PRJ_ProjectDetailsIncludedBINS:122])
End while 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
//End ut_UpgradeBINGroups