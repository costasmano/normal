// ----------------------------------------------------
// Form Method: AssignReplacement.dlg
// User name (OS): cjmiller
// Date and time: 05/13/08, 11:43:29
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v55  //r007 `05/13/08, 11:43:32     
	Mods_2008_CJM_v55  //r010 `06/12/08, 11:27:09     
	Mods_2011_06  // CJ Miller`06/20/11, 10:36:29      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		ARRAY TEXT:C222(PRJ_ExistSelectedBins_atxt; 0)
		ARRAY LONGINT:C221(PRJ_ExstSelectedBinRecordNos_al; 0)
		ARRAY TEXT:C222(PRJ_NewSelectedBins_atxt; 0)
		ARRAY LONGINT:C221(PRJ_NewSelectedBinRecordNos_al; 0)
		
		OBJECT SET VISIBLE:C603(*; "NewBINDD@"; True:C214)
		PRJ_PopulateForAssignReplacemen
		
		QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; *)
		QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122];  & ; [PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6>0)
		C_LONGINT:C283($Loop_l)
		DISTINCT VALUES:C339([PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6; $GroupDD_al)
		SORT ARRAY:C229($GroupDD_al; >)
		ARRAY TEXT:C222(GroupDD_as; Size of array:C274($GroupDD_al))  //Command Replaced was o_ARRAY string length was 25
		For ($Loop_l; 1; Size of array:C274($GroupDD_al))
			GroupDD_as{$Loop_l}:="Replacement Group # "+String:C10($GroupDD_al{$Loop_l})
		End for 
		SORT ARRAY:C229(GroupDD_as; >)
		If (Size of array:C274(GroupDD_as)=0)
			INSERT IN ARRAY:C227(GroupDD_as; 1; 1)
			GroupDD_as{1}:="Replacement Group # 1"
			GroupDD_as:=1
		Else 
			GroupDD_as:=2
			INSERT IN ARRAY:C227(GroupDD_as; 0; 1)
			GroupDD_as{1}:="Create New Group"
		End if 
		
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=NewBin_s)
		
End case 

//End Form Method: AssignReplacement.dlg