//%attributes = {"invisible":true}
// GetTownAddress
// Description
// Get Town address data and load into process variables
// Parameters
// $1 : $sTownName : Name of town coming from the [Bridge MHD NBIS]Town Name field
If (False:C215)
	// User name (OS): charlesmiller
	// Date and time: 03/06/09, 14:22:31
	// ----------------------------------------------------
	
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(4/20/2006 09:39:04)
	Mods_2006_CM04
	Mods_2009_03  //CJM  r001   `03/06/09, 14:22:38`Upgrade from open form window to open window
	// Modified by: Costas Manousakis-(Designer)-(4/17/20 17:57:00)
	Mods_2020_04
	//  `Use a Query by formula to search for the town address to strip City of and Town of
	// Modified by: Costas Manousakis-(Designer)-(5/13/20 14:43:29)
	Mods_2020_05
	//  `modified to take advantage of the new field [Town Address]TownBDEPTPrefix
	//  `will try that first and then use the old method.
End if 

C_TEXT:C284($1; $sTownName; vTownName_s; $BDEPTPrefix_s)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(vPrefix)  // Command Replaced was o_C_STRING length was 50
C_LONGINT:C283($i)
C_BOOLEAN:C305($bEnterAddress)

// this is from the TownName of [Bridge MHD NBIS] table which comes from [Town Data]
//therefore it can be used to find the BDEPTprefix
$sTownName:=$1
$bEnterAddress:=False:C215

$BDEPTPrefix_s:=""
Begin SQL
	select [Town Data].[BDEPT Prefix]
	from [Town Data]
	where [Town Data].[Town Name] = :$sTownName
	into :$BDEPTPrefix_s ;
End SQL
vPrefix:="Mr."
vLastName:="Town_Contact_Last_Name"
vContactName:="Town_Contact_Name"
vAddressedTo:="Addressed_To"
vAddress1:="Town_Address_Line1"
vAddress2:="Town_Address_Line2"
vOfficialTownName:="Town_Name"

READ ONLY:C145([Town Address:78])
//QUERY([Town Address];[Town Address]OfficialTownName=("@"+$sTownName+"@"))
If ($BDEPTPrefix_s#"")
	QUERY:C277([Town Address:78]; [Town Address:78]TownBDEPTPrefix:17=$BDEPTPrefix_s)
End if 
If (Records in selection:C76([Town Address:78])=0)
	//nothing with the prefix - try the old way
	QUERY BY FORMULA:C48([Town Address:78]; Replace string:C233(\
		Replace string:C233([Town Address:78]OfficialTownName:4; "City of "; ""); \
		"Town of "; "")=$sTownName)
End if 

If (Records in selection:C76([Town Address:78])<1)
	CONFIRM:C162("There is no address for the town "+$sTownName+". Would you like to enter the address now?"; "Yes"; "No")
	If (Ok=1)
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Town Address:78]; "Town Address In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
		//$window:=Open form window([Town Address];"Town Address In")
		FORM SET INPUT:C55([Town Address:78]; "Town Address In")
		ADD RECORD:C56([Town Address:78])
		SAVE RECORD:C53([Town Address:78])
		CLOSE WINDOW:C154($Win_l)
		LOAD RECORD:C52([Town Address:78])
		
	End if 
	
Else 
	//found exact match        
	If (Records in selection:C76([Town Address:78])=1)
		LOAD RECORD:C52([Town Address:78])
	Else 
		vTownName_s:=$sTownName
		ARRAY TEXT:C222($asAddrTo; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY TEXT:C222($asContF; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY TEXT:C222($asContL; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY TEXT:C222($asOfficName; 0)  //Command Replaced was o_ARRAY string length was 50
		
		SELECTION TO ARRAY:C260([Town Address:78]AddressedTo:3; $asAddrTo; [Town Address:78]ContactFName:8; $asContF; [Town Address:78]ContactLName:9; $asContL)
		SELECTION TO ARRAY:C260([Town Address:78]OfficialTownName:4; $asOfficName)
		ARRAY TEXT:C222(asComboItem; Records in selection:C76([Town Address:78]))  //Command Replaced was o_ARRAY string length was 250
		For ($i; 1; Records in selection:C76([Town Address:78]))
			asComboItem{$i}:=$asOfficName{$i}+" - "+$asAddrTo{$i}+" "+$asContF{$i}+" "+$asContL{$i}
		End for 
		C_LONGINT:C283($winW_L; $winH_L)
		FORM GET PROPERTIES:C674([Dialogs:21]; "SelectTownAddress"; $winW_L; $winH_L)
		CENTER_WINDOW($winW_L; $winH_L)
		asComboItem:=0  //Start with blank
		DIALOG:C40([Dialogs:21]; "SelectTownAddress")
		CLOSE WINDOW:C154
		If (OK=1)
			GOTO SELECTED RECORD:C245([Town Address:78]; asComboItem)
			LOAD RECORD:C52([Town Address:78])
		Else 
			If (btnEnterNew=1)
				
				C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
				C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
				C_TEXT:C284($Title_txt)
				FORM GET PROPERTIES:C674([Town Address:78]; "Town Address In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
				$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
				//$window:=Open form window([Town Address];"Town Address In")
				FORM SET INPUT:C55([Town Address:78]; "Town Address In")
				ADD RECORD:C56([Town Address:78])
				SAVE RECORD:C53([Town Address:78])
				CLOSE WINDOW:C154($Win_l)
				LOAD RECORD:C52([Town Address:78])
				
			Else 
				UNLOAD RECORD:C212([Town Address:78])
			End if 
			
		End if 
	End if 
End if 
If (Is record loaded:C669([Town Address:78]))
	If ([Town Address:78]ContactPrefix:12="")
		vPrefix:="Mr."
	Else 
		vPrefix:=[Town Address:78]ContactPrefix:12
		If (Substring:C12(vPrefix; Length:C16(vPrefix); 1)#".")
			vPrefix:=vPrefix+"."
		End if 
	End if 
	
	vLastName:=[Town Address:78]ContactLName:9
	vAddressedTo:=[Town Address:78]AddressedTo:3
	
	If ([Town Address:78]ContactMName:10="")
		vContactName:=[Town Address:78]ContactFName:8+" "+[Town Address:78]ContactLName:9
	Else 
		vContactName:=[Town Address:78]ContactFName:8+" "+[Town Address:78]ContactMName:10+" "+[Town Address:78]ContactLName:9
	End if 
	
	If ([Town Address:78]ContactTitle:11#"")
		vContactName:=vContactName+", "+[Town Address:78]ContactTitle:11
	End if 
	
	vAddress1:=[Town Address:78]Street:5
	vAddress2:=[Town Address:78]TownName:2+", "+[Town Address:78]State:6+" "+[Town Address:78]Zip:7
	vOfficialTownName:=[Town Address:78]OfficialTownName:4
	UNLOAD RECORD:C212([Town Address:78])
	
End if 
//End GetTownAddress
