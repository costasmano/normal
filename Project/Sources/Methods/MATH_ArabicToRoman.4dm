//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/08, 08:56:44
	// ----------------------------------------------------
	// Method: Method: MATH_ArabicToRoman
	// Description
	// Copied from Math4D and renamed. See comments below.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	
	// MATH_ArabeVersRomain [Olivier Deschanels 27/2/3]
	// Elément du projet Vitruve © 1991
	// ---------------------------------------------
	// Conversion d'un entier en chaine de chiffre romain.
	// Note : les entiers suffisent car les romains ne traitaient pas de grands nombre
	// ---------------------------------------------
	// MATH_ArabeVersRomain (Entier) -> TexteRésultat
	// ---------------------------------------------
	// MATHERROR
	// 0 -> Pas d'erreur
	// ---------------------------------------------
	//  
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_TEXT:C284($0; $resultat)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($1; $chiffre; $num)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($fin)
C_TEXT:C284($d; $c; $u)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($aj)  // Command Replaced was o_C_STRING length was 255

//initialisation
$fin:=False:C215
$chiffre:=$1
$resultat:=""
MATHERROR:=0
//calcul
Repeat 
	$num:=$chiffre
	Case of 
		: ($num>999)
			$aj:="M"*Num:C11(Substring:C12(String:C10($chiffre); 1; 1))
		: ($num>99)
			$u:="C"
			$c:="D"
			$d:="M"
		: ($num>9)
			$u:="X"
			$c:="L"
			$d:="C"
		Else 
			$u:="I"
			$c:="V"
			$d:="X"
	End case 
	If ($num<1000)
		$num:=Num:C11(Substring:C12(String:C10($chiffre); 1; 1))
		$aj:=""
		Case of 
			: ($num<4)
				$aj:=$u*$num
			: ($num=4)
				$aj:=$u+$c
			: ($num=5)
				$aj:=$c
			: ($num<9)
				$aj:=$c+($u*($num-5))
			: ($num=9)
				$aj:=$u+$d
		End case 
	End if 
	$resultat:=$resultat+$aj
	$chiffre:=Num:C11(Substring:C12(String:C10($chiffre); 2))
	$fin:=($chiffre<=0)
Until ($fin=True:C214)

$0:=$resultat