//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/26/07, 14:06:53
	// ----------------------------------------------------
	// Method: PRJ_SortByAdDate
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

SET CURSOR:C469(4)
SET QUERY DESTINATION:C396(Into set:K19:2; "PRJSETNOADDATE")
QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5=!00-00-00!)
SET QUERY DESTINATION:C396(Into set:K19:2; "PRJSETVALIDADDDATE")
QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5#!00-00-00!)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
ARRAY LONGINT:C221($RecordNumberNOAD_al; 0)
ARRAY LONGINT:C221(RecordNumberAD_al; 0)
ARRAY DATE:C224(AdDates_ad; 0)
ARRAY TEXT:C222(Bridges_atxt; 0)
ARRAY TEXT:C222($NonBridges_atxt; 0)
ARRAY POINTER:C280(sortarrays_ap; 3)
ARRAY LONGINT:C221(orderarray_al; 3)
sortarrays_ap{1}:=->AdDates_ad
sortarrays_ap{2}:=->Bridges_atxt
sortarrays_ap{3}:=->RecordNumberAD_al
orderarray_al{2}:=1
orderarray_al{3}:=0
If (SortColumn6_l=0) | (SortColumn6_l=2)
	SortColumn6_l:=1
	//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectFile]PF_Advertising_d;>)
	orderarray_al{1}:=1
Else 
	SortColumn6_l:=2
	//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectFile]PF_Advertising_d;<)
	orderarray_al{1}:=-1
End if 

If (Records in set:C195("PRJSETNOADDATE")>0)
	USE SET:C118("PRJSETNOADDATE")
	SortColumn1_l:=0
	ut_PRJSortByBridge
	SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; $RecordNumberNOAD_al)
	SortColumn1_l:=0
End if 

If (Records in set:C195("PRJSETVALIDADDDATE")>0)
	USE SET:C118("PRJSETVALIDADDDATE")
	SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; RecordNumberAD_al; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; AdDates_ad; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; Bridges_atxt; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; $NonBridges_atxt)
	C_LONGINT:C283($Position_l)
	C_BOOLEAN:C305($Complete_b)
	$Complete_b:=False:C215
	$Position_l:=1
	Repeat 
		$Position_l:=Find in array:C230(Bridges_atxt; ""; $Position_l)
		If ($Position_l>0)
			Bridges_atxt{$Position_l}:=$NonBridges_atxt{$Position_l}
			$Position_l:=$Position_l+1  //Mods_2007_CM11
		Else 
			$Complete_b:=True:C214
		End if 
	Until ($Complete_b)
	
	MULTI SORT ARRAY:C718(sortarrays_ap; orderarray_al)
End if 
If (Size of array:C274($RecordNumberNOAD_al)>0)
	C_LONGINT:C283($OldArrSize_l; $NextElmt_l; $NewSize_l; $i)
	$OldArrSize_l:=Size of array:C274(RecordNumberAD_al)
	$NextElmt_l:=$OldArrSize_l+1
	ARRAY LONGINT:C221(RecordNumberAD_al; ($OldArrSize_l+Size of array:C274($RecordNumberNOAD_al)))
	$NewSize_l:=Size of array:C274(RecordNumberAD_al)
	For ($i; $NextElmt_l; $NewSize_l)
		RecordNumberAD_al{$i}:=$RecordNumberNOAD_al{$i-$OldArrSize_l}
	End for 
End if 
If (Size of array:C274(RecordNumberAD_al)>0)
	CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; RecordNumberAD_al; "SortedProjects")
	USE NAMED SELECTION:C332("SortedProjects")
	CLEAR NAMED SELECTION:C333("SortedProjects")
End if 

CLEAR SET:C117("PRJSETNOADDATE")
CLEAR SET:C117("PRJSETVALIDADDDATE")
ARRAY LONGINT:C221($RecordNumberNOAD_al; 0)
ARRAY LONGINT:C221(RecordNumberAD_al; 0)
ARRAY DATE:C224(AdDates_ad; 0)
ARRAY TEXT:C222(Bridges_atxt; 0)
ARRAY TEXT:C222($NonBridges_atxt; 0)
ARRAY POINTER:C280(sortarrays_ap; 0)
ARRAY LONGINT:C221(orderarray_al; 0)

ut_SetSortColumns(7; 6)