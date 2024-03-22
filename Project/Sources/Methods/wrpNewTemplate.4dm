//%attributes = {"invisible":true}
// PM: "wrpNewTemplate" (neu LV xx.09.2018) 
// Kommentar
// $1 - OBJECT - $wpPropertiesObj, so wie es von z.B. "wrpNewTemplateNewProperties" erstellt wurde und ggf. individuell mit Werten gefüllt wurde
// $0 - OBJECT - $wpDocNew - Neues wpDocument
// Letzte Änderung: LV xx.09.2018, xx:yy Uhr

C_OBJECT:C1216($wpPropertiesObj; $1)
C_OBJECT:C1216($wpDocNew; $0)
C_TEXT:C284($srcHtmlStart; $srcHtmlEnd)
C_TEXT:C284($srcHeadStart; $srcHeadEnd)
C_TEXT:C284($srcBodyStart; $srcBodyEnd; $srcBodyContent)
C_TEXT:C284($srcTitleStart; $srcTitleEnd; $srcTitleContent)
C_TEXT:C284($srcMetaCreate; $srcMetaModify)
C_TEXT:C284($srcStyleStart; $srcStyleEnd; $srcStyleContent)
C_TEXT:C284($srcAll)

If (Count parameters:C259>0)
	$wpPropertiesObj:=$1
Else 
	$wpPropertiesObj:=wrpNewTemplateNewProperties
End if 

$srcHtmlStart:="<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:d4=\"http://www.4D.com\">"
$srcHtmlEnd:="</html>"

$srcHeadStart:="<head>"
$srcHeadEnd:="</head>"

$srcBodyStart:="<body>"
$srcBodyEnd:="</body>"
$srcBodyContent:=$wpPropertiesObj.bodyContent
// --- section1 ---
If ($wpPropertiesObj.section1Header)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section1Header\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section1HeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section1FirstHeader)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section1FirstHeader\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section1FirstHeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section1LeftHeader)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section1LeftHeader\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section1LeftHeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section1RightHeader)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section1RightHeader\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section1RightHeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section1Footer)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section1Footer\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section1FooterContent+"</div>"
End if 
If ($wpPropertiesObj.section1FirstFooter)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section1FirstFooter\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section1FirstFooterContent+"</div>"
End if 
If ($wpPropertiesObj.section1LeftFooter)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section1LeftFooter\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section1LeftFooterContent+"</div>"
End if 
If ($wpPropertiesObj.section1RightFooter)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section1RightFooter\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section1RightFooterContent+"</div>"
End if 
// --- section2 ---
If ($wpPropertiesObj.section2Header)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section2Header\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section2HeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section2FirstHeader)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section2FirstHeader\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section2FirstHeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section2LeftHeader)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section2LeftHeader\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section2LeftHeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section2RightHeader)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section2RightHeader\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section2RightHeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section2Footer)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section2Footer\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section2FooterContent+"</div>"
End if 
If ($wpPropertiesObj.section2FirstFooter)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section2FirstFooter\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section2FirstFooterContent+"</div>"
End if 
If ($wpPropertiesObj.section2LeftFooter)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section2LeftFooter\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section2LeftFooterContent+"</div>"
End if 
If ($wpPropertiesObj.section2RightFooter)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section2RightFooter\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section2RightFooterContent+"</div>"
End if 
// --- section3 ---
If ($wpPropertiesObj.section3Header)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section3Header\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section3HeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section3FirstHeader)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section3FirstHeader\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section3FirstHeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section3LeftHeader)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section3LeftHeader\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section3LeftHeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section3RightHeader)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section3RightHeader\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section3RightHeaderContent+"</div>"
End if 
If ($wpPropertiesObj.section3Footer)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section3Footer\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section3FooterContent+"</div>"
End if 
If ($wpPropertiesObj.section3FirstFooter)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section3FirstFooter\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section3FirstFooterContent+"</div>"
End if 
If ($wpPropertiesObj.section3LeftFooter)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section3LeftFooter\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section3LeftFooterContent+"</div>"
End if 
If ($wpPropertiesObj.section3RightFooter)
	$srcBodyContent:=$srcBodyContent+"<div class=\"section3RightFooter\" style=\"visibility: hidden; height: 0\">"+$wpPropertiesObj.section3RightFooterContent+"</div>"
End if 

