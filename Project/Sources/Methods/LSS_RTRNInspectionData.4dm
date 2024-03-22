//%attributes = {"invisible":true}
//Method: LSS_RTRNInspectionData
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/19/18, 12:06:00
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
End if 
//

C_TEXT:C284($1)
C_POINTER:C301($2; $3)
$Key_txt:=$1
C_TEXT:C284($Key_txt; $Description_txt; $Allowed_Elements_txt)

Begin SQL
	select [LSS_refInspectionType].[LSS_Description_txt],
	[LSS_refInspectionType].[LSS_AllowedElements_txt]
	from 
	[LSS_refInspectionType]
	where [LSS_refInspectionType].[LSS_InspectionTypeId_s] = :$Key_txt
	into 
	:$Description_txt, 
	:$Allowed_Elements_txt;
End SQL
$2->:=$Description_txt
$3->:=$Allowed_Elements_txt

//End LSS_RTRNInspectionDescription