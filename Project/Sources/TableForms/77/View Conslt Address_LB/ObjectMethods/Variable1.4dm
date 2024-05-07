If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/09/07, 15:28:56
	// ----------------------------------------------------
	// Method: Object Method: bzAddLay
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(3/9/10 12:32:14)
	Mods_2010_03
	//  `Added initialization variables that are passed by the ADD button on the list form.
	//  `they get filled from the first record in the usetset ("highlighted")
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06)
	Mods_2021_10
	//  `unload record at end - reset LB headers
	// Modified by: Costas Manousakis-(Designer)-(2024-04-30 16:47:37)
	Mods_2024_04
	//  `remove on load code - handled in form method
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		//If (Current user="Designer")
		//OBJECT SET VISIBLE(Self->;True)
		//Else 
		//OBJECT SET VISIBLE(Self->;False)
		//End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		
		CREATE SET:C116(Current form table:C627->; "GENERICPREADDSET")
		C_TEXT:C284(CSLT_INI_Cname_txt; CSLT_INI_str1_txt; CSLT_INI_str2_txt; CSLT_INI_city_txt; CSLT_INI_state_txt; CSLT_INI_zip_txt; CSLT_INI_phone1_txt; CSLT_INI_phone2_txt; CSLT_INI_phone3_txt; CSLT_INI_fax1_txt; CSLT_INI_fax2_txt)
		C_LONGINT:C283(CSLT_INI_cnameID_L)
		CSLT_INI_Cname_txt:=""
		CSLT_INI_str1_txt:=""
		CSLT_INI_str2_txt:=""
		CSLT_INI_city_txt:=""
		CSLT_INI_state_txt:=""
		CSLT_INI_zip_txt:=""
		CSLT_INI_phone1_txt:=""
		CSLT_INI_phone2_txt:=""
		CSLT_INI_phone3_txt:=""
		CSLT_INI_fax1_txt:=""
		CSLT_INI_fax2_txt:=""
		CSLT_INI_cnameID_L:=0
		If (Records in set:C195("UserSet")>0)
			USE SET:C118("UserSet")
			READ ONLY:C145([Conslt Address:77])
			FIRST RECORD:C50([Conslt Address:77])
			CSLT_INI_Cname_txt:=[Conslt Address:77]ConsltName:2
			CSLT_INI_str1_txt:=[Conslt Address:77]Street1:8
			CSLT_INI_str2_txt:=[Conslt Address:77]Street2:9
			CSLT_INI_city_txt:=[Conslt Address:77]City:10
			CSLT_INI_state_txt:=[Conslt Address:77]State:11
			CSLT_INI_zip_txt:=[Conslt Address:77]Zip:12
			CSLT_INI_phone1_txt:=[Conslt Address:77]PhoneNo1:13
			CSLT_INI_phone2_txt:=[Conslt Address:77]PhoneNo2:14
			CSLT_INI_phone3_txt:=[Conslt Address:77]PhoneNo3:15
			CSLT_INI_fax1_txt:=[Conslt Address:77]FaxNo1:16
			CSLT_INI_fax2_txt:=[Conslt Address:77]FaxNo2:17
			CSLT_INI_cnameID_L:=[Conslt Address:77]ConsultantNameID_l:22
			READ WRITE:C146([Conslt Address:77])
			
		End if 
		
		ADD RECORD:C56(Current form table:C627->)
		If (OK=1)
			ADD TO SET:C119(Current form table:C627->; "GENERICPREADDSET")
		End if 
		USE SET:C118("GENERICPREADDSET")
		CLEAR SET:C117("GENERICPREADDSET")
		ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ConsltName:2; >)
		UNLOAD RECORD:C212(Current form table:C627->)
		LB_ResetHeaders("SelectListBox")
		RegionTitle
End case 
