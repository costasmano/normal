
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 10:31:13
//----------------------------------------------------
//Method: Object Method: [LSS_UT].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 10:31:17)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
End if 
ONE RECORD SELECT:C189([LSS_UT:175])
C_BOOLEAN:C305($Skip_B)
C_LONGINT:C283($Count_L)
$Count_L:=1
C_TEXT:C284($ConfirmMessage_txt)

$ConfirmMessage_txt:="There are some locked records associated with this inspection do you want to try again?"
QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=[LSS_UT:175]LSS_UTId_s:1)

Repeat 
	DELETE SELECTION:C66([LSS_UtResult:176])
	If (Records in set:C195("LockedSet")>0)
		If ($Count_L=1)
			CONFIRM:C162($ConfirmMessage_txt; "Yes"; "No")
			If (OK=1)
				$Count_L:=$Count_L+1
			Else 
				$Skip_B:=True:C214
			End if 
			
		End if 
		$Count_L:=$Count_L+1
		If ($Count_L=10) & (Not:C34($Skip_B))
			$ConfirmMessage_txt:="There are still some locked records associated with this inspection do you want to try again?"
			$Count_L:=1
		End if 
		If (Not:C34($Skip_B))
			DELAY PROCESS:C323(Current process:C322; 30)
		End if 
	End if 
Until (Records in set:C195("LockedSet")=0) | ($Skip_B)

If ($Skip_B)
	ALERT:C41("Not all UT results records deleted")
Else 
	LSS_UpdateMany_B:=True:C214
	LogDeletion(->[LSS_UT:175]LSS_UTId_s:1; ->[LSS_UT:175]LSS_UTId_s:1; ->[LSS_UT:175]LSS_UTId_s:1; 0)
	DELETE RECORD:C58([LSS_UT:175])
	LSS_UTRow_L:=-9
End if 

CANCEL:C270


//End Object Method: [LSS_UT].Input.bDelete

