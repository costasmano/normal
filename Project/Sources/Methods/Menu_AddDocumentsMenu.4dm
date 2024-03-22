//%attributes = {"invisible":true}
//Method: Menu_AddDocumentsMenu
//Description
// add the DownloadDocuments menu item to the Tools menu of the current tool bar
// uses system parameter DocumentsMenu
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Dec 14, 2023, 21:20:15
	Mods_2023_12
	// ----------------------------------------------------
	
End if 
//
C_LONGINT:C283($Tools_L)

$Tools_L:=MENU_GetMenuByName("Tools")
If ($Tools_L#0)
	C_COLLECTION:C1488($menudef_c)
	C_TEXT:C284($Menuitem_txt; $syspar_)
	C_OBJECT:C1216($syspar_o)
	C_BOOLEAN:C305($useDefmenu_B)
	$useDefmenu_B:=False:C215
	$syspar_:=ut_GetSysParameter("DocumentsMenu")
	If ($syspar_#"")
		C_TEXT:C284($errmethod)
		$errmethod:=Method called on error:C704
		C_BOOLEAN:C305(4DError_b)
		4DError_b:=False:C215
		ON ERR CALL:C155("4D_Errors")
		$syspar_o:=JSON Parse:C1218($syspar_)
		ON ERR CALL:C155($errmethod)
		If (4DError_b)
			ALERT:C41("System Parameter DocumentsMenu is malformed! Using default settings for Tools\\Download Documents!")
			$useDefmenu_B:=True:C214
			4DError_b:=False:C215
		End if 
		
	Else 
		$useDefmenu_B:=True:C214
	End if 
	
	If (Not:C34($useDefmenu_B))
		$Menuitem_txt:=$syspar_o.name
		$menudef_c:=$syspar_o.items
	Else 
		$menudef_c:=New collection:C1472
		$menudef_c.push(New object:C1471("name"; "BIN request - PDF"; \
			"method"; "DOC_SaveFileToLocal"; \
			"newproc"; 0; \
			"param"; "DOC_BINRequestPDF"))
		$menudef_c.push(New object:C1471("name"; "BIN request - Excel Windows"; \
			"method"; "DOC_SaveFileToLocal"; \
			"newproc"; 0; \
			"param"; "DOC_BINRequestXLW"))
		$menudef_c.push(New object:C1471("name"; "BIN request - Excel Mac"; \
			"method"; "DOC_SaveFileToLocal"; \
			"newproc"; 0; \
			"param"; "DOC_BINRequestXLM"))
		$Menuitem_txt:="Download documents"
		
		If (User in group:C338(Current user:C182; "Design Access Group"))
			ut_SaveSysParam("DocumentsMenu"; JSON Stringify:C1217(New object:C1471("name"; $Menuitem_txt; "items"; $menudef_c)))
		End if 
		
	End if 
	
	C_TEXT:C284($files_submenu)
	$files_submenu:=Create menu:C408
	C_OBJECT:C1216($item_o)
	For each ($item_o; $menudef_c)
		INSERT MENU ITEM:C412($files_submenu; -1; $item_o.name)
		SET MENU ITEM PROPERTY:C973($files_submenu; -1; Start a new process:K56:2; $item_o.newproc)
		SET MENU ITEM METHOD:C982($files_submenu; -1; $item_o.method)
		SET MENU ITEM PARAMETER:C1004($files_submenu; -1; $item_o.param)
	End for each 
	
	APPEND MENU ITEM:C411($Tools_L; $Menuitem_txt; $files_submenu)
	
End if 

//End Menu_AddDocumentsMenu   