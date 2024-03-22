If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/05, 15:52:35
	// ----------------------------------------------------
	// Method: Form Method: Print2
	// Description
	// 
	WKHR_Print
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/1/2005 15:52:39)
	Mods_2005_CM19
	Mods_2011_06  // CJ Miller`06/20/11, 11:39:21      ` Type all local variables for v11
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_LONGINT:C283($l; $t; $r; $b; $FixW; $FixH; $wdth; $hght)
		OBJECT GET COORDINATES:C663([Work_Estimate:103]CompleteCmts:31; $l; $t; $r; $b)
		$FixW:=$r-$l  //Calculation of the Cmts text field size
		$FixH:=$b-$t
		OBJECT GET BEST SIZE:C717([Work_Estimate:103]CompleteCmts:31; $wdth; $hght; $FixW)
		//Optimal size of the field according to its contents
		If ($hght>$FixH)
			C_LONGINT:C283($movement)
			$movement:=$hght-$FixH
			//Change size first
			OBJECT MOVE:C664([Work_Estimate:103]CompleteCmts:31; 0; 0; 0; $movement)
			//Move Review and approve chkbox and comments
			OBJECT MOVE:C664(*; "ReviewCmt@"; 0; $movement; 0; 0)
			OBJECT MOVE:C664(*; "ApproveCmt@"; 0; $movement; 0; 0)
		End if 
		
		//Now check review cmts
		OBJECT GET COORDINATES:C663([Work_Estimate:103]ReviewCmts:35; $l; $t; $r; $b)
		$FixW:=$r-$l  //Calculation of the Cmts text field size
		$FixH:=$b-$t
		OBJECT GET BEST SIZE:C717([Work_Estimate:103]ReviewCmts:35; $wdth; $hght; $FixW)
		If ($hght>$FixH)
			$movement:=$hght-$FixH
			//Change size first
			OBJECT MOVE:C664([Work_Estimate:103]ReviewCmts:35; 0; 0; 0; $movement)
			//Move approve chkbox and comments
			OBJECT MOVE:C664(*; "ApproveCmt@"; 0; $movement; 0; 0)
		End if 
		
		//Now check approve cmts
		OBJECT GET COORDINATES:C663([Work_Estimate:103]ApproveCmts:30; $l; $t; $r; $b)
		$FixW:=$r-$l  //Calculation of the Cmts text field size
		$FixH:=$b-$t
		OBJECT GET BEST SIZE:C717([Work_Estimate:103]ApproveCmts:30; $wdth; $hght; $FixW)
		If ($hght>$FixH)
			$movement:=$hght-$FixH
			//Change size first
			OBJECT MOVE:C664([Work_Estimate:103]ApproveCmts:30; 0; 0; 0; $movement)
		End if 
		WKHR_RevStatus_p:=[Work_Estimate:103]WkHrEstReviewed:33+1
		WKHR_ApprStatus_p:=[Work_Estimate:103]WkHrEstApproved:18+1
End case 