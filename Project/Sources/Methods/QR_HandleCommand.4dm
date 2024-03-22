//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/26/07, 09:50:15
	// ----------------------------------------------------
	// Method: QR_HandleCommand
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Copied from : Report_Edtr_HandleCommand
	
	// Installed as a callback method. Gets called whenever a menu item
	//   is selected or toolbar button is clicked.
	
	// Parameters:
	//   $1: Area reference
	//   $2: Selected command
	
	// Created by Dave Batton on Feb 6, 2003
	
	Mods_2007_CM12_5301
End if 

C_LONGINT:C283($area; $command)

$area:=$1
$command:=$2

Case of 
	: ($command=qr cmd new:K14900:18)
		Report_Gen_ClearList(->Report_SortList_i)
		REDRAW WINDOW:C456  //Wasn't redrawing without this.
		QR EXECUTE COMMAND:C791($area; $command)
		QR SET REPORT TABLE:C757(Report_Area_l; Report_DefaultTableNumber_l)
		
	: (($command=qr cmd add column:K14900:45) | ($command=qr cmd insert column:K14900:37))
		ALERT:C41("To add a column, drag it from the list of fields.")
		// Don't allow the user to add or insert columns (access the Formula Editor).
		
	: ($command=qr cmd edit column:K14900:40)
		ALERT:C41("Use the toolbar buttons to edit the style of the column.")
		// Don't allow the user to edit columns (access the Formula Editor).
		
	Else 
		QR EXECUTE COMMAND:C791($area; $command)
End case 

