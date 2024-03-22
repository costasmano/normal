//%attributes = {"invisible":true}
//GP BMS_QtyButtnTxt
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Used by layout [Cond Units];"Cond Units In".

If (sbMetric=1)
	OBJECT SET TITLE:C194(rbQ; "Qty ("+[BMS Elements:47]Units:6+")")
Else 
	OBJECT SET TITLE:C194(rbQ; "Qty ("+AnglicizeUnit([BMS Elements:47]Units:6)+")")
End if 