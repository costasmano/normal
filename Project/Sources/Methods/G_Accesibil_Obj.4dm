//%attributes = {"invisible":true}
If (False:C215)
	//G_Accesibil_Obj
	//Object method for Accessibility fields.
End if 
C_POINTER:C301($1)  //Form object field
C_POINTER:C301($2)  //database field
C_LONGINT:C283($3; $vsPart)  //Command Replaced was o_C_INTEGER//part of accesibility 1: Needed 2:Used
C_LONGINT:C283($4)  //Command Replaced was o_C_INTEGER//change stack number
C_POINTER:C301($vpFormObj; $vpDBFld)  //Local copies
$vpFormObj:=$1
$vpDBFld:=$2
$vsPart:=$3
//check if self works
C_LONGINT:C283($vsLenFld)  //Command Replaced was o_C_INTEGER
$vsLenFld:=Length:C16($2->)
C_TEXT:C284($vsAccesibilFld)  // Command Replaced was o_C_STRING length was 2
Case of 
	: ($vsLenFld=2)
		$vsAccesibilFld:=$vpDBFld->
	: ($vsLenFld=1)
		$vsAccesibilFld:=$vpDBFld->+" "
	Else 
		$vsAccesibilFld:="  "
End case 

Case of 
	: (Form event code:C388=On Load:K2:1)
		$vpFormObj->:=Substring:C12($vsAccesibilFld; $vsPart; 1)
		
	: (Form event code:C388=On Data Change:K2:15)
		Case of 
			: ($vsPart=1)  //Needed part
				$vpDBFld->:=$vpFormObj->+Substring:C12($vsAccesibilFld; 2; 1)
			: ($vsPart=2)  //Used part
				$vpDBFld->:=Substring:C12($vsAccesibilFld; 1; 1)+$vpFormObj->
		End case 
		PushChange($4; $vpDBFld)
End case 