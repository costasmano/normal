//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/14/06, 08:21:08
	// ----------------------------------------------------
	// Method: INV_SetupSortVars
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_LONGINT:C283($i; INV_SortBDEPT; INV_SortBIN; INV_SortINVTmLdr; INV_SortINVDate; INV_SortINVCompl; INV_SortApprv)
ARRAY POINTER:C280(INV_SortBtns_aptr; 6)
ARRAY POINTER:C280(INV_SortArrays_aptr; 9)
INV_SortBtns_aptr{1}:=->INV_SortBIN
INV_SortArrays_aptr{1}:=->InvPhotoInspBIN_as
INV_SortBtns_aptr{2}:=->INV_SortBDEPT
INV_SortArrays_aptr{2}:=->InvPhotoInspBDEPT_as
INV_SortBtns_aptr{3}:=->INV_SortINVDate
INV_SortArrays_aptr{3}:=->invPhotoInspDate_aD
INV_SortBtns_aptr{4}:=->INV_SortINVTmLdr
INV_SortArrays_aptr{4}:=->InvPhotoInspTmLdr_as
INV_SortBtns_aptr{5}:=->INV_SortINVCompl
INV_SortArrays_aptr{5}:=->invPhotoInspCompl_ab
INV_SortBtns_aptr{6}:=->INV_SortApprv
INV_SortArrays_aptr{6}:=->invPhotoInspAppr_aI
INV_SortArrays_aptr{7}:=->InvPhotoInspID_aL
INV_SortArrays_aptr{8}:=->invPhotoInspAppr_aP
INV_SortArrays_aptr{9}:=->InvPhotoInspRecNum_aL
ARRAY POINTER:C280(SortArrays_aptr; Size of array:C274(INV_SortArrays_aptr))  //used in the sort button methods
ARRAY LONGINT:C221(SortOrder_aL; Size of array:C274(INV_SortArrays_aptr))
For ($i; 1; Size of array:C274(SortOrder_aL))
	SortOrder_aL{$i}:=0
End for 
