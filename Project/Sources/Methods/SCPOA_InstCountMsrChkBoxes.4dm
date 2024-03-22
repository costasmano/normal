//%attributes = {"invisible":true}
//Method: SCPOA_InstCountMsrChkBoxes
//Description
//  ` Make sure Install countermeasure checkboxes is on 
// Parameters
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/23/12, 21:58:08
	// ----------------------------------------------------
	//Created : 
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(11/2/12 )
	Mods_2012_11
	//  `Fixed problem with setting var SCPOA_InstCNT_L to value higher than 1; would cause checkboxes
	//  `not to be printed.
	// Modified by: Costas Manousakis-(Designer)-(10/7/14 17:31:18)
	Mods_2014_10_bug
	//  `General POA modifications Oct 2014
End if 
//
ARRAY TEXT:C222($ObjArr_atxt; 0)
ARRAY POINTER:C280($objPtrs_aptr; 0)
ARRAY LONGINT:C221($Pages_aL; 0)
FORM GET OBJECTS:C898($ObjArr_atxt; $objPtrs_aptr; $Pages_aL)

C_TEXT:C284($varname_txt)
C_LONGINT:C283($tbl_L; $fld_L)

C_LONGINT:C283($loop_L; $checkCount_L)
$checkCount_L:=0
For ($loop_L; 1; Size of array:C274($objPtrs_aptr))
	RESOLVE POINTER:C394($objPtrs_aptr{$loop_L}; $varname_txt; $tbl_L; $fld_L)
	
	If ($varname_txt="SCPOA_Inst_@_L")
		//Found 
		If (Type:C295($objPtrs_aptr{$loop_L}->)=Is longint:K8:6)
			$checkCount_L:=$checkCount_L+($objPtrs_aptr{$loop_L}->)
		End if 
		
	End if 
	
End for 

If ($checkCount_L=0)
	SCPOA_InstCNT_L:=$checkCount_L
Else 
	SCPOA_InstCNT_L:=1
End if 

//added checks to make sure monitoring and struc counters are checked
SCPOA_Variables("VERIFYRECACTIONS")

[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2

//End SCPOA_InstCountMsrChkBoxes