//%attributes = {"invisible":true}
//GP ChkBDept
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

C_TEXT:C284($BDept)
C_BOOLEAN:C305($StartCityNo; $FinCityNo; $StartBrNo)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

$BDept:=$1
$BDept:=Uppercase:C13($BDept)

$StartCityNo:=False:C215
$FinCityNo:=False:C215
$StartBrNo:=False:C215

//TRACE

$i:=1
While ($i<=Length:C16($BDept))
	
	If ($i=1)
		//The first character must be a letter.    
		Case of 
			: ($BDept[[1]]="0")
				$BDept[[1]]:="O"
			: ($BDept[[1]]="1")
				$BDept[[1]]:="I"
			: ($BDept[[1]]="2")
				$BDept[[1]]:="Z"
			: ($BDept[[1]]="5")
				$BDept[[1]]:="S"
		End case 
		If (($BDept[[1]]>="A") & ($BDept[[1]]<="Z"))
			$i:=$i+1
		Else 
			//This character is not a letter, so delete it and keep looking. 
			$BDept:=Delete string:C232($BDept; $i; 1)
		End if   //($BDept≤$i≥ is a letter?)
		
	Else 
		//The remaining characters must be numbers.
		Case of 
			: ($BDept[[$i]]="O")
				$BDept[[$i]]:="0"
			: (($BDept[[$i]]="I") | ($BDept[[$i]]="l"))
				$BDept[[$i]]:="1"
			: ($BDept[[$i]]="Z")
				$BDept[[$i]]:="2"
			: ($BDept[[$i]]="S")
				$BDept[[$i]]:="5"
		End case 
		
		If (($BDept[[$i]]>="0") & ($BDept[[$i]]<="9"))
			//This character is a number. 
			//Check the state in reverse order.        
			Case of 
				: ($StartBrNo)
					//This digit is past the beginning of the three digit bridge number.
					If ($i>=6)
						//That's it; get rid of any extraneous characters.
						$BDept:=Substring:C12($BDept; 1; 6)
					End if 
				: ($FinCityNo)
					//This is the beginning of the three digit bridge number.
					$StartBrNo:=True:C214
				: ($StartCityNo)
					//This is the last digit of the two digit city number     
					$FinCityNo:=True:C214
				Else 
					//This is the beginning of the two digit city number.
					$StartCityNo:=True:C214
			End case 
			$i:=$i+1
			
		Else 
			//This character is not a number, delete it. 
			$BDept:=Delete string:C232($BDept; $i; 1)
			//Check the state in reverse order.        
			Case of 
				: ($StartBrNo)
					//That's it; get rid of any extraneous characters.
					$BDept:=Substring:C12($BDept; 1; $i-1)
				: ($FinCityNo)
					//No need to do anything; keep looking for the start of the bridge number.
				: ($StartCityNo)
					//Complete the City number.
					If ($i=3)
						//This should be true; otherwise the city number would have been completed.
						//Pad with a zero.
						$BDept:=Insert string:C231($BDept; "0"; 2)
						$i:=$i+1
					End if 
					$FinCityNo:=True:C214
			End case 
		End if   //($BDept≤$i≥ is a number?)
		
	End if   //($i=1?)
	
End while 


While (Length:C16($BDept)<6)
	//Pad the bridge number with zero(s).
	$BDept:=Insert string:C231($BDept; "0"; 4)
End while 

$0:=$BDept