If (False:C215)
	
	// Modified by: costasmanousakis-(Designer)-(1/17/2006 13:56:17)
	Mods_2006_CM03
	
End if 

C_TEXT:C284(vContactName; vStreet; vCityStateZip)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vEmail; vTelephone; vFax)  // Command Replaced was o_C_STRING length was 50
C_BOOLEAN:C305(bFoundExactMatch)
bFoundExactMatch:=False:C215
vContactName:=""
vStreet:=""
vCityStateZip:=""
vEmail:=""
vTelephone:=""
vFax:=""
QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2="@"+[Contracts:79]ConsltName:3+"@")

If (Records in selection:C76([Conslt Address:77])=1)
	bFoundExactMatch:=True:C214
Else 
	If (Records in selection:C76([Conslt Address:77])>1)
		bFoundExactMatch:=True:C214
		C_TEXT:C284($type)  // Command Replaced was o_C_STRING length was 20
		$type:=Substring:C12([Contracts:79]ContractType:2; Position:C15(" "; [Contracts:79]ContractType:2)+1; Length:C16([Contracts:79]ContractType:2))
		If ($type="Rating")
			QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Rating:19=True:C214)
		Else 
			QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Insp:20=True:C214)
		End if 
		//found exact match        
		//    If (Records in selection([Conslt Address])=1)
		//     bFoundExactMatch:=True
		//  End if 
	End if 
End if 

If (bFoundExactMatch=True:C214)
	//retrieve consultant address information  
	vContactName:=[Conslt Address:77]ContactPrefix:6+" "+[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactMName:5+" "+[Conslt Address:77]ContactLName:4
	If ([Conslt Address:77]ContactTitle:7#"")
		vContactName:=vContactName+", "+[Conslt Address:77]ContactTitle:7
	End if 
	
	vStreet:=[Conslt Address:77]Street1:8
	If ([Conslt Address:77]Street2:9#"")
		vStreet:=vStreet+", "+[Conslt Address:77]Street2:9
	End if 
	vCityStateZip:=[Conslt Address:77]City:10+", "+[Conslt Address:77]State:11+" "+[Conslt Address:77]Zip:12
	
	vEmail:=[Conslt Address:77]Email:18
	vTelephone:=[Conslt Address:77]PhoneNo1:13
	vFax:=[Conslt Address:77]FaxNo1:16
End if 


G_CalculateTLFandDE