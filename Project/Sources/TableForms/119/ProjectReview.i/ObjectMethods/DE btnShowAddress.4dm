
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Current user:C182="Designer")
			OBJECT SET VISIBLE:C603(btnShowAddress; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(btnShowAddress; False:C215)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($bEnterAddress)
		$bEnterAddress:=False:C215
		C_TEXT:C284(vCompanyName; vcontactName)  // Command Replaced was o_C_STRING length was 100
		C_TEXT:C284(vcontact)  // Command Replaced was o_C_STRING length was 150
		C_TEXT:C284(vprefix)  // Command Replaced was o_C_STRING length was 50
		Case of 
				
			: ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53>0)
				QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53)
				If (Records in selection:C76([Conslt Address:77])=0)
					QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53)
					vCompanyName:=[Conslt_Name:127]ConsultantName_s:2
				Else 
					vCompanyName:=[Conslt Address:77]ConsltName:2
				End if 
			: ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54>0)
				QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
				QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
				If (Records in selection:C76([Conslt Address:77])=0)
					QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
					vCompanyName:=[Conslt_Name:127]ConsultantName_s:2
				Else 
					vCompanyName:=[Conslt Address:77]ConsltName:2
				End if 
				
			Else 
				QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
				QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
				If (Records in selection:C76([Conslt Address:77])=0)
					QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
					vCompanyName:=[Conslt_Name:127]ConsultantName_s:2
				Else 
					vCompanyName:=[Conslt Address:77]ConsltName:2
				End if 
				
		End case 
		
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2="@"+vCompanyName+"@")
		
		If (Records in selection:C76([Conslt Address:77])<1)
			CONFIRM:C162("There is no address for the designer "+vCompanyName+". Would you like to enter the address now?"; "Yes"; "No")
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
			
			FORM SET INPUT:C55([Conslt Address:77]; "Conslt Address In")
			ADD RECORD:C56([Conslt Address:77])
			CLOSE WINDOW:C154($Win_l)
		End if 
		
End case 

//End Object Method: btnShowAddress
