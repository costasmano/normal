//%attributes = {"invisible":true}
//Method: PON_NBEDateOn_b
//Description
// decide whether a date is effective for NBE inspections;
// For Rail, Tunnel, Ped inspections is always false
// Parameters
// $0: $NBEOn_b
// $1 :$TestDate_d
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/26/15, 16:57:19
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
End if 
//
C_BOOLEAN:C305($0)
C_DATE:C307($1)

C_BOOLEAN:C305($NBEOn_b)
C_DATE:C307($TestDate_d)

$TestDate_d:=$1
PON_INIT  //call this just in case

$NBEOn_b:=($TestDate_d>=<>PON_NBEStartDate_d)
If (([Inspections:27]Insp Type:6="RR@") | ([Inspections:27]Insp Type:6="T@") | ([Inspections:27]Insp Type:6="PED"))
	$NBEOn_b:=False:C215
Else 
	
End if 

$0:=$NBEOn_b
//End PON_NBEDateOn_b