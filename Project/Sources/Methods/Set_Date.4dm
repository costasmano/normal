//%attributes = {}
//GP Set_Date(Month; Day; Year)
//Copyright © 1995-1996, Thomas D. Nee, All Rights Reserved.

C_LONGINT:C283($Month; $Day; $Year)
C_DATE:C307($Date)

$Month:=$1
$Day:=$2
$Year:=$3
$Date:=Date:C102(String:C10($Month)+"/"+String:C10($Day)+"/"+String:C10($Year))
vLastDate:=$Date  //Store it for later use.
$0:=$Date