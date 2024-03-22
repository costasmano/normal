//%attributes = {"invisible":true}
//Method: SCPOA_TextVarWDefault_OM
//Description
//  ` method used for text variables in the POA form where a default value based on the owner can be assigned.
// Parameters
// $1 : $TextVar_ptr :  Pointer to textvar or field
// $2 : $SysParamPrefix_txt : Prefix of a sys param in parameters table to be used as default. full param would be
//  ` the prefix + the owner code from Item 8 owner
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/12/15, 12:55:24
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_POINTER:C301($1; $TextVar_ptr)
C_TEXT:C284($2; $SysParamPrefix_txt)
$TextVar_ptr:=$1
$SysParamPrefix_txt:=$2

C_TEXT:C284($Owner_txt; $newText_txt; $prompt_txt)
$Owner_txt:=Substring:C12(SCPOA_Item8_txt; 10; 3)
$newText_txt:=ut_GetSysParameter($SysParamPrefix_txt+$Owner_txt)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Contextual click:C713 | Right click:C712)
			If ($newText_txt#"")
				$prompt_txt:=$newText_txt
				If (Length:C16($newText_txt)>400)
					$prompt_txt:=Substring:C12($newText_txt; 1; 400)+" ..."
				End if 
				If ($TextVar_ptr->="")
					$TextVar_ptr->:=$newText_txt
					[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
				Else 
					CONFIRM:C162("Replace current text with the Default = \r\""+$prompt_txt+"\" ?")
					If (OK=1)
						$TextVar_ptr->:=$newText_txt
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
					End if 
				End if 
				
			End if 
		Else 
			SCPOA_TextVar_OM($TextVar_ptr)
		End if 
		
	: (Form event code:C388=On Mouse Enter:K2:33)
		C_TEXT:C284(vGenericHlpMsgVar1_S; SCPOA_OldGenMsg_txt)
		SCPOA_OldGenMsg_txt:=vGenericHlpMsgVar1_S
		If ($newText_txt#"")
			vGenericHlpMsgVar1_S:="Edit Text in a Separate Window, or,\rRight Click for Default"
		Else 
			vGenericHlpMsgVar1_S:="Edit Text in a Separate Window"
		End if 
	: (Form event code:C388=On Mouse Leave:K2:34)
		C_TEXT:C284(vGenericHlpMsgVar1_S; SCPOA_OldGenMsg_txt)
		If (SCPOA_OldGenMsg_txt#"")
			vGenericHlpMsgVar1_S:=SCPOA_OldGenMsg_txt
		End if 
		
End case 
//End SCPOA_TextVarWDefault_OM