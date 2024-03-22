//%attributes = {"invisible":true}
//Mods_2004_CM03
//7-Sep-2004

//Modified ControlClientProcess and ControlServerProcess to set 
//  `the [ServerProcess] table to readonly.
//Modified Launch_CtrlClientProc to create a process name not starting with $
//  `and not start anything if quiting
//Modified ControlClientProcess to 
//  `a) check for the ◊fQuit variable AFTER the delay
//Added code in On Startup to launch ControlClientProcess for BMSExternal Server
//  `when on client connected to a "@BMS External Server" structure
//Modified M_HandleTrans method to store in the [Preferences] table the
//  `TxUserName from the dialog.

//Modifications made in methods :
//M_SearchDefElement
//  `Enabled printing from the menu...
//CreateRandomSetForDefElement 
//  `Cleaned up code-fixed some errors.
//M_DeficientElementRpt
//  `Use Print Record command instead of Print Form
//  `Cleaned up Print Settings and Page Setup cmds
//Print_DefElement_Cmts 
//  `Cleaned up code 

//New form :
//[ElementsSafety];"Rpt DefElem"
//  `Used in M_DeficientElementRpt

//Modified forms :
//[Dialogs];"Search Def Element"
//  `Set default check boxes to 0
//  `Adjusted location of items.
//[ElementsSafety];"Rpt DefElem Comments2"
//  `Added additional Header info to match Report.

//Added user group "Structure Maintenance" - allowed access to
//  `menu item  Menu bar #2\Records \ "Search by Element Deficiency" to that group