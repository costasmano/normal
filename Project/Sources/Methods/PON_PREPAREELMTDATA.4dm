//%attributes = {"invisible":true,"publishedWeb":true}
// Method: PON_PREPAREELMTDATA
// Description
// load needed records and variables
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name(OS): Costas Manousakis
	// User(4D): Designer
	// Date and time: 12/27/14, 20:37:59
	// ----------------------------------------------------
	// Created :
	Mods_2014_12
End if 
// 
C_TEXT:C284($0; $1)  //These MUST be declared for calls by 4DACTION 

QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Cond Units:45]Inspection ID:2)
QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element ID:1=[Cond Units:45]Element ID:3)
C_TEXT:C284(PON_INSPID2INSPKEY_txt; PON_INSPDATE_txt)
PON_INSPID2INSPKEY_txt:=PON_INSPID2INSPKEY([Cond Units:45]Inspection ID:2)
PON_INSPDATE_txt:=Substring:C12(String:C10([BMS Inspections:44]Insp Date:4; ISO date:K1:8); 1; 10)
//need to make sure quantities add up and check for 99% so migraor works ok
C_REAL:C285($TotQ_r; $qs1_r; $qs2_r; $qs3_r; $qs4_r; $qs5_r)
C_LONGINT:C283($Round_L)
$Round_L:=PON_ExportPrecision_L
$TotQ_r:=Round:C94([Cond Units:45]Total Quantity:5; $Round_L)
If ([Cond Units:45]CondState1:10>=0)
	$qs1_r:=Round:C94([Cond Units:45]CondState1:10; $Round_L)
Else 
	$qs1_r:=0
End if 
If ([Cond Units:45]CondState2:11>=0)
	$qs2_r:=Round:C94([Cond Units:45]CondState2:11; $Round_L)
Else 
	$qs2_r:=0
End if 
If ([Cond Units:45]CondState3:12>=0)
	$qs3_r:=Round:C94([Cond Units:45]CondState3:12; $Round_L)
Else 
	$qs3_r:=0
End if 
If ([Cond Units:45]CondState4:13>=0)
	$qs4_r:=Round:C94([Cond Units:45]CondState4:13; $Round_L)
Else 
	$qs4_r:=0
End if 
If ([Cond Units:45]CondState5:14>=0)
	$qs5_r:=Round:C94([Cond Units:45]CondState5:14; $Round_L)
Else 
	$qs5_r:=0
End if 
Case of 
	: (Round:C94($qs1_r; $Round_L)>0)
		$qs1_r:=Round:C94(($TotQ_r-($qs2_r+$qs3_r+$qs4_r+$qs5_r)); $Round_L)
	: (Round:C94($qs2_r; $Round_L)>0)
		$qs2_r:=Round:C94(($TotQ_r-($qs3_r+$qs4_r+$qs5_r)); $Round_L)
	: (Round:C94($qs3_r; $Round_L)>0)
		$qs3_r:=Round:C94(($TotQ_r-($qs4_r+$qs5_r)); $Round_L)
	: (Round:C94($qs4_r; $Round_L)>0)
		$qs4_r:=Round:C94(($TotQ_r-($qs5_r)); $Round_L)
	: (Round:C94($qs5_r; $Round_L)>0)
		$qs5_r:=Round:C94($TotQ_r; $Round_L)
End case 

[Cond Units:45]Total Quantity:5:=$TotQ_r  //do this to match the template - does not get saved 
PON_elemqt1_txt:=String:C10($qs1_r; "###########0.#########")
PON_elemqt2_txt:=String:C10($qs2_r; "###########0.#########")
PON_elemqt3_txt:=String:C10($qs3_r; "###########0.#########")
PON_elemqt4_txt:=String:C10($qs4_r; "###########0.#########")
PON_elemqt5_txt:=String:C10($qs5_r; "###########0.#########")

//End PON_PREPAREELMTDATA