//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_FixData
// User name (OS): cjmiller
// Date and time: 10/12/04, 14:04:33
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2005_CM12
End if 


If (Length:C16([SD_History:89]Bin:1)#3)
	[SD_History:89]Bin:1:=Substring:C12([SD_History:89]Item8:6; 7; 3)
End if 
[SD_History:89]SD_Owner_s:17:=Substring:C12([SD_History:89]Item8:6; 10; 3)
If ([SD_History:89]Item2:12="") | ([SD_History:89]Item21:14="")
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[SD_History:89]Bin:1)
	[SD_History:89]Item2:12:=[Bridge MHD NBIS:1]Item2:60
	[SD_History:89]Item21:14:=[Bridge MHD NBIS:1]Item21:127
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
End if 

//make sure all strings don't have trailing blanks
[SD_History:89]Item2:12:=Replace string:C233([SD_History:89]Item2:12; " "; "")
[SD_History:89]Item21:14:=Replace string:C233([SD_History:89]Item21:14; " "; "")
[SD_History:89]Item41:15:=Replace string:C233([SD_History:89]Item41:15; " "; "")
[SD_History:89]Item58:9:=Replace string:C233([SD_History:89]Item58:9; " "; "")
[SD_History:89]Item59:10:=Replace string:C233([SD_History:89]Item59:10; " "; "")
[SD_History:89]Item60:11:=Replace string:C233([SD_History:89]Item60:11; " "; "")
[SD_History:89]Item6A:8:=f_TrimStr([SD_History:89]Item6A:8; True:C214; True:C214)
[SD_History:89]Item7:7:=f_TrimStr([SD_History:89]Item7:7; True:C214; True:C214)
[SD_History:89]Town Name:5:=f_TrimStr([SD_History:89]Town Name:5; True:C214; True:C214)

//End SD_FixData