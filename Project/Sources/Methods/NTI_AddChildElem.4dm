//%attributes = {"invisible":true}
//Method: NTI_AddChildElem
//Description
//
// Parameters
// $1 : $AddProtSys_b
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/21/16, 17:17:44
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_POINTER:C301(NTI_AddChildElem; $1)
	C_BOOLEAN:C305(NTI_AddChildElem; $2)
	
End if 
//

//$AddProtSys_b:=$1

//C_BOOLEAN($AddProtSys_b)
C_POINTER:C301($Tbl_ptr)
If (Count parameters:C259>0)
	C_POINTER:C301($1)
	$Tbl_ptr:=$1
Else 
	$Tbl_ptr:=->[NTI_ELEM_BIN_INSP:183]
End if 
C_BOOLEAN:C305($AddProtSys_b)
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	$AddProtSys_b:=$2
Else 
	$AddProtSys_b:=False:C215
End if 

C_LONGINT:C283($selectRow_L)
$selectRow_L:=Selected record number:C246($Tbl_ptr->)
READ ONLY:C145($Tbl_ptr->)
LOAD RECORD:C52($Tbl_ptr->)
C_BOOLEAN:C305(PON_ADDPROTSYS_b)
ARRAY LONGINT:C221(PON_ELEMDEPTH_aL; 0)  //start the depth

NTI_SetupChildParams($Tbl_ptr)  //PON_SetupChildParams
PON_ADDPROTSYS_b:=$AddProtSys_b
//ALERT("Add Defect to "+String([NTI_ELEM_BIN_INSP]ELEM_KEY)+" env "+String([NTI_ELEM_BIN_INSP]ENVKEY))

READ WRITE:C146($Tbl_ptr->)
ADD RECORD:C56($Tbl_ptr->)
If (OK=1)
	
	If ($Tbl_ptr=(->[NTI_ELEM_BIN_INSP:183]))
		NTI_ListElements
	Else 
		NTI_ListElements_TIN
	End if 
	OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage Btn@"; False:C215)
	OBJECT SET ENABLED:C1123(*; "@PON_ADD_protsys Btn@"; False:C215)
	
End if 

// set to no parent after adding
PON_PARENTKEY_L:=0
PON_PARENTID_L:=0
//End NTI_AddChildElem