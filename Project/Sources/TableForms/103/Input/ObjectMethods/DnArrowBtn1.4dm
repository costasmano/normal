C_LONGINT:C283($currentRow; $NewRow)
$currentRow:=Arr_ItemNos
Case of 
	: ($currentRow=0)
		//Go to the bottom
		$NewRow:=1
	: ($currentRow=Size of array:C274(Arr_ItemNos))
		//Go to the bottom
		$NewRow:=1
	Else 
		//Go to the bottom
		$NewRow:=$currentRow+1
		
End case 
WKHR_SetListRow($NewRow)