// ----------------------------------------------------
// Form Method: Match.o
// User name (OS): cjmiller
// Date and time: 02/22/07, 11:33:44
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2011_06  // CJ Miller`06/20/11, 11:14:08      ` Type all local variables for v11
End if 
CONS_Address_O_FM
If (Form event code:C388=On Double Clicked:K2:5)
	C_TEXT:C284($temp_txt)
	C_LONGINT:C283($RecordNumber_l; $Loop_l)
	COPY NAMED SELECTION:C331([Conslt Address:77]; "AddressUserSel")
	COPY SET:C600("UserSet"; "AddressUserSet")
	USE SET:C118("UserSet")
	$temp_txt:=[Conslt Address:77]ConsltName:2
	$RecordNumber_l:=Record number:C243([Conslt Address:77])
	QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=$temp_txt)
	CREATE SET:C116([Conslt Address:77]; "AddressAllSet")
	ARRAY TEXT:C222(PRJ_Item1_atxt; 0)
	ARRAY TEXT:C222(PRJ_Item1_atxt; Records in selection:C76([Conslt Address:77]))
	FIRST RECORD:C50([Conslt Address:77])
	For ($Loop_l; 1; Records in selection:C76([Conslt Address:77]))
		If ($RecordNumber_l#Record number:C243([Conslt Address:77]))
			PRJ_Item1_atxt{$Loop_l}:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
		End if 
		NEXT RECORD:C51([Conslt Address:77])
	End for 
	GOTO RECORD:C242([Conslt Address:77]; $RecordNumber_l)
	ut_LoadRecord(->[Conslt Address:77])
	
	
End if 
//End Form Method: Match.o