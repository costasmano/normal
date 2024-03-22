//%attributes = {"invisible":true}
C_LONGINT:C283($1; $ID)
C_POINTER:C301($2; $pArray)
$ID:=$1
$pArray:=$2
C_LONGINT:C283($vlNgrps; $i; $k; $j)
$vlNgrps:=Size of array:C274(alGRIDs)
For ($i; 1; $vlNgrps)
	$k:=Find in array:C230(alMembers{$i}; $ID)
	If ($k>0)
		$j:=Size of array:C274($pArray->)+1
		INSERT IN ARRAY:C227($pArray->; $j; 1)
		$pArray->{$j}:=alGRIDS{$i}
	End if 
	
End for 