//%attributes = {"invisible":true}
If (False:C215)
	//f_Insp_Revision1 
	//Check whether a date is after Revision date 1
	
	//$0 : True/ False  
	//$1 : Date
	
End if 

C_BOOLEAN:C305($0)
C_DATE:C307($1; $vDateCheck)
$vDateCheck:=$1
$0:=($vDateCheck>=<>InspFormRevDate_1)