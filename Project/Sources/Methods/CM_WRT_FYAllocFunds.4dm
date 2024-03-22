//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/11/06, 15:59:14
	// ----------------------------------------------------
	// Method: CM_WRT_FYAllocFunds
	// Description
	// Function to Assemble the FY Fund Allocations for an extension letter
	// Called directly from the 4D Write 'template'
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMz1
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_TEXT:C284($0; $AllocFunds_txt)
$AllocFunds_txt:=""
If (Type:C295(arr_CM_FYAlloc_I)=Integer array:K8:18)  //to avoid errors when editing template
	C_LONGINT:C283($i)
	If (Size of array:C274(arr_CM_FYAlloc_I)>0)
		$AllocFunds_txt:="Remain in fiscal year "+CurrentFY_s+<>sTAB+String:C10(CurrentFYFunds_R; "$###,###,###.00")+<>sCR
		For ($i; 1; Size of array:C274(arr_CM_FYAlloc_I))
			$AllocFunds_txt:=$AllocFunds_txt+"To be moved to fiscal year "+String:C10(arr_CM_FYAlloc_I{$i})+<>sTAB+String:C10(arr_CM_FYFundAlloc_r{$i}; "$###,###,###.00")+<>sCR
		End for 
		
	End if 
	
End if 

$0:=$AllocFunds_txt