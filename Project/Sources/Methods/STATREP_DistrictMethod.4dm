//%attributes = {"invisible":true}
//Method: STATREP_DistrictMethod
//Description
// `Return the description of the method used to separate the bridges to districts
// Parameters
// $0 : DistrictMethod_txt
// $1 : DistrictMethoddCode_L

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/09/19, 15:33:51
	// ----------------------------------------------------
	//Created : 
	Mods_2019_09
End if 
//
C_TEXT:C284($0; DistrictMethod_txt)
C_LONGINT:C283($1; DistrictMethoddCode_L)
DistrictMethod_txt:=""

DistrictMethoddCode_L:=$1

Case of 
	: (DistrictMethoddCode_L=2)
		DistrictMethod_txt:="6 Distr."
		
	: (DistrictMethoddCode_L=3)
		DistrictMethod_txt:="Original 5 Distr."
		
	: (DistrictMethoddCode_L=4)
		DistrictMethod_txt:="6 Distr. (Somerville in D6)"
End case 

$0:=DistrictMethod_txt
//End STATREP_DistrictMethod