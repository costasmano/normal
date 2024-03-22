//%attributes = {"invisible":true}
//Method: PON_AddChildElem
//Description
//
// Parameters
// $1 : $AddProtSys_b
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 17:07:58
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(6/22/16 16:29:56)
	Mods_2016_06
	//  `disable ADD defect/prot sys buttons after an OK ADD Record
End if 
//
C_BOOLEAN:C305($1)

C_BOOLEAN:C305($AddProtSys_b)

$AddProtSys_b:=$1

C_LONGINT:C283($selectRow_L)
$selectRow_L:=Selected record number:C246([PON_ELEM_INSP:179])
READ ONLY:C145([PON_ELEM_INSP:179])
LOAD RECORD:C52([PON_ELEM_INSP:179])
C_BOOLEAN:C305(PON_ADDPROTSYS_b)
PON_SetupChildParams
PON_ADDPROTSYS_b:=$AddProtSys_b
//ALERT("Add Defect to "+String([PON_ELEM_INSP]ELEM_KEY)+" env "+String([PON_ELEM_INSP]ENVKEY))

READ WRITE:C146([PON_ELEM_INSP:179])
ADD RECORD:C56([PON_ELEM_INSP:179])
If (OK=1)
	PON_ListElements
	OBJECT SET ENABLED:C1123(*; "@PON_ADD_Damage@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(*; "@PON_ADD_PROTSYS@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	
End if 

// set to no parent after adding
PON_PARENTKEY_L:=0
PON_GRANDPARENTKEY_L:=0
PON_PARENTENV_L:=0
PON_PARENTID_L:=0
PON_GRANDPARENTID_L:=0
//End PON_AddChildElem