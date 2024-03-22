//%attributes = {"invisible":true}
If (False:C215)
	//Method to add group user members to an array.
	//Will drill down through nested groups.
	//$1: Group ID
	//$2 : pointer to string array that will contain the list of user names.
	Mods_2011_06  // CJ Miller`06/13/11, 17:07:04      ` Type all local variables for v11
End if 

C_LONGINT:C283($1; $vGrpID)
C_POINTER:C301($2; $pMembList)
$vGrpID:=$1
$pMembList:=$2
C_TEXT:C284($vsName; $vsSt; $vsPW; $vsUname)
C_LONGINT:C283($varrsize; $vsOwner; $NumMemb; $vbblog)
C_DATE:C307($vbLastlog)

$varrsize:=Size of array:C274($pMembList->)
ARRAY LONGINT:C221($aGrpMems; 0)
GET GROUP PROPERTIES:C613($vGrpID; $vsName; $vsOwner; $aGrpMems)
C_LONGINT:C283($NumMembs; $i)
$NumMembs:=Size of array:C274($aGrpMems)
For ($i; 1; $NumMembs)
	If (Abs:C99($aGrpMems{$i})>15000)
		Temp_addGroupMembers($aGrpMems{$i}; $pMembList)
	Else 
		If (Not:C34(Is user deleted:C616($aGrpMems{$i})))
			$varrsize:=Size of array:C274($pMembList->)+1
			GET USER PROPERTIES:C611($aGrpMems{$i}; $vsUname; $vsSt; $vsPW; $vbblog; $vbLastlog)
			If (Find in array:C230($pMembList->; $vsUname)<0)
				INSERT IN ARRAY:C227($pMembList->; $varrsize)
				$pMembList->{$varrsize}:=$vsUname
			End if 
		End if 
	End if 
End for 