$srcTitleStart:="<title>"
$srcTitleEnd:="</title>"
$srcTitleContent:=$wpPropertiesObj.docTitle
$srcTitleContent:=Replace string:C233($srcTitleContent; "<"; "&lt;")
$srcTitleContent:=Replace string:C233($srcTitleContent; ">"; "&gt;")
$srcTitleContent:=Replace string:C233($srcTitleContent; Char:C90(Carriage return:K15:38); " ")
$srcTitleContent:=Replace string:C233($srcTitleContent; Char:C90(Line feed:K15:40); " ")
$srcTitleContent:=Replace string:C233($srcTitleContent; Char:C90(Backspace:K15:36); " ")
$srcTitleContent:=Replace string:C233($srcTitleContent; Char:C90(Tab:K15:37); " ")

$srcMetaCreate:="<meta name=\"datetimeCreation\" content=\""+$wpPropertiesObj.docCreate+"\" />"
$srcMetaModify:="<meta name=\"datetimeModified\" content=\""+$wpPropertiesObj.docModify+"\" />"

$srcStyleStart:="<style type=\"text/css\">"
$srcStyleEnd:="</style>"

$srcStyleContent:=""
$srcStyleContent:=$srcStyleContent+"body { "
If (Length:C16($wpPropertiesObj.bodyVersion)>0)
	$srcStyleContent:=$srcStyleContent+"-d4-version:"+$wpPropertiesObj.bodyVersion+";"
Else 
	$srcStyleContent:=$srcStyleContent+"-d4-version:2.01;"
End if 
If (Length:C16($wpPropertiesObj.bodyUserUnit)>0)
	$srcStyleContent:=$srcStyleContent+"-d4-user-unit:"+$wpPropertiesObj.bodyUserUnit+";"
Else 
	$srcStyleContent:=$srcStyleContent+"-d4-user-unit:pt;"
End if 
If (Length:C16($wpPropertiesObj.bodyBgColor)>0)
	$srcStyleContent:=$srcStyleContent+"background-color:"+$wpPropertiesObj.bodyBgColor+";"
Else 
	$srcStyleContent:=$srcStyleContent+"background-color:#FFFFFF;"
End if 
$srcStyleContent:=$srcStyleContent+" }"

$srcStyleContent:=$srcStyleContent+"ul, ol { margin:0;padding:0 }"
$srcStyleContent:=$srcStyleContent+"p,li { white-space:pre-wrap;border-width:2pt;margin:0pt;padding:0pt;-d4-list-font:'Times New Roman';-d4-font:'Times New Roman';font-family:'Times New Roman' }"
If ($wpPropertiesObj.section0)
	$srcStyleContent:=$srcStyleContent+"div.section0 { "
	If (Length:C16($wpPropertiesObj.section0PageWidth)>0)
		$srcStyleContent:=$srcStyleContent+"-d4-page-width:"+$wpPropertiesObj.section0PageWidth+";"
	End if 
	If (Length:C16($wpPropertiesObj.section0PageHeight)>0)
		$srcStyleContent:=$srcStyleContent+"-d4-page-height:"+$wpPropertiesObj.section0PageHeight+";"
	End if 
	If (Length:C16($wpPropertiesObj.section0PageMargin)>0)
		$srcStyleContent:=$srcStyleContent+"-d4-page-margin:"+$wpPropertiesObj.section0PageMargin+";"
	End if 
	If (Length:C16($wpPropertiesObj.section0PageOrientation)>0)
		$srcStyleContent:=$srcStyleContent+"-d4-page-orientation:"+$wpPropertiesObj.section0PageOrientation+";"
	End if 
	$srcStyleContent:=$srcStyleContent+" }"
End if 
// --- section1 ---
If ($wpPropertiesObj.section1First)
	$srcStyleContent:=$srcStyleContent+"div.section1First { white-space:normal }"
End if 
If ($wpPropertiesObj.section1FirstFooter)
	$srcStyleContent:=$srcStyleContent+"div.section1FirstFooter { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section1FirstHeader)
	$srcStyleContent:=$srcStyleContent+"div.section1FirstHeader { margin:1cm 2.5cm 0.5cm }"
End if 
If ($wpPropertiesObj.section1Footer)
	$srcStyleContent:=$srcStyleContent+"div.section1Footer { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section1Header)
	$srcStyleContent:=$srcStyleContent+"div.section1Header { margin:1cm 2.5cm 0.5cm }"
End if 
If ($wpPropertiesObj.section1Left)
	$srcStyleContent:=$srcStyleContent+"div.section1Left { white-space:normal }"
End if 
If ($wpPropertiesObj.section1LeftFooter)
	$srcStyleContent:=$srcStyleContent+"div.section1LeftFooter { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section1LeftHeader)
	$srcStyleContent:=$srcStyleContent+"div.section1LeftHeader { margin:1cm 2.5cm 0.5cm }"
