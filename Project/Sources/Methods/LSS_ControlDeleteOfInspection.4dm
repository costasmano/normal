//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/10/16, 12:03:24
//----------------------------------------------------
//Method: LSS_ControlDeleteOfInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_03_bug  // 
	//Modified by: administrator (3/10/16 12:03:26)
	
End if 
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($Skip_B)
C_LONGINT:C283($Count_L)
$Count_L:=1
C_TEXT:C284($ConfirmMessage_txt)

$ConfirmMessage_txt:="There are some locked records associated with this inspection do you want to try again?"

Repeat 
	DELETE SELECTION:C66([LSS_Inspection:164])
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
		If ($Count_L=11) & (Not:C34($Skip_B))
			$ConfirmMessage_txt:="There are still some locked records associated with this inspection do you want to try again?"
			$Count_L:=1
		End if 
		If (Not:C34($Skip_B))
			DELAY PROCESS:C323(Current process:C322; 30)
		End if 
	End if 
Until (Records in set:C195("LockedSet")=0) | ($Skip_B)
$0:=$Skip_B
//End LSS_ControlDeleteOfInspection