//%attributes = {"invisible":true}
//Get ID of a user given the user name
C_LONGINT:C283($0)
ARRAY TEXT:C222($aUserNames; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY LONGINT:C221($aUserIDs; 0)
GET USER LIST:C609($aUserNames; $aUserIDs)
C_LONGINT:C283($k; $i; $0)
$k:=Size of array:C274($aUserIDs)
For ($i; $k; 1; -1)
	If (Is user deleted:C616($aUserIDs{$i}))
		DELETE FROM ARRAY:C228($aUserIDs; $i; 1)
		DELETE FROM ARRAY:C228($aUserNames; $i; 1)
	End if 
End for 

$k:=Find in array:C230($aUserNames; $1)
If ($k>0)
	$0:=$aUserIDs{$k}
Else 
	$0:=0
End if 