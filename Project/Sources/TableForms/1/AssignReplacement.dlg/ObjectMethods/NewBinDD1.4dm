// ----------------------------------------------------
// Object Method: GroupDD_as
// User name (OS): cjmiller
// Date and time: 04/15/08, 12:11:30
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //Copied to Server on : 06/25/08, 11:57:25   `04/15/08, 12:11:32     
End if 
C_TEXT:C284($Selection_txt)
$Selection_txt:=GroupDD_as{GroupDD_as}
If (Substring:C12($Selection_txt; 1; 1)="C")
	INSERT IN ARRAY:C227(GroupDD_as; Size of array:C274(GroupDD_as)+1; 1)
	GroupDD_as{Size of array:C274(GroupDD_as)}:="Replacement Group # "+String:C10(Size of array:C274(GroupDD_as)-1)
	GroupDD_as:=Size of array:C274(GroupDD_as)
End if 
CONFIRM:C162("Assign new BIN "+NewBin_s+" to "+GroupDD_as{GroupDD_as}; "Yes"; "No")
If (OK=1)
	C_LONGINT:C283($number_l; $Size_l)
	$number_l:=Num:C11(Replace string:C233(GroupDD_as{GroupDD_as}; "Replacement Group # "; ""))
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
	QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3=[Bridge MHD NBIS:1]BDEPT:1)
	QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2=NewBin_s)
	QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=True:C214)
	If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])=0)
		CREATE RECORD:C68([PRJ_ProjectDetailsIncludedBINS:122])
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6:=$number_l
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3:=[Bridge MHD NBIS:1]BDEPT:1
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2:=NewBin_s
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_Date_d:5:=Current date:C33(*)
		[PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4:=True:C214
		[PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
	End if 
	$Size_l:=Size of array:C274(PRJ_NewSelectedBins_atxt)+1
	INSERT IN ARRAY:C227(PRJ_NewSelectedBins_atxt; $Size_l; 1)
	INSERT IN ARRAY:C227(PRJ_NewSelectedBinRecordNos_al; $Size_l; 1)
	PRJ_NewSelectedBins_atxt{$Size_l}:="G "+String:C10($number_l)+"-"+[Bridge MHD NBIS:1]BIN:3+"-"+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+"/"+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)+" ("+f_TrimStr([Bridge MHD NBIS:1]Item8:206; True:C214; True:C214)+")"
	NewBin_s:=""
	NewBinDesription_txt:=""
End if 
OBJECT SET VISIBLE:C603(*; "NewBINDD@"; False:C215)
//End Object Method: GroupDD_as