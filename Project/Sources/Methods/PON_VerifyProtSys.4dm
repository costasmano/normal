//%attributes = {"invisible":true}
//Method: PON_VerifyProtSys
//Description
// Verify that protective systems are assigned to correct parents
// Parameters
// $0 : $Errors_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/02/21, 19:51:27
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
	
	C_TEXT:C284(PON_VerifyProtSys; $0)
	
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($PontisErrors_txt)
$PontisErrors_txt:=""
ARRAY LONGINT:C221($Strunit_aL; 0)
ARRAY LONGINT:C221($elemKey_aL; 0)
ARRAY LONGINT:C221($envKey_aL; 0)
ARRAY LONGINT:C221($ParKey_aL; 0)
ARRAY LONGINT:C221($GrandPKey_aL; 0)
ARRAY LONGINT:C221($ProtSystems_aL; 0)
C_LONGINT:C283($InspID_L)
$InspID_L:=[Inspections:27]InspID:2
ARRAY TEXT:C222($CompoundKeys_atxt; 0)
Begin SQL
	select
	[PON_ELEM_INSP].[STRUNITKEY],
	[PON_ELEM_INSP].[ELEM_KEY],
	[PON_ELEM_INSP].[ENVKEY],
	[PON_ELEM_INSP].[ELEM_PARENT_KEY],
	[PON_ELEM_INSP].[ELEM_GRANDPARENT_KEY]
	from [PON_ELEM_INSP]
	where 
	[PON_ELEM_INSP].[INSPID] = :$InspID_L
	into 
	:$Strunit_aL,
	:$elemKey_aL,
	:$envKey_aL,
	:$ParKey_aL,
	:$GrandPKey_aL ;
	
	select
	[PON_ELEM_DEFS].[ELEM_KEY]
	from [PON_ELEM_DEFS]
	where
	[PON_ELEM_DEFS].[ELEM_PROTECT_SYS] = 'Y'
	into
	:$ProtSystems_aL ;
	
End SQL

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($elemKey_aL))
	If (Find in array:C230($ProtSystems_aL; $elemKey_aL{$loop_L})>0)
		//protective system
		ARRAY LONGINT:C221($allowedProtsys_aL; 0)
		PON_FindAllowedProtSys($ParKey_aL{$loop_L}; ->$allowedProtsys_aL)
		
		If (Find in array:C230($allowedProtsys_aL; $elemKey_aL{$loop_L})>0)
			//ok
		Else 
			//protective system not allowed for parent element
			//build the Message
			$PontisErrors_txt:=$PontisErrors_txt+Char:C90(13)
			$PontisErrors_txt:=$PontisErrors_txt+"Struct. Unit "+String:C10($Strunit_aL{$loop_L})+\
				", Protective system "+String:C10($elemKey_aL{$loop_L})+\
				" is not allowed for Parent "+String:C10($ParKey_aL{$loop_L})+\
				" in Env "+String:C10($envKey_aL{$loop_L})
			
		End if 
		
	End if 
End for 

$0:=$PontisErrors_txt

//End PON_VerifyProtSys