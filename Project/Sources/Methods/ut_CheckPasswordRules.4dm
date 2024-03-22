//%attributes = {"invisible":true}
//Method: ut_CheckPasswordRules
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/12/22, 11:44:50
	// ----------------------------------------------------
	//Created : 
	// Modified by: Chuck Miller-(Designer)-(7/19/22 12:51:55)
	Mods_2022_07  //Modified how passwords are changed in single user so that server password can be changed at the same time
	
End if 
C_TEXT:C284($1; $2; $Pass1_txt; $Pass2_txt)
$Pass1_txt:=$1
$Pass2_txt:=$2
C_BOOLEAN:C305($Return_B; $0)
$Return_B:=False:C215
C_LONGINT:C283($Loop_L; $Length_L; $NumberCapitals_L; $NumbersNumbers_L; $NumberLower_L; $Other_L)
Case of 
	: ($Pass2_txt="") & ($Pass1_txt#"")
	: ($Pass1_txt="") & ($Pass2_txt#"")
		
	: ($Pass2_txt="") | ($Pass1_txt="")
		ALERT:C41("Both passwords must be entered to change!")
	: (Replace string:C233($Pass1_txt; " "; "")="") | (Replace string:C233($Pass2_txt; " "; "")="")
		ALERT:C41("Password cannot be a blank string!")
	: (Length:C16($Pass1_txt)<8)
		ALERT:C41("Passwords must be at least 8 characters in length")
	: ((Length:C16($Pass1_txt))#(Length:C16($Pass2_txt)))
		ALERT:C41("The two passwords are not the same length")
	: ($Pass1_txt#$Pass2_txt)
		ALERT:C41("The two passwords are not the same!")
	: (($Pass1_txt=$Pass2_txt))
		C_BOOLEAN:C305($Matched_B)
		$Matched_B:=True:C214
		$Length_L:=Length:C16($Pass1_txt)
		For ($Loop_L; 1; $Length_L)
			If (Character code:C91($Pass1_txt[[$Loop_L]])#Character code:C91($Pass2_txt[[$Loop_L]]))  //Test that each character matches
				ALERT:C41("The two passwords are not the same!")
				$Loop_L:=$Length_L+1  // exit the loop
				$Matched_B:=False:C215
			End if 
			If ($Loop_L<=$Length_L)
				Case of 
					: (Character code:C91($Pass1_txt[[$Loop_L]])>=48) & (Character code:C91($Pass1_txt[[$Loop_L]])<=57)
						$NumbersNumbers_L:=$NumbersNumbers_L+1
					: (Character code:C91($Pass1_txt[[$Loop_L]])>=65) & (Character code:C91($Pass1_txt[[$Loop_L]])<=90)
						$NumberCapitals_L:=$NumberCapitals_L+1
					: (Character code:C91($Pass1_txt[[$Loop_L]])>=97) & (Character code:C91($Pass1_txt[[$Loop_L]])<=122)
						$NumberLower_L:=$NumberLower_L+1
					Else 
						$Other_L:=$Other_L+1  //If you want to add special character
				End case 
			End if 
		End for 
		ARRAY TEXT:C222($Messages_atxt; 0)
		If ($Matched_B)
			
			If ($NumbersNumbers_L=Length:C16($Pass1_txt))
				APPEND TO ARRAY:C911($Messages_atxt; "Password can not Be all Numbers")
			End if 
			If ($NumberCapitals_L=Length:C16($Pass1_txt))
				APPEND TO ARRAY:C911($Messages_atxt; "Password can not be all Capital Letters")
			End if 
			If ($NumberLower_L=Length:C16($Pass1_txt))
				APPEND TO ARRAY:C911($Messages_atxt; "Password can not be all Lowercase Letters")
			End if 
			If ($NumbersNumbers_L=0)
				APPEND TO ARRAY:C911($Messages_atxt; "Password must have at least 1 number")
			End if 
			If ($NumberCapitals_L=0)
				APPEND TO ARRAY:C911($Messages_atxt; "Password must have at least 1 Capital Letter")
			End if 
			If ($NumberLower_L=0)
				APPEND TO ARRAY:C911($Messages_atxt; "Password must have at least 1 Lowercase Letter")
			End if 
			//if($Other_L=0)//Uncomment if a special character is desired
			//APPEND TO ARRAY($Messages_atxt;"Password must have at least 1 Special Character")
			//end if
		Else 
			
		End if 
		C_TEXT:C284($Messages_txt)
		$Messages_txt:=""
		For ($Loop_L; 1; Size of array:C274($Messages_atxt))
			$Messages_txt:=$Messages_txt+$Messages_atxt{$Loop_L}+Char:C90(Carriage return:K15:38)
		End for 
		If ($Messages_txt#"")
			ALERT:C41("The following criteria was not met for your password : "+Char:C90(Carriage return:K15:38)+$Messages_txt)
			$Matched_B:=False:C215
		End if 
		$Return_B:=($Matched_B)
	Else 
		$Return_B:=False:C215
		
End case 
$0:=$Return_B

//End ut_CheckPasswordRules