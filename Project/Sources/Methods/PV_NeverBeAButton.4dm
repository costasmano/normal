//%attributes = {"invisible":true}
If (False:C215)
	// Project Method: PV_NeverBeAButton
	
	// Call this method to prevent any future 4D View areas from turning into a button
	//   if the area gets resized.
	
	// Method History:
	//   DB021025 - Created by Dave Batton
	
	// Don't allow an area to become a button, no matter how small it gets.
	// Modified by: root-(Designer)-(10/18/2007 12:17:58)
	Mods_2007_CM12_5302  //copied
End if 
//PV SET PLUGIN PROPERTY (pv button width;0)
//PV SET PLUGIN PROPERTY (pv button height;0)