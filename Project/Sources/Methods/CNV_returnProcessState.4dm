//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/26/16, 11:54:36
//----------------------------------------------------
//Method: CNV_returnProcessState
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (5/26/16 11:55:13)
	C_LONGINT:C283(CNV_returnProcessState; $0)
	C_LONGINT:C283(CNV_returnProcessState; $1)
	compiler_CNV
End if 

C_LONGINT:C283($State_L; $ProcID_L; $Process_L)
C_TEXT:C284($Name_txt)
C_LONGINT:C283($1)
$ProcID_L:=$1
If ($ProcID_L<0)
	$ProcID_L:=$ProcID_L*-1
End if 
C_TEXT:C284($2)

PROCESS PROPERTIES:C336($ProcID_L; $Name_txt; $State_L; $Process_L)
If ($Name_txt#$2)
	$State_L:=-9
End if 
$0:=$State_L
//End CNV_returnProcessState

