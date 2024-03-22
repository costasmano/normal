//%attributes = {"invisible":true}
//Method: NTI_LoadDOMTrees
//Description
// Load the XML trees needed for NTI inspection review
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/16/16, 16:49:23
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	// Modified by: Costas Manousakis-(Designer)-(9/1/16 13:19:02)
	Mods_2016_09
	//  `added exrta checks for blank db parameters
	// Modified by: Costas Manousakis-(Designer)-(1/11/18 12:31:57)
	Mods_2018_01
	//  `added NTI_CSWTFACTORSTREE_txt
End if 
//
C_TEXT:C284(NTI_INSPREQUIREMENTSTREE_txt; NTI_REVIEWPERMISSIONSTREE_txt; NTI_CSWTFACTORSTREE_txt)
C_TEXT:C284($paramValue_txt; $errmsg_txt)
$paramValue_txt:=ut_GetSysParameter("NTI_INSPREQ")

If ($paramValue_txt#"")
	ON ERR CALL:C155("XMLErrorHandler")
	XMLError_b:=False:C215
	NTI_INSPREQUIREMENTSTREE_txt:=DOM Parse XML variable:C720($paramValue_txt)
	
	If (XMLError_b)
		$errmsg_txt:="Error loading database parameter NTI_INSPREQ : Inspection Review Requirements."+Char:C90(13)
		$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}+Char:C90(13)
		$errmsg_txt:=$errmsg_txt+"Value read :("+$paramValue_txt+")"
		ALERT:C41($errmsg_txt)
	End if 
	
	ON ERR CALL:C155("")
	
Else 
	ALERT:C41("Missing Required database parameter NTI_INSPREQ : Inspection Review Requirements!")
End if 


$paramValue_txt:=ut_GetSysParameter("NTI_REVIEWPERMS")

If ($paramValue_txt#"")
	ON ERR CALL:C155("XMLErrorHandler")
	XMLError_b:=False:C215
	NTI_REVIEWPERMISSIONSTREE_txt:=DOM Parse XML variable:C720($paramValue_txt)
	
	If (XMLError_b)
		$errmsg_txt:="Error loading database parameter NTI_REVIEWPERMS : Inspection Review Permissions."+Char:C90(13)
		$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}+Char:C90(13)
		$errmsg_txt:=$errmsg_txt+"Value read :("+$paramValue_txt+")"
		ALERT:C41($errmsg_txt)
	End if 
	
	ON ERR CALL:C155("")
	
Else 
	ALERT:C41("Missing Required database parameter NTI_REVIEWPERMS : Inspection Review Permissions!")
End if 

$paramValue_txt:=ut_GetSysParameter("NTI_CSWTFACTORS")

If ($paramValue_txt#"")
	ON ERR CALL:C155("XMLErrorHandler")
	XMLError_b:=False:C215
	NTI_CSWTFACTORSTREE_txt:=DOM Parse XML variable:C720($paramValue_txt)
	
	If (XMLError_b)
		$errmsg_txt:="Error loading database parameter NTI_CSWTFACTORS : Condition State Weight Factors."+Char:C90(13)
		$errmsg_txt:=$errmsg_txt+"Error :"+String:C10(XMLErrorNumbers_al{1})+" : "+XML_InternalDescriptions_atxt{1}+Char:C90(13)
		$errmsg_txt:=$errmsg_txt+"Value read :("+$paramValue_txt+")"
		ALERT:C41($errmsg_txt)
	End if 
	
	ON ERR CALL:C155("")
	
Else 
	ALERT:C41("Missing Required database parameter NTI_CSWTFACTORS : Condition State Weight Factors!")
End if 

//End NTI_LoadDOMTrees