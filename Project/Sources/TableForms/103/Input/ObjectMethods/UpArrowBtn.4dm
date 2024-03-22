C_LONGINT:C283($currentRow; $NewRow)
$currentRow:=Arr_ItemNos
Case of 
	: ($currentRow=0)
		//Go to the bottom
		$NewRow:=Size of array:C274(Arr_ItemNos)
	: ($currentRow=1)
		//Go to the bottom
		$NewRow:=Size of array:C274(Arr_ItemNos)
	Else 
		//Go to the bottom
		$NewRow:=$currentRow-1
		
End case 
WKHR_SetListRow($NewRow)