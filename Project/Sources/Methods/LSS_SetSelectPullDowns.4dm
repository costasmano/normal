//%attributes = {"invisible":true}
//LSS_SetSelectPullDowns 
ARRAY TEXT:C222(LSS_Categories_as; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(LSS_Districts_as; 0)  //Command Replaced was o_ARRAY string length was 10
//Begin SQL
//select 
//distinct([LSS_Inventory].[LSS_Category_s])
//from 
//[LSS_Inventory]
//into
//:LSS_Categories_as;
//End SQL
//ARRAY LONGINT($Districts_aL;0)
//Begin SQL
//select 
//distinct([LSS_Inventory].[LSS_District_L])
//from 
//[LSS_Inventory]
//into
//:$Districts_aL;
//End SQL
ARRAY LONGINT:C221($Districts_aL; 0)
//  `update select  pulldowns
Begin SQL
	
	select
	DISTINCT([LSS_Inventory].[LSS_Category_s])
	from
	[LSS_Inventory]
	into
	:LSS_Categories_as;
	
	select
	DISTINCT([LSS_Inventory].[LSS_District_L])
	from
	[LSS_Inventory]
	into
	:$Districts_aL;
	
	
End SQL
//DISTINCT VALUES([LSS_Inventory]LSS_Category_s;LSS_Categories_as)
//DISTINCT VALUES([LSS_Inventory]LSS_District_L;$Districts_aL)
If (Size of array:C274(LSS_Categories_as)>1)
	INSERT IN ARRAY:C227(LSS_Categories_as; 0; 1)
	LSS_Categories_as{1}:="ALL"
	LSS_Categories_as:=0
Else 
	LSS_Categories_as:=1
End if 
If (Size of array:C274($Districts_aL)>1)
	ARRAY TEXT:C222(LSS_Districts_as; (Size of array:C274($Districts_aL)+1))  //Command Replaced was o_ARRAY string length was 10
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($Districts_aL))
		LSS_Districts_as{$loop_L+1}:=String:C10($Districts_aL{$loop_L})
	End for 
	LSS_Districts_as{1}:="ALL"
	LSS_Districts_as:=0
Else 
	ARRAY TEXT:C222(LSS_Districts_as; (Size of array:C274($Districts_aL)))  //Command Replaced was o_ARRAY string length was 10
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($Districts_aL))
		LSS_Districts_as{$loop_L}:=String:C10($Districts_aL{$loop_L})
	End for 
	LSS_Districts_as:=1
End if 

ARRAY TEXT:C222(LSS_MassDOTReps_atxt; 0)
ARRAY LONGINT:C221(LSS_MassDOTRepIDs_aL; 0)
GRP_GetMembersOfGrps(->LSS_MassDOTRepIDs_aL; ->LSS_MassDOTReps_atxt; ""; "LSS_MassDOTRep")

ARRAY TEXT:C222(LSS_ConsultanList_atxt; 0)
TOL_ListToArray("LSS_Consultants"; ->LSS_ConsultanList_atxt)
SORT ARRAY:C229(LSS_ConsultanList_atxt)