//%attributes = {"invisible":true}
// Method: Method: SRC_EL_Util
// Description
//  ` load arrays used in Search by element deficiency
// 
// Parameters
// $1 : $Task_txt ( "LOADCAT" | "LOADELEM")
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/18/11, 15:52:08
	// ----------------------------------------------------
	
	Mods_2011_01
	// Modified by: Costas Manousakis-(Designer)-(5/6/13 11:32:58)
	Mods_2013_05
	//  `RR elements from 2000- 3999, Tunnel from 5000  and up
	Mods_2013_05  //r003 ` Change [Element Cat]Description from 15 to 20 characters
	//Modified by: Charles Miller (5/7/13 14:40:49)
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
		
	: ($Task_txt="LOADCAT")
		OBJECT SET ENABLED:C1123(cboInspType; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(cboElem; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		READ ONLY:C145([Element Cat:32])
		QUERY:C277([Element Cat:32]; [Element Cat:32]Code:1#"FRZ")
		ARRAY TEXT:C222(cboInspType; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY TEXT:C222(aInspCod_; 0)  //Command Replaced was o_ARRAY string length was 3
		SELECTION TO ARRAY:C260([Element Cat:32]Code:1; aInspCod_)
		SELECTION TO ARRAY:C260([Element Cat:32]Description:2; cboInspType)
		//Added this to replace All Inspections with All Elements
		C_LONGINT:C283($k)
		$k:=Find in array:C230(aInspCod_; "ALL")
		cboInspType{$k}:="All Elements"
		REDUCE SELECTION:C351([Element Cat:32]; 0)
		READ WRITE:C146([Element Cat:32])
		CurCat:="ALL"
		POPUPMENUC(->cboInspType; ->aInspCod_; ->CurCat)
		
	: ($Task_txt="LOADELEM")
		ARRAY INTEGER:C220(aElemNo; 0)
		ARRAY TEXT:C222(cboElem; 0)  //Command Replaced was o_ARRAY string length was 80
		If (CurCat#"ALL")
			QUERY:C277([ElementDict:30]; [ElementDict:30]Category:3=CurCat)
		Else 
			QUERY:C277([ElementDict:30]; [Element Cat:32]Code:1#"FRZ")
		End if 
		ORDER BY:C49([ElementDict:30]; [ElementDict:30]Category:3; >; [ElementDict:30]ElementNo:1; >)
		SELECTION TO ARRAY:C260([ElementDict:30]ElementNo:1; aElemNo; [ElementDict:30]Description:2; cboElem)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(cboElem))
			
			Case of 
				: (aElemNo{$loop_L}>=5000)
					cboElem{$loop_L}:=cboElem{$loop_L}+" (TNL)"
				: (aElemNo{$loop_L}>=2000)
					cboElem{$loop_L}:=cboElem{$loop_L}+" (RR)"
			End case 
			
		End for 
		REDUCE SELECTION:C351([ElementDict:30]; 0)
		REDRAW:C174(cboElem)
End case 