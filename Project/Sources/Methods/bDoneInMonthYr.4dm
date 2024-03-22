//%attributes = {}
//procedure: bDoneInMonthYr
//by: Albert Leung
//created: 10/24/97
//purpose: see if a bridge was inspected in a certain month and year, 
//not including dive

C_LONGINT:C283($1; $2; $y; $m)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($test; $0)

$m:=$1
$y:=$2
$test:=(bInMonth([Bridge MHD NBIS:1]Item90:161; $m; $y) | bInMonth([Bridge MHD NBIS:1]Item93A:169; $m; $y))
$test:=(($test) | bInMonth([Bridge MHD NBIS:1]OtherIDate:41; $m; $y) | bInMonth([Bridge MHD NBIS:1]ClosedIDate:44; $m; $y))
$test:=(($test) | bInMonth([Bridge MHD NBIS:1]Item93A:169; $m; $y) | bInMonth([Bridge MHD NBIS:1]Item93C:171; $m; $y))
$0:=$test