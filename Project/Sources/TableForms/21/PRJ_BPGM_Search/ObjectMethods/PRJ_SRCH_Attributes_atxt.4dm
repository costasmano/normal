// ----------------------------------------------------
// Object Method: PRJ_SRCH_Attributes_atxt
// User name (OS): charlesmiller
// Date and time: 12/24/08, 13:12:02
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 


POPUPMENUC(->PRJ_SRCH_Attributes_atxt; ->PRJ_SRCH_AttributesKey_al; ->PRJ_SRCH_AttributeKey_l)
PRJ_SRCH_AttributeKey_txt:=String:C10(PRJ_SRCH_AttributeKey_l)
PRJ_BPGM_ClearOtherSrch(->PRJ_SRCH_AttributeKey_txt)

//End Object Method: PRJ_SRCH_Attributes_atxt
