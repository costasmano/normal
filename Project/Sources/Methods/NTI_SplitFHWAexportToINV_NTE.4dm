//%attributes = {"invisible":true}
//Method: NTI_SplitFHWAexportToINV_NTE
//Description
// method to split the annual FHWA NTI submittal to inventory and NTE files separate.
// Will parse the XML ; find references for all TunnelInstances ;
// for each Tunnelinstance get all "/FHWAElements/FHWAED" elements
// append each element to a new ElementTree
// Remove the "/FHWAElements" element from the parsed document.
// Save the modified parsed xml and the new ElementTree to files
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 13, 2023, 15:43:54
	Mods_2023_03
	// ----------------------------------------------------
	
End if 

// select export for FHWA containing both inventory and NTE data

C_TEXT:C284($NTI_FHWA_txt)
$NTI_FHWA_txt:=Select document:C905(""; ".xml"; "Select xml file"; 0)
If (OK=1)
	C_OBJECT:C1216($NTI_FHWA_o)
	$NTI_FHWA_o:=File:C1566(Document; fk platform path:K87:2)
	C_TEXT:C284($SourceTree_txt; $child_; $name_; $currInv_; $InvTree_; $ElementTree_)
	$SourceTree_txt:=DOM Parse XML source:C719($NTI_FHWA_o.platformPath)
	
	DOM GET XML ELEMENT NAME:C730($SourceTree_txt; $name_)
	ARRAY TEXT:C222($TunnelInstances_; 0)
	$child_:=DOM Find XML element:C864($SourceTree_txt; $name_+"/TunnelInstance"; $TunnelInstances_)
	If (OK=1)
		
		$ElementTree_:=DOM Create XML Ref:C861("NTElements")  //start the Tree for the Elements
		
		C_LONGINT:C283($Tunnel_L)
		C_TEXT:C284($CurrElementTree_; $newREf_; $currElmt_)
		For ($Tunnel_L; 1; Size of array:C274($TunnelInstances_))
			DOM GET XML ELEMENT NAME:C730($TunnelInstances_{$Tunnel_L}; $name_)
			ARRAY TEXT:C222($NTElements_; 0)
			$CurrElementTree_:=DOM Find XML element:C864($TunnelInstances_{$Tunnel_L}; $name_+"/FHWAElements")
			$currElmt_:=DOM Find XML element:C864($TunnelInstances_{$Tunnel_L}; $name_+"/FHWAElements/FHWAED"; $NTElements_)
			C_LONGINT:C283($elemt_L)
			For ($elemt_L; 1; Size of array:C274($NTElements_))
				DOM SET XML ELEMENT NAME:C867($NTElements_{$elemt_L}; "TunnelElements")  // change name from FHWAED to TunnelElements
				$newREf_:=DOM Append XML element:C1082($ElementTree_; $NTElements_{$elemt_L})
			End for 
			DOM SET XML ELEMENT NAME:C867($TunnelInstances_{$Tunnel_L}; "InventoryItems")  // change name to InventoryItems
			DOM REMOVE XML ELEMENT:C869($CurrElementTree_)
		End for 
		
		C_OBJECT:C1216($inventory_o; $elements_o)
		$inventory_o:=File:C1566($NTI_FHWA_o.parent.platformPath+"InventoryItems.xml"; fk platform path:K87:2)
		$elements_o:=File:C1566($NTI_FHWA_o.parent.platformPath+"TunnelElements.xml"; fk platform path:K87:2)
		C_TEXT:C284($File_; $ShowFile_)
		C_BOOLEAN:C305($exported_b)
		
		$File_:=Select document:C905($NTI_FHWA_o.parent.platformPath+"InventoryItems.xml"; ".xml"; "Select file for Inventory Items XML"; File name entry:K24:17)
		If (OK=1)
			$ShowFile_:=Document
			DOM EXPORT TO FILE:C862($SourceTree_txt; $ShowFile_)
			$exported_b:=True:C214
		End if 
		
		$File_:=Select document:C905($NTI_FHWA_o.parent.platformPath+"TunnelElements.xml"; ".xml"; "Select file for Tunnel Elements Items XML"; File name entry:K24:17)
		
		If (OK=1)
			$ShowFile_:=Document
			DOM EXPORT TO FILE:C862($ElementTree_; $ShowFile_)
			$exported_b:=True:C214
		End if 
		
		If ($exported_b)
			SHOW ON DISK:C922($ShowFile_)  // will show the last one created
		End if 
		DOM CLOSE XML:C722($ElementTree_)
		
	Else 
		ALERT:C41("Selected XML file does not contain TunnelInstance elements!")
	End if 
	
	DOM CLOSE XML:C722($SourceTree_txt)
End if 

//
//End NTI_SplitFHWAexportToINV_NTE   