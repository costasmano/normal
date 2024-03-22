//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/15/15, 14:51:24
//----------------------------------------------------
//Method: LSS_SetPrevNextButtons
//Description
//
// Parameters
//$1 Row
//$2 Record in selection
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/15/15 14:51:26)
	
End if 
C_LONGINT:C283($1; $2; $Row_L; $RecordsInSelection_L)
$Row_L:=$1
$RecordsInSelection_L:=$2

Case of 
	: ($RecordsInSelection_L=1)
		OBJECT SET ENABLED:C1123(*; "bFirst"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bLast"; False:C215)
		
	: ($Row_L=1)
		OBJECT SET ENABLED:C1123(*; "bFirst"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bNext"; True:C214)
		OBJECT SET ENABLED:C1123(*; "bLast"; True:C214)
	: ($Row_L=$RecordsInSelection_L)
		OBJECT SET ENABLED:C1123(*; "bFirst"; True:C214)
		OBJECT SET ENABLED:C1123(*; "bPrevious"; True:C214)
		OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bLast"; False:C215)
	Else 
		OBJECT SET ENABLED:C1123(*; "bFirst"; True:C214)
		OBJECT SET ENABLED:C1123(*; "bPrevious"; True:C214)
		OBJECT SET ENABLED:C1123(*; "bNext"; True:C214)
		OBJECT SET ENABLED:C1123(*; "bLast"; True:C214)
End case 


//End LSS_SetPrevNextButtons

