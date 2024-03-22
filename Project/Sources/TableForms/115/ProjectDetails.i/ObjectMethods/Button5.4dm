// ----------------------------------------------------
// Object Method: Button1
// User name (OS): cjmiller
// Date and time: 04/07/06, 11:05:10
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //04/26/07, 12:15:37`Integrate Changes made by Costas
	Mods_2007_CJMv2  //04/30/07, 11:58:23``Fix compiler errors
	Mods_2007_CJM_v5310  //06/20/07 Fix so that if nothing selected, no errors
	Mods_2008_v55  //r004 `04/15/08, 17:04:13     
	Mods_2008_CJM_v56  //r002 `06/16/08, 12:16:32   `make ure crrect bin dialog displays
	// Modified by: costasmanousakis-(Designer)-(6/25/08 15:43:53)
	Mods_2008_CM_5404
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2019_12  //add code to modify how bin groups are created and maintained for a project
	//by Chuck Miller
	Mods_2020_09  //remove obsolete form and fix bug
End if 
READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])



C_LONGINT:C283($Height_l; $Width_L)
SET QUERY DESTINATION:C396(Into set:K19:2; "IncludedBinsSet")
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
FORM GET PROPERTIES:C674("PRJ_BIN_Hierarchy"; $Width_L; $Height_l)
ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; "Update BIN Groups"; "ut_CloseAsk")
DIALOG:C40("PRJ_BIN_Hierarchy")

If (OK=1)
	If (Size of array:C274(Group_atxt)>0)
		C_LONGINT:C283($loop_L)
		For ($Loop_L; Size of array:C274(Bin_atxt); 1; -1)
			If (Bin_atxt{$loop_L}="")
				DELETE FROM ARRAY:C228(Bin_atxt; $Loop_L; 1)
				DELETE FROM ARRAY:C228(Group_atxt; $loop_L; 1)
				DELETE FROM ARRAY:C228(Type_atxt; $loop_L; 1)
			End if 
		End for 
		
		C_LONGINT:C283($GrpNum_L; $CurrGrpNum_L)
		$GrpNum_L:=1
		$CurrGrpNum_L:=Num:C11(Group_atxt{1})
		For ($Loop_L; 1; Size of array:C274(Group_atxt))
			
			If (Num:C11(Group_atxt{$Loop_L})=$CurrGrpNum_L)
				
			Else 
				$GrpNum_L:=$GrpNum_L+1
				$CurrGrpNum_L:=Num:C11(Group_atxt{$Loop_L})
				
			End if 
			Group_atxt{$Loop_L}:="Group "+String:C10($GrpNum_L)
		End for 
		
	End if 
	
	
	CLEAR SET:C117("CurrentBinSet")
	CLEAR SET:C117("PotentialBinSet")
	C_LONGINT:C283($Loop_L; $GroupNumber_L)
	For ($Loop_L; 1; Size of array:C274(Bin_atxt))
		USE SET:C118("IncludedBinsSet")
		If (Bin_atxt{$Loop_L}="")
		Else 
			QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2=Bin_atxt{$Loop_L})
			If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])=0)
				ProjectChangesMade_b:=True:C214
				CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
				[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
				[PRJ_ProjectDetailsIncludedBINS:122]PDB_Date_d:5:=Current date:C33
				[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=Bin_atxt{$Loop_L}
				[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=(Type_atxt{$loop_l}="Proposed")
				[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
				SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
			End if 
			If (ut_LoadRecord(->[PRJ_ProjectDetailsIncludedBINS:122]; 5))
				[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=(Type_atxt{$loop_l}="Proposed")
				$GroupNumber_L:=Num:C11(Replace string:C233(Group_atxt{$loop_l}; "Group "; ""))
				If ([PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6#$GroupNumber_L)
					
					[PRJ_ProjectDetailsIncludedBINS:122]PDB_Date_d:5:=Current date:C33
					[PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=$GroupNumber_L
					
				End if 
			End if 
			If (Modified record:C314([PRJ_ProjectDetailsIncludedBINS:122]))
				ProjectChangesMade_b:=True:C214
				SAVE RECORD:C53([PRJ_ProjectDetailsIncludedBINS:122])
				UNLOAD RECORD:C212([PRJ_ProjectDetailsIncludedBINS:122])
			End if 
		End if 
		
	End for 
	USE SET:C118("IncludedBinsSet")
	SET QUERY DESTINATION:C396(Into set:K19:2; "CurrentBinsSet")
	QUERY SELECTION WITH ARRAY:C1050([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; Bin_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	DIFFERENCE:C122("IncludedBinsSet"; "CurrentBinsSet"; "DeleteBinSet")
	
	If (Records in set:C195("DeleteBinSet")>0)
		USE SET:C118("DeleteBinSet")
		Repeat 
			DELETE SELECTION:C66([PRJ_ProjectDetailsIncludedBINS:122])
			If (Records in set:C195("LockedSet")>0)
				USE SET:C118("LockedSet")
				IDLE:C311
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
			
		Until (Records in set:C195("LockedSet")=0)
		CLEAR SET:C117("CurrentBinsSet")
		CLEAR SET:C117("DeleteBinSet")
		
	End if 
	
	PRJ_SetUpIncludedBins
	
	
	CLEAR SET:C117("IncludedBinsSet")
	
End if 



PRJ_LoadPage2Bins
PRJ_BD_BuildBrgDataShtList
If (Size of array:C274(PRJ_SelectedBins_as)>0)
	OBJECT SET VISIBLE:C603(*; "SelPrimaryBin1"; True:C214)
End if 

//End Object Method: Button1