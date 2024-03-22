//%attributes = {"invisible":true}
//Method: PushAllChanges
//Description
//
// Parameters
// $1 : stack 
// $2 : $Tbl_ptr
// ${3} : $FieldToSkip_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/13/13, 13:20:24
	// ----------------------------------------------------
	//Created : 
	Mods_2013_05
	// Modified by: Costas Manousakis-(Designer)-(12/19/14 12:34:51)
	Mods_2014_12
	//  `added check if field number is valid
	// Modified by: Costas Manousakis-(Designer)-(3/16/15 17:39:16)
	Mods_2015_03_bug
	//  `fixed bug  in field number valid statement
	// Modified by: Costas Manousakis-(Designer)-(6/18/15 16:21:15)
	Mods_2015_06
	//  `added a case to check for alpha/text fields to account for a change in upper/lower case
	//  `uses Position (x;y;*) ; 
	// Modified by: Costas Manousakis-(Designer)-(11/3/17 10:36:29)
	Mods_2017_11_bug
	//  `skip UUID fields
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Reset To not do updates for LSS Tables
	//If (Table name($TblNum_L)="LSS@")
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 
//
C_LONGINT:C283($1)
C_POINTER:C301($2; $Tbl_ptr)

C_LONGINT:C283($TblNum_L; $FldNum_L)
$TblNum_L:=Table:C252($2)
ARRAY POINTER:C280($FldsToSkip_aptr; 0)
C_LONGINT:C283($numParams_L; $pLoop_L; $numFlds_L; $fLoop_L; $Pos_L; $FldType_L; $FldLen_L)
If (Table name:C256($TblNum_L)="LSS@")
	ARRAY POINTER:C280(Ptr_changes; $1; 0)
Else 
	$numParams_L:=Count parameters:C259
	If ($numParams_L>2)
		C_POINTER:C301(${3})
		For ($pLoop_L; 3; $numParams_L)
			APPEND TO ARRAY:C911($FldsToSkip_aptr; ${$pLoop_L})
		End for 
		
	End if 
	
	$numFlds_L:=Get last field number:C255($2)
	C_POINTER:C301($fld_ptr)
	For ($fLoop_L; 1; $numFlds_L)
		If (Is field number valid:C1000($TblNum_L; $fLoop_L))
			$fld_ptr:=Field:C253($TblNum_L; $fLoop_L)
			If (Find in array:C230($FldsToSkip_aptr; $fld_ptr)>0)
				
			Else 
				GET FIELD PROPERTIES:C258($fld_ptr; $FldType_L; $FldLen_L)
				Case of 
					: (Type:C295($fld_ptr->)=Is picture:K8:10)
					: (Type:C295($fld_ptr->)=Is BLOB:K8:12)
						
					: ((Type:C295($fld_ptr->)=Is alpha field:K8:1) & ($FldLen_L=0))  //skip uuids
						
					: (Type:C295($fld_ptr->)=Is text:K8:3) | (Type:C295($fld_ptr->)=Is alpha field:K8:1)
						If (Length:C16($fld_ptr->)=Length:C16(Old:C35($fld_ptr->)))
							If (Length:C16($fld_ptr->)>0)  // if both are blank no need to push anything
								$Pos_L:=Position:C15($fld_ptr->; Old:C35($fld_ptr->); *)
								If ($Pos_L=0)
									PushChange($1; $fld_ptr)
								End if 
							End if 
						Else 
							PushChange($1; $fld_ptr)  //if not same length push it anyway
						End if 
					Else 
						If (($fld_ptr->)#Old:C35($fld_ptr->))
							PushChange($1; $fld_ptr)
						End if 
				End case 
				
			End if 
		End if 
	End for 
End if 
//End PushAllChanges