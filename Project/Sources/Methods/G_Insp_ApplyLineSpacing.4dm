//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_ApplyLineSpacing
	
	Mods_2004_CM12
	// Modified by: Costas Manousakis-(Designer)-(11/1/19 14:35:33)
	Mods_2019_11_bug
	//  `adjustments for CallReference #668
	// Modified by: Costas Manousakis-(Designer)-(4/27/20 13:12:32)
	Mods_2020_04
	//  `don't do any adjustments if there is nothing in the document ($vlEndSel=0)
	//  `addresses CallReference #710
End if 

C_LONGINT:C283($1; $MyArea)
$MyArea:=$1
C_LONGINT:C283($vlStartSel; $vlEndSel; $uniform_L)

//‘12000;2‘ ($MyArea;$vlStartSel;$vlEndSel)
//If ($vlEndSel=0)
//Else 
//‘12000;113‘ ($MyArea;‘k12007;7‘)
//C_REAL($LineSpacing_r;$CurrLineSpacing_r)
//$CurrLineSpacing_r:=‘12000;102‘ ($MyArea;‘k12000;17‘;$uniform_L)

//$LineSpacing_r:=1
//If ([Inspections]Insp Type="DV@")  //use 1:1.1=Mac:PC for arial 11
//If (<>PL_LPlatfrm#3)  //if mac platform  
//$LineSpacing_r:=1

//Else 
//$LineSpacing_r:=1.1

//End if 
//Else   //use 1.1:1=Mac:PC for arial 11  
//If (<>PL_LPlatfrm#3)  //if mac platform  
//$LineSpacing_r:=1.1

//Else 
//$LineSpacing_r:=1

//End if 
//End if 

//Case of 
//: ($uniform_L=0)
//  //apply spacing if spacing is not uniform
//‘12000;103‘ ($MyArea;‘k12000;17‘;$LineSpacing_r)
//: ($CurrLineSpacing_r#$LineSpacing_r)
//  //apply spacing if spacing if it is not the required one
//‘12000;103‘ ($MyArea;‘k12000;17‘;$LineSpacing_r)

//End case 

//‘12000;3‘ ($MyArea;$vlStartSel;$vlEndSel)
//End if 