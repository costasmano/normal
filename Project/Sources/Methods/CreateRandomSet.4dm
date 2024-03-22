//%attributes = {"invisible":true}
//procedure: CreateRandomSet
//purpose: create a random set of bridges  from the Search Bridge dialog
If (False:C215)
	//by: Albert Leung
	//created: 5/21/97
	//modified:
	
	Mods_2005_CM17
	// Modified by: costasmanousakis-(Designer)-(1/11/2006 14:43:28)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(11/24/2006 17:32:45)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(9/28/2007 12:21:35)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/24/2007 09:15:53)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(1/8/08 16:39:19)
	Mods_2007_CM_5401
	// Modified by: Costas Manousakis-(Designer)-(12/30/13 16:44:16)
	Mods_2013_12
	//  `Instead of blanking the search variables,  leave them with a space as a workaround for the v13  upgrade.
	Mods_2018_11  // Change code from
	//_ o_ENABLE BUTTON and _ o_DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
End if 
SRC_DeclareBrgVars
C_TEXT:C284($s)  // Command Replaced was o_C_STRING length was 30
vBDEPT:=Replace string:C233(vBDEPT; " "; "")
vBDEPT:=Replace string:C233(vBDEPT; "_"; "")
vBridgeKey:=Replace string:C233(vBridgeKey; " "; "")
vBIN:=Replace string:C233(vBIN; " "; "")
If (Not:C34(SRC_NewSearchMethod_b))
	If ((vBIN+vBridgeKey+vBDEPT)#"")
		If ((vAddTo) & (Records in set:C195("Random Set")=0))
			CREATE SET:C116([Bridge MHD NBIS:1]; "Random Set")
		End if 
		OBJECT SET ENABLED:C1123(bFind; False:C215)
		
		If (Not:C34(SRC_HideLooking_b))
			SHORT_MESSAGE("Looking…")
		End if 
		If (vAddTo)
			If (SRC_AllowSearchAll_b)
				ALL RECORDS:C47([Bridge MHD NBIS:1])
			Else 
				USE NAMED SELECTION:C332("UserRegionA")
			End if 
		Else 
			If (SRC_AllowSearchAll_b)
				ALL RECORDS:C47([Bridge MHD NBIS:1])
			Else 
				USE NAMED SELECTION:C332("UserRegionA")
			End if 
		End if 
		If (vBDEPT#"")
			$s:=fRemoveChar(" "; vBDEPT)
			If (Length:C16($s)<6)
				$s:=$s+"@"
			End if 
			QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$s)
		End if 
		If (vBridgeKey#"")
			$s:=fRemoveChar(" "; vBridgeKey)
			If (Length:C16($s)<12)
				$s:=$s+"@"
			End if 
			QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Bridge Key:2=$s)
		End if 
		If (vBIN#"")
			$s:=fRemoveChar(" "; vBIN)
			If (Length:C16($s)<3)
				$s:=$s+"@"
			End if 
			QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$s)
		End if 
		
		CREATE SET:C116([Bridge MHD NBIS:1]; "Found Bridge Recs Set")
		If (Records in set:C195("Random Set")=0)
			If (vAddTo=False:C215)
				CREATE EMPTY SET:C140([Bridge MHD NBIS:1]; "Random Set")
			End if 
		End if 
		UNION:C120("Random Set"; "Found Bridge Recs Set"; "Random Set")
		C_TEXT:C284(vsSearchResults)
		vsSearchResults:="Last Find : "+String:C10(Records in set:C195("Found Bridge Recs Set"))+" Recs"
		vsSearchResults:=vsSearchResults+" - Total Recs Found : "+String:C10(Records in set:C195("Random Set"))
		CLEAR SET:C117("Found Bridge Recs Set")
		OBJECT SET ENABLED:C1123(bFind; True:C214)
		
		Case of 
			: (vBIN#"")
				GOTO OBJECT:C206(vBIN)
				SRC_StartFieldArea_s:="BI"
			: (vBDEPT#"")
				GOTO OBJECT:C206(vBDEPT)
				SRC_StartFieldArea_s:="BD"
			: (vBridgeKey#"")
				GOTO OBJECT:C206(vBridgeKey)
				SRC_StartFieldArea_s:="BK"
		End case 
		vBIN:=""
		vBDEPT:=""
		vBridgeKey:=""
		
		If (Not:C34(SRC_HideLooking_b))
			CLOSE WINDOW:C154
		End if 
		
	End if 
Else 
	If ((vBIN+vBridgeKey+vBDEPT)#"")
		If ((vAddTo) & (Records in set:C195("Random Set")=0))
			CREATE SET:C116(SRC_MasterTable_ptr->; "Random Set")
		End if 
		OBJECT SET ENABLED:C1123(bFind; False:C215)
		
		If (Not:C34(SRC_HideLooking_b))
			SHORT_MESSAGE("Looking…")
		End if 
		If (vAddTo)
			If (SRC_AllowSearchAll_b)
				ALL RECORDS:C47(SRC_MasterTable_ptr->)
			Else 
				USE NAMED SELECTION:C332("UserRegionA")
			End if 
		Else 
			If (SRC_AllowSearchAll_b)
				ALL RECORDS:C47(SRC_MasterTable_ptr->)
			Else 
				USE NAMED SELECTION:C332("UserRegionA")
			End if 
		End if 
		If (vBDEPT#"")
			$s:=Replace string:C233(vBDEPT; " "; "")
			If (Length:C16($s)<6)
				$s:=$s+"@"
			End if 
			QUERY SELECTION:C341(SRC_MasterTable_ptr->; SRC_BDEPTField_ptr->=$s)
		End if 
		If (vBridgeKey#"")
			$s:=Replace string:C233(vBridgeKey; " "; "")
			If (Length:C16($s)<12)
				$s:=$s+"@"
			End if 
			QUERY SELECTION:C341(SRC_MasterTable_ptr->; SRC_BRKEYField_ptr->=$s)
		End if 
		If (vBIN#"")
			$s:=Replace string:C233(vBIN; " "; "")
			If (Length:C16($s)<3)
				$s:=$s+"@"
			End if 
			QUERY SELECTION:C341(SRC_MasterTable_ptr->; SRC_BINField_ptr->=$s)
		End if 
		
		CREATE SET:C116(SRC_MasterTable_ptr->; "Found Bridge Recs Set")
		If (Records in set:C195("Random Set")=0)
			If (vAddTo=False:C215)
				CREATE EMPTY SET:C140(SRC_MasterTable_ptr->; "Random Set")
			End if 
		End if 
		UNION:C120("Random Set"; "Found Bridge Recs Set"; "Random Set")
		C_TEXT:C284(vsSearchResults)
		vsSearchResults:="Last Find : "+String:C10(Records in set:C195("Found Bridge Recs Set"))+" Recs"
		vsSearchResults:=vsSearchResults+" - Total Recs Found : "+String:C10(Records in set:C195("Random Set"))
		CLEAR SET:C117("Found Bridge Recs Set")
		
		If (Not:C34(SRC_HideLooking_b))
			CLOSE WINDOW:C154
		End if 
		OBJECT SET ENABLED:C1123(bFind; True:C214)
		
		Case of 
			: (vBIN#"")
				GOTO OBJECT:C206(vBIN)
				vBIN:=" "
				vBDEPT:=""
				vBridgeKey:=""
				SRC_StartFieldArea_s:="BI"
			: (vBDEPT#"")
				GOTO OBJECT:C206(vBDEPT)
				vBIN:=""
				vBDEPT:=" "
				vBridgeKey:=""
				SRC_StartFieldArea_s:="BD"
			: (vBridgeKey#"")
				GOTO OBJECT:C206(vBridgeKey)
				vBIN:=""
				vBDEPT:=""
				vBridgeKey:=" "
				SRC_StartFieldArea_s:="BK"
		End case 
		
	End if 
End if 