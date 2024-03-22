//%attributes = {"invisible":true}
//Method: PON_ELEMINP_SetNavControls
//Description
// set the navigation controls on the element input form.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/09/15, 17:16:38
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
End if 
//

If (Is new record:C668([PON_ELEM_INSP:179]))
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
		: (Records in selection:C76([PON_ELEM_INSP:179])=1)
			OBJECT SET ENABLED:C1123(*; "bFirst"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bLast"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		: (Selected record number:C246([PON_ELEM_INSP:179])=1)
			OBJECT SET ENABLED:C1123(*; "bFirst"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		: (Selected record number:C246([PON_ELEM_INSP:179])=Records in selection:C76([PON_ELEM_INSP:179]))
			OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bLast"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End case 
	
End if 

//End PON_ELEMINP_SetNavControls