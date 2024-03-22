//%attributes = {"shared":true}
//Number of Pontis Insp after a year
C_LONGINT:C283($0; $viRes; $1; $viYear)  //Command Replaced was o_C_INTEGER
C_DATE:C307($vdLastDay)
$viYear:=$1
$vdLastDay:=Date:C102("12/31/"+String:C10($viYear))

SET QUERY DESTINATION:C396(Into variable:K19:4; $viRes)
RELATE MANY:C262([Bridge MHD NBIS:1])
QUERY SELECTION:C341([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4>$vdLastDay)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$viRes