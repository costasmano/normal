C_BOOLEAN:C305($bEnterAddress)
$bEnterAddress:=False:C215

QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2="@"+[DCM_Contracts:136]ConsultantName:3+"@")

If (Records in selection:C76([Conslt Address:77])<1)
	CONFIRM:C162("There is no address for the contractor "+[DCM_Contracts:136]ConsultantName:3+". Would you like to enter the address now?"; "Yes"; "No")
	If (Ok=1)
		$bEnterAddress:=True:C214
	End if 
	
Else 
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Conslt Address:77]; "Conslt Address In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
	//$window:=Open form window([Conslt Address];"Conslt Address In")
	MODIFY RECORD:C57([Conslt Address:77])
	CLOSE WINDOW:C154($Win_l)
End if 

If ($bEnterAddress=True:C214)
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Conslt Address:77]; "Conslt Address In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
	
	vCompanyName:=[DCM_Contracts:136]ConsultantName:3
	FORM SET INPUT:C55([Conslt Address:77]; "Conslt Address In")
	ADD RECORD:C56([Conslt Address:77])
	CLOSE WINDOW:C154($Win_l)
End if 

//End Object Method: btnShowAddress
