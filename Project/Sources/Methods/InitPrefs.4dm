//%attributes = {"invisible":true}
If (False:C215)
	//procedure: InitPrefs
	//by: Albert Leung
	//created: 10/27/97
	//modified: 3/18/98
	//purpose: read preferences for application  
	
	
	//  `RELEASES - DISTRIBUTIONS
	//2023-10-02 : Version 8.0.3.a beta - 
	//  `  `  `  ` changes described in Mods_2023_10 - test for standalone Windows app
	
	//2023-09-29 : Version 8.0.3 - 
	//  `  `  `  ` changes described in Mods_2023_09
	//  `  `  `  ` minor fixes in OutOfFrequency reports
	//  `  `  `  ` adjustments in LSS_inventory input form for maps and status entry
	
	//2023-06-29 : Version 8.0.2 - 
	//  `  `  `  ` changes described in Mods_2023_LSSNew - Status and Project number fields in [LSS_Inventory]
	//  `  `  `  ` Critical findings search for bridge records
	//  `  `  `  ` Bug fix in the printing of [Standard Photos], multiple LSS_inspections, 
	//  `  `  `  ` selecting email addresses when sending emails from inspection review process.
	//  `  `  `  ` some adjustments to code base on DCA recommendations.
	//  `  `  `  ` For consultant letters from inspections or rating assignments, allow mixing NBI and non-NBI bridges in same assignement.
	//  `  `  `  ` fix bug in finding missing bdepts from current selection.
	//  `  `  `  ` 
	
	//2023-02-28 : Version 8.0.1.a - 
	//  `  `  `  ` Increased size of fields [Cons Inspection]ConContractNo, [Conslt Rating]ContractNoRat to 20 to match [Contracts]ContractNo
	
	//2022-12-02 : Version 8.0.1 - 
	//  `  `  `  ` Allow changing of password on standalone and sending change to server
	//  `  `  `  ` Fix printing of multiple inspection in ancillary structures
	//  `  `  `  ` assign a TL or a TM based on the current user when duplicating inventory photo inspections and set destination correctly
	//  `  `  `  ` Fix problem in "bridge input" form of buttons not resetting correctly
	//  `  `  `  ` When creating comment areas with WritePro set the line height to 99% to fix cut-off areas at bottom of page.
	//  `  `  `  ` Always load the [inspection type] table when building inspection description.
	//  `  `  `  ` Address problems when there are multiple shared volumes mounted on Mac with same name. (ex shareddata)
	//  `  `  `  ` Fix to allow copying from comments area of ElementsSafety when in read-only mode
	//  `  `  `  ` Fix display of Item44 in inspection reports
	//  `  `  `  ` Added tools to the Personnel input form.
	//  `  `  `  ` Added tools to control 4DRequestlogs - accessible from the Administrative tasks menu.
	//  `  `  `  ` Fixed issue when creating archives of Bridge table on server.
	//  `  `  `  ` Fixed issue of Bridge status reports generated on server with incorrect owner
	//  `  `  `  ` Various internal or system display issues.
	
	//2022-06-28 : Version 8.0.0.e - 
	//  `  `  `  ` bug fix in ACTFIX202206
	
	//2022-06-27 : Version 8.0.0.d - 
	//  `  `  `  ` bug fix in ACTFIX202206
	
	//2022-06-17 : Version 8.0.0.c - 
	//  `  `  `  ` Implement dixes to correct missing actlog records that were not downloaded because they were 
	//  `  `  `  ` in a transaction while a download was executed : Ignore the LastRefID downloaded ; execute ACTFIX202206
	//  `  `  `  `     execute ACTFIX202206 on start of download
	//  `  `  `  ` add option to execute a QR to Excel in various places where Quick reports are run.
	//  `  `  `  ` add spellcheck button to the WPToolbar.
	
	
	//2022-05-18 : Version 8.0.0.a - 
	//  `  `  `  ` bug fixes in printing of LSS and bridge inspection comments; Fix in initial display of UW inspection elements.
	
	//2022-04-18 : Version 8.0.0 - converted to v18
	
	//2022-03-24 : Version 7.3.1.i - Fix in NTIED print form
	
	//2022-01-14 : Version 7.3.1.h - 
	//  `  `  `  ` Addition to the Relog form to handle LSS records which have a parent but don't use it in activity log
	//  `  `  `  ` Fix in Duplicate_inspection to copy NBEs only for inspections that need them.
	//  `  `  `  ` other fixes in MODS_2021_12_bug
	
	//2021-12-03 : Version 7.3.1.g - 
	//  `  `  `  ` fixes / adjustments in Pedestrian inspection reports
	//  `  `  `  ` enhancements in ADDUSER_utility; Replaced FO column with FAIR column in Bridge Rank Calculation results
	//  `  `  `  ` fix problem when printing sketches in portrait mode for OSX 10.14 and higher
	
	//2021-10-29 : Version 7.3.1.f - 
	//  `  `  `  ` added searching for TM when reviewing inspection
	//  `  `  `  ` changed labels of Neoplan/Nabi/HA to TBusA/TBusB/TBusC per request for D.Ng 10/29/2021
	
	//2021-10-19 : Version 7.3.1.e - 
	//  `  `  `  ` corrected problem with UT and UT_results inputs where adding a ut_result would not register correctly
	
	//2021-06-15 : Version 7.3.1.d - 
	//  `  `  `  ` corrected problems with transfers from districts where sessions were timing out and processes
	//  `  `  `  ` called Internal Bridge process were left on the Boston server counting as connected users.
	
	//2021-04-26 : Version 7.3.1.c - 
	//  `  `  `  ` 
	
	//2021-04-23 : Version 7.3.1.b - 
	//  `  `  `  ` Fixes in the mounting of volumes when looking for scanned ratings
	//  `  `  `  ` Fixes in the record navigation buttons in standard photos and Elementssafety
	
	//2021-04-22 : Version 7.3.1.a - 
	//  `  `  `  ` enhancements to listboxes, correction to subforms to handle double-click events
	
	//2021-04-21 : Version 7.3.1 - 
	//  `  `  `  ` enhancements to listboxes, correction to subforms to handle double-click events
	
	//2020-07-30 : Version 7.3.0.d - For Boston server
	//  `  `  `  ` see Mods_2020_07_bug
	
	//2020-07-28 : Version 7.3.0.c - For External server, Boston and district servers
	//  `  `  `  ` see Mods_2020_07_bug
	
	//2020-07-21 : Version 7.3.0.b - only for External server and Boston server
	//  `  `  `  ` see Mods_2020_07_bug
	
	//2020-07-20 : Version 7.3.0.a -
	//  `  `  `  ` see Mods_2020_07_bug
	
	//2020-07-17 : Version 7.3.0 -
	//  `  `  `  ` Mods_2020_01_bug, Mods_2020_02_bug , Mods_2020_03_bug
	//  `  `  `  ` Changed Bridge List to a Listbox with a search area.
	
	//2019-12-06 : Version 7.2.1 -
	//  `  `  `  ` Mods_2019_11_bug Mods_2019_11 Mods_2019_12
	//  `  `  `  ` Additions of bridge rating vehicles and new commuter rail rating engine.
	
	//2019-11-12 : Version 7.2.0.h -
	//  `  `  `  ` Mods_2019_11_bug
	//  `  `  `  ` fix bug in retrieval of AE data.
	//  `  `  `  ` Better handling of seaching for scanned reports to make sure share drive is loaded.
	
	//2019-10-30 : Version 7.2.0.g -
	//  `  `  `  ` Mods_2019_11_bug
	//  `  `  `  ` fix the insertion of (Cont'd) labels in bridge inspection comments CallReference #668
	//2019-10-30 : Version 7.2.0.f -
	//  `  `  `  ` Mods_2019_04_bug , Mods_2019_05_bug ,Mods_2019_06_bug ,Mods_2019_07_bug ,Mods_2019_09_bug , Mods_2019_10_bug 
	//  `  `  `  ` Mods_2019_07_bug is only two ut_NewSavemethod, ut_openMethod
	//  `  `  `  ` bug fixes in Search for NBEs, opening Bridge web site
	//  `  `  `  ` change to Request for Rating in Bridge inspection forms CallReference #634
	//  `  `  `  ` adjustments to web areas in the display of NBE/NTE help
	//  `  `  `  ` fixes in the Master list report forms
	//  `  `  `  ` adjust assigning default DBIE in bridge inspection forms CallReference #639
	//  `  `  `  ` change retrieves from SQL servers to use natvie 4D SQL instead of ODBC plugin commands
	//  `  `  `  ` fixes in the BDEPT Input form (new BIN) for more error checks in BDEPT and inspection resp.
	//  `  `  `  ` fix calculation and saving of bridge HI CallReference #660
	//  `  `  `  ` remove Tunnel engineer from TIN inspection forms
	//  `  `  `  ` added checks to the FieldWorkComplete date of inspections - restrict editing after 1st entry CallReference #663
	//  `  `  `  ` fix in 4D Write fields where formatting of last paragraph was not saved CallReference #655
	//  `  `  `  ` fix in 4D Write assembly where element text was not added to end of area but a few chars before CallReference #658
	//  `  `  `  ` added sort by NBI Letter date in the Rating Reports CallReference #662
	//  `  `  `  ` fix inspection date printing and labeling of elements in PED inspection reports CallReference #667
	//2019-04-18 : Version 7.2.0.e -
	//  `  `  `  ` bug fixes usercalls #631 - transfers
	//2019-04-12 : Version 7.2.0.d -
	//  `  `  `  ` bug fixes usercalls #617, #615, #621, #618, #623, #627, #628
	//  `  `  `  ` added jp2 and emf to list of prohibited images
	//  `  `  `  ` method to change .4Dlink file to point to IP address
	//  `  `  `  ` fixes in filter for Item5 (5D) to allow routes like 2A
	//  `  `  `  ` removed Girder and slab rating values from TIN inspections and related areas.
	//2019-02-28 : Version 7.2.0.c -
	//  `  `  `  ` bug fixes usercalls #607, #604
	//  `  `  `  ` Fix in downloading changed resources
	//  `  `  `  ` updates/fixed in combining NBEs and NTEs for submission to FHWA
	//  `  `  `  ` address access to Rail info for insp resp DOTRT bridge records
	//2019-02-01 : Version 7.2.0.b -
	//  `  `  `  ` bug fixes usercalls #596, #593, #595, #598 #600 #601 #602 #603
	//  `  `  `  ` added utilities to fix PON_ELEMENT_ parent-grandparent link issues
	//2019-01-11 : Version 7.2.0.a -
	//  `  `  `  ` bug fixes usercalls #591, #592, #594
	//2018-11-30 : Version 7.2.0 -
	//  `  `  `  ` Add Owner field for Ancillary structures
	//  `  `  `  ` Add SinglePosting for Bridge records - changes in Bridge and Ratings tables
	//  `  `  `  ` Add NBE input for OTHer inspections 
	//  `  `  `  ` Add Damage inspection for Ancillary structures 
	//  `  `  `  ` adjustment in scaling of preview picture in 2nd page of culvert form.
	//  `  `  `  ` bug fix in combining of inspection report comments 
	//  `  `  `  ` include tunnel inspection info in the download of data 
	//  `  `  `  ` Fixes in the export of NBE to xml for FHWA to avoid sending child elements without
	//  `  `  `  ` `  a parent
	//  `  `  `  ` Allow transfer of Resource files
	//  `  `  `  ` other minor bug fixes and enhancements.
	//2018-09-28 : Version 7.1.1.f -
	//  `  `  `  ` bug fix in report on overdue inspection reports 
	//  `  `  `  ` adjustment in scaling of preview picture in 2nd page of culvert form.
	//  `  `  `  ` other minor bug fixes.
	//2018-09-13 : Version 7.1.1.e -
	//  `  `  `  ` bug fixes in input of Tunnel images 
	//  `  `  `  ` other minor bug fixes.
	//2018-09-10 : Version 7.1.1.d -
	//  `  `  `  ` bug fixes in printing of Tunnel inspections and scanning of sequences.
	//  `  `  `  ` other minor bug fixes.
	//2018-07-12 : Version 7.1.1.c -
	//  `  `  `  ` bug fix in [NTI_ELEM_TIN_INSP];"Input".DE Spell Check, FM_SavePhotoInput
	//2018-07-05 : Version 7.1.1.b -
	//  `  `  `  ` bug fix in [Bridge MHD NBIS];"Other Info", INSP_ImportInspection, NTI_SaveandUpdateComments
	//  `  `  `  ` allow two copies of Server_ReportIncompleteInsp
	//2018-06-20 : Version 7.1.1.a -
	//  `  `  `  ` fix in inv photos not opening when in RO mode
	//2018-06-20 : Version 7.1.1 -
	//  `  `  `  ` Fix to remove extra DRC in act log for tables pon_elem_insp, [NTI_ELEM_BIN_INSP], [NTI_ELEM_TIN_INSP]
	//  `  `  `  ` changes in Clone tools to account for cases when remote table does not have all fields.
	//  `  `  `  ` SET DATABASE PARAMETER(49;2) to allow searching by fields in other tables.
	//  `  `  `  ` Various bug fixes
	//  `  `  `  ` Method to notify about brg insp reports not completed on time (60 or 90 days)
	//  `  `  `  ` One fix in Anc photos to not record extra act log entries
	//  `  `  `  ` Check on locked records when downloading data.
	//  `  `  `  ` Additions to the Rating reports table to show status and NBIS letter
	//  `  `  `  ` New bridge status reports according to FHWA CFR 490
	//  `  `  `  ` print multiple inspections in Anc structures from inventory list
	//  `  `  `  ` Added Tunnel ratings and the TIN column in the inventory list and TIN insp review list
	//2018-05-31 : Version 7.1.0.d -
	//  `  `  `  ` bug fix where empty act log records are created in LSS_photos
	//  `  `  `  ` fix with entry of Boat sections in NTI_Tunnelinfo
	//2018-05-09 : Version 7.1.0.c -
	//  `  `  `  ` bug fix in the Add / dupl inspection buttons.
	//  `  `  `  ` bug fix in the loading locked Freeze Thaw elements.
	//2018-05-04 : Version 7.1.0.b -
	//  `  `  `  ` Allow BTS BIN inspections
	//  `  `  `  ` bug fixes in TIN_Inspection comment log
	//  `  `  `  ` bug fix in Calculating clearances in TIN inspections
	//  `  `  `  ` bug fixes printing of tin inspections
	//2018-04-27 : Version 7.1.0.a -
	//  `  `  `  ` bug fixes for v11 only
	//2018-04-18 : Version 7.1.0 -
	//  `  `  `  ` Updates to the NTI inspections : allow only TIN inspections
	//  `  `  `  `   added new elements; element cond rating 1-9; protect. systems;
	//  `  `  `  `   new TIN insp types; added several inspection fields
	//  `  `  `  `   New fields in NTI_TunnelInfo;
	//  `  `  `  ` bug fix in duplicate LSS inventory records
	//  `  `  `  ` bug fixes
	//  `  `  `  ` enhancement in Personell input screen to show groups on page 2
	
	//2018-03-09 : Version 7.0.3.a -
	//  `  `  `  ` released only to Boston server
	//  `  `  `  ` fix in method SFA_getServerFileList
	//2018-03-09 : Version 7.0.3 -
	//  `  `  `  ` released only to Boston server
	//  `  `  `  ` bugfixes in item67 calculations, LSS inventory numbers
	//  `  `  `  ` allow copying rating reports to the shared location.
	//2017-12-01 : Version 7.0.2.a -
	//  `  `  `  ` start debug log for abovewater inspections
	//  `  `  `  ` fixes in import of anc structures to account for UUIDs
	//  `  `  `  ` missing obj method to log deletion of [TIN_Insp_Images]
	//2017-09-27 : Version 7.0.2 -
	//  `  `  `  ` missing parent is ok when downloading from Boston
	//2017-09-18 : Version 7.0.1.a -
	//  `  `  `  ` missing parent is ok when downloading from Boston
	//2017-09-06 : Version 7.0.1 -
	//  `  `  `  ` various bug fixes
	//  `  `  `  ` bug fix in doubleclick on listboxes
	//  `  `  `  ` fix bug on download NRCs : do not save Act log rec when parent not found
	//  `  `  `  ` bug fix in printing NTEs with comments
	//  `  `  `  ` enhancement in search by NBEs
	//  `  `  `  ` add 10 yr rating eval form
	//  `  `  `  ` several designer utilities 
	//  `  `  `  ` methods to get data for BridgeArchiveTable quick reports
	//2017-06-27 : Version 7.0.0.c -
	//  `  `  `  ` various bug fixes
	//2017-06-19 : Version 7.0.0.b -
	//  `  `  `  ` fix for double clicking on some included fomrs in Contracts input form
	//2017-06-19 : Version 7.0.0.a -
	//  `  `  `  ` fix for error in checking for 4dlink file in volume desktop
	//2017-06-16 : Version 7.0.0 -
	//  `  `  `  ` 4D V15 Release
	//2017-04-19 : Version 6.6.4.f -
	//  `  `  `  ` Only Boston and external server release
	//  `  `  `  ` bug fixes : Rail print forms ; incorrect calculation for the initials
	//  `  `  `  ` enhancemements to export of NTIs and adjustments in fixing size of photos
	//2017-03-20 : Version 6.6.4.e -
	//  `  `  `  ` bug fixes ; Fix error in Item70 and NBI data export due to Rating factor codes ;
	//  `  `  `  ` add save/load of serverprocess records
	//  `  `  `  ` modify NBI export to include all records in export file padding missing items to fit
	//  `  `  `  ` added fields for new rail rating load HSP46 - no data input yet
	//  `  `  `  ` FIX 'bug' in picture compression where photos were not being compressed
	//2017-02-06 : Version 6.6.4.d -
	//  `  `  `  ` bug fixes ; Enhance Tunnel NTI inspections to handle agencies instead of just by district
	//2017-01-19 : Version 6.6.4.c -
	//  `  `  `  ` Remove ImageCheck on inspection completion
	//2017-01-17 : Version 6.6.4.b -
	//  `  `  `  ` bug fixes
	//2017-01-16 : Version 6.6.4.a -
	//  `  `  `  ` bug fixes ; save [Preferences] and [serverprocesses] on server shutdown, and reload them on server startup
	//2016-12-29 : Version 6.6.4 -
	//  `  `  `  ` check images for picts when saving inspections - prevent inspection from being complete
	//  `  `  `  ` KML export of bridges ; bug fixes in Rail arch ; fix sorting in UT Results ;
	//  `  `  `  ` Printing of comments in NBE elements
	//2016-12-05 : Version 6.6.3 -
	//  `  `  `  ` minor enhancements in act log output form ; import of fed records 
	//  `  `  `  ` Added check to verify uniqueness in NBE elements
	//  `  `  `  ` added mail utilities to script Outlook on OSX and Windows
	//  `  `  `  ` enabled keyboard shortcuts to navigate between records in elementssafety, photos, NBEs, various records in LSS tables
	//  `  `  `  `  various records in LSS tables, and TIN inspections
	//  `  `  `  ` Update Culvert Items from inspections to SIA (Shape, material, num barrels,...)
	//  `  `  `  ` when sending email notifications (inspections and invoices), if the SMTP email fails, try to script outlook, if that fails show a dialog to copy.
	//  `  `  `  ` added ability to copy data fro excel into negotiated costs for inspections/ratings
	//  `  `  `  ` temp methods to check on photos in District 1 user-server-boston
	//2016-10-25 : Version 6.6.2.a -
	//  `  `  `  ` adjustments in process delays when getting sequences 
	//  `  `  `  ` adress bullets in 4D Write areas.
	//  `  `  `  ` allow preference setting for new mehod of printing 4D Write areas
	//2016-10-17 : Version 6.6.2 -
	//  `  `  `  ` Bug fixes; ability to combine pdfs when printing to pdf from Mac
	//  `  `  `  ` test of new method of printing 4D Write areas (use of ◊pref_New4DWR)
	//  `  `  `  ` adjustment in transfers to avoid duplicate FileIDRes entries
	//  `  `  `  ` added use of hmFree to get and restrict PICT and PDF images
	//2016-09-08 : Version 6.6.1.b - 
	//  `  `  `  ` 
	//2016-09-08 : Version 6.6.1.a - 
	//  `  `  `  ` Bug fixes; add ability to copy data from excel to tunnel cost tables
	//2016-09-06 : Version 6.6.1 - 
	//  `  `  `  ` Added ability to combine pdfs from inspection into one
	//  `  `  `  ` Added ability to copy from Excel data to ConsRating or ConsInspection actual Cost tables
	//  `  `  `  ` Chaage in LSS Labels ; bug fixes
	//2016-08-10 : Version 6.6.0.a - 
	//  `  `  `  ` Bug fixes
	//  `  `  `  `  
	//2016-06-24 : Version 6.6.0 - 
	//  `  `  `  ` National Tunnel Element implementation Mods_2016_NTE
	//  `  `  `  `  
	//2016-05-27 : Version 6.5.1 - 
	//  `  `  `  ` Added Inspection Review form for Ancillary structures.
	//  `  `  `  ` 
	//2016-05-06 : Version 6.5.0.k - 
	//  `  `  `  ` Adjustment in the saving of photos to stop using QT ; 
	//  `  `  `  ` Modification in Rail/TRansit routine print to show Dive ratings; allow editing of DMeter sketch notes
	//  `  `  `  ` adjustments in fixing characters in inspection 4D write areas; 
	//  `  `  `  ` bug fix in verifying PON_NBE quantity
	//  `  `  `  ` Added hmFree plugin and code to check picture types.
	//2016-05-06 : Version 6.5.0.j - 
	//  `  `  `  ` initial Adjustment in the saving of photos to stop using QT ; bug fix in saving LSS photos 
	//2016-04-04 : Version 6.5.0.i - 
	//  `  `  `  ` Fix in SET_ITEM70 method; enhancements in the ut_FixFileIDResTransfers and included methods
	//2016-03-23 : Version 6.5.0.h - 
	//  `  `  `  ` fixes in the PON_ExportFHWANBE method; custom Progress dlog; ut_SetUpBridgeInfoLinkTable method ; LSS_SaveDMorUTPicture method
	//  `  `  `  ` first deployment of the ut_FixFileIDResTransfers tools; 
	//2016-03-14 : Version 6.5.0.g - 
	//  `  `  `  ` utiltiy methods to fix the activitylog / FileIDRes tables
	//  `  `  `  ` minor bug fixes ; 
	//2016-02-03 : Version 6.5.0.f - 
	//  `  `  `  ` minor bug fixes ; utilities to reload  LSS tables from imports from MsAccess dbs.
	//  `  `  `  ` deployed on external and boston servers only
	//2016-02-25 : Version 6.5.0.e - 
	//  `  `  `  ` bug fix in PON verify quantities - correctly initialize damage and child quantities.
	//  `  `  `  ` bug fix in LSS Highway sign inspections with incorrect field being used for section 3.0
	//  `  `  `  ` other minor fixes in Bridge Spec memb ispections, etc.
	//  `  `  `  ` deployed on external and boston servers only
	//2016-02-21 : Version 6.5.0.d - 
	//  `  `  `  ` big fix in LSS custom search
	//  `  `  `  ` enhancements in NBE input form and help ; utility to load new help for NBEs
	//  `  `  `  ` bug fixes in LSS photo sequence management ; 
	//  `  `  `  ` bug fixe in method ut_Use4DChartorSVG to account for unicode too
	//  `  `  `  ` Enhancement in NBE : Damage element (7000) not included in roll up to parent, Q must be in other defects.
	//  `  `  `  ` UI enhancement in NBE input
	//  `  `  `  ` Enhancements /bug fixes in LSS Photo saves ; allow all members of company to edit inspections
	//  `  `  `  ` LSS : Added missing field AdditionalComments from Inspection recordin input forms and print forms.
	//  `  `  `  ` deployed on external and boston servers only
	//2016-01-12 : Version 6.5.0.c - 
	//  `  `  `  ` Bug fixes in check boxes for LSS print forms
	//  `  `  `  ` New Export NBE to FHWA method
	//  `  `  `  ` Bug fixes in saving UT , Dmeter sketches; printing method
	//  `  `  `  ` Adjustments in the retrieve of data from CIS_2000 and AE due to move to TISH
	//  `  `  `  ` deployed on external and boston servers only
	//2016-01-12 : Version 6.5.0.b - 
	//  `  `  `  ` Minor bug fixes/enhancements; Fixes in ALL Forms for move to v14 or v15
	//  `  `  `  `Adjustment in setting the DBIE;   Add Route Siffix to LSS route number
	//  `  `  `  ` Bug fix in DATA TRANSFERS ; Edit most parts of SIN in LSS inventory ; Print multiple UT pages
	//2015-12-08 : Version 6.5.0.a - 
	//  `  `  `  `minor bug fixes in Tunnel inventory ;   
	//2015-12-04 : Version 6.5.0 - 
	//  `  `  `  `Add Tunnel Inventory ; minor bug fixes ; Unicoce mode in v11 failed when executing functions in SQL select statements in methd
	//  `  `  `  `Unicoce mode in v11 failed when executing functions in SQL select statements example : ut_TestServerStructureName
	//2015-12-01 : Version 6.4.1.c - 
	//  `  `  `  `Bug fixes in PON_ELEM_INSP entry and MBTA rail culvert print form   
	//2015-11-06 : Version 6.4.1.b - 
	//  `  `  `  `Bug fixes in compare local vs server NBEs method   
	//2015-11-04 : Version 6.4.1.a - 
	//  `  `  `  `Bug fixes in Download of inspections, relog of NBEs;   
	//  `  `  `  `other minor bug fixes.
	//2015-10-14 : Version 6.4.1 - 
	//  `  `  `  `Bug fixes;  in NBE input, LSS_photo input,
	//  `  `  `  `added drag drop in lss_photos; allow edit of mile point / struct num sequence in lss_inventory
	//  `  `  `  `enhancement in the checking of act log records to be downloaded.
	//2015-07-08 : Version 6.4.0.a - 
	//  `  `  `  `Bug fixes;  New forms Tunnel damage, Tunnel other;
	//2015-06-30 : Version 6.4 - 
	//  `  `  `  `Bug fixes;  New forms Tunnel damage, Tunnel other;
	//2015-02-26 : Version 6.3.3.c - 
	//  `  `  `  `Bug fixes;  New forms Tunnel damage, Tunnel other;
	//  `  `  `  `download also changes to [town address] and [conslt address] tables that come from districts.
	//  `  `  `  `Inspection review process tracking based on system parameter InspFormRevDate_8 ; 
	//  `  `  `  `more updates to SCPOA print and input forms; 
	//  `  `  `  `Start preparation for new NBE elements. 
	//2014-11-14 : Version 6.3.3.b - 
	//  `  `  `  `Minor adjustments in POA forms
	//2014-10-31 : Version 6.3.3.a - 
	//  `  `  `  `Bug fixes;  fixes/updates in maximo transfers; Update to [Town Address];
	//  `  `  `  `new ver of Insp QA form; updates to SCPOA print and input forms; fix for SET_item67 for factor rating
	//2014-08-28 : Version 6.3.3 - 
	//  `  `  `  `Bug fixes; added spec memb to routine tunnel; fixes in maximo transfers
	//  `  `  `  `more fixes in the NRC record transfer; last round of updates to the ScourPOAs
	//2014-06-24 : Version 6.3.2.a - 
	//  `  `  `  `Bug fix in stranfer of NRC with ignore unique key error tables
	//  `  `  `  `Tunnel Inventory photos; Other minor bug fixes
	//2014-06-02 : Version 6.3.2 - 
	//  `  `  `  `Added BridgeRank Calculation system
	//  `  `  `  `Added element rating loads for MBTA Fract critical inspection reports
	//  `  `  `  `Enabled adding / editing secondary records
	//2014-04-09 : Version 6.3.1.c - 
	//  `  `  `  `Bug Fixes
	//2014-03-18 : Version 6.3.1.b - 
	//  `  `  `  `Bug Fixes
	//2014-03-14 : Version 6.3.1.a - 
	//  `  `  `  `Bug Fixes
	//2014-03-12 : Version 6.3.1 - 
	//  `  `  `  `New Freeze thaw inspection form; additional rating fields in railInfo
	//2014-02-20 : Version 6.3.0.d - 
	//  `  `  `  `minor enhancement/bug fixes
	//2013-12-19 : Version 6.3.0.c - 
	//  `  `  `  `minor enhancement/bug fix
	//2013-12-16 : Version 6.3.0.b - 
	//  `  `  `  `bug fixes;
	//2013-11-22 : Version 6.3.0.a - 
	//  `  `  `  `bug fixes;
	//2013-11-07 : Version 6.3.0 - 
	//  `  `  `  `Enhancements to Tunnel inspections, inspection scheduling for tunnels;
	//  `  `  `  `Implemented Preservation module.
	//  `  `  `  `
	//2013-06-11 : Version 6.2.0.a - 
	//  `  `  `  `BUG FIXES
	//2013-05-29 : Version 6.2.0 - 
	//  `  `  `  `Added new set of inspections for Tunnels. 
	//2013-03-19 : Version 6.1.0 - 
	//  `  `  `  `Added new set of inspections for Rail/Transit. 
	//  `  `  `  `Added modified NBISStackInfo form for MBTA users
	//  `  `  `  `Added BridgeLink table to link one to one tables with the bridge table such as RailInfo
	//2013-02-27 : Version 6.0.9.c - 
	//  `  `  `  `Fixes in the ut_ReturnKeyFldandVariable method
	//  `  `  `  `Added new Bridge status reports for SD by deck area
	//  `  `  `  `fix iin fUpforInsp for UW Spec member
	//2013-01-16 : Version 6.0.9.b - 
	//  `  `  `  `[FileIDRes Table] visible
	//2013-01-14 : Version 6.0.9.a - 
	//  `  `  `  `Minor fixes in POA module (forms); 
	//  `  `  `  `Bug fixes in startup routines (table sorting, personnel arrays)
	//  `  `  `  `fix in routine insp page 1 misplaced objects.
	//2012-12-12 : Version 6.0.9 - 
	//  `  `  `  `Bug fixes in POA module; 
	//  `  `  `  `New QR methods;
	//  `  `  `  `Started adding more Rail inspection forms and elements- not enabled yet;
	//  `  `  `  `Several utilities for the structure;
	//  `  `  `  `Start of new method to decide inspection type - not enabled only for designers;
	//  `  `  `  `Bug fix in the inspection schedule for non nbi records
	//  `  `  `  `Minor UI fixes in Inspection forms and Bridge List.
	//2012-08-30 : Version 6.0.8 -  
	//  `  `  `  `Bug fixes in ScourPOA module; BridgeDesign print forms; Adjustement in MHD Bridge Status report
	//2012-07-09 : Version 6.0.7- 
	//  `  `  `  `Fix in methods ut_SQLCheckExternalTransfer that locked the record in [ServerProcesses] . 
	//  `  `  `  `Minor UI fixes/additions ; 
	//2012-06-27 : Version 6.0.6 - 
	//  `  `  `  `Minor fixes in POA forms; Bug fix in the [Personnel] log of new records;
	//  `  `  `  `Added QA form printing for Inspections ; Fix in printing of Pontis to reset page setup;
	//  `  `  `  `Added ProjectInfo Task events; Increased size of print boxes for photo descriptions.
	//2012-05-16 : Version 6.0.5 - 
	//  `  `  `  `Add Flood Damage Inspection ; Adjustments in Lists from the Bridge Input form. 
	//  `  `  `  `Adjustments in POA forms ; Allow local storing of the mail server ; 
	//  `  `  `  `Review comments are no longer cleared at end of Inspection review ; bug fix in Bridge Design input.
	//2012-04-25 : Version 6.0.4a - 
	//  `  `  `  `bug fixes ;
	//2012-04-25 : Version 6.0.4 - 
	//  `  `  `  `bug fixes ; Additions/mods to ScourPOA FVC,
	//2012-03-26 : Version 6.0.3 - 
	//  `  `  `  `bug fixes ; Additions/mods to ScourPOA; Custom clone table additions; SpellCheck all. 
	//2012-03-6 : Version 6.0.2.a - 
	//  `  `  `  `bug fixes in table [LB_QueryTable] and the effect in buttons on the Bridge Input form. 
	//  `  `  `  `Released only as a buld standalone app to the districts
	//2012-03-02 : Version 6.0.2 - 
	//  `  `  `  `bug fixes in Transfers , addition of some listboxes, fixes in logging of pictures, new version of POA.
	//2012-02-14 : Version 6.0.1 - 
	//  `  `  `  `bug fixes in Freeze thaw, RRR, inspection review, etc.
	//2012-02-03 : Version 6.0.0 - 
	//  `  `  `  `release on v11
	//2011-01-26 : Version 5.9.0  
	//  `  `  `  `Mods to mark in Mods_2011_01
	//2010-09-02 : Version 5.7.1.d  
	//  `  `  `  `Only Method Mods_2010_09 in Release Structure file. Incorporates minor changes for MDC user
	//2010-05-28 : Version 5.8.0  
	//  `  `  `  `Mods------
	//2010-04-28 : Version 5.7.1.c  
	//  `  `  `  `Mods_2010_04-5.7.1.c MHD BRIDGES only
	//2010-04-26 : Version 5.7.1.b  
	//  `  `  `  `Mods_2010_04-5.7.1.b  EXTERNAL SERVER ONLY
	//2010-04-05 : Version 5.7.1a   
	//  `  `  `  `Mods_2010_03, Mods_2010_04-571a - Also copied the Releases from the Comments of InitPrefs in the structure to the code of InitPrefs above.
	//2008-06-20 : Version 5.4.3   
	//  `  `  `  `Mods_2008_CM5403
	//2008-02-20 : Version 5.4.2   
	//  `  `  `  `Mods_2007_CM.. to Mods_2008_CM5402
	//2007-06-04 : Version 5.3.0   
	//  `  `  `  `All the way up to Mods_2007_CM10a+Added the Bridge Project module.
	//2007-04-18 : Version 5.2.1   
	//  `  `  `  `Mods_2007_CM07
	//2007-02-14 : Version 5.2.0c   
	//  `  `  `  `Mods_2007_CM06
	//2007-01-29 : Version 5.2.0b   
	//  `  `  `  `Mods_2006_CM05-Mods_2007_CM05a 
	//2007-01-19 : Version 5.2.0   
	//  `  `  `  `Mods_2006_CM04-Mods_2007_CM04 
	//2006-04-04 : Version 5.1.2c 
	//  `  `  `  `Mods_2006_CM03
	//2006-01-09 : Version 5.1.2a 
	//  `  `  `  `Mods_2006_CM02
	//2006-01-04 : Version 5.1.2   
	//  `  `  `  `Mods_2005_CM20,21+Mods_2006_CM01 
	//2005-12-06 : Version 5.1.1   
	//  `  `  `  `Mods_2005_CM19+Mods_2005_VN04 
	//2005-11-15 : Version 5.1.0   
	//  `  `  `  `Mods_2005_CM16-Mods_2005_CM18 +Mods_2005_VN02 -3+Contracts Maintenance Module.
	//2005-08-25 : Version 5.0.10 
	//  `  `  `  `Mods_2005_CM15+Mods_2005_VN01 
	//2005-07-07 : Version 5.0.9 
	//  `  `  `  `Mods_2005_CM14
	//2005-07-01 : Version 5.0.8 
	//  `  `  `  `Mods_2005_CM13
	//2005-06-01 : Version 5.0.7 
	//  `  `  `  `Mods_2005_CM08-12
	//2005-03-23 : Version 5.0  
	//  `  `  `  `Mods_2005_CM03-7
	//2004-10-19 : Version 4.3d. 
	//  `  `  `  `See Mods_2004_CM04-10
	//2004-07-19 : Version 4.3-
	//  `  `  `  `Include tracking of Items 21,22,26,106 with each Inspection.
	//2004-06-30 : Version 4.2c1-
	//  `  `  `  `Fix controlMenubar.
	//2004-06-20 : Version 4.2c-
	//  `  `  `  `Fixed Re-Send method. Added Server process and table  for scheduled execution of methods.
	//2004-06-06 : Version 4.2b-
	//  `  `  `  `Added Special Menu item to re-send activity log entries.
	//2004-05-27 : Version 4.2a-
	//  `  `  `  `Fixes in Closed, Culvert and Routine Inspection forms. Adjustment in Rating Repo
	//2004-05-04 : Version 4.2-
	//  `  `  `  `Changed size of input screens;Fixes in Configuring of Inspections;Fixes in renumbering of images;Enhanced ElementDict table to allow faster sorting of Elements;Fixes in various Inspections forms.
	//2004-04-29 : 
	//  `  `  `  `Changed size of◊sPrefname to 255.
	//2004-02-13 : Version 4.1-
	//  `  `  `  `Multi-page 1s for FC,SpecM, Dam inspections;Combine Routine+Special.
	//2004-01-22 : 
	//  `  `  `  `When connecting with 4D Client use the structure file name to define the na
	//2003-11-13 : Version 4.0b-Fixes in Save and Cont of inspection;Fix in display of pending inspections;Fix in Print_closed method.
	//2003-10-21 : Version 4.0a-Fix problem in copy-pasting sketches in picture fields and then trying to compress them.
	//2003-10-20 : Version 4.0
	//2003-09-02 : Version 3.3f2-more minor bug fixes.
	//2003-08-26 : Version 3.3f1-Fix bug in FM DependencyCheck.
	//2003-08-25 : Version 3.3f-Fixes in Spec memb forms, Damage, Adjustments of buttons in Inspections, Users g
	//2003-07-01 : Version 3.3d-Final† fix on the Item 61 label of UW LowCL pg1.
	//2003-06-30 : Version 3.3c-Adjust Dive Low CL pg1, and saving of Insp Dates for UW inspections to SIA table
	//2003-06-29 : Version 3.3b-+
	//2003-06-26 : Version 3.3a-Fix problem in ADD_inspect method. Some more fixes in Damage and Closed insps.
	//2003-06-23 : Version 3.3-Added Closed and Damage Inspections. Added Group Data transfers. Added Consultan
	//2003-06-03 : Version 3.2b-Fixes.
	//2003-06-03 : Version 3.2a-Allow Item 62 in CMI insps+small bug fixes+add D5.
	//2003-05-27 : Version 3.2-Added inspections FCR, CMI+changed up-downloads.
	//2003-04-23 : Version 3.1f
	//2003-03-28 : Version 3.1e
	//2003-03-24 : Version 3.1d
	//2003-03-11 : Version 3.1c
	//2003-02-13 : Version 3.1b
	//2003-02-10 : Version 3.1a
	//2003-02-05 : Version 3.1
	//2003-01-14 : Version 3.0d4
	//2003-01 : Added Unload Record command.
	//2002-12-31 : Version 3.0d3
	//2002-12-10 : Version 3.0d2
	//2002-12-03 : Version 3.0d1
	//2002-11-26 : Version 3.0d
	//2002-11 : Version 3.0c
	//2002-10 : Version 3.0b
	//2002-08 : Adjusted ZoneInfo to determine the correct 4D version. Changed MHD BMS appl
	//2001-11 : Changed Version to 2.1
	//2001-04-15 : added a line to set ZoneInfo to":4D Server 6.5@*". This to allow the automatic connection using ADSP.  Changed Version to 2.0a fo
	//2001-04-01 : Changed Version to 2.0
	
