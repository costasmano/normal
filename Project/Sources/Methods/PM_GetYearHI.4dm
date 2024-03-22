//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/29/09, 15:26:48
	// ----------------------------------------------------
	// Method: PM_GetYearHI
	// Description
	// 
	// 
	// Parameters
	// $0 : $HI_r
	// $1 : $Year_L
	// ----------------------------------------------------
	
	Mods_2009_06
End if 
C_REAL:C285($0; $HI_r)
C_LONGINT:C283($1; $Year_L)

$Year_L:=$1

$HI_r:=0
QUERY:C277([Pontis_Metric_Data:40]; [Pontis_Metric_Data:40]PM_UNiqueKey_s:1=[Pontis_Metrics:41]PM_UniqueKey_s:2)
QUERY SELECTION:C341([Pontis_Metric_Data:40]; [Pontis_Metric_Data:40]PMD_YKey_l:2=$Year_L)
If (Records in selection:C76([Pontis_Metric_Data:40])>0)
	$HI_r:=[Pontis_Metric_Data:40]PMD_Hindex_r:3
End if 

$0:=$HI_r