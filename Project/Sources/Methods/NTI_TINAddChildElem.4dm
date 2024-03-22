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
End if 
//
//C_BOOLEAN($1)
//$AddProtSys_b:=$1

//C_BOOLEAN($AddProtSys_b)


C_LONGINT:C283($selectRow_L)
$selectRow_L:=Selected record number:C246([NTI_ELEM_TIN_INSP:185])
READ ONLY:C145([NTI_ELEM_TIN_INSP:185])
LOAD RECORD:C52([NTI_ELEM_TIN_INSP:185])
C_BOOLEAN:C305(PON_ADDPROTSYS_b)
NTI_SetupChildParams(->[NTI_ELEM_TIN_INSP:185])  //PON_SetupChildParams
PON_ADDPROTSYS_b:=False:C215
//ALERT("Add Defect to "+String([NTI_ELEM_BIN_INSP]ELEM_KEY)+" env "+String([NTI_ELEM_BIN_INSP]ENVKEY))

READ WRITE:C146([NTI_ELEM_TIN_INSP:185])
ADD RECORD:C56([NTI_ELEM_TIN_INSP:185])
If (OK=1)
	NTI_ListElements_TIN
End if 

// set to no parent after adding
PON_PARENTKEY_L:=0
PON_GRANDPARENTKEY_L:=0
PON_PARENTENV_L:=0
PON_PARENTID_L:=0
PON_GRANDPARENTID_L:=0
//End NTI_AddChildElem