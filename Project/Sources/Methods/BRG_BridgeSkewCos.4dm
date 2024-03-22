//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:54:45
	// ----------------------------------------------------
	// Method: BRG_BridgeSkewCos
	// Description
	// Calculate the Bridge Skew Cosine
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $skew)
If ([Bridge MHD NBIS:1]Item34:100<=90)
	$skew:=Cos:C18(Degree:K30:2*[Bridge MHD NBIS:1]Item34:100)
Else 
	// if item34 is bigger than 90 ie 99 assume skew is 0
	$skew:=Cos:C18(Degree:K30:2*0)
End if 
$0:=$skew