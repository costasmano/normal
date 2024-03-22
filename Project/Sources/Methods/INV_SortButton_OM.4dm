//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/14/06, 08:25:45
	// ----------------------------------------------------
	// Method: INV_SortButton_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : Button number
	// ----------------------------------------------------
	Mods_2007_CM02
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_LONGINT:C283($1; $ButtonNum_L; $i)
$ButtonNum_L:=$1
For ($i; 1; Size of array:C274(SortArrays_aptr))
	Case of 
		: ($i=1)
			SortArrays_aptr{$i}:=INV_SortArrays_aptr{$ButtonNum_L}
		: ($i=$ButtonNum_L)
			SortArrays_aptr{$i}:=INV_SortArrays_aptr{1}
		Else 
			SortArrays_aptr{$i}:=INV_SortArrays_aptr{$i}
	End case 
	SortOrder_aL{$i}:=0
End for 

Case of 
	: (INV_SortBtns_aptr{$ButtonNum_L}->=0)
		SortOrder_aL{1}:=1
		INV_SortBtns_aptr{$ButtonNum_L}->:=1
	: (INV_SortBtns_aptr{$ButtonNum_L}->=1)
		SortOrder_aL{1}:=-1
		INV_SortBtns_aptr{$ButtonNum_L}->:=2
	: (INV_SortBtns_aptr{$ButtonNum_L}->=2)
		SortOrder_aL{1}:=1
		INV_SortBtns_aptr{$ButtonNum_L}->:=1
End case 
C_TEXT:C284($VarName)
C_LONGINT:C283($TblNum; $FldNum)
MULTI SORT ARRAY:C718(SortArrays_aptr; SortOrder_aL)
For ($i; 1; Size of array:C274(INV_SortBtns_aptr))
	RESOLVE POINTER:C394(INV_SortBtns_aptr{$i}; $VarName; $TblNum; $FldNum)
	If ($i=$ButtonNum_L)
		OBJECT SET VISIBLE:C603(*; $VarName; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*; $VarName; False:C215)
		INV_SortBtns_aptr{$i}->:=0
	End if 
	
End for 
CREATE SELECTION FROM ARRAY:C640([InventoryPhotoInsp:112]; InvPhotoInspRecNum_aL)