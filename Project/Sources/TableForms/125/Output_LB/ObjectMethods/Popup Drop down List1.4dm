
OBJECT SET ENABLED:C1123(bAdd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
If (ListNames_atxt{ListNames_atxt}="New")
	C_BOOLEAN:C305($complete_b)
	C_TEXT:C284($NewAttribute_txt)
	
	$complete_b:=False:C215
	$NewAttribute_txt:="Enter a new unique List Name"
	Repeat 
		$NewAttribute_txt:=Request:C163($NewAttribute_txt)
		Case of 
			: ($NewAttribute_txt="")
				$complete_b:=True:C214
			: ($NewAttribute_txt="Enter a new unique List Name")
			: (Find in array:C230(ListNames_atxt; $NewAttribute_txt)>1)
				ALERT:C41("This List name already exists")
				$complete_b:=True:C214
			Else 
				CONFIRM:C162("New Attribute - "+$NewAttribute_txt; "Create"; "Try Again")
				If (OK=1)
					SelectedListName_s:=$NewAttribute_txt
					APPEND TO ARRAY:C911(ListNames_atxt; SelectedListName_s)
					$complete_b:=True:C214
					OBJECT SET ENABLED:C1123(bAdd; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					ListNames_atxt:=Size of array:C274(ListNames_atxt)
				End if 
		End case 
	Until ($complete_b)
End if 
If (ListNames_atxt>0)
	SelectedListName_s:=ListNames_atxt{ListNames_atxt}
	OBJECT SET ENABLED:C1123(bAdd; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1=SelectedListName_s)
	ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >; [TableOfLists:125]ListValue_s:2; >)
	CREATE SET:C116([TableOfLists:125]; SelectedListName_s)
	
End if 
UNLOAD RECORD:C212([TableOfLists:125])
