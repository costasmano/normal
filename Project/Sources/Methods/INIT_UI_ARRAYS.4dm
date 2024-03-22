//%attributes = {"invisible":true}
//GP: INIT_UI_ARRAYS
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.

//Arrays for pop up menus in dialog boxes and layouts for
//user interface

//Months of the year for pop up menus in dialogs
If (False:C215)
	Mods_2016_08  // Make sure sorted 
	//Modified by: Chuck Miller (8/11/16 11:13:59)
End if 
ARRAY TEXT:C222(<>aMonths; 0)  //Command Replaced was o_ARRAY string length was 10
ARRAY INTEGER:C220(<>aMonthI; 0)
ALL RECORDS:C47([Months:26])
ORDER BY:C49([Months:26]; [Months:26]Code:1; >)

SELECTION TO ARRAY:C260([Months:26]Code:1; <>aMonthI)
SELECTION TO ARRAY:C260([Months:26]Description:2; <>aMonths)
REDUCE SELECTION:C351([Months:26]; 0)
