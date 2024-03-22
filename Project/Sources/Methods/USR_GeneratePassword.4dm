//%attributes = {"invisible":true}
//Method: USR_GeneratePassword
//Description
// generate a password for a user
// Parameters
// $0 : $password_
// $1 : $params_o
//     .firstname
//     .lastname
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 9, 2022, 19:07:59
	Mods_2022_11
	// ----------------------------------------------------
	
	C_TEXT:C284(USR_GeneratePassword; $0)
	C_OBJECT:C1216(USR_GeneratePassword; $1)
End if 
//

C_TEXT:C284($0; $pw)
C_OBJECT:C1216($1)

C_TEXT:C284($P1; $P2; $P3; $P4; $N1; $N2)
C_LONGINT:C283($C0; $loop_L)
//warm up Random
For ($loop_L; 1; 500)
	$C0:=Random:C100
End for 
$N1:=String:C10(((Random:C100+Tickcount:C458)%(9+1))+0)
$N2:=String:C10(((Random:C100+Tickcount:C458)%(9+1))+0)
$C0:=(((Random:C100+Tickcount:C458)%(5+1))+1)
$P1:=""
$P2:=""
$P3:=""
Case of 
	: ($C0=1)
		//a _ _ b
		$P1:=$N1
		$P2:=""
		$P3:=$N2
		
	: ($C0=2)
		//a _ b _ 
		$P1:=$N1
		$P2:=$N2
		$P3:=""
	: ($C0=3)
		// _ a _ b
		$P1:=""
		$P2:=$N1
		$P3:=$N2
	: ($C0=4)
		//ab _  _ 
		$P1:=$N1+$N2
		$P2:=""
		$P3:=""
	: ($C0=5)
		// _ ab _ 
		$P1:=""
		$P2:=$N1+$N2
		$P3:=""
	: ($C0=6)
		// _ _ ab
		$P1:=""
		$P2:=""
		$P3:=$N1+$N2
		
End case 
$pw:=$P1+Substring:C12($1.firstname; 1; 3)+$P2+Substring:C12($1.lastname; 1; 3)+$P3
$pw:=Lowercase:C14($pw)

$0:=$pw
//End USR_GeneratePassword   