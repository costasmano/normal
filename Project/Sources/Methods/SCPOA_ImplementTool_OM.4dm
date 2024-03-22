//%attributes = {"invisible":true}
//Method: SCPOA_ImplementTool_OM
//Description
// object method for the tool buttons in the 2 - summary implemented
// Parameters
// $1  : $Obj_Ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/19/15, 11:37:52
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03_bug
End if 
//
C_POINTER:C301($1)
C_POINTER:C301($Toolbtn_ptr)
$Toolbtn_ptr:=$1
C_TEXT:C284($varName_txt; $YorN_txt)
C_LONGINT:C283($tbl_L; $fld_L)
RESOLVE POINTER:C394($Toolbtn_ptr; $varName_txt; $tbl_L; $fld_L)
C_POINTER:C301($Yes_ptr; $No_ptr)
$Yes_ptr:=Get pointer:C304(Substring:C12($varName_txt; 1; (Length:C16($varName_txt)-3))+"Y"+"_L")
$NO_ptr:=Get pointer:C304(Substring:C12($varName_txt; 1; (Length:C16($varName_txt)-3))+"N"+"_L")
Case of 
	: (Form event code:C388=On Load:K2:1)
	: (Form event code:C388=On Alternative Click:K2:36)
		//ALERT("clicked the arrow")
	: (Form event code:C388=On Long Click:K2:37)
		//ALERT("long clicked the arrow")
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		If ($Yes_ptr->#0) | ($NO_ptr->#0)
			[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2  //do this to mark a change
			$Yes_ptr->:=0
			$NO_ptr->:=0
		End if 
		
	: (Form event code:C388=On Mouse Enter:K2:33)
		C_TEXT:C284(vGenericHlpMsgVar1_S; SCPOA_OldGenMsg_txt)
		SCPOA_OldGenMsg_txt:=vGenericHlpMsgVar1_S
		vGenericHlpMsgVar1_S:="Clear Implemented Checkboxes"
		
	: (Form event code:C388=On Mouse Leave:K2:34)
		C_TEXT:C284(vGenericHlpMsgVar1_S; SCPOA_OldGenMsg_txt)
		If (SCPOA_OldGenMsg_txt#"")
			vGenericHlpMsgVar1_S:=SCPOA_OldGenMsg_txt
		End if 
		
End case 

//End SCPOA_ImplementTool_OM