C_POINTER:C301($area3_)
$area3_:=OBJECT Get pointer:C1124(Object named:K67:5; "wparea")

C_OBJECT:C1216($firstpagehdr_o; $hdrrange_o; $logo_o)
$firstpagehdr_o:=WP Get header:C1503($area3_->; 1; wk first page:K81:203)
C_COLLECTION:C1488($elements_co)
$elements_co:=WP Get elements:C1550($firstpagehdr_o; wk type image:K81:192)
$logo_o:=$elements_co[0]
C_REAL:C285($ht; $widt)
WP GET ATTRIBUTES:C1345($logo_o; wk height:K81:46; $ht; wk width:K81:45; $widt)
$hdrrange_o:=WP Text range:C1341($firstpagehdr_o; wk start text:K81:165; wk end text:K81:164)
$elements_co:=WP Get elements:C1550($hdrrange_o; wk type image:K81:192)

If (False:C215)
	G_CloseAllTables
	ARRAY TEXT:C222($bookmarks_a; 0)
	WP GET BOOKMARKS:C1417($area3_->; $bookmarks_a)
	C_OBJECT:C1216($bookmark)
	C_LONGINT:C283($loop_L)
	C_TEXT:C284($bookmarktext)
	For ($loop_L; 1; Size of array:C274($bookmarks_a))
		$bookmark:=WP Bookmark range:C1416($area3_->; $bookmarks_a{$loop_L})
		$bookmarktext:=WP Get text:C1575($bookmark; wk expressions as value:K81:255)
	End for 
	
	
End if 
If (False:C215)
	WP USE PAGE SETUP:C1358($area3_->)
	C_LONGINT:C283($printht; $printW; $marL; $marT; $marR; $marB; $targW; $targH)
	GET PRINTABLE AREA:C703($printht; $printW)
	GET PRINTABLE MARGIN:C711($marL; $marT; $marR; $marB)
	WP SET ATTRIBUTES:C1342($area3_->; wk layout unit:K81:78; wk unit pt:K81:136)
	C_OBJECT:C1216($wpBody)
	$wpBody:=WP Get body:C1516($area3_->)
	WP GET ATTRIBUTES:C1345($wpBody; wk margin right:K81:12; $marR; wk margin left:K81:11; $marL; wk margin top:K81:13; $marT; wk margin bottom:K81:14; $marB)
	//WP SET ATTRIBUTES($wpBody;wk margin right;($printW-532))
	
End if 

If (False:C215)
	
	C_OBJECT:C1216(INSP_Comments_WP)
	//_O_PAGE SETUP([Inspections]; "WPCmtsPrint")
	FORM SET OUTPUT:C54([Inspections:27]; "WPCmtsPrint")
	$targW:=532  //1pt less than the width
	$targH:=655  //5pt less than ht
	//adjust printable margins to fix the printed page to calculate the page breaks in WP Pro
	SET PRINTABLE MARGIN:C710($marL; $marT; ($marR-($targW-$printW)); ($marB-($targH-$printht)))
	C_OBJECT:C1216(INSP_Comments_WP)
	INSP_Comments_WP:=WP New:C1317("")
	ARRAY LONGINT:C221($pages; 0)
	pageBreakFind($area3_; ->$pages)
	
	//_O_PAGE SETUP([Inspections]; "WPCmtsPrint")
	FORM SET OUTPUT:C54([Inspections:27]; "WPCmtsPrint")
	SET PRINTABLE MARGIN:C710(-1; -1; -1; -1)
	//SET PRINTABLE MARGIN($marL;$marT;$marR;$marB)  //reset the printable margins
	C_TEXT:C284(sBDEPT)
	C_LONGINT:C283(vPageNo; vTotal)
	vTotal:=23
	SET PRINT PREVIEW:C364(True:C214)
	OPEN PRINTING JOB:C995
	C_LONGINT:C283($loop_L)
	C_OBJECT:C1216($pageRange; $range)
	$range:=WP Text range:C1341(INSP_Comments_WP; wk start text:K81:165; wk end text:K81:164)
	For ($loop_L; 1; (Size of array:C274($pages)-1))
		$pageRange:=WP Text range:C1341($area3_->; $pages{$loop_L}; $pages{$loop_L+1})
		INSP_Comments_WP:=WP New:C1317($pageRange)
		Print form:C5([Inspections:27]; "WPCmtsPrint")
	End for 
	$pageRange:=WP Text range:C1341($area3_->; $pages{Size of array:C274($pages)}; wk end text:K81:164)
	INSP_Comments_WP:=WP New:C1317($pageRange)
	Print form:C5([Inspections:27]; "WPCmtsPrint")
	
	CLOSE PRINTING JOB:C996
	SET PRINT PREVIEW:C364(False:C215)
	
End if 
