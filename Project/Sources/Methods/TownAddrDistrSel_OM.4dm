//%attributes = {"invisible":true}
//Method: TownAddrDistrSel_OM
//Description
// object method for the Select byt District int the Town Address lists
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-01-10T00:00:00, 17:31:48
	// ----------------------------------------------------
	//Created : 
	Mods_2022_01
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		aDistrictSelect:=0
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($distrno_s)
		C_LONGINT:C283($index)
		$index:=aDistrictSelect
		$distrno_s:=Substring:C12(aDistrictSelect{$index}; Length:C16(aDistrictSelect{$index}); 1)
		$distrno_s:=String:C10(Num:C11($distrno_s); "00")
		QUERY:C277([Town Data:2]; [Town Data:2]District:6=$distrno_s)
		ARRAY TEXT:C222($towns_as; 0)
		ARRAY TEXT:C222($BDEPTRefix_as; 0)
		SELECTION TO ARRAY:C260([Town Data:2]Town Name:1; $towns_as; [Town Data:2]BDEPT Prefix:2; $BDEPTRefix_as)
		SET QUERY DESTINATION:C396(Into set:K19:2; "SearchByName")
		QUERY WITH ARRAY:C644([Town Address:78]TownName:2; $towns_as)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY DESTINATION:C396(Into set:K19:2; "SearchByBDEpt")
		QUERY WITH ARRAY:C644([Town Address:78]TownBDEPTPrefix:17; $BDEPTRefix_as)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		UNION:C120("SearchByName"; "SearchByBDEpt"; "SearchByBDEpt")
		USE SET:C118("SearchByBDEpt")
		CLEAR SET:C117("SearchByBDEpt")
		CLEAR SET:C117("SearchByName")
		ORDER BY:C49([Town Address:78]; [Town Address:78]TownName:2)
		UNLOAD RECORD:C212(Current form table:C627->)
		LB_ResetHeaders("TownAddressLB")
		RegionTitle
		REDRAW WINDOW:C456
		ARRAY TEXT:C222($towns_as; 0)
		ARRAY TEXT:C222($BDEPTRefix_as; 0)
End case 
//End TownAddrDistrSel_OM