End if 

If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(3/11/09 12:12:20)
	Mods_2009_03
	//  `For MTA and MDC users logged in with 4D Client to the MHD BMS server set 
	//  `variable ◊Transfer to zero, so that their changes do not go to the district offices.
	// Modified by: costasmanousakis-(Designer)-(4/22/09 10:56:40)
	Mods_2009_04
	//  `Added ".4D@" to the Structure file comparison for the new 2004 type extensions.
	//  `When checking for the Prefs in Client mode extract only the filename of the structure file w/out
	//  ` the extension.
	// Modified by: costasmanousakis-(Designer)-(2/19/10 13:18:07)
	Mods_2010_02
	//  `If district inspection engineers connqect to the boston server
	//  `set to no transfer until the district inspection resp is cleared up
	//Ugrade to v11
	//Modified by: Charles Miller (5/16/11 16:56:19)
	//Ugrade to v11
	//Modified by: Charles Miller (8/19/11 12:22:31)
	// Modified by: Costas Manousakis-(Designer)-(5/14/12 16:01:33)
	Mods_2012_05
	//  `Call ut_setPrefSMTPServer after loading prefs from db or MHDBMSPrefs file
	// Modified by: Costas Manousakis-(Designer)-(4/30/15 12:03:49)
	Mods_2015_04
	//  `added $DatafileKey_s from Prefs to define  ◊KeyMask_s
	// Modified by: Costas Manousakis-(Designer)-(11/30/15 11:18:00)
	Mods_2015_11
	//  `call ut_ControlUserPrefs("INIT") before ut_setPrefSMTPServer
	// Modified by: Costas Manousakis-(Designer)-(11/1/18 16:54:27)
	//  `Removed case where transfer was set to 0 (=Send) when "Inspection Engineers" connect to Boston Server - UserCall Ref = 577
	Mods_NewDownloadCode  //Replace [Preferences]Protocol with [Preferences]LastRefID_L
	//replace [Preferences]zoneinfo with [Preferences]DistrictInformation_s
	//and update code to reflect changes needed
	//Modified by: Chuck Miller (12/27/21 13:37:10)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	// Modified by: Costas Manousakis-(Designer)-(2023-10-03 10:55:44)
	Mods_2023_10
	//  `when Windows in Local mode, the extension is .exe - so the MHD BMS Prefs file is placed next to the .exe
