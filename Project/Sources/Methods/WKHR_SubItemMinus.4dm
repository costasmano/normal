//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/03/05, 13:48:01
	// ----------------------------------------------------
	// Method: WKHR_SubItemMinus
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-06/19/08, 08:37:55
	Mods_2008_CM_5403  //("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(3/13/09 16:06:09)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 11:55:44  ` ("WKHRMODS")
End if 
C_POINTER:C301($1; $MySelf; $VarPtr; $VarPtr2; $ptr_sum; $ptr_value)
$MySelf:=$1
C_TEXT:C284($VarName; $MyRow; $SubPrefix; $SumPrefix)  // Command Replaced was o_C_STRING length was 32
C_LONGINT:C283($Tbl; $Fld; $MyRow_Num; $j; $i; $txtL; $txtT; $txtR; $txtB; $textHt; $NewTextTop; $Wl; $Wt; $Wr; $Wb)  //Command Replaced was o_C_INTEGER
RESOLVE POINTER:C394($MySelf; $VarName; $Tbl; $Fld)
C_POINTER:C301($SubItmCount_ptr)
If (FORM Get current page:C276=1)
	$SubPrefix:=""
	$SumPrefix:="WKHR_Real_"
	$SubItmCount_ptr:=->WKHR_SubItemCount
Else 
	$SubPrefix:="OffEst"
	$SumPrefix:="OfficeEstItm_"
	$SubItmCount_ptr:=->WKHR_OffEstSubItemCount
End if 
$MyRow:=Replace string:C233($VarName; ($SubPrefix+"ButtonMinus"); "")
$MyRow_Num:=Num:C11($MyRow)
//Remove row $Myrow
//Move up variables from rows below the current one
For ($j; $MyRow_Num; ($SubItmCount_ptr->-1))
	$VarPtr:=Get pointer:C304($SubPrefix+"SubItDsc_"+String:C10($j))
	$VarPtr2:=Get pointer:C304($SubPrefix+"SubItDsc_"+String:C10($j+1))
	$VarPtr->:=$VarPtr2->
	For ($i; 1; (WKHR_CategoryCount_i+1))
		$VarPtr:=Get pointer:C304($SubPrefix+"SubItmV"+String:C10($j)+"_"+String:C10($i))
		$VarPtr2:=Get pointer:C304($SubPrefix+"SubItmV"+String:C10($j+1)+"_"+String:C10($i))
		$VarPtr->:=$VarPtr2->
	End for 
End for 

//Set last row vars to 0 and blank descr
For ($i; 1; (WKHR_CategoryCount_i+1))
	$VarPtr:=Get pointer:C304($SubPrefix+"SubItmV"+String:C10($SubItmCount_ptr->)+"_"+String:C10($i))
	$VarPtr->:=0
End for 
$VarPtr:=Get pointer:C304($SubPrefix+"SubItDsc_"+String:C10($SubItmCount_ptr->))
$VarPtr->:=""
//recalc
For ($i; 1; (WKHR_CategoryCount_i+1))
	$ptr_sum:=Get pointer:C304($SumPrefix+String:C10($i))
	$ptr_sum->:=0
	For ($j; 1; WKHR_MaxNumSubBreakDwn)
		$ptr_value:=Get pointer:C304($SubPrefix+"SubItmV"+String:C10($j)+"_"+String:C10($i))
		$ptr_sum->:=($ptr_sum->)+($ptr_value->)
	End for 
	
End for 
//Hide last rows
OBJECT SET VISIBLE:C603(*; $SubPrefix+"SubItmV"+String:C10($SubItmCount_ptr->)+"@"; False:C215)
OBJECT SET VISIBLE:C603(*; $SubPrefix+"SubItDsc_"+String:C10($SubItmCount_ptr->)+"@"; False:C215)
OBJECT SET VISIBLE:C603(*; $SubPrefix+"ButtonMinus"+String:C10($SubItmCount_ptr->)+"@"; False:C215)
OBJECT SET VISIBLE:C603(*; $SubPrefix+"ButtonPlus"+String:C10($SubItmCount_ptr->)+"@"; False:C215)

OBJECT SET ENABLED:C1123(*; $SubPrefix+"ButtonPlus@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 

$SubItmCount_ptr->:=$SubItmCount_ptr->-1

OBJECT GET COORDINATES:C663(*; "ItemComments@"; $txtL; $txtT; $txtR; $txtB)
$textHt:=$txtB-$txtT
$textHt:=MaxNum($textHt; 0)
If (Not:C34(WKHR_CommentsShown))
	$textHt:=0
End if 

$NewTextTop:=WKHR_SetCmmtTxtTop
//Change window size by -22
GET WINDOW RECT:C443($Wl; $Wt; $Wr; $Wb)
SET WINDOW RECT:C444($Wl; $Wt; $Wr; ($Wt+$NewTextTop+$textHt+WKHR_LineEntryFormMargin))
//Now move the text block
OBJECT MOVE:C664(*; "ItemComments@"; $txtL; $NewTextTop; $txtR; ($NewTextTop+$textHt); *)
If ($SubItmCount_ptr->=0)
	OBJECT SET ENABLED:C1123(*; $SubPrefix+"AddSubItm"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENTERABLE:C238(*; $SumPrefix+"@"; True:C214)
	OBJECT SET RGB COLORS:C628(*; $SumPrefix+"@"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_WR)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_WR)\256))  // **Replaced o OBJECT SET COLOR(*; $SumPrefix+"@"; WKHR_ItemColor_WR)
	OBJECT SET ENTERABLE:C238(*; $SumPrefix+"6@"; False:C215)
	OBJECT SET RGB COLORS:C628(*; $SumPrefix+"6@"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; $SumPrefix+"6@"; WKHR_ItemColor_RO)
	GOTO OBJECT:C206(*; $SumPrefix+"1")
End if 