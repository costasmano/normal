//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:55:11
	// ----------------------------------------------------
	// Method: BRG_ReplLength
	// Description
	// Calculate Replacement Len for a Bridge based on FHWA guidelines
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_REAL:C285($0; $Item76)
C_REAL:C285($1; $RyWdth; $2; $skew)
$RyWdth:=$1
$skew:=$2
C_REAL:C285($lengthfctr; $skew; $RyWdth)
//Calculate Item 76 for non-culvert bridges based on structure length (Item 49)
If ([Bridge MHD NBIS:1]Item62:134="N")
	If (Round:C94([Bridge MHD NBIS:1]Item49:93; 1)<=30.9)
		$lengthfctr:=2.894-(0.1919*[Bridge MHD NBIS:1]Item49:93)+(0.00815*([Bridge MHD NBIS:1]Item49:93^2))-(0.0001176*([Bridge MHD NBIS:1]Item49:93^3))
	Else 
		If ([Bridge MHD NBIS:1]Item49:93<=300)
			$lengthfctr:=1.436-(0.00623*[Bridge MHD NBIS:1]Item49:93)+(0.0000351*([Bridge MHD NBIS:1]Item49:93^2))-(0.000000071*([Bridge MHD NBIS:1]Item49:93^3))
		Else 
			$lengthfctr:=1
		End if 
	End if 
	$Item76:=Round:C94((([Bridge MHD NBIS:1]Item49:93*$lengthfctr)+0.5); 0)
Else 
	C_REAL:C285($length)
	
	//Calculate Item76 for culverts along the centerline of barrel based on the
	//roadway width and the skew of the culvert (include  3 m for barriers/sidewalk)
	$length:=($RyWdth/$skew)+3
	$Item76:=Round:C94(($length+0.5); 0)
End if 
$0:=$Item76