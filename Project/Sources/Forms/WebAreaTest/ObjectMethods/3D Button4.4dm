C_POINTER:C301($area)
$area:=OBJECT Get pointer:C1124(Object named:K67:5; "web area")

WA OPEN URL:C1020(*; "web area"; "about:blank")
DELAY PROCESS:C323(Current process:C322; 1)
WA SET PAGE CONTENT:C1037(*; "web area"; "<html><body><h1>"+"FILE HAS BEEN DELETED!!"+"</h1></body></html>"; "file:///")
//WA REFRESH CURRENT URL(*;"web area")
