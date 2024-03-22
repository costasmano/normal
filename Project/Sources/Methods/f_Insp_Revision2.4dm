//%attributes = {"invisible":true}
If (False:C215)
	//f_Insp_Revision2 
	//Check whether a date is after Revision date 2
	
	//$0 : True/ False  
	//$1 : Date
	
	Mods_2005_CM05
	
End if 

C_BOOLEAN:C305($0)
C_DATE:C307($1; $vDateCheck)
$vDateCheck:=$1
$0:=($vDateCheck>=<>InspFormRevDate_2)