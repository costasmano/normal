//%attributes = {"invisible":true}
//Method: SIA_CheckOther2ND
//Description
//  ` Retrieves info on other Secondary records
// Parameters
// $1 : $OtherItm5arr_ptr
// $2 : $OtherItm6Aarr_ptr
// $3 : $BIN_s
// $4 : $Curr2NDKey_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/22/14, 09:28:06
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//

C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($4)

C_TEXT:C284($myBIN_s)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($myKey_L)
$myBIN_s:=$3
$myKey_L:=$4

ARRAY TEXT:C222($otherItem5_atxt; 0)
ARRAY TEXT:C222($otherItem6a_atxt; 0)

Begin SQL
	select [NBIS Secondary].[Item5], [NBIS Secondary].[Item6A] from [NBIS Secondary]
	where 
	[NBIS Secondary].[BIN] = :$myBIN_s
	and
	[NBIS Secondary].[NBISSecondaryKey_l] <> :$myKey_L
	into :$otherItem5_atxt, :$otherItem6a_atxt
End SQL

COPY ARRAY:C226($otherItem5_atxt; $1->)
COPY ARRAY:C226($otherItem6a_atxt; $2->)

//End SIA_CheckOther2ND