If (False:C215)
	Mods_2011_10  // CJ Miller`10/27/11, 15:19:25      ` Change query method
End if 

C_TEXT:C284($Query_txt)

$Query_txt:=Request:C163("Enter value for "+<>SelectionOption_txt)

If (OK=1)
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1=<>SelectionOption_txt)
	QUERY SELECTION:C341([TableOfLists:125]; [TableOfLists:125]ListValue_s:2="@"+$Query_txt+"@")
	ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListValue_s:2; >)
End if 
