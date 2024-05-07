If (False:C215)
	// ----------------------------------------------------
	// Form Method: Conslt Address In
	// User name (OS): cjmiller
	// Date and time: 02/15/07, 13:34:50
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(9/18/2007 11:59:47)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/5/2007 16:04:36)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 11:18:22)
	Mods_2007_CM12_5302  //made some more initializations
	// Modified by: costasmanousakis-(Designer)-(11/9/07 15:41:28)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(3/9/10 12:30:52)
	Mods_2010_03
	//  `Added initialization variables that are passed by the ADD button on the list form.
	// Modified by: costasmanousakis-(Designer)-(4/6/11 11:07:20)
	Mods_2011_04
	//  `do on load for the ConsNames_HL hlist menu
	// Modified by: Costas Manousakis-(Designer)-(2024-04-30 16:52:17)
	Mods_2024_04
	//  `run the code for the HL menu for all users. disable HL menu when in RO mode
End if 

C_TEXT:C284(vCompanyName)  // Command Replaced was o_C_STRING length was 100

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		If ((Read only state:C362([Conslt Address:77])) & Not:C34(Is new record:C668([Conslt Address:77])))
			_O_OBJECT SET COLOR:C271(*; "Field@"; <>Color_Not_Editable)
			OBJECT SET ENABLED:C1123(*; "ConsNames_HL"; False:C215)
		Else 
			InitChangeStack(1)
			C_LONGINT:C283(ConsltNameID_L)
			C_TEXT:C284(ConsltNameFunct_s)  // Command Replaced was o_C_STRING length was 3
			
			If (Is new record:C668([Conslt Address:77]))
				C_TEXT:C284(CSLT_INI_Cname_txt; CSLT_INI_str1_txt; CSLT_INI_str2_txt; CSLT_INI_city_txt; CSLT_INI_state_txt; CSLT_INI_zip_txt; CSLT_INI_phone1_txt; CSLT_INI_phone2_txt; CSLT_INI_phone3_txt; CSLT_INI_fax1_txt; CSLT_INI_fax2_txt)
				C_LONGINT:C283(CSLT_INI_cnameID_L)
				
				Inc_Sequence("ConsAddress"; ->[Conslt Address:77]ConsltAddressID:1)
				If (CSLT_INI_Cname_txt="")
					[Conslt Address:77]ConsltName:2:=vCompanyName
				Else 
					[Conslt Address:77]ConsltName:2:=CSLT_INI_Cname_txt
					vCompanyName:=[Conslt Address:77]ConsltName:2
				End if 
				PushChange(1; ->[Conslt Address:77]ConsltName:2)
				If (ConsltNameID_L#0)
					[Conslt Address:77]ConsultantNameID_l:22:=ConsltNameID_L
				Else 
					If (CSLT_INI_cnameID_L#0)
						[Conslt Address:77]ConsultantNameID_l:22:=CSLT_INI_cnameID_L
					End if 
				End if 
				PushChange(1; ->[Conslt Address:77]ConsultantNameID_l:22)
				Case of 
					: (ConsltNameFunct_s="DES")
						[Conslt Address:77]Func_Design:21:=True:C214
						PushChange(1; ->[Conslt Address:77]Func_Design:21)
					: (ConsltNameFunct_s="RAT")
						[Conslt Address:77]Func_Rating:19:=True:C214
						PushChange(1; ->[Conslt Address:77]Func_Rating:19)
					: (ConsltNameFunct_s="INS")
						[Conslt Address:77]Func_Insp:20:=True:C214
						PushChange(1; ->[Conslt Address:77]Func_Insp:20)
				End case 
				[Conslt Address:77]Street1:8:=CSLT_INI_str1_txt
				[Conslt Address:77]Street2:9:=CSLT_INI_str2_txt
				[Conslt Address:77]City:10:=CSLT_INI_city_txt
				[Conslt Address:77]State:11:=CSLT_INI_state_txt
				[Conslt Address:77]Zip:12:=CSLT_INI_zip_txt
				[Conslt Address:77]PhoneNo1:13:=CSLT_INI_phone1_txt
				[Conslt Address:77]PhoneNo2:14:=CSLT_INI_phone2_txt
				[Conslt Address:77]PhoneNo3:15:=CSLT_INI_phone3_txt
				[Conslt Address:77]FaxNo1:16:=CSLT_INI_fax1_txt
				[Conslt Address:77]FaxNo2:17:=CSLT_INI_fax2_txt
				PushChange(1; ->[Conslt Address:77]Street1:8)
				PushChange(1; ->[Conslt Address:77]Street2:9)
				PushChange(1; ->[Conslt Address:77]City:10)
				PushChange(1; ->[Conslt Address:77]State:11)
				PushChange(1; ->[Conslt Address:77]Zip:12)
				PushChange(1; ->[Conslt Address:77]PhoneNo1:13)
				PushChange(1; ->[Conslt Address:77]PhoneNo2:14)
				PushChange(1; ->[Conslt Address:77]PhoneNo3:15)
				PushChange(1; ->[Conslt Address:77]FaxNo1:16)
				PushChange(1; ->[Conslt Address:77]FaxNo2:17)
				
			Else 
				vCompanyName:=[Conslt Address:77]ConsltName:2
			End if 
		End if 
		
		If ([Conslt Address:77]ConsultantNameID_l:22=0)
			vCompanyName:=[Conslt Address:77]ConsltName:2
		Else 
			QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[Conslt Address:77]ConsultantNameID_l:22)
			vCompanyName:=[Conslt_Name:127]ConsultantName_s:2
		End if 
		C_LONGINT:C283(ConsNames_HL)
		OBJECT SET VISIBLE:C603(ConsNames_HL; True:C214)
		ALL RECORDS:C47([Conslt_Name:127])
		ARRAY TEXT:C222(ar_CName_atxt; 0)
		ARRAY LONGINT:C221(a_CnameID_aL; 0)
		SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantName_s:2; ar_CName_atxt; [Conslt_Name:127]ConsultantNameID_l:1; a_CnameID_aL)
		SORT ARRAY:C229(ar_CName_atxt; a_CnameID_aL)
		
		INSERT IN ARRAY:C227(ar_CName_atxt; 0; 1)
		INSERT IN ARRAY:C227(a_CnameID_aL; 0; 1)
		ar_CName_atxt{1}:="  Clear ID"
		a_CnameID_aL{1}:=0
		ConsNames_HL:=ut_ArrayToHL(->ar_CName_atxt)
		//If (Current user="Designer")
		//Else 
		//OBJECT SET VISIBLE(ConsNames_HL;False)
		//End if 
		
	: (Form event code:C388=On Validate:K2:3)
		FlushGrpChgs(1; ->[Conslt Address:77]ConsltAddressID:1; ->[Conslt Address:77]ConsltAddressID:1; ->[Conslt Address:77]ConsltAddressID:1; 1)
End case 

//End Form Method: Conslt Address In