End if 
If ($wpPropertiesObj.section1Right)
	$srcStyleContent:=$srcStyleContent+"div.section1Right { white-space:normal }"
End if 
If ($wpPropertiesObj.section1RightFooter)
	$srcStyleContent:=$srcStyleContent+"div.section1RightFooter { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section1RightHeader)
	$srcStyleContent:=$srcStyleContent+"div.section1RightHeader { margin:1cm 2.5cm 0.5cm }"
End if 
// --- section2 ---
If ($wpPropertiesObj.section2First)
	$srcStyleContent:=$srcStyleContent+"div.section2First { white-space:normal }"
End if 
If ($wpPropertiesObj.section2FirstFooter)
	$srcStyleContent:=$srcStyleContent+"div.section2FirstFooter { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section2FirstHeader)
	$srcStyleContent:=$srcStyleContent+"div.section2FirstHeader { margin:1cm 2.5cm 0.5cm }"
End if 
If ($wpPropertiesObj.section2Footer)
	$srcStyleContent:=$srcStyleContent+"div.section2Footer { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section2Header)
	$srcStyleContent:=$srcStyleContent+"div.section2Header { margin:1cm 2.5cm 0.5cm }"
End if 
If ($wpPropertiesObj.section2Left)
	$srcStyleContent:=$srcStyleContent+"div.section2Left { white-space:normal }"
End if 
If ($wpPropertiesObj.section2LeftFooter)
	$srcStyleContent:=$srcStyleContent+"div.section2LeftFooter { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section2LeftHeader)
	$srcStyleContent:=$srcStyleContent+"div.section2LeftHeader { margin:1cm 2.5cm 0.5cm }"
End if 
If ($wpPropertiesObj.section2Right)
	$srcStyleContent:=$srcStyleContent+"div.section2Right { white-space:normal }"
End if 
If ($wpPropertiesObj.section2RightFooter)
	$srcStyleContent:=$srcStyleContent+"div.section2RightFooter { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section2RightHeader)
	$srcStyleContent:=$srcStyleContent+"div.section2RightHeader { margin:1cm 2.5cm 0.5cm }"
End if 
// --- section3 ---
If ($wpPropertiesObj.section3First)
	$srcStyleContent:=$srcStyleContent+"div.section3First { white-space:normal }"
End if 
If ($wpPropertiesObj.section3FirstFooter)
	$srcStyleContent:=$srcStyleContent+"div.section3FirstFooter { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section3FirstHeader)
	$srcStyleContent:=$srcStyleContent+"div.section3FirstHeader { margin:1cm 2.5cm 0.5cm }"
End if 
If ($wpPropertiesObj.section3Footer)
	$srcStyleContent:=$srcStyleContent+"div.section3Footer { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section3Header)
	$srcStyleContent:=$srcStyleContent+"div.section3Header { margin:1cm 2.5cm 0.5cm }"
End if 
If ($wpPropertiesObj.section3Left)
	$srcStyleContent:=$srcStyleContent+"div.section3Left { white-space:normal }"
End if 
If ($wpPropertiesObj.section3LeftFooter)
	$srcStyleContent:=$srcStyleContent+"div.section3LeftFooter { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section3LeftHeader)
	$srcStyleContent:=$srcStyleContent+"div.section3LeftHeader { margin:1cm 2.5cm 0.5cm }"
End if 
If ($wpPropertiesObj.section3Right)
	$srcStyleContent:=$srcStyleContent+"div.section3Right { white-space:normal }"
End if 
If ($wpPropertiesObj.section3RightFooter)
	$srcStyleContent:=$srcStyleContent+"div.section3RightFooter { margin:0.5cm 2.5cm 1cm }"
End if 
If ($wpPropertiesObj.section3RightHeader)
	$srcStyleContent:=$srcStyleContent+"div.section3RightHeader { margin:1cm 2.5cm 0.5cm }"
End if 
$srcStyleContent:=$srcStyleContent+"p.Normal,li.Normal { white-space:pre-wrap }"

$srcAll:=$srcHtmlStart+$srcHeadStart
$srcAll:=$srcAll+$srcTitleStart+$srcTitleContent+$srcTitleEnd
$srcAll:=$srcAll+$srcMetaCreate+$srcMetaModify
$srcAll:=$srcAll+$srcStyleStart+$srcStyleContent+$srcStyleEnd
$srcAll:=$srcAll+$srcHeadEnd
$srcAll:=$srcAll+$srcBodyStart+$srcBodyContent+$srcBodyEnd
$srcAll:=$srcAll+$srcHtmlEnd

$wpDocNew:=WP New:C1317($srcAll)
$0:=$wpDocNew
