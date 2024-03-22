C_LONGINT:C283($Choice_L)
$Choice_L:=Pop up menu:C542(" ;Export Lists;Import Lists")

Case of 
	: ($Choice_L=2)
		CUT NAMED SELECTION:C334([TableOfLists:125]; "$TempSaveSel")
		utl_ExportTOLRecords
		USE NAMED SELECTION:C332("$TempSaveSel")
	: ($Choice_L=3)
		utl_ImportTOLRecords
		ALL RECORDS:C47(Current form table:C627->)
		ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListName_s:1; >; [TableOfLists:125]ListSequence_l:3; >; [TableOfLists:125]ListValue_s:2; >)
		
End case 