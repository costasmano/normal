//%attributes = {"invisible":true}

If (False:C215)
	// ----------------------------------------------------
	// CONS_Address_O_FM
	// User name (OS): cjmiller
	// Date and time: 02/22/07, 11:32:51
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(9/18/2007 12:22:10)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 16:19:19)
	Mods_2007_CM12_5302
	Mods_2018_11  // Change code from
	//_ o_ENABLE BUTTON and _ o_DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 14:46:17)
	Mods_2021_10
	//  `unload current record on load - remove setting of header vars
	// Modified by: Costas Manousakis-(Designer)-(2024-04-30 16:50:17)
	Mods_2024_04
	//  `fixed wrong variable for the add button
End if 
C_TEXT:C284(vAddress; vCityStateZip; vContactFunction)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vContact)  // Command Replaced was o_C_STRING length was 150

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Read only state:C362([Conslt Address:77]))
			OBJECT SET ENABLED:C1123(bzAddLay; False:C215)
			
		Else 
			OBJECT SET ENABLED:C1123(bzAddLay; True:C214)
		End if 
		
		UNLOAD RECORD:C212([Conslt Address:77])
		
	: (Form event code:C388=On Display Detail:K2:22)
		vContactFunction:=""
		If ([Conslt Address:77]Func_Rating:19=True:C214)
			vContactFunction:="Rating"
		End if 
		If ([Conslt Address:77]Func_Insp:20=True:C214)
			vContactFunction:="Inspection"
		End if 
		If ([Conslt Address:77]Func_Design:21=True:C214)
			vContactFunction:="Design"
		End if 
		If (([Conslt Address:77]Func_Rating:19=True:C214) & ([Conslt Address:77]Func_Insp:20=True:C214))
			vContactFunction:="Insp.,Ratg."
		End if 
		If (([Conslt Address:77]Func_Design:21=True:C214) & ([Conslt Address:77]Func_Insp:20=True:C214))
			vContactFunction:="Insp.,Des."
		End if 
		If (([Conslt Address:77]Func_Design:21=True:C214) & ([Conslt Address:77]Func_Rating:19=True:C214))
			vContactFunction:="Ratg.,Des."
		End if 
		If (([Conslt Address:77]Func_Rating:19=True:C214) & ([Conslt Address:77]Func_Insp:20=True:C214) & ([Conslt Address:77]Func_Design:21=True:C214))
			vContactFunction:="Ratg.,Insp.,Des."
		End if 
		
		vAddress:=[Conslt Address:77]Street1:8
		If ([Conslt Address:77]Street2:9#"")
			vAddress:=vAddress+", "+[Conslt Address:77]Street2:9
		End if 
		
		vCityStateZip:=[Conslt Address:77]City:10+", "+[Conslt Address:77]State:11+" "+Substring:C12([Conslt Address:77]Zip:12; 1; 5)
		If ([Conslt Address:77]ContactMName:5#"")
			vContact:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
		Else 
			vContact:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactMName:5+" "+[Conslt Address:77]ContactLName:4
		End if 
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
End case 
//End CONS_Address_O_FM