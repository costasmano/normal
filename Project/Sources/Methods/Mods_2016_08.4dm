//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/11/16, 11:14:33
//----------------------------------------------------
//Method: Mods_2016_08
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_08  // 
	//Modified by: Chuck Miller (8/11/16 11:14:54)
End if 

//**********`Modified by: Costas Manousakis-(Designer)-(8/5/16)
// Modified Method(s) : 
//INSP_PRN_InitVars
//  `add vars for print destination

//Print_Dive_Photos
//  `use method Print_SetPDFDest to change name of output

//PON_PrintNBEs_FM
//  `new way of printing by using print form instead of print selection.

//INSP_PreviewBrM
//  `use NTI_Preview

// Method: INSP_PRINTPontis
//  `use NTI_PrintNTEList 

// Method: INSP_PrintSketchChartSingle
//  `use only set Print option(orientation;1 | 2) to switch portrait or landscape
//  `use method Print_SetPDFDest to change name of output

//PRINT_ROUTINE_F
//  `move check for page break after the INSP_PRINTPontis call
//  `set print opt spooler doc name

//PRINT_Critical
//  `move check for page break after the INSP_PRINTPontis call
//  `if Tunnel inspection print Tunnel SIA
//  `set print opt spooler doc name
//PRINT_CULVERT_F
//  `move check for page break after the INSP_PRINTPontis call
//  `set print opt spooler doc name

// Method: PRINT_FREEZE_F
//Procedure: PRINT_Damage
//Procedure: Print_Dive_F
//  `set print opt spooler doc name

//COMPILER_Utilities
//  `add vars for print destination to pdf

// Created Method(s) : 
//Method: Print_SetPDFDest
//Description
//  `Handle changing the destination
//Method: PRINT_CombinePdfs
//Description
//  `Use PHP to combine pfs files from inspection reports
//Method: Print_initPrintToPDF
//Description
// initialize printing to PDF for Mac

//**********`Modified by: Costas Manousakis-(Designer)-(8/15/16)
// Created Method(s) : 
//Method: Pers_GetNames
//Return the names in a string from a list of Personnel IDs in an array
//Method InitPers must have been executed before- arrays aPeople_ID and aPeople are needed
// Parameters
// $0 : $Names_txt
// $1 : $array_ptr

//Method: QR_InspTmMembers
//Return the names of the inspection team members 
// Parameters
// $0 : $TmMembers_txt
// $1 : $InspID_L (optional)

// Modified Method(s) : 
//Compiler_Methods 
//  `added Pers_GetNames and QR_InspTmMembers

//**********`Modified by: Costas Manousakis-(Designer)-(8/16/16)
// Created Method(s) : 
//Method: NTI_CreateParams
//Description
//  ` Create the XML parameters used in Inspection...

//Method: ut_SaveSysParam
//Description
// Save (create or update) a system parameter in the [Parameters] table
// Parameters
// $1 : $ParamName_txt
// $2 : $Value_txt
// $3 : $DescrOrValue_txt (save value in Descr or in Value field - default "D" ; if not "D" will save in Value field)

//Method: ut_DOM_FindElmtRef
//Description
// find the reference in a DOM tree of an element with a value
// Parameters
// $0 : $elemRef_txt
// $1 : $DomTree_txt
// $2 : $ElementPath_txt
// $3 : $FindElemValue_ptr

//Method: NTI_LoadDOMTrees
//Description
// Load the XML trees needed for NTI inspection review

//Method: NTI_GetInspRequirements
//Description
// get the Requirements for the inspection type
// Parameters
// $1 : $InspType_txt
// $2 : $DBIEReq_ptr
// $3 : $AreaReq_ptr

//Method: NTI_GetReviewGroups
//Description
// Get the PersGroups that can review the inspection based on inspResp
// Parameters
// $1 : $InspResp_txt
// $2 : $DBIEGroups_ptr
// $3 : $AreaEngGroups_ptr

