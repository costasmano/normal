//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_SetStringOrTextFilter
// User name (OS): cjmiller
// Date and time: 01/22/08, 10:31:49
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//r002 `01/22/08, 10:31:52     
End if 
C_TEXT:C284(TextEntryFilter_txt; StringEntryFilter_txt)

If (TextEntryFilter_txt="")
	TextEntryFilter_txt:="&"+Char:C90(Double quote:K15:41)+"a-z;A-Z;0-9; -?;:-@;[-';_;];{;};|"+Char:C90(13)+Char:C90(Double quote:K15:41)
	StringEntryFilter_txt:="&"+Char:C90(Double quote:K15:41)+"a-z;A-Z;0-9; -?;:-@;[-';_;];{;};|"+Char:C90(Double quote:K15:41)
End if 

C_POINTER:C301($1; $FielorVariable_ptr)
$FielorVariable_ptr:=$1

Case of 
	: (Type:C295($FielorVariable_ptr->)=Is alpha field:K8:1) | (Type:C295($FielorVariable_ptr->)=Is string var:K8:2)
		OBJECT SET FILTER:C235($FielorVariable_ptr->; StringEntryFilter_txt)
	: (Type:C295($FielorVariable_ptr->)=Is text:K8:3)
		OBJECT SET FILTER:C235($FielorVariable_ptr->; TextEntryFilter_txt)
		
End case 


//End ut_SetStringOrTextFilter