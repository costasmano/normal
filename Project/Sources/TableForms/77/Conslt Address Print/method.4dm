C_DATE:C307(vDate)
C_TEXT:C284(vFunction)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(vCityStateZip; vStreet)  // Command Replaced was o_C_STRING length was 100

vDate:=Current date:C33(*)
If (Form event code:C388=On Printing Detail:K2:18)
	vContactName:=[Conslt Address:77]ContactPrefix:6+" "+[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactMName:5+" "+[Conslt Address:77]ContactLName:4
	If ([Conslt Address:77]ContactTitle:7#"")
		vContactName:=vContactName+", "+[Conslt Address:77]ContactTitle:7
	End if 
	
	vFunction:=""
	If ([Conslt Address:77]Func_Rating:19=True:C214)
		vFunction:="Rating"
	End if 
	If ([Conslt Address:77]Func_Insp:20=True:C214)
		vFunction:=vFunction+", Inspection"
	End if 
	
	vStreet:=[Conslt Address:77]Street1:8
	If ([Conslt Address:77]Street2:9#"")
		vStreet:=vStreet+", "+[Conslt Address:77]Street2:9
	End if 
	vCityStateZip:=[Conslt Address:77]City:10+", "+[Conslt Address:77]State:11+" "+[Conslt Address:77]Zip:12
	
	vPhone:=[Conslt Address:77]PhoneNo1:13
	If ([Conslt Address:77]PhoneNo2:14#"")
		vPhone:=vPhone+", "+[Conslt Address:77]PhoneNo2:14
	End if 
	If ([Conslt Address:77]PhoneNo3:15#"")
		vPhone:=vPhone+", "+[Conslt Address:77]PhoneNo3:15
	End if 
	
	vFax:=[Conslt Address:77]FaxNo1:16
	If ([Conslt Address:77]FaxNo2:17#"")
		vFax:=vFax+", "+[Conslt Address:77]FaxNo2:17
	End if 
End if 


