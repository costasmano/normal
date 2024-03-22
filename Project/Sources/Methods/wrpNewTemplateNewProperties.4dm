//%attributes = {"invisible":true}
// PM: "wrpNewTemplateNewProperties" (neu LV 24.08.2018)
// Erzeugt (und gibt zurück) ein Object(json) mit den Einstell-Parametern zu einem 4DWritePro-Dokument um mit "wrpNewTemplate" ein wpDocument zu erstellen
// $0 - OBJECT - Object(json) mit Einstellungen zu einem 4DWritePro-Dokument(customTemplate)
// Letzte Änderung: LV xx.09.2018, xx:yy

C_OBJECT:C1216($wpPropertiesObj; $0)

OB SET:C1220($wpPropertiesObj; "docTitle"; "4D Write Pro Neues Dokument")
OB SET:C1220($wpPropertiesObj; "docCreate"; Replace string:C233(String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178); "Z"; ".000Z"))  //"2018-08-24T07:34:14.000Z"
OB SET:C1220($wpPropertiesObj; "docModify"; $wpPropertiesObj.docCreate)  //"2018-08-24T07:34:14.448Z"

OB SET:C1220($wpPropertiesObj; "bodyVersion"; "2.01")
OB SET:C1220($wpPropertiesObj; "bodyUserUnit"; "pt")
OB SET:C1220($wpPropertiesObj; "bodyBgColor"; "#FFFFFF")
OB SET:C1220($wpPropertiesObj; "bodyContent"; "<p class=\"Normal\">"+Char:C90(NBSP ASCII CODE:K15:43)+"</p>")

OB SET:C1220($wpPropertiesObj; "section0"; False:C215)
OB SET:C1220($wpPropertiesObj; "section0PageWidth"; "")  // Leer=Standard oder z.B. "420pt"
OB SET:C1220($wpPropertiesObj; "section0PageHeight"; "")  // Leer=Standard oder z.B. "595pt"
OB SET:C1220($wpPropertiesObj; "section0PageMargin"; "")  // Leer=Standard oder z.B. "2.5cm" oder "0cm" oder "0pt" oder "0px" oder "1cm 2cm 3cm 4cm"(Oben Rechts Unten Links)
OB SET:C1220($wpPropertiesObj; "section0PageOrientation"; "")  // Leer=Standard="portrait", oder "landscape"

OB SET:C1220($wpPropertiesObj; "section1First"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1FirstFooter"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1FirstHeader"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1Footer"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1Header"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1Left"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1LeftFooter"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1LeftHeader"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1Right"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1RightFooter"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1RightHeader"; False:C215)
OB SET:C1220($wpPropertiesObj; "section1FirstFooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section1FirstHeaderContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section1FooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section1HeaderContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section1LeftFooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section1LeftHeaderContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section1RightFooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section1RightHeaderContent"; "<p class=\"Normal\"> </p>")

OB SET:C1220($wpPropertiesObj; "section2First"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2FirstFooter"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2FirstHeader"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2Footer"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2Header"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2Left"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2LeftFooter"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2LeftHeader"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2Right"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2RightFooter"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2RightHeader"; False:C215)
OB SET:C1220($wpPropertiesObj; "section2FirstFooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section2FirstHeaderContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section2FooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section2HeaderContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section2LeftFooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section2LeftHeaderContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section2RightFooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section2RightHeaderContent"; "<p class=\"Normal\"> </p>")

OB SET:C1220($wpPropertiesObj; "section3First"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3FirstFooter"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3FirstHeader"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3Footer"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3Header"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3Left"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3LeftFooter"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3LeftHeader"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3Right"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3RightFooter"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3RightHeader"; False:C215)
OB SET:C1220($wpPropertiesObj; "section3FirstFooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section3FirstHeaderContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section3FooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section3HeaderContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section3LeftFooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section3LeftHeaderContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section3RightFooterContent"; "<p class=\"Normal\"> </p>")
OB SET:C1220($wpPropertiesObj; "section3RightHeaderContent"; "<p class=\"Normal\"> </p>")

$0:=$wpPropertiesObj
