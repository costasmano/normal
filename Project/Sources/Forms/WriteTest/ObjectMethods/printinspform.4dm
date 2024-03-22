C_POINTER:C301($area3_)
C_OBJECT:C1216(INSP_Comments_WP)
$area3_:=OBJECT Get pointer:C1124(Object named:K67:5; "wparea")
C_OBJECT:C1216(INSP_Comments_WP)
//_O_PAGE SETUP([Inspections]; "WPCmtsPrint")
FORM SET OUTPUT:C54([Inspections:27]; "WPCmtsPrint")
C_LONGINT:C283($printht; $printW; $marL; $marT; $marR; $marB; $targW; $targH)
GET PRINTABLE AREA:C703($printht; $printW)
GET PRINTABLE MARGIN:C711($marL; $marT; $marR; $marB)
$targW:=533
$targH:=661
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
