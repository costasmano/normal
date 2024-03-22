//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:56:56
	// ----------------------------------------------------
	// Method: SC_EndExpFile
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
Case of 
	: (SC_SAVEASHTML_i=1)
		SEND PACKET:C103(vScourCalcDocRef; "</table>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</body>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</html>"+<>sCR)
	: (SC_SAVEASHTML_i=2)
		SEND PACKET:C103(vScourCalcDocRef; "</Table>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<WorksheetOptions xmlns="+<>sQU+"urn:schemas-microsoft-com:office:excel"+<>sQU+">"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<PageLayoutZoom>0</PageLayoutZoom>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Selected/>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<FreezePanes/>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<SplitHorizontal>1</SplitHorizontal>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<TopRowBottomPane>1</TopRowBottomPane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<SplitVertical>2</SplitVertical>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<LeftColumnRightPane>2</LeftColumnRightPane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<ActivePane>0</ActivePane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Panes>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Pane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Number>3</Number>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</Pane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Pane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Number>2</Number>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</Pane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Pane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Number>1</Number>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</Pane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Pane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Number>0</Number>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<ActiveRow>0</ActiveRow>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<ActiveCol>0</ActiveCol>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</Pane>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</Panes>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<ProtectObjects>False</ProtectObjects>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<ProtectScenarios>False</ProtectScenarios>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</WorksheetOptions>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Sorting xmlns="+<>sQU+"urn:schemas-microsoft-com:office:excel"+<>sQU+">"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Sort>Category</Sort>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Sort>Life Time Risk</Sort>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Descending/>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "<Sort>BDEPT</Sort>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</Sorting>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</Worksheet>"+<>sCR)
		SEND PACKET:C103(vScourCalcDocRef; "</Workbook>"+<>sCR)
End case 