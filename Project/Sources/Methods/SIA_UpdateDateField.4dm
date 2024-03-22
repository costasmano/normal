//%attributes = {"invisible":true}
//Method: SIA_UpdateDateField
//Description
// update a date field in a [bridge table from data from an FHWA tape file
// Parameters
// $1 : $FldPtr
// $2 : $NewData - in "MMYY" format
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 15, 2023, 18:09:32
	Mods_2023_03
	// ----------------------------------------------------
	
	C_POINTER:C301(SIA_UpdateDateField; $1)
	C_TEXT:C284(SIA_UpdateDateField; $2)
	
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($2; $sdate)
C_DATE:C307($newdate)
$sdate:=$2


If (Num:C11(Substring:C12($sdate; 3; 2))<50)
	$sdate:=Insert string:C231($sdate; "/01/20"; 3)  //Y2000 problem
Else 
	$sdate:=Insert string:C231($sdate; "/01/19"; 3)
End if 
$newdate:=Date:C102($sdate)

If ($newdate#!00-00-00!)
	If (Year of:C25($1->)#Year of:C25($newdate)) | (Month of:C24($1->)#Month of:C24($newdate))
		$1->:=$newdate
	End if 
End if 

//End SIA_UpdateDateField   