//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(11/17/05 15:01:28)
// Modified Method(s) : 
//G_Insp_SaveContinue 
//G_Insp_SaveInspection
//  `Fixed Query statements that were missing the base table to apply the query to.
//ADD_COMBINED_INSPECT
//  `Added Save Record command after assigning -1 to BMSInspID for combined record

// Modified by: costasmanousakis-(Designer)-(11/18/05 12:45:46)
// Modified Method(s) : 
//G_DeleteInspection
//  `Added code to delete related CUs and log the deletion

// Modified Form Methods : 
//[Bridge MHD NBIS];"NBIS Stack Info"
//  `Disable Delete button since it is not usable.

// Created Method(s) : 
//INSP_ExportInspection 
//INSP_ImportInspection
//  `Methods to export to a disk file and import from disk inspections.

// Modified Forms : 
//[Inspections];"AboveWater Template"
//  `Added button to Export inspection to disk file accessible only by Designer
//[Bridge MHD NBIS];"CombinedInspections"
//  `Added button to Import Inspection from a disk file accessible only by Designer.

// Modified by: costasmanousakis-(Designer)-(11/19/05 09:53:39)
// Modified Method(s) : 
//G_WRT_MakeDocument 
//  `Adjusted code that clears 4D Write area; 
//  `Added case for the generic bridge letter setup.
//G_WRT_GenericBridgeLetter 
//  `Use G_WRT_MakeDocument method

// Modified by: costasmanousakis-(Designer)-(11/19/05 17:00:06)
// Created Method(s) : 
//SIA_MountModule
//  `Load subsequent input/list screens from parent [Bridge MHD NBIS];"Bridge Input" form.
// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Changed object methods of all Module buttons on form to use method SIA_MountModule.

// Modified Form Methods : 
//[Bridge MHD NBIS];"ID Input"
//  `Change object colors to editable or not.

// Modified by: costasmanousakis-(Designer)-(11/21/05 16:21:53)
// Modified Method(s) : 
//G_SpellCheckSetup
//  `Added code so that GetItRight license is loaded from a file in the Mac4DX folder,
//  `for an Engined application.

// Modified by: costasmanousakis-(Designer)-(11/22/05 14:28:37)
// Modified Method(s) : 
//P_ReviewInspcts
//  `Added Greg KriKoris as Area engineer.

// Modified Object Methods : 
//[Bridge Design];"Bridge Design In".sItem54h, n,r;tItem55h,n,r
//  `Fixed PushChange calls to [Bridge MHD NBIS] table which was sending stuff to the wrong 'stack'
//  `Fixed code in tItem55n setting the wrong code.

// Modified Forms : 
//[Bridge Design];"Bridge Design Out"
//  `Changed resizing options of objects and background grey bar. 
//[Bridge MHD NBIS];"Bridge Design"
//  `Adjusted size of objects.

// Modified by: costasmanousakis-(Designer)-(11/23/2005 16:49:40)
// Modified Method(s) : 
//Server_GenCondRep
//  `Added Calculation of health indexes.
//HI_CalcBridgeHIFields
//  `Change and save SIA table only if there is a change in HI values.

// Modified by: costasmanousakis-(Designer)-(11/28/2005 09:09:14)
// Modified Method(s) : 
//WKHR_InitVars
//  `Cleared unused variables; Fixed Item_250_T0 to Item_220_T0.

// Modified Forms : 
//[Work_Estimate];"Input"
//  `Cleared unused Variables in pages 3-16.

// Modified Form Methods : 
//[Work_Estimate];"List"
//  `Added variable to display a combination of Assignement/Addendum  number.

// Modified Method(s) : 
//P_ListWorkHours
//  `Added code to check for max width req'rd for Input and output forms.

// Modified Forms : 
//[Contract AddFund];"AddFund In"
//[Contract AddFund];"AddFund Out"
//  `Adjusted Display format for Cost fields to be up to millions.

