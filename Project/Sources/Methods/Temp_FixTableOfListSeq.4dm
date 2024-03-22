//%attributes = {"invisible":true}
//Method: Temp_FixTableOfListSeq
//Description
//Fix keyID_L in table of lists
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/04/14, 12:47:46
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04_bug
End if 
//

If (User in group:C338(Current user:C182; "Design Access Group"))
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListKeyID_L:4=0)
	
	
	If (Records in selection:C76([TableOfLists:125])>0)
		FIRST RECORD:C50([TableOfLists:125])
		While (Not:C34(End selection:C36([TableOfLists:125])))
			
			If (ut_LoadRecordInteractive(->[TableOfLists:125]))
				Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
				ALERT:C41("fixed list "+[TableOfLists:125]ListName_s:1+", value "+[TableOfLists:125]ListValue_s:2+" to "+String:C10([TableOfLists:125]ListKeyID_L:4))
				SAVE RECORD:C53([TableOfLists:125])
				NEXT RECORD:C51([TableOfLists:125])
			End if 
			
		End while 
	Else 
		ALERT:C41("No zero ID records were found in [TableOfLists]")
	End if 
	
End if 

//End Temp_FixTableOfListSeq