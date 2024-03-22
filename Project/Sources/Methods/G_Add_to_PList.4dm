//%attributes = {"invisible":true}
If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 10:27:48      ` Type all local variables for v11
End if 
//Add To parent Hlist
C_LONGINT:C283($1; $ID)
C_LONGINT:C283($2; $hlist)
$ID:=$1
$hlist:=$2
ARRAY LONGINT:C221(alparentlist; 0)
ARRAY LONGINT:C221($locList; 0)
G_GetParents($ID; ->alparentlist)
COPY ARRAY:C226(alparentlist; $locList)
$K:=Find in array:C230(alGRIDs; $ID)
If (Size of array:C274($locList)=0)
	C_LONGINT:C283($k)
	APPEND TO LIST:C376($hlist; asGrNames{$k}; $ID)
Else 
	C_LONGINT:C283($newList; $i)
	$newList:=New list:C375
	For ($i; 1; Size of array:C274($locList))
		G_Add_to_PList($locList{$i}; $newList)
	End for 
	APPEND TO LIST:C376($hlist; asGrNames{$k}; $ID; $newList; True:C214)
End if 