End if 
C_BOOLEAN:C305($LoadFromDocument_b)
$LoadFromDocument_b:=True:C214
C_TEXT:C284(<>sPrefname)  // Command Replaced was o_C_STRING length was 255
If (Application type:C494=4D Remote mode:K5:5)
	$LoadFromDocument_b:=False:C215
	C_TEXT:C284($StructFile_txt)
	C_LONGINT:C283($4Dx_pos_L)
	$StructFile_txt:=Structure file:C489
	$4Dx_pos_L:=Position:C15(".4D"; $StructFile_txt)
	If ($4Dx_pos_L<=0)
	Else 
		$StructFile_txt:=Substring:C12($StructFile_txt; 1; ($4Dx_pos_L-1))
	End if 
	<>sPrefname:=$StructFile_txt+" Prefs"
Else 
	C_TEXT:C284($Path_txt; $Ext_txt)
	$Path_txt:=Structure file:C489
	
	If (Application type:C494#4D Local mode:K5:1)
		
		If (Is Windows:C1573)
			$Ext_txt:=".exe"
		Else 
			$Ext_txt:=".APP"
		End if 
		
	Else 
		$Ext_txt:=".4D"
	End if 
	C_BOOLEAN:C305($Complete_b)
	$Complete_b:=False:C215
	C_LONGINT:C283($pos_l)
	$pos_l:=Position:C15($Ext_txt; $Path_txt)
	If ($pos_l>0)
		Repeat 
			If ($Path_txt[[$pos_l]]=<>PL_DirectorySep_s)
				$Complete_b:=True:C214
			Else 
				$pos_l:=$pos_l-1
			End if 
		Until ($Complete_b)
		$Path_txt:=Substring:C12($Path_txt; 1; $pos_l)
	End if 
	<>sPrefname:=$Path_txt+"MHD BMS Prefs"
	
End if 

C_TEXT:C284(<>Destination; <>Forward; <>DestIP; <>ForwardIP; <>TxUserName)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283(<>Transfer; <>Protocol)
C_BOOLEAN:C305(<>ManualCon; <>ShowPrint; <>LockUserTx; <>AllowTxRx)

C_TIME:C306($tPref_file)
C_TEXT:C284($fname)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($stransfer; $sManualCon; $sShowPrint; $sProtocol; $sLockUserTx; $sAllowTxRx)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($DatafileKey_s)  // Command Replaced was o_C_STRING length was 3

//Read the version number
C_TEXT:C284(<>Version)  // Command Replaced was o_C_STRING length was 80
C_DATE:C307(<>dbDate)
ALL RECORDS:C47([Preferences:57])
FIRST RECORD:C50([Preferences:57])
<>dbDate:=[Preferences:57]dbDate:7
//changing the version will re-set the vsForward variable in The Rail input forms and methods
//method SIA_RRInput_FM and form method [RAILBridgeInfo];"RailRoutineInput". the check is for 5.9.0 so 5.9.0.a is OK
// Release format major.minor.sub[.part] ex: 5.6.0 : no part  ; 5.7.1.c (partial fix = c)
<>Version:="9.0.0 beta 2023-10-11-1"
If (($LoadFromDocument_b))
	$fname:=<>sPrefname
	ON ERR CALL:C155("HandlePrefError")
	$tPref_file:=Open document:C264($fname; ""; Read mode:K24:5)
End if 
If (Ok=1) & ($LoadFromDocument_b)
	//Read the preferences
	ON ERR CALL:C155("")  //go back to the default error call. any error including a code error 
	//will call the error handler
	RECEIVE PACKET:C104($tPref_file; <>Destination; <>sCR)
	RECEIVE PACKET:C104($tPref_file; $stransfer; <>sCR)
	RECEIVE PACKET:C104($tPref_file; <>Forward; <>sCR)
	RECEIVE PACKET:C104($tPref_file; <>ZoneInfo; <>sCR)  //not used kept for compatibility
	RECEIVE PACKET:C104($tPref_file; $sManualCon; <>sCR)
	RECEIVE PACKET:C104($tPref_file; $sShowPrint; <>sCR)
	RECEIVE PACKET:C104($tPref_file; $sProtocol; <>sCR)  //not used kept for compatibility
	RECEIVE PACKET:C104($tPref_file; <>DestIP; <>sCR)
	RECEIVE PACKET:C104($tPref_file; <>ForwardIP; <>sCR)
	RECEIVE PACKET:C104($tPref_file; $sLockUserTx; <>sCR)
	RECEIVE PACKET:C104($tPref_file; <>TxUserName; <>sCR)
	RECEIVE PACKET:C104($tPref_file; $sAllowTxRx; <>sCR)
	RECEIVE PACKET:C104($tPref_file; $DatafileKey_s; <>sCR)
	
	<>Transfer:=Num:C11($stransfer)
	<>ManualCon:=($sManualCon="True")
	<>ShowPrint:=($sShowPrint="True")
	//<>Protocol:=Num($sProtocol)
	<>LockUserTx:=($sLockUserTx="True")
	<>AllowTxRx:=($sAllowTxRx="True")
	<>KeyMask_s:=$DatafileKey_s+"-"+("0"*(19-Length:C16($DatafileKey_s)))  // make sure it is 20 chars long
	CLOSE DOCUMENT:C267($tPref_file)
Else 
	//Use defaults stored in data file
	ON ERR CALL:C155("")
	ALL RECORDS:C47([Preferences:57])
	FIRST RECORD:C50([Preferences:57])
	<>Destination:=[Preferences:57]Destination:1
	<>Transfer:=[Preferences:57]Transfer Type:2
	<>Forward:=[Preferences:57]Forward:3
	//<>ZoneInfo:=[Preferences]ZoneInfo
	<>ManualCon:=[Preferences:57]ManualCon:5
	<>ShowPrint:=[Preferences:57]ShowPrintDialog:6
	//<>Protocol:=[Preferences]Protocol
	<>ForwardIP:=[Preferences:57]ForwardIP:10
	<>DestIP:=[Preferences:57]DestIP:9
	<>LockUserTx:=[Preferences:57]LockUserTx:11
	<>TxUserName:=[Preferences:57]TxUserName:12
	<>AllowTxRx:=[Preferences:57]AllowTxRx:13
	<>KeyMask_s:=[Preferences:57]DataFileKEY_s:14+"-"+("0"*(19-Length:C16([Preferences:57]DataFileKEY_s:14)))  // make sure it is 20 chars long
	
End if 

ut_ControlUserPrefs("INIT")

ut_setPrefSMTPServer  //this also calls ut_ControlUserPrefs ("LOAD")  overrides the  values in [preferences] record

If ((Structure file:C489="MHD BMS.4D@") & (Application type:C494=4D Remote mode:K5:5))
	C_TEXT:C284($currUser_txt)
	$currUser_txt:=Current user:C182
	If ((User in group:C338($currUser_txt; "MTA")) | (User in group:C338($currUser_txt; "MDC")))
		<>Transfer:=0
	End if 
	
	If (False:C215)
		If (User in group:C338($currUser_txt; "Inspection Engineers"))
			<>Transfer:=0  //If district inspection engineers connect to the boston server
			//set to no transfer until the district inspection resp is cleared up
		End if 
		
	End if 
End if 

UNLOAD RECORD:C212([Preferences:57])
REDUCE SELECTION:C351([Preferences:57]; 0)
//Correctly specify the 4D server zone.
C_TEXT:C284($s4Dversion)  // Command Replaced was o_C_STRING length was 48
$s4Dversion:=String:C10(Num:C11(Substring:C12(Application version:C493; 1; 2)))+"."+Substring:C12(Application version:C493; 3; 1)
//◊ZoneInfo:=":4D Server "+$s4Dversion+"@*"