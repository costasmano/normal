//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/01/14, 14:41:45
//----------------------------------------------------
//Method: LSS_FillStructureTypes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// 
	//Modified by: Charles Miller (5/1/14 14:41:46)
	// Modified by: Costas Manousakis-(Designer)-(2/15/15 18:59:37)
	Mods_2015_02
	//  `check if parame 2 is passed
End if 

C_TEXT:C284($1; $2; $Category_txt)
$Category_txt:=$1


ARRAY TEXT:C222(v_171_001_atxt; 0)  //LSS_StructureTypeId_s
ARRAY TEXT:C222(v_171_003_atxt; 0)  //LSS_Description_txt

Begin SQL
	select [LSS_refStructureTypes].[LSS_StructureTypeId_s],
	[LSS_refStructureTypes].[LSS_Description_txt]
	from
	[LSS_refStructureTypes]
	where
	[LSS_refStructureTypes].[LSS_Category_s] = :$Category_txt
	into
	:v_171_001_atxt, :v_171_003_atxt;
	
End SQL

If (Count parameters:C259>1)
	v_171_003_atxt:=Find in array:C230(v_171_001_atxt; $2)
End if 

//End LSS_FillStructureTypes