// Modified Object Methods : 
//[Bridge Design];"Bridge Design In" cboProjectType
//  `Added code to include Bridge Betterment and Preservation projects.

// Modified Forms : 
//[Bridge Design];"Bridge Design In"
//  `Modified Entry list for cboProjectType object to include Betterment and Preservation projects.

// Modified by: costasmanousakis-(Designer)-(11/30/2005 10:36:38)
// Modified Forms : 
//[Work_Estimate];"Input"
//  `Added buttons and fields for Review and approval.

// Modified Form Methods : 
//[Work_Estimate];"Input"
//  `Adjusted code 

// Modified Method(s) : 
//WKHR_SetUpCategPullDwn 
// `Added page for Review / approve comments
//P_ListWorkHours
//  `Increased window height
//WK_ScrollArea
//  `Added code to check for users in groups.
//WKHR_CreateProposal 
//  `Added code to handle Addendums better.

// Modified Object Methods : 
//[Work_Estimate];"Input".WKHR_PagetTitles
//  `Adjusted code to use new page titles.

// Modified Forms : 
//[Work_Estimate];"List"
//  `Added objects for Review and approve - Adjusted sizes.

// Modified Form Methods : 
//[Work_Estimate];"List"
//  `Added code to handle the new objects

// Modified Forms : 
//[Bridge MHD NBIS];"NBIS Stack Info"
//  `Changed button sizes to 48x48 to match icon size; Appearance to automatic

// Modified Method(s) : 
//Startup
//  `Fixed code that checks for user part of External Inspectors or Designers.

// Modified Forms : 
//[Personnel];"Inspectors In"
//  `Added Combo Box to select 4D PW system user

// Modified Form Methods : 
//[Personnel];"Inspectors In"
//  `Added code to load list of 4D users and setup up the combo box.

// Modified by: costasmanousakis-(Designer)-(12/1/2005 12:27:21)
//ControlMenuBar
//  `Adjusted code to check for ExternalDesigners, and rename Work hour Est menu item.

// Modified Object Methods : 
//[Work_Estimate];"Input".bDelete
//  `Added code in object method to confirm deletion.
//[Work_Estimate];"Input".ApprvReject_p
//  `Clean out completed check box.

// Modified Method(s) : 
//WK_ScrollArea
//  `Use new variable WKHR_LockEstimate
//P_ListWorkHours
//  `Use Find in array to look for estimates. Set addendum table to read only.

// Modified Forms : 
//[Work_Estimate];"Print2"
//  `Added the review and approve icon and comments with a naming convention.

// Modified Form Methods : 
//[Work_Estimate];"Print2"
//  `Coded for the additional comment fields and icons
//[Work_Estimate];"Input"
//  `Added variable WKHR_LockEstimate; adjusted locking and unlocking of estimate fields.

// Modified by: costasmanousakis-(Designer)-(12/2/2005 15:07:53)
// Modified Forms : 
//[Work_Estimate];"Print4"
//  `Added PayRates at the top; Modified form method to hide addendum if 0; Moved objects
//  `to give more margins.
//[Work_Estimate];"Print3"
//  `Moved objects to give more margins; Modified form method to hide addendum if 0.

// Modified Method(s) : 
//WKHR_Print 
//  `Print form Print4 first; Skip form Print2.

// Modified Forms : 
//[Work_Estimate];"Config"
//  `Added button SaveDefaultsBtn to save current exclusion list as a default.
// Modified Form Methods : 
//[Work_Estimate];"Config"
//  `Code to hide SaveDefaultsBtn for not BridgeMaintenance users.

// Modified Object Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".projectType
//  `Added entry "Bridge Betterment-Deck Replacement" in obj code and choise list for object.

// Modified Object Methods : 
//[Contract_Maintenance];"Contract Maintenance In".ContrInfoTab
//  `Reverse order of Invoices.

