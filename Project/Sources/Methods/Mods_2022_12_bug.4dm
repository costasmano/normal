//%attributes = {"invisible":true}
//Method: Mods_2022_12_bug
//Description
If (False:C215)
	
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2022-12-09)

// ut_RunScript
//  `convert to use File object
// OpenWordDoc
//  `fix first line in windows script - add .save after changing font size
//  ` add save after changing font size in windows and Mac

//**********`Modified by: Costas Manousakis-(Designer)-(2022-12-13)
// ut_ReturnBackupInfo
//  `fixed getting volume attributes for windows
//  `modified/added info to the return message
//  `added information from backuphistroy.json file in the backup folder

//**********`Modified by: Costas Manousakis-(Designer)-(2022-12-14)
// M_ChgPassword
//  `allow users in Design access group access to the password system
//  `Re enable old way of changing password.

// G_PickFromList
//  `added optional pointer parameter $3

// [RatingRequests];"Output"
//  `Fixed help tip for show All button to display show all pending.
//  `adjusted widths of buttons.

// SRV_RetrieveLogFromServer
//  `modified to accept an object as the 1st parameter to indicate whether retrieving files based on a pattern
//  `or from a collection of file objects
// SRV_SaveziplogfileToLocal
//  `allow to select the files to be zipped from the list available
// SRV_DisplayFilesinLogsonServer
//  `allow retrieving the list of files selected
// [Dialogs];"BigAlert"
//  `use .messageDisplay of the Form object for the message if it is defined.
// [Dialogs];"SelectFromList"
//  `allow multiple selections from the hlist
//  `If the index array pointer has been passsed in the Form object, fill it with the indexes of all selected items

//**********`Modified by: Costas Manousakis-(Designer)-(2022-12-23)
// "ChangePassword"
//  `moved away the administrator pw field. added a ? button to display help message about the pw rules
// FN_SetPassword
//  `adjust location of debug text file 
//  `accept in blob a dbg boolean to save debug text, return debug text in the return blob.

//**********`Modified by: Costas Manousakis-(Designer)-(2022-12-27)
// P_ListConsAddress
//  `change write access from "Bridge Insp engineer" 4D group to CSLTAddressManage Personnel group

// [PERS_Groups];"PG_Output_LB"
//  `deleted hidden button cmd-d (duplicate record) - code moved to add button.
//  `changed help message on add button
// [PERS_Groups];"PG_Output_LB".bDelete
//  `fixed deletion to check for locked records
//  `display the list as is (same sort) with the deleted records removed
// [PERS_Groups];"Input"
//  `added missing code when duplicating a group
// [PERS_Groups];"PG_Output_LB".bAdd
//  `fixed resizing of window after adding 
//  `add the new record to current selection to the bottom and scroll to it after adding
//  `moved code from duplicating group hidden button here- accessible if shift is down

//**********`Modified by: Costas Manousakis-(Designer)-(2022-12-28)
// ModSelSort
//  `use Dialog if output form ends in _LB
// [BridgeMHDNBISArchive];"Output_LB"
//  `fixed buttons; listbox configurations; added option in Quick report button to run quick report to excel.
// [zSpecialReports];"Input"
//  `allowed all other fields to grow horizontal.

//End Mods_2022_12_bug   