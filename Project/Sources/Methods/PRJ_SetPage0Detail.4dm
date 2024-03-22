//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): MillerC
// Date and time: 06/13/07, 12:23:22
// ----------------------------------------------------
// Method: PRJ_SetPage0Detail
// Description
// 
//
// Parameters
//$1 true or false to show or hide areas
// ----------------------------------------------------
C_BOOLEAN:C305($1; $ShowOrHide_b)
$ShowOrHide_b:=$1
OBJECT SET VISIBLE:C603(*; "ManyButtonsProjReview2"; $ShowOrHide_b)

OBJECT SET VISIBLE:C603(PRJ_Detail_s; $ShowOrHide_b)
OBJECT SET VISIBLE:C603(PRJ_DetailHead_atxt; $ShowOrHide_b)
OBJECT SET VISIBLE:C603(PRJ_Detail_atxt; $ShowOrHide_b)
