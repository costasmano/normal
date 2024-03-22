//%attributes = {"invisible":true}
//GP GetPersonID
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Try to identify a single person from an array of names,
//which may include last name, first name, etc.

C_POINTER:C301($ptr_aNames)
C_LONGINT:C283($0; $JobCode; $District)  //Command Replaced was o_C_INTEGER

C_LONGINT:C283($names; $LNMatches; $FNMatches; $JCMatches; $DMatches)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($i; $j; $k; $pos)  //Command Replaced was o_C_INTEGER

$ptr_aNames:=$1  //Given: A pointer to an array of names.
$JobCode:=$2  //Given: The preferred job code.
$District:=$3  //Given: The bridge's district.

//TRACE

$names:=Size of array:C274($ptr_aNames->)
$LNMatches:=0
$i:=1  //The array element to compare with last names.
While (($LNMatches=0) & ($i<=$names))
	//Use the first array element that matches a last name.  
	QUERY:C277([Personnel:42]; [Personnel:42]Last Name:5=$ptr_aNames->{$i})
	$LNMatches:=Records in selection:C76([Personnel:42])
	
	Case of 
		: ($LNMatches=1)
			$pos:=[Personnel:42]Person ID:1
		: ($LNMatches>1)
			ARRAY INTEGER:C220($aIDs; 0)
			ARRAY TEXT:C222($aFirstNames; 0)  //Command Replaced was o_ARRAY string length was 20
			ARRAY TEXT:C222($aDivNo; 0)  //Command Replaced was o_ARRAY string length was 4
			ARRAY INTEGER:C220($aJCodes; 0)
			SELECTION TO ARRAY:C260([Personnel:42]Person ID:1; $aIDs; [Personnel:42]First Name:3; $aFirstNames; [Personnel:42]Division No:7; $aDivNo; [Personnel:42]Job Code:8; $aJCodes)
			ARRAY BOOLEAN:C223($aFNGood; $LNMatches)
			ARRAY BOOLEAN:C223($aJCGood; $LNMatches)
			ARRAY BOOLEAN:C223($aDGood; $LNMatches)
			ARRAY INTEGER:C220($aMatches; $LNMatches)
			$FNMatches:=0
			For ($k; 1; $LNMatches)
				$j:=0
				While (($j<$names) & Not:C34($aFNGood{$k}))
					$j:=$j+1
					If ($j#$i)  //Don't use the $i element; it was used to find the last name.
						//The position function ignores case.
						$pos:=Position:C15($ptr_aNames->{$j}; $aFirstNames{$k})
						//This test bypasses a supplied initial that was found past the first letter.
						If (($pos>0) & (($pos=1) | (Length:C16($ptr_aNames->{$j})>1)))
							$aFNGood{$k}:=True:C214
							$FNMatches:=$FNMatches+1  //Count the number of personnel records matching the first name.
							//The aMatches array quantifies how closely this record matches.
							$aMatches{$k}:=$aMatches{$k}+1
						End if 
					End if 
				End while 
			End for 
			
			$pos:=0
			If ($FNMatches=1)
				//There is one first name match; use it.          
				$k:=Find in array:C230($aFNGood; True:C214)
				$pos:=$aIDs{$k}
			Else 
				
				//Check District and Job Code.
				$JCMatches:=0
				$DMatches:=0
				For ($k; 1; $LNMatches)
					If (($FNMatches=0) | ($aFNGood{$k}))
						//Check all records if there are no first name matches or
						//check just the first name matches.
						If ($aDivNo{$k}=("044"+String:C10($District)))
							$aDGood{$k}:=True:C214
							$DMatches:=$DMatches+1
							$aMatches{$k}:=$aMatches{$k}+1
						End if 
						If ($aJCodes{$k}=$JobCode)
							$aJCGood{$k}:=True:C214
							$JCMatches:=$JCMatches+1
							$aMatches{$k}:=$aMatches{$k}+1
						End if 
					End if 
				End for 
				
				If ($DMatches=1)
					//There is one district match; use it.          
					$k:=Find in array:C230($aDGood; True:C214)
					$pos:=$aIDs{$k}
				Else 
					If ($JCMatches=1)
						//There is one job code match; use it.          
						$k:=Find in array:C230($aJCGood; True:C214)
						$pos:=$aIDs{$k}
					Else 
						
						//There is no single match; sort them.
						//Make no preference in case of a tie.       
						SORT ARRAY:C229($aMatches; $aIDs; $aFirstNames; $aDivNo; $aJCodes)
						$pos:=$aIDs{1}
					End if 
				End if 
				
			End if 
			
			
	End case 
	
	$i:=$i+1
End while 

$0:=$pos

If ($names>0)
	//Delete elements up to the last name.
	//Keep elements that may be another person.
	DELETE FROM ARRAY:C228($ptr_aNames->; 1; $i-1)
End if 