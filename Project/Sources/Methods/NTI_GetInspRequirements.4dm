//%attributes = {"invisible":true}
//Method: NTI_GetInspRequirements
//Description
// get the Requirements for the inspection type
// Parameters
// $1 : $InspType_txt
// $2 : $DBIEReq_ptr
// $3 : $AreaReq_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/16/16, 17:01:19
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	
	C_TEXT:C284(NTI_GetInspRequirements; $1)
	C_POINTER:C301(NTI_GetInspRequirements; $2)
	C_POINTER:C301(NTI_GetInspRequirements; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(9/1/16 17:11:02)
	Mods_2016_09
	//  `use fuul xPath in the Dom search "/NTI_INSPREQ/INSPTYPE"
End if 
//
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_TEXT:C284($InspType_txt)

C_POINTER:C301($DBIEReq_ptr; $AreaReq_ptr)
$InspType_txt:=$1
$DBIEReq_ptr:=$2
$AreaReq_ptr:=$3

C_BOOLEAN:C305($DBIEReq_b; $AreaReq_b)

C_TEXT:C284($ref_txt; $errmsg_txt)
ON ERR CALL:C155("XMLErrorHandler")
XMLError_b:=False:C215
$DBIEReq_b:=False:C215
$AreaReq_b:=False:C215
$ref_txt:=ut_DOM_FindElmtRef(NTI_INSPREQUIREMENTSTREE_txt; "/NTI_INSPREQ/INSPTYPE"; ->$InspType_txt)

If (XMLError_b)
	$errmsg_txt:="Error searching for Inspection in XML tree NTI_INSPREQUIREMENTSTREE_txt."+Char:C90(13)
	$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}
	ALERT:C41($errmsg_txt)
Else 
	DOM GET XML ATTRIBUTE BY NAME:C728($ref_txt; "DBIEREQ"; $DBIEReq_b)
	DOM GET XML ATTRIBUTE BY NAME:C728($ref_txt; "AreaREQ"; $AreaReq_b)
	
	If (XMLError_b)
		$errmsg_txt:="Error Getting DBIE / AreaEng review requirements for inspection type "+$InspType_txt+"."+Char:C90(13)
		$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}
		ALERT:C41($errmsg_txt)
	End if 
End if 

$DBIEReq_ptr->:=$DBIEReq_b
$AreaReq_ptr->:=$AreaReq_b

//End NTI_GetInspRequirements