// Modified Object Methods : 
//[Work_Estimate];"Input".bDone
//  `Check if Estimate is complete or not.

// Modified by: costasmanousakis-(Designer)-(12/5/2005 09:49:22)
// Modified Object Methods : 
//[Work_Estimate];"Input".ReadWriteBtn
//  `Enable/Disable ToolBox button also.

// Modified Method(s) : 
//WKHR_ProposalToAssgn 
//  `Made sure table [Contract_Assignment_Maintenance] is in RW mode
// Modified Form Methods : 
//[Work_Estimate];"Input"
//  `On the validate event reset tables [Contract_Assignment_Maintenance] and
//  `[Addendum_Maintenance] to read only after saving;
//  `Also in case of other users just lock everything.

//[Work_Estimate];"Print3"
//  `Adjusted heights and layout.
//[Work_Estimate];"Print4"
//  `Fixed display formats and alignments
//[Work_Estimate];"PrintCmts"
//  `Moved objects and markers to match other print forms.
// Modified Form Methods : 
//[Work_Estimate];"PrintCmts"
//  `Hide addendum no if zero.

// Modified Method(s) : 
//WKHR_Print
//  `Print only sections that have non-zero grand total

// Modified Forms : 
//[Work_Estimate];"Config"
//  `Renamed Save to default button so that the on resize code in the form method
//  ` works properly.
// Modified Form Methods : 
//[Work_Estimate];"Config"
//  `Adjusted code that hides the renamed Save to Defaults button.

// Modified Forms : 
//[Work_Estimate];"LineEntry"
//  `Moved buttons to top- made them non-movable; and added some descriptive labels  `.
// Modified Form Methods : 
//[Work_Estimate];"LineEntry"
//  `Disable entry to fields when WKHR_LockEstimate is true

// Modified Method(s) : 
//WKHR_ZeroAll 
//  `Fixed incorrect reference to $textVar_ptr code.

//PASSWORD Structure:
//  `Added External Designers to ReadWrite group

// Created Method(s) : 
//MENU_ClearMenu

// Modified Method(s) : 
//ControlMenuBar
//  `Use method MENU_ClearMenu to clear unused menus; Disable as needed 
//  `menu items in the special menu for menubar 1

// Modified by: costasmanousakis-(Designer)-(12/5/2005 11:34:42)
// Modified Method(s) : 
//G_Insp_SetTitle
//  `Added a check to avoid getting a double Special member & Special Member in the 
//  `title.
//G_Insp_FormatInpTitle
//  `Decreased reduction to -56 from -57 for the two larger cases (38,28)

// Modified Forms : 
//[Inspections];"FC Pr (Pg 1)"
//  `Moved Inspection title block a bit to the left.

// Modified Forms : 
//[Bridge Design];"View Bridge Design"
//[Cons Inspection];"View Cslt Insp"
//[Conslt Address];"View Conslt Address"
//[Conslt Rating];"View Cslt Rating"
//[Contracts];"Contracts Out"
//[Inspections];"InspectionReview"
//[Town Address];"View Town Address"
//  `Increased size of buttons to match the icon size so that they don't display 'fuzzy'.

//MODIFIED TABLE
//[Cond Units]
//  `Added field [Cond Units]DateModified_d.

// Modified Method(s) : 
//WKHR_InsertRow 
//WKHR_DeleteRow
//  `Force a validate event when adding or deleting a row.

// Modified Form Methods : 
//[Inspections];"FC Pr (Pg 1)"
//  `When checking for inspection type include RT@ and CUL types with CMI.

//Created New Menu bar 8 = Workhours

// Modified Method(s) : 
//P_ListWorkHours
//  `Use menu bar 8 and disable first two items of file menu.

// Modified by: costasmanousakis-(Designer)-(12/6/2005 08:20:07)
// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".ImportBtn
//  `Fixed code that was not hiding button for non-designer.