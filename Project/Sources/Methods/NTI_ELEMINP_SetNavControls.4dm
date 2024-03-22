//%attributes = {"invisible":true}
//Method: NTI_ELEMINP_SetNavControls
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 12:53:25
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
End if 
//

If (Is new record:C668(Current form table:C627->))
	OBJECT SET ENABLED:C1123(*; "bFirst"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET ENABLED:C1123(*; "bLast"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	
Else 
	
	OBJECT SET ENABLED:C1123(*; "bFirst"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(*; "bPrevious"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(*; "bNext"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(*; "bLast"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	Case of 
		: (Records in selection:C76(Current form table:C627->)=1)
			OBJECT SET ENABLED:C1123(*; "bFirst"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bLast"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		: (Selected record number:C246(Current form table:C627->)=1)
			OBJECT SET ENABLED:C1123(*; "bFirst"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		: (Selected record number:C246(Current form table:C627->)=Records in selection:C76(Current form table:C627->))
			OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bLast"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End case 
	
End if 

//End NTI_ELEMINP_SetNavControls