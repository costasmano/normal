//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/03/05, 13:48:41
	// ----------------------------------------------------
	// Method: WKHR_SubItemPlus
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-06/19/08, 08:37:55
	Mods_2008_CM_5403  // ("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(3/13/09 16:07:57)
	Mods_2009_CM_5404  //("WKHRMODS")
	//Mods for V1 version of Work Hours
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_POINTER:C301($1; $MySelf)
$MySelf:=$1
C_TEXT:C284($VarName; $MyRow; $SubPrefix; $SumPrefix)  // Command Replaced was o_C_STRING length was 32
C_LONGINT:C283($Tbl; $Fld; $txtL; $txtT; $txtR; $txtB; $Wl; $Wt; $Wr; $Wb; $NewTxtTop; $TxtHt)  //Command Replaced was o_C_INTEGER
RESOLVE POINTER:C394($MySelf; $VarName; $Tbl; $Fld)
C_POINTER:C301($SubItmCount_ptr)
If (FORM Get current page:C276=1)
	$SubPrefix:=""
	$SumPrefix:="WKHR_Real_@"
	$SubItmCount_ptr:=->WKHR_SubItemCount
Else 
	$SubPrefix:="OffEst"
	$SumPrefix:="OfficeEstItm_@"
	$SubItmCount_ptr:=->WKHR_OffEstSubItemCount
End if 

$MyRow:=Replace string:C233($VarName; ($SubPrefix+"ButtonPlus"); "")
//If number is <maximum
If ($SubItmCount_ptr-><WKHR_MaxNumSubBreakDwn)
	$SubItmCount_ptr->:=$SubItmCount_ptr->+1
	OBJECT SET VISIBLE:C603(*; $SubPrefix+"SubItmV"+String:C10($SubItmCount_ptr->)+"@"; True:C214)
	If ([Work_Estimate:103]Version_L:47>0)
	Else 
		OBJECT SET VISIBLE:C603(*; $SubPrefix+"SubItmV"+String:C10($SubItmCount_ptr->)+"@_7"; False:C215)
	End if 
	
	OBJECT SET VISIBLE:C603(*; $SubPrefix+"SubItDsc_"+String:C10($SubItmCount_ptr->)+"@"; True:C214)
	OBJECT SET VISIBLE:C603(*; $SubPrefix+"ButtonMinus"+String:C10($SubItmCount_ptr->)+"@"; True:C214)
	OBJECT SET VISIBLE:C603(*; $SubPrefix+"ButtonPlus"+String:C10($SubItmCount_ptr->)+"@"; True:C214)
	OBJECT GET COORDINATES:C663(*; "ItemComments@"; $txtL; $txtT; $txtR; $txtB)
	GET WINDOW RECT:C443($Wl; $Wt; $Wr; $Wb)
	C_LONGINT:C283($NewTextTop)
	$NewTextTop:=WKHR_SetCmmtTxtTop
	If (WKHR_CommentsShown)
		$TxtHt:=$txtB-$txtT
	Else 
		$TxtHt:=0
	End if 
	
	SET WINDOW RECT:C444($Wl; $Wt; $Wr; ($Wt+$NewTextTop+$TxtHt+WKHR_LineEntryFormMargin))
	OBJECT MOVE:C664(*; "ItemComment@"; $txtL; $NewTextTop; $txtR; ($NewTextTop+($txtB-$txtT)); *)
	If ($SubItmCount_ptr->=WKHR_MaxNumSubBreakDwn)
		OBJECT SET ENABLED:C1123(*; $SubPrefix+"ButtonPlus@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End if 
	
End if 
OBJECT SET ENTERABLE:C238(*; $SubPrefix+"SubItDsc_"+String:C10($SubItmCount_ptr->)+"@"; True:C214)
OBJECT SET ENTERABLE:C238(*; $SumPrefix; False:C215)
OBJECT SET RGB COLORS:C628(*; $SumPrefix; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; $SumPrefix; WKHR_ItemColor_RO)
GOTO OBJECT:C206(*; $SubPrefix+"SubItDsc_"+String:C10($SubItmCount_ptr->))
//  ` add line at bottom