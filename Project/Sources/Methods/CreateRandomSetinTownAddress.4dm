//%attributes = {"invisible":true}
//CreateRandomSetinTownAddress 
//purpose: create a random set of town address from the Search Town Address dialog
If (False:C215)
	//created: 10/10/2003
	//copied and modified from CreateRandomSetinConsltRating
	
	// Modified by: Costas Manousakis-(Designer)-(12/30/13 16:44:16)
	Mods_2013_12
	//  `Instead of blanking the search variables,  leave them with a space as a workaround for the v13  upgrade.
	// Modified by: Costas Manousakis-(Designer)-(3/28/19 13:38:34)
	Mods_2019_03
	//  `cleaned up code ; added results string - use query destination. use wildcard and search town in address and official townname
	//  //Changed to using the combo box array aTownName_
End if 

C_TEXT:C284($vTown)
$vTown:=f_TrimStr(aTownName_{0}; True:C214; True:C214)
If ($vTown#"")
	
	If ((vAddTo=True:C214) & (Records in set:C195("Random Set")=0))
		CREATE SET:C116([Town Address:78]; "Random Set")
	End if 
	
	OBJECT SET ENABLED:C1123(bFind; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	
	If (vAddTo=False:C215)
		USE NAMED SELECTION:C332("UserRegionA")
	Else 
		ALL RECORDS:C47([Town Address:78])
	End if 
	
	$vTown:="@"+$vTown+"@"
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "Found Town Address Set")
	QUERY SELECTION:C341([Town Address:78]; [Town Address:78]TownName:2=$vTown; *)
	QUERY SELECTION:C341([Town Address:78];  | ; [Town Address:78]OfficialTownName:4=$vTown)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If (Records in set:C195("Random Set")=0)
		If (vAddTo=False:C215)
			CREATE EMPTY SET:C140([Town Address:78]; "Random Set")
		End if 
	End if 
	UNION:C120("Random Set"; "Found Town Address Set"; "Random Set")
	OBJECT SET TITLE:C194(*; "SearchResults"; "Last Find : "+String:C10(Records in set:C195("Found Town Address Set"))+\
		" - Total Found : "+String:C10(Records in set:C195("Random Set")))
	CLEAR SET:C117("Found Town Address Set")
	OBJECT SET ENABLED:C1123(bFind; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	aTownName_{0}:=" "
	
End if 
