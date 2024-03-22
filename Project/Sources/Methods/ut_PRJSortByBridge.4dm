//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJSortByBridge
// User name (OS): cjmiller
// Date and time: 03/01/07, 13:03:14
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CM12_5301
End if 
ARRAY LONGINT:C221($RecordNumber_al; 0)
ARRAY TEXT:C222($Bridges_atxt; 0)
ARRAY TEXT:C222($NonBridges_atxt; 0)
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; $RecordNumber_al; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $Bridges_atxt; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; $NonBridges_atxt)
C_LONGINT:C283($Position_l)
C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
$Position_l:=1
Repeat 
	$Position_l:=Find in array:C230($Bridges_atxt; ""; $Position_l)
	If ($Position_l>0)
		$Bridges_atxt{$Position_l}:=$NonBridges_atxt{$Position_l}
		$Position_l:=$Position_l+1
	Else 
		$Complete_b:=True:C214
	End if 
Until ($Complete_b)
If (SortColumn1_l=0) | (SortColumn1_l=2)
	SortColumn1_l:=1
	SORT ARRAY:C229($Bridges_atxt; $RecordNumber_al; >)
	//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_BridgeNo_s;>)
Else 
	SortColumn1_l:=2
	SORT ARRAY:C229($Bridges_atxt; $RecordNumber_al; <)
	
	//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_BridgeNo_s;<)
End if 
CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; $RecordNumber_al; "SortedProjects")
USE NAMED SELECTION:C332("SortedProjects")
CLEAR NAMED SELECTION:C333("SortedProjects")
ARRAY LONGINT:C221($RecordNumber_al; 0)
ARRAY TEXT:C222($Bridges_atxt; 0)
ARRAY TEXT:C222($NonBridges_atxt; 0)

//End ut_PRJSortByBridge