If (False:C215)
	// LP.: [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By:  Generic ACI Shell Programming
	//Date:  8/11/95
	//Purpose: Enables and disables buttons as needed
	
	Mods_2005_CM15
End if 

Case of 
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
		If ((asFields#0) & (ck4DFormat#1) & (ckLayout#1))
			OBJECT SET ENABLED:C1123(bAppend; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(bInsert; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bAppend; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(bInsert; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
		If ((asFields#0) & (asExpImpFld#0) & (ck4DFormat#1) & (ckLayout#1))
			OBJECT SET ENABLED:C1123(bInsert; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bInsert; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
		If ((asExpImpFld#0) & (ck4DFormat#1) & (ckLayout#1))
			OBJECT SET ENABLED:C1123(bRemove; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bRemove; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
		If ((Size of array:C274(asExpImpFld)#0) | (ck4DFormat=1) | (ckLayout=1))
			OBJECT SET ENABLED:C1123(bExport; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(bCopyAll; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bCopyAll; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(bExport; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		If (Size of array:C274(asFields)>0)
			asFields:=1
		Else 
			asFields:=0
		End if 
		If ((Size of array:C274(asExpImpFld)#0) | (ck4DFormat=1) | (ckLayout=1))
			OBJECT SET ENABLED:C1123(bExport; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(bCopyAll; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(bCopyAll; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(bExport; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
		OBJECT SET TITLE:C194(bExport; Substring:C12(sDlogText1; 1; 6))  // Set the OK button to "Import" or "Export".
		
End case 