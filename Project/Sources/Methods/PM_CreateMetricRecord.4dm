//%attributes = {"invisible":true}
// ----------------------------------------------------
// PM_CreateMetricRecord
// User name (OS): charlesmiller
// Date and time: 05/22/09, 16:05:48
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$1 pointer to run key
//$2 pointer to current date
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //r002  `05/22/09, 16:05:51 `Add code and tables to retrieve pontis simulation data
End if 
C_POINTER:C301($1; $2; $3; $4; $Runkey_ptr; $CurrentDate_ptr; $SCKey_ptr; $Tev_ptr)
$Runkey_ptr:=$1
$CurrentDate_ptr:=$2
$SCKey_ptr:=$3
$Tev_ptr:=$4
CREATE RECORD:C68([Pontis_Metrics:41])
[Pontis_Metrics:41]PM_RunKey_l:1:=$Runkey_ptr->
[Pontis_Metrics:41]PM_SCKey_s:5:=$SCKey_ptr->
[Pontis_Metrics:41]PM_Tev_r:6:=$Tev_ptr->
[Pontis_Metrics:41]PM_UniqueKey_s:2:=PM_Bin_s+"-"+String:C10([Pontis_Metrics:41]PM_RunKey_l:1; "000000000")
[Pontis_Metrics:41]PM_ImportDate_d:4:=$CurrentDate_ptr->
[Pontis_Metrics:41]PM_Bin_s:3:=PM_Bin_s
SAVE RECORD:C53([Pontis_Metrics:41])
//End PM_CreateMetricRecord