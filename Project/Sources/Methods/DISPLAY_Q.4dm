//%attributes = {"invisible":true}
//GP DISPLAY_Q
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//This procedure sets up the new (enterable) and old (not enterable)
//quantity variables to be displayed on a layout.

If ([BMS Inspections:44]Metric:14)
	vTotQ:=Round:C94([Cond Units:45]Total Quantity:5; 1)
	vOldQ:=Round:C94(vOldQm; 1)
Else 
	vTotQ:=Round:C94(AnglicizeQ([Cond Units:45]Total Quantity:5; [BMS Elements:47]Units:6); 1)
	vOldQ:=Round:C94(AnglicizeQ(vOldQm; [BMS Elements:47]Units:6); 1)
End if 
