//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_CreateHistoryRecord
// User name (OS): cjmiller
// Date and time: 10/05/04, 13:04:26
// ----------------------------------------------------
// Description
// This method will actually create the individual record. I seperated this
//out so that when I import from a file, I can do the same thing

//
// Parameters
//15
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2009_12  // r004 CJ Miller`12/29/09, 16:03:49      `Add [Bridge MHD NBIS]LegacyOwner to SD Data
End if 

C_TEXT:C284($1; $Year_txt; $2; $Month_txt; $3; $Bin_txt; $4; $BDept_txt; $5; $Town_txt; $6; $Item8_txt; $7; $Item7_txt; $8; $Item6A_txt; $9; $Item58_txt; $10; $Item59_txt; $11; $Item60_txt; $12; $Item2_txt; $14; $Item21_txt; $15; $Item41_txt; $16; $LegacyOwner_txt)
C_REAL:C285($13; $Aashto_r)
$Year_txt:=$1
$Month_txt:=$2
$Bin_txt:=$3
$BDept_txt:=$4
$Town_txt:=$5
$Item8_txt:=$6
$Item7_txt:=$7
$Item6A_txt:=$8
$Item58_txt:=$9
$Item59_txt:=$10
$Item60_txt:=$11
$Item2_txt:=$12
$Aashto_r:=$13
$Item21_txt:=$14
$Item41_txt:=$15
$LegacyOwner_txt:=$16
CREATE RECORD:C68([SD_History:89])
[SD_History:89]Bin:1:=$Bin_txt
[SD_History:89]SD_Year:2:=$Year_txt
[SD_History:89]SD_Month:3:=$Month_txt
[SD_History:89]BDEPT:4:=$BDept_txt
[SD_History:89]Town Name:5:=$Town_txt
[SD_History:89]Item8:6:=$Item8_txt
[SD_History:89]Item7:7:=$Item7_txt
[SD_History:89]Item6A:8:=$Item6A_txt
[SD_History:89]Item58:9:=$Item58_txt
[SD_History:89]Item59:10:=$Item59_txt
[SD_History:89]Item60:11:=$Item60_txt
[SD_History:89]Item2:12:=$Item2_txt
[SD_History:89]AASHTO:13:=$Aashto_r
[SD_History:89]Item21:14:=$Item21_txt
[SD_History:89]Item41:15:=$Item41_txt
[SD_History:89]SD_PreviousOwner_s:19:=$LegacyOwner_txt
SAVE RECORD:C53([SD_History:89])
UNLOAD RECORD:C212([SD_History:89])

//End SD_CreateHistoryRecord