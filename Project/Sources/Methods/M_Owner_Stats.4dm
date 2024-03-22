//%attributes = {"invisible":true}
//GP M_Owner_Stats

C_TEXT:C284($Text; $Message)
C_LONGINT:C283($Current; $Next; $Last; $Current; $NumOwners; $i)

CONFIRM:C162("Do you wish to generate a file of data owner statistics?")
If (OK=1)
	SHORT_MESSAGE("Please Wait - Sorting Owners of Data...")
	ALL RECORDS:C47([Owners of Data:62])
	SELECTION TO ARRAY:C260([Owners of Data:62]Owner Name:2; aOwnerData)
	SORT ARRAY:C229(aOwnerData)
	$Last:=Size of array:C274(aOwnerData)
	DISTINCT VALUES:C339([Owners of Data:62]Owner Name:2; aOwners)
	SORT ARRAY:C229(aOwners)
	$NumOwners:=Size of array:C274(aOwners)
	$Current:=1
	$Text:="Total Owner Records"+<>sTab+String:C10($Last)+<>sCR
	For ($i; 1; $NumOwners)
		If ($i<$NumOwners)
			$Next:=Find in array:C230(aOwnerData; aOwners{$i+1}; $Current)
		Else 
			$Next:=$Last+1
		End if 
		ARRAY LONGINT:C221(aNumChanges; $i)
		aNumChanges{$i}:=$Next-$Current
		$Text:=$Text+aOwners{$i}+<>sTab+String:C10(aNumChanges{$i})+<>sCR
		$Current:=$Next
	End for 
	
	CLOSE WINDOW:C154
	
	$Message:="In the next dialog box, please specify the name for a tab-delimited text file"
	$Message:=$Message+" for the owners of data statistics."
	ALERT:C41($Message)
	C_TIME:C306($Doc)
	$Doc:=Create document:C266("")
	If (OK=1)
		SEND PACKET:C103($Doc; $Text)
		CLOSE DOCUMENT:C267($Doc)
	End if 
End if 