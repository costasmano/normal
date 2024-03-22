//%attributes = {"invisible":true}
//Method: GetRandomArrayElmts
//Description
// Create an array of randomly chosen X items from a source array
// Parameters
// $1 : $SourceArray_ptr
// $2 : $NumberItems_L
// $3 : $ResultArray_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-07
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	
	C_POINTER:C301(GetRandomArrayElmts; $1)
	C_LONGINT:C283(GetRandomArrayElmts; $2)
	C_POINTER:C301(GetRandomArrayElmts; $3)
	
End if 
//

C_POINTER:C301($1; $sourcearr_ptr)
C_LONGINT:C283($2; $numitems_L)
C_POINTER:C301($3; $resultarr_ptr)

$sourcearr_ptr:=$1
$resultarr_ptr:=$3
$numitems_L:=$2

ASSERT:C1129((fGetDataType(Type:C295($sourcearr_ptr->))="@array"); "1st Parameter must be an array")
ASSERT:C1129((Type:C295($sourcearr_ptr->)=Type:C295($resultarr_ptr->)); "Source and Result arrays must be the same type")

C_LONGINT:C283($SourceLength_L; $ResultLen_L; $i)
$SourceLength_L:=Size of array:C274($sourcearr_ptr->)

If ($numitems_L>=$SourceLength_L)
	//just copy the array
	COPY ARRAY:C226($sourcearr_ptr->; $resultarr_ptr->)
	
Else 
	C_BOOLEAN:C305($Deletearray_b)
	C_LONGINT:C283($ResultLength_L)
	C_LONGINT:C283($tick1; $tick2; $tick3; $tick4; $tick5; $tick6; $hits)  // these are performance check vars
	$tick1:=Tickcount:C458
	$ResultLength_L:=Size of array:C274($resultarr_ptr->)
	If ($ResultLength_L<$numitems_L)
		//pre-size result array
		INSERT IN ARRAY:C227($resultarr_ptr->; 0; ($numitems_L-$ResultLength_L))
	Else 
		DELETE FROM ARRAY:C228($resultarr_ptr->; 0; ($ResultLength_L-$numitems_L))
	End if 
	$tick2:=Tickcount:C458
	ARRAY LONGINT:C221($SourceIndx_aL; Size of array:C274($sourcearr_ptr->))
	ARRAY LONGINT:C221($resultIndx_aL; $numitems_L)
	
	C_LONGINT:C283($loop_L; $index_L)
	For ($loop_L; 1; Size of array:C274($SourceIndx_aL))  //initalize source indexes
		$SourceIndx_aL{$loop_L}:=$loop_L
	End for 
	$tick3:=Tickcount:C458
	For ($loop_L; 1; 500)
		$index_L:=Random:C100  //warming up Random function
	End for 
	$hits:=0
	If ($numitems_L<($SourceLength_L/2))
		//if we want less than half of the source - 
		
		For ($i; 1; $numitems_L)
			Repeat 
				$hits:=$hits+1
				$index_L:=RandomNumber(1; $SourceLength_L)  //random index 1- sourcelen
			Until ($SourceIndx_aL{$index_L}>0)
			$resultIndx_aL{$i}:=$SourceIndx_aL{$index_L}
			$SourceIndx_aL{$index_L}:=-1
		End for 
		$tick4:=Tickcount:C458
		SORT ARRAY:C229($resultIndx_aL)  // make the indexes in the same order as the source
		$tick5:=Tickcount:C458
		
	Else 
		//if it is more than half - 
		For ($i; 1; ($SourceLength_L-$numitems_L))
			
			Repeat 
				$hits:=$hits+1
				$index_L:=RandomNumber(1; $SourceLength_L)  //random index 1- sourcelen
			Until ($SourceIndx_aL{$index_L}>0)
			$SourceIndx_aL{$index_L}:=-1
		End for 
		$tick4:=Tickcount:C458
		
		C_LONGINT:C283($Sourceindx_L)
		$Sourceindx_L:=0
		
		For ($i; 1; $numitems_L)
			Repeat 
				$Sourceindx_L:=$Sourceindx_L+1
			Until ($SourceIndx_aL{$Sourceindx_L}>0)
			$resultIndx_aL{$i}:=$SourceIndx_aL{$Sourceindx_L}
		End for 
		$tick5:=Tickcount:C458
		
	End if 
	
	//now fill the result array
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($resultIndx_aL))
		$resultarr_ptr->{$loop_L}:=$sourcearr_ptr->{$resultIndx_aL{$loop_L}}
	End for 
	$tick6:=Tickcount:C458
End if 

//End GetRandomArrayElmts