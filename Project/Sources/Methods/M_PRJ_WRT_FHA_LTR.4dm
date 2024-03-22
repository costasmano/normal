//%attributes = {"invisible":true}
//M_PRJ_WRT_FHA_LTR 
C_BOOLEAN:C305(PRJ_WRT_InList_b)
If (Count parameters:C259=1)
	C_BOOLEAN:C305($1)
	PRJ_WRT_InList_b:=$1
Else 
	PRJ_WRT_InList_b:=True:C214
End if 
PRJ_WRT_ProjectLetters("WRtemplate_FHA_LTR")