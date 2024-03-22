//%attributes = {"invisible":true}
//CreateRandomSetinConsltAddress 
//purpose: create a random set of conslt from Search Consultant Address dialog
If (False:C215)
	//created: 10/15/2003
	//copied and modified from CreateRandomSetinConsltRating
	
	// Modified by: costasmanousakis-(Designer)-(10/31/2007 08:29:51)
	Mods_2007_CM12_5302  // made changes in the search :if user has a wild card, then use it.
	// Modified by: Costas Manousakis-(Designer)-(12/30/13 16:44:16)
	Mods_2013_12
	//  `Instead of blanking the search variables,  leave them with a space as a workaround for the v13  upgrade.
	// Modified by: Costas Manousakis-(Designer)-(3/28/19 15:28:28)
	Mods_2019_03
	//  `do nothing if both vars are empty - remove progress window
End if 

vConsltName:=f_TrimStr(vConsltName; True:C214; True:C214)
vLastName:=f_TrimStr(vLastName; True:C214; True:C214)
If (vConsltName#"") | (vLastName#"")
	
	If ((vAddTo=True:C214) & (Records in set:C195("Random Set")=0))
		CREATE SET:C116([Conslt Address:77]; "Random Set")
	End if 
	
	OBJECT SET ENABLED:C1123(bFind; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	
	If (vAddTo=False:C215)
		USE NAMED SELECTION:C332("UserRegionA")
	Else 
		ALL RECORDS:C47([Conslt Address:77])
	End if 
	
	If (vConsltName#"")
		If (Position:C15("@"; vConsltName)>0)
		Else 
			If (Length:C16(vConsltName)<6)
				vConsltName:="@"+vConsltName+"@"
			End if 
		End if 
		
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]ConsltName:2=vConsltName)
		vConsltName:=" "
		GOTO OBJECT:C206(vConsltName)
		HIGHLIGHT TEXT:C210(vConsltName; 1; 2)
	End if 
	
	If (vLastName#"")
		If (Position:C15("@"; vLastName)>0)
		Else 
			If (Length:C16(vLastName)<6)
				vLastName:="@"+vLastName+"@"
			End if 
		End if 
		
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]ContactLName:4=vLastName)
		vLastName:=" "
		GOTO OBJECT:C206(vLastName)
		HIGHLIGHT TEXT:C210(vLastName; 1; 2)
		
	End if 
	
	OBJECT SET ENABLED:C1123(bFind; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	
	CREATE SET:C116([Conslt Address:77]; "Found Consultant Address Set")
	If (Records in set:C195("Random Set")=0)
		If (vAddTo=False:C215)
			CREATE EMPTY SET:C140([Conslt Address:77]; "Random Set")
		End if 
	End if 
	UNION:C120("Random Set"; "Found Consultant Address Set"; "Random Set")
	OBJECT SET TITLE:C194(*; "SearchResults"; "Last Find : "+String:C10(Records in set:C195("Found Consultant Address Set"))+\
		" - Total Found : "+String:C10(Records in set:C195("Random Set")))
	
	CLEAR SET:C117("Found Consultant Address Set")
Else 
	vLastName:=" "
	vConsltName:=" "
	GOTO OBJECT:C206(vConsltName)
	HIGHLIGHT TEXT:C210(vConsltName; 1; 2)
	
End if 