//Method: GRP_UserInGroupList
//Description
// Determine whether the user is a member of a list of groups passed as an text array pointer
// Parameters
// $0 : $Result_L
// $1 : $PersGrps_ptr ptr to string/text array with names of groups in ([Pers_Groups])
// $2 : $PersUserID_i (optional) : ID from [Personnel] table
// Result : L 
//  ` 0 : User not in any group
//  ` N>0 : User in N group(s)
//  ` -1 : Some error

//**********`Modified by: Costas Manousakis-(Designer)-(8/23/16)
// Created Method(s) : 
//Method: ActualDataToAssignmnt
//Description
//Get actual data from pasteboard copied from Excel and update records in Cons insp or Cons rating
// Excel data have 10 columns . total salary to date, total hours to date and direct expense are used.

//BRIDGE          | SALARY MAX | SALARY       | TOTAL SALARY | TOTAL SALARY | HOURS MAX | HOURS         | TOTAL HOURS | TOTAL HOURS | DIRECT
//NUMBER         | ALLOWED     | PREVIOUSLY | THIS PERIOD     | TO DATE           | ALLOWED    | PREVIOUSLY | THIS PERIOD    | TO DATE         | EXPENSE
//         
//B-16-281 3BM $8,260.47      $7,532.06      $0.00               $7,532.06         176.00         161.00             0.00                161.00             8238.97
//B-16-281 3BP $6,427.87       $4,654.40      $0.00               $4,654.40         136.00          95.50              0.00                 95.50              3594.8 
// ----------------------------------------------------

// Modified Menu(s)
//ConsltRtgMenu
//ConsltInspMenu
//Under Utilities menu added 
//  a  Separator Line
//  item "Copy Actual Cost Data From Excel" ;Method Name : "ActualDataToAssignmnt" ;Access "Conslt Rating - ReadWrite"

//**********`Modified by: Costas Manousakis-(Designer)-(8/24/16)
// Modified Forms : 
//[Cons Inspection];"Cslt Insp In"
//  `assigned "Enter" key to the save button - otherwise costs were not saved


//**********`Modified by: Costas Manousakis-(Designer)-(8/29/16)

// Created Method(s) : 
//Method: CU_Print_FM
//Description
// Method for print forms of [Cond Units]; purpose : to allow printing using print form instead of Print SElection
// Parameters
// ----------------------------------------------------

// Modified Form Methods : 
//[Cond Units];"Cond Units Prt 2".
//[Cond Units];"Cond Units Prt".
//  `use new method CU_Print_FM to allow printing using Print Form.

// Modified Method(s) : 
//INSP_PRINTPontis
//  `use NTI_PrintNTEList for [Cond Units] also

// Modified Method(s) : 
//PRINT_CombinePdfs
//  `added message when combining pdfs

//PRINT_TunnelAllItems_F 
//  `set print opt spooler doc name and combine pdfs at the end

//**********`Modified by: Costas Manousakis-(Designer)-(8/30/16)
// Modified Method(s) : 
//NTI_PrintSketchChartSingle
//  `added calls to Print_SetPDFDest and SET PRINT OPTION(Orientation option ; removed G_PrintOptions
//NTI_PrintImages
//  `use method Print_SetPDFDest to change name of output; remove G_PrintOptions
//NTI_PrintInspection
//  `added ability to combine pdfs 

// Modified Method(s) : 
//Method: ActualDataToAssignmnt
//  `added ability to scan and then combine costs from subconsultants into the comments field.

// Modified Forms : 
//[Conslt Rating];"Cslt Rating In "
//  `made sure comments/remarks  fields on pages  2,3 ,4 are set to grow vertical and  have vertical scroll bar - 
//  `also increased vert size 
//[Cons Inspection];"Cslt Insp In"
//  `made remarks/comments fields to resize veritcal - added vertical scroll bar - also Rectangle2 on page 1 to grow vertical



//End Mods_2016_08