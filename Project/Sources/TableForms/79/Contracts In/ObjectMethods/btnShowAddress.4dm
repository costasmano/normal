// ----------------------------------------------------
// Object Method: btnShowAddress
// User name (OS): charlesmiller
// Date and time: 03/06/09, 12:26:26
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CM12
	Mods_2009_03  //CJM  r001   `03/06/09, 12:26:28`Upgrade from open form window to open window
End if 


C_LONGINT:C283($window)
C_BOOLEAN:C305($bEnterAddress)
$bEnterAddress:=False:C215
READ WRITE:C146([Conslt Address:77])

QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2="@"+[Contracts:79]ConsltName:3+"@")

If (Records in selection:C76([Conslt Address:77])<1)
	CONFIRM:C162("There is no address for the consultant "+[Contracts:79]ConsltName:3+". Would you like to enter the address now?"; "Yes"; "No")
	If (Ok=1)
		$bEnterAddress:=True:C214
	End if 
	
Else 
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Conslt Address:77]; "Conslt Address In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
	
	//$Win_l:=Open form window([Conslt Address];"Conslt Address In")
	
	MODIFY RECORD:C57([Conslt Address:77])
	CLOSE WINDOW:C154
End if 

If ($bEnterAddress=True:C214)
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Conslt Address:77]; "Conslt Address In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
	
	//$Win_l:=Open form window([Conslt Address];"Conslt Address In")
	
	vCompanyName:=[Contracts:79]ConsltName:3
	FORM SET INPUT:C55([Conslt Address:77]; "Conslt Address In")
	ADD RECORD:C56([Conslt Address:77])
	CLOSE WINDOW:C154
End if 
If (Is record loaded:C669([Conslt Address:77]))
	UNLOAD RECORD:C212([Conslt Address:77])
End if 
READ ONLY:C145([Conslt Address:77])
//End Object Method: btnShowAddress

