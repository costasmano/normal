//%attributes = {}
//procedure: bInMonth
//if $d in certain month and year then return true
//$1 date in question
//$2 is the month
//$3 is the year

C_BOOLEAN:C305($0; $test)
C_LONGINT:C283($2; $m; $3; $y)  //Command Replaced was o_C_INTEGER
C_DATE:C307($d; $1)

$d:=$1
$m:=$2
$y:=$3

$test:=((Month of:C24($d)=$m) & (Year of:C25($d)=$y))

$0:=$test