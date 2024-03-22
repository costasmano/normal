If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/06/09, 16:21:46
	// ----------------------------------------------------
	// Method: Form Method: [ScourPOA];"Input-A"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(12/11/09 13:52:54)
	Mods_2009_12
	//  `Changes/Additions for new version of POA
	// Modified by: costasmanousakis-(Designer)-(8/2/10 16:28:54)
	Mods_2010_08
	//Replaced the second occurance of SCPOA_WatchUW_txt  with SCPOA_InstLoc_txt
	// Modified by: costasmanousakis-(Designer)-(10/13/10 15:21:21)
	Mods_2010_10
	//  `Added Letter labels (a. b. etc) to the sections of the recommended program. Adjusted a few of the
	//  `boxes. 
	// Modified by: costasmanousakis-(Designer)-(1/14/11 14:49:34)
	Mods_2011_01
	//  `Added variable  SCPOA_BrgOpenPendDive_L for the Bridge reopenning plan
	//  `Changed the description of checkboxes in 7.b
	// Modified by: costasmanousakis-(Designer)-(5/24/11 12:31:29)
	Mods_2011_05
	//  `SCPOA V2 modifications
	// Modified by: costasmanousakis-(Designer)-(6/14/11 15:32:48)
	Mods_2011_06
	//  `Added varibales  SCPOA_FVCAttach_L; relabeled and reordered other attachments ; made font 10 bold to fit
	// Modified by: Costas Manousakis-(Designer)-(3/23/12 14:49:31)
	Mods_2012_03
	//  `modified page 0 : removed Scour Eval  info
	//  `modified page 2 : added section 1a and added button View old Eval Summary
	//  `modified page 10 Photos : changed photo listbox, added notes, and button to switch between FVC and inventory list
	// Modified by: Costas Manousakis-(Designer)-(4/19/12 16:29:10)
	Mods_2012_04
	//  `Added pages 17 and 18 for field verif card info.
	//  `adjusted / fixed some other pages for better consistancy in screen location
	// Modified by: Costas Manousakis-(Designer)-(5/10/12 10:12:13)
	Mods_2012_05
	//  `Adjusted size of object on field verif page 1 - general
	// Modified by: Costas Manousakis-(Designer)-(2/7/13 10:10:34)
	Mods_2013_02
	//  `Changed NOAA label from "Stage (WSE) at Gage" to "Storm Surge at Gage"
	// Modified by: Costas Manousakis-(Designer)-(3/7/14 11:59:37)
	Mods_2014_03
	//  `added  buttons with obj name SCPOA_OpenNWSURL_L to open 
	// Modified by: Costas Manousakis-(Designer)-(6/20/14 11:13:19)
	Mods_2014_06_bug
	//  `Fixed label page 10 - "First 6 photos"
	// Modified by: Costas Manousakis-(Designer)-(8/21/14 10:11:54)
	Mods_2014_08
	//  `General POA modifications Aug 2014
	// Modified by: Costas Manousakis-(Designer)-(10/6/14 16:04:52)
	Mods_2014_10_bug
	//  `General POA modifications Oct 2014
	// Modified by: Costas Manousakis-(Designer)-(10/23/14 17:28:36)
	Mods_2014_10
	//  `General POA modifications Oct 2014
	// Modified by: Costas Manousakis-(Designer)-(1/13/15 15:52:23)
	Mods_2015_01
	//  `cleanup 
	// Modified by: Costas Manousakis-(Designer)-(2/12/15 14:47:02)
	Mods_2015_02
	//  ` added  textEdit button for  SCPOA_Contacts_txt which calls new method  SCPOA_TextVarWDefault_OM
	// Modified by: Costas Manousakis-(Designer)-(3/4/15 16:45:19)
	Mods_2015_03_bug
	//  `removed display format of SCPOA_LowChordDistFt_r to avoid confusion
	//  `removed the last text and variables in section 2d, replaced with a two line static text
	// Modified by: Costas Manousakis-(Designer)-(3/19/15 12:25:38)
	Mods_2015_03_bug
	//  ` Added "tool" buttons to clear both checkboxes for the Implemented part in the summary of section 2
	// Modified by: Costas Manousakis-(Designer)-(4/10/15 14:38:28)
	Mods_2015_04_bug
	//  `In Secion 6B (page 3) placed 'hidden' buttons above Monitorin and  Fixed Mon dev checkboxes
	//  `made text plain to disitnghuish from editable
	//  `uncover Install Crit WSE marker checkbox - it is not linked to anything else anymore
	// Modified by: Costas Manousakis-(Designer)-(11/29/18 16:43:33)
	Mods_2018_11
	//  `removed the variable name from all buttons that open URLs and made sure the obj 
	//  `name is not SCPOA@ - does not disable them for read only users
End if 
SCPOA_InpFormMethod_A