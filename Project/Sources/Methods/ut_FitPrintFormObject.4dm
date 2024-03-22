//%attributes = {"invisible":true}
// Method: ut_FitPrintFormObject
// Description
// 
// 
// Parameters
// $0 : $ReachedMin_b
// $1 : $objPtr_ptr
// $2 : $CurrFontSize_L
// $3 : $MinFontSize_L
// $4 : $TopMarg_L
// $5 : $BotMarg_L
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/17/09, 13:02:52
	// ----------------------------------------------------
	
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: costasmanousakis-(Designer)-(12/15/09 22:31:23)
	Mods_2009_12
	//Added a 3 pt margin to fit to allow lowercase g's p's q's
	// Modified by: costasmanousakis-(Designer)-(6/15/11 17:48:46)
	Mods_2011_06
	//Graduate the margin depeneding of font size
	// Modified by: Costas Manousakis-(Designer)-(5/14/14 13:56:20)
	Mods_2014_05
	//  `added an increment between font size 1 and 9. changed the small size  box margin to 1
End if 
C_BOOLEAN:C305($0; $ReachedMin_b)
$ReachedMin_b:=False:C215
C_POINTER:C301($1; $objPtr_ptr)
$objPtr_ptr:=$1
C_LONGINT:C283($2; $CurrFontSize_L; $3; $MinFontSize_L)
$CurrFontSize_L:=$2
$MinFontSize_L:=$3
C_LONGINT:C283($TopMarg_L; $BotMarg_L)
If (Count parameters:C259>3)
	$TopMarg_L:=$4
	$BotMarg_L:=$5
Else 
	$TopMarg_L:=0
	$BotMarg_L:=0
End if 

C_LONGINT:C283($T; $B; $L; $R; $BestW_L; $BestHt_L; $MaxWidth_L; $ObjHt_L; $CurrFontSize_L; $MinFontSize_L)
C_LONGINT:C283($newtopM_L; $vertMove_L; $NewSize_L; $BoxMargin_L)
OBJECT GET COORDINATES:C663($objPtr_ptr->; $L; $T; $R; $B)
$ObjHt_L:=$B-$T
$MaxWidth_L:=$R-$L
OBJECT GET BEST SIZE:C717($objPtr_ptr->; $BestW_L; $BestHt_L; $MaxWidth_L)
C_BOOLEAN:C305($doneresizing_b; $ReachedMin_b)
$ReachedMin_b:=False:C215
$doneresizing_b:=False:C215
$BoxMargin_L:=3
Repeat 
	Case of 
		: ($CurrFontSize_L>14)
		: ($CurrFontSize_L>9)
			$BoxMargin_L:=3
		: ($CurrFontSize_L>7)
			$BoxMargin_L:=2
		: ($CurrFontSize_L>1)
			$BoxMargin_L:=1
	End case 
	
	Case of 
		: ($BestHt_L<=($ObjHt_L-$BoxMargin_L))  //Added a 3 pt margin to fit lowercase g's p's q's
			$doneresizing_b:=True:C214
		: ($BestHt_L<=($ObjHt_L+$TopMarg_L+$BotMarg_L-$BoxMargin_L))  //Added a 3 pt margin to fit 
			
			If ($TopMarg_L>0)
				$newtopM_L:=(($ObjHt_L+$TopMarg_L+$BotMarg_L)-$BestHt_L)\2
			Else 
				$newtopM_L:=0
			End if 
			$vertMove_L:=$newtopM_L-$TopMarg_L
			OBJECT MOVE:C664($objPtr_ptr->; 0; -$vertMove_L; 0; $BestHt_L)
			$doneresizing_b:=True:C214
		: ($CurrFontSize_L>$MinFontSize_L)
			$CurrFontSize_L:=$CurrFontSize_L-1
			OBJECT SET FONT SIZE:C165($objPtr_ptr->; $CurrFontSize_L)
			OBJECT GET BEST SIZE:C717($objPtr_ptr->; $BestW_L; $BestHt_L; $MaxWidth_L)
		Else 
			//done shrinking - still not fiting
			$doneresizing_b:=True:C214
			$ReachedMin_b:=True:C214
	End case 
	
Until ($doneresizing_b)

$0:=$ReachedMin_b