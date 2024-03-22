
If (False:C215)
	Mods_2020_02  //Remove obsolete commands
End if 

If (Table name:C256(TableNumber_L)="TableOfLists")
	
	Case of 
		: (Form event code:C388=On Clicked:K2:4)
			If (ListNames_atxt>0)
				TOL_ListName_txt:=ListNames_atxt{ListNames_atxt}
				OBJECT SET ENABLED:C1123(bAdd; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1=TOL_ListName_txt)
				ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >; [TableOfLists:125]ListValue_s:2; >)
				CREATE SET:C116([TableOfLists:125]; "QuerySet")
				C_TEXT:C284($IPAddress_txt; $TableName_txt)
				
				$IPAddress_txt:=SQL_TestConnection
				
				C_TEXT:C284(SQL_txt)
				
				ARRAY TEXT:C222(RemoteListName_atxt; 0)
				ARRAY LONGINT:C221(RemoteListKey_al; 0)
				ARRAY LONGINT:C221(RemoteListSequence_al; 0)
				ARRAY TEXT:C222(RemoteListValue_atxt; 0)
				
				SQL_txt:="Select [TableOfLists].[ListName_s], "+Char:C90(Carriage return:K15:38)
				SQL_txt:=SQL_txt+"[TableOfLists].[ListValue_s], "+Char:C90(Carriage return:K15:38)
				SQL_txt:=SQL_txt+"[TableOfLists].[ListSequence_l], "+Char:C90(Carriage return:K15:38)
				SQL_txt:=SQL_txt+"[TableOfLists].[ListKeyID_L] "+Char:C90(Carriage return:K15:38)
				SQL_txt:=SQL_txt+"from [TableOfLists] "+Char:C90(Carriage return:K15:38)
				SQL_txt:=SQL_txt+"where [TableOfLists].[ListName_s] = :TOL_ListName_txt"+Char:C90(Carriage return:K15:38)
				SQL_txt:=SQL_txt+"INTO :RemoteListName_atxt, :RemoteListValue_atxt, :RemoteListSequence_al, :RemoteListKey_al;  "+Char:C90(Carriage return:K15:38)
				ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
				
				Begin SQL
					execute Immediate :SQL_txt;
				End SQL
				ut_SQLLogout
				//_ o _USE INTERNAL DATABASE
			End if 
			
	End case 
End if 