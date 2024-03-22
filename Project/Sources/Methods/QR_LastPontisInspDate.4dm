//%attributes = {"shared":true}
C_DATE:C307($0; $vdLastDate)
RELATE MANY:C262([Bridge MHD NBIS:1])
C_LONGINT:C283($vlNumInsps)
$vlNumInsps:=Records in selection:C76([BMS Inspections:44])
If ($vlNumInsps>0)
	ARRAY DATE:C224($adAllDates; $vlNumInsps)
	SELECTION TO ARRAY:C260([BMS Inspections:44]Insp Date:4; $adAllDates)
	SORT ARRAY:C229($adAllDates; <)
	$0:=$adAllDates{1}
Else 
	$0:=!00-00-00!
End if 