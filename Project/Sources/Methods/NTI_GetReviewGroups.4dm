//%attributes = {"invisible":true}
//Method: NTI_GetReviewGroups
//Description
// Get the PersGroups that can review the inspection based on inspResp
// Parameters
// $1 : $InspResp_txt
// $2 : $DBIEGroups_ptr
// $3 : $AreaEngGroups_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/16/16, 17:28:54
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	
	C_TEXT:C284(NTI_GetReviewGroups; $1)
	C_POINTER:C301(NTI_GetReviewGroups; $2)
	C_POINTER:C301(NTI_GetReviewGroups; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(9/1/16 17:11:59)
	Mods_2016_09
	//  `use full paths in the DOM searches
End if 
//
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_TEXT:C284($InspResp_txt)
C_POINTER:C301($DBIEGroups_ptr; $AreaEngGroups_ptr)
$InspResp_txt:=$1
$DBIEGroups_ptr:=$2
$AreaEngGroups_ptr:=$3

C_TEXT:C284($ref_txt; $errmsg_txt; $elemRef_txt; $Groupnmae_txt)
ON ERR CALL:C155("XMLErrorHandler")
XMLError_b:=False:C215

ARRAY TEXT:C222($DBIEGroups_ptr->; 0)
ARRAY TEXT:C222($AreaEngGroups_ptr->; 0)

$ref_txt:=ut_DOM_FindElmtRef(NTI_REVIEWPERMISSIONSTREE_txt; "/NTI_REVIEWPERMS/INSPRESP"; ->$InspResp_txt)
If (XMLError_b)
	$errmsg_txt:="Error searching for Inspection responsibility in XML tree NTI_REVIEWPERMISSIONSTREE_txt."+Char:C90(13)
	$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}
	ALERT:C41($errmsg_txt)
Else 
	ARRAY TEXT:C222($GroupRefs_atxt; 0)
	$elemRef_txt:=DOM Find XML element:C864($ref_txt; "/INSPRESP/DBIEGRP"; $GroupRefs_atxt)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($GroupRefs_atxt))
		DOM GET XML ELEMENT VALUE:C731($GroupRefs_atxt{$loop_L}; $Groupnmae_txt)
		APPEND TO ARRAY:C911($DBIEGroups_ptr->; $Groupnmae_txt)
	End for 
	
	$elemRef_txt:=DOM Find XML element:C864($ref_txt; "/INSPRESP/AreaGRP"; $GroupRefs_atxt)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($GroupRefs_atxt))
		DOM GET XML ELEMENT VALUE:C731($GroupRefs_atxt{$loop_L}; $Groupnmae_txt)
		APPEND TO ARRAY:C911($AreaEngGroups_ptr->; $Groupnmae_txt)
	End for 
	
	If (XMLError_b)
		$errmsg_txt:="Error Getting DBIE / AreaEng Review groups for Inspection Responsibility "+$InspResp_txt+"."+Char:C90(13)
		$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}
		ALERT:C41($errmsg_txt)
	End if 
End if 

ON ERR CALL:C155("")

//End NTI_GetReviewGroups