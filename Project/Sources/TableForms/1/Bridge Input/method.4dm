If (False:C215)
	//Form Method: [Bridge MHD NBIS];"Bridge Input"
	Mods_2004_CM05
	Mods_2005_CM03
	Mods_2005_CM06
	Mods_2005_CM10
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(4/18/2007 15:42:54)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(1/4/08 12:26:04)
	Mods_2007_CM_5401
	//  `Release the current bridge record
	// Modified by: costasmanousakis-(Designer)-(4/15/08 17:48:15)
	Mods_2008_CM_5403  //Special for MDC users- if not a MDC bridge lock buttons except sia,insp, inv
	// Modified by: costasmanousakis-(Designer)-(4/21/09 20:11:32)
	Mods_2009_04
	//Place WildCard around "MHD BMS External" for new .4Dx extensions 
	//Removed the .comp at the District X BMS.comp string.
	// Modified by: costasmanousakis-(Designer)-(6/5/09 09:47:03)
	Mods_2009_06
	//Call  SCPOA_POABtnCtrl  to setup.. Added Scour POA button in form
	// Modified by: costasmanousakis-(Designer)-(11/10/09 08:46:24)
	Mods_2009_11
	//  `Lock some buttons for DUM and REM bridges
	// Modified by: costasmanousakis-(Designer)-(12/1/09 14:31:38)
	Mods_2009_11
	//fixed the MDC security
	// Modified by: costasmanousakis-(Designer)-(2/16/10 10:32:23)
	Mods_2010_02
	//  `use new method SIA_BridgeInput_FM
	// Modified by: costasmanousakis-(Designer)-(9/15/10 16:27:28)
	Mods_2010_09
	//  `Added 8 poages in preparation of switrching to a one form method with multiple pages
	//  ` instead of launching new forms.
	// Modified by: Costas Manousakis-(Designer)-(5/4/12 15:57:07)
	Mods_2012_05
	//  `Checked the Hide focus rectangle on all listboxes;  Hide headers on the invphoto  LB ; 
	//  `adjusted invphot LB; cleaned form events on Add Buttons
	//  `Deleted the bPontis button
	// Modified by: Costas Manousakis-(Designer)-(5/8/12 09:34:46)
	Mods_2012_05
	//  `Adjusted sizes and locations of various listboxes and labels in several pages for better fit in windows platform
	//  `adjusted header bars, window size
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 11:43:17)
	Mods_2012_12
	//  `Moved ForDesigner@ objects on page 0 20 pix lower to increase size of window so that SIA input form fits better.
	// Modified by: Costas Manousakis-(Designer)-(2/26/14 15:48:33)
	Mods_2014_02
	//  `Added Ratting Request button and page 12 forr rating requests
	// Modified by: Costas Manousakis-(Designer)-(6/6/14 13:22:34)
	Mods_2014_06_bug
	//  `removed dispaly filter on Bridge Name in the  pages.
	// Modified by: Costas Manousakis-(Designer)-(5/31/17 16:22:53)
	Mods_2017_05
	//  `added button to list available scanned rating reports in the rating reports page (4)
	// Modified by: Costas Manousakis-(Designer)-(3/23/18 14:56:47)
	Mods_2018_03
	//  `deleted adding and duplicating inspections in tunnel inspections
	// Modified by: Costas Manousakis-(Designer)-(4/30/18 12:12:59)
	Mods_2018_04_bug
	//  `added back adding and duplicating inspections in tunnel inspections - enable only for BTS up until a date in parameters
	// Modified by: Costas Manousakis-(Designer)-(5/9/18 13:46:04)
	Mods_2018_05
	//  `changes in page 4 Ratings : enabled on display on listbox; changed LB size - rearranged label objects
	// Modified by: Chuck Miller (11/1/18 09:13:41)
	Mods_2018_11
	//  `added buttons on page 8 (inventory photos) to export / import inv photo inspection
	// Modified by: Costas Manousakis-(Designer)-(5/3/19 16:39:48)
	Mods_2019_05
	//  `removed objects used as headers for the Inventory photo LB - enabled visible headers in listbox "InventoryPhotos"
	// Modified by: Costas Manousakis-(Designer)-(6/17/19 16:22:02)
	Mods_2019_06
	//  `Enabled On Resize event on form
	// Modified by: CJMiller-(Designer)-(12/31/19 )
	Mods_2019_12
	//  `Added button and obj method to OpenRatingFolder on page 4 (Rating reports)
	// Modified by: Costas Manousakis-(Designer)-(5/7/2020)
	Mods_2020_05
	//  `made all buttons on page 1 3D buttons bevel ht 30 - will show that they have been clicked
	// Modified by: Costas Manousakis-(Designer)-(2023-10-04 18:38:39)
	Mods_2023_10
	//  `removed Bold attr from all listboxes - was not in v18
End if 
SIA_BridgeInput_FM