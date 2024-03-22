//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/09/06, 22:52:23
	// ----------------------------------------------------
	// Method: CM_FYFundRecalc
	// Description
	// recalculate Fund allocation
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMz1
	// Modified by: costasmanousakis-(Designer)-(1/27/09 11:38:52)
	Mods_2009_CM_5404
	// check size of array arr_CM_FYAlloc_I to be greater than 0 instead of 1
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
If (Size of array:C274(arr_CM_FYAlloc_I)>0)
	C_LONGINT:C283($i)
	C_REAL:C285(AvailFunds_R; $TotalFutureFunds)
	$TotalFutureFunds:=0
	For ($i; 1; Size of array:C274(arr_CM_FYAlloc_I))
		$TotalFutureFunds:=$TotalFutureFunds+arr_CM_FYFundAlloc_r{$i}
	End for 
	CurrentFYFunds_R:=AvailFunds_R-$TotalFutureFunds
	POST OUTSIDE CALL:C329(-1)
	REDRAW WINDOW:C456
End if 
