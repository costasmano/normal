//%attributes = {"invisible":true}
// Method: ut_setIndexes
// Description
//  ` Set the indexed fields on all tables in the datbase 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 12/07/12, 11:58:56
	// ----------------------------------------------------
	// First Release
	Mods_2012_12
End if 
//Method ut_setIndexes 
//
// Bridge MHD NBIS
// 1 BDEPTIndexed Alpha 6
SET INDEX:C344([Bridge MHD NBIS:1]BDEPT:1; True:C214)
// 3 BINUnique Indexed Alpha 3
SET INDEX:C344([Bridge MHD NBIS:1]BIN:3; True:C214)
// 4 FHWA SelectIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]FHWA Select:4; True:C214)
// 5 AASHTOIndexed Real 0
SET INDEX:C344([Bridge MHD NBIS:1]AASHTO:5; True:C214)
// 10 Posting3AxleIndexed Integer 0
SET INDEX:C344([Bridge MHD NBIS:1]Posting3Axle:10; True:C214)
// 41 OtherIDateIndexed Date 0
SET INDEX:C344([Bridge MHD NBIS:1]OtherIDate:41; True:C214)
// 42 OtherInspIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]OtherInsp:42; True:C214)
// 43 OtherIFreqIndexed Integer 0
SET INDEX:C344([Bridge MHD NBIS:1]OtherIFreq:43; True:C214)
// 44 ClosedIDateIndexed Date 0
SET INDEX:C344([Bridge MHD NBIS:1]ClosedIDate:44; True:C214)
// 45 ClosedInspIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]ClosedInsp:45; True:C214)
// 46 ClosedIFreqIndexed Integer 0
SET INDEX:C344([Bridge MHD NBIS:1]ClosedIFreq:46; True:C214)
// 47 DamageInspIndexed Date 0
SET INDEX:C344([Bridge MHD NBIS:1]DamageInsp:47; True:C214)
// 48 InspWaiverIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]InspWaiver:48; True:C214)
// 63 Item6AIndexed Alpha 24
SET INDEX:C344([Bridge MHD NBIS:1]Item6A:63; True:C214)
// 65 Item7Indexed Alpha 18
SET INDEX:C344([Bridge MHD NBIS:1]Item7:65; True:C214)
// 103 StructDefIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]StructDef:103; True:C214)
// 106 FunctObsIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]FunctObs:106; True:C214)
// 138 OnSystemIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]OnSystem:138; True:C214)
// 161 Item90Indexed Date 0
SET INDEX:C344([Bridge MHD NBIS:1]Item90:161; True:C214)
// 162 Item91Indexed Integer 0
SET INDEX:C344([Bridge MHD NBIS:1]Item91:162; True:C214)
// 163 Item92AAIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]Item92AA:163; True:C214)
// 164 Item92ABIndexed Integer 0
SET INDEX:C344([Bridge MHD NBIS:1]Item92AB:164; True:C214)
// 165 Item92BAIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]Item92BA:165; True:C214)
// 166 Item92BBIndexed Integer 0
SET INDEX:C344([Bridge MHD NBIS:1]Item92BB:166; True:C214)
// 167 Item92CAIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]Item92CA:167; True:C214)
// 168 Item92CBIndexed Integer 0
SET INDEX:C344([Bridge MHD NBIS:1]Item92CB:168; True:C214)
// 169 Item93AIndexed Date 0
SET INDEX:C344([Bridge MHD NBIS:1]Item93A:169; True:C214)
// 170 Item93BIndexed Date 0
SET INDEX:C344([Bridge MHD NBIS:1]Item93B:170; True:C214)
// 171 Item93CIndexed Date 0
SET INDEX:C344([Bridge MHD NBIS:1]Item93C:171; True:C214)
// 173 InspRespIndexed Alpha 5
SET INDEX:C344([Bridge MHD NBIS:1]InspResp:173; True:C214)
// 174 FHWARecordIndexed Boolean 0
SET INDEX:C344([Bridge MHD NBIS:1]FHWARecord:174; True:C214)
// 206 Item8Unique Indexed Alpha 15
SET INDEX:C344([Bridge MHD NBIS:1]Item8:206; True:C214)
// 207 Item8 BridgeCatIndexed Alpha 3
SET INDEX:C344([Bridge MHD NBIS:1]Item8 BridgeCat:207; True:C214)
// 208 Item8 OwnerIndexed Alpha 3
SET INDEX:C344([Bridge MHD NBIS:1]Item8 Owner:208; True:C214)

// Town Data
// 1 Town NameUnique Indexed Alpha 20
SET INDEX:C344([Town Data:2]Town Name:1; True:C214)
// 2 BDEPT PrefixUnique Indexed Alpha 3
SET INDEX:C344([Town Data:2]BDEPT Prefix:2; True:C214)

// NBIS Secondary
// 1 BINIndexed Alpha 3
SET INDEX:C344([NBIS Secondary:3]BIN:1; True:C214)
// 34 Bridge KeyIndexed Alpha 12
SET INDEX:C344([NBIS Secondary:3]Bridge Key:34; True:C214)
// 38 Item8Indexed Alpha 15
SET INDEX:C344([NBIS Secondary:3]Item8:38; True:C214)
// 39 NBISSecondaryKey_lUnique Indexed Long Integer 0
SET INDEX:C344([NBIS Secondary:3]NBISSecondaryKey_l:39; True:C214)

// MaintOwnerCode

// FunctionalClass

// Design Load

// Posting Code

// Service Over

// Service Under

// Material

// Design

// Truck Code

// Direction

// Deck Structure

// Wearing Surface

// Membrane

// Deck Protection

// Type of Work

// Work Done By

// Insp Resp

// Dialogs

// Item 20 Tolls

// Item 33 Median

// Item 38

// HistSig

// Months

// Inspections
// 1 BINIndexed Alpha 3
SET INDEX:C344([Inspections:27]BIN:1; True:C214)
// 2 InspIDUnique Indexed Long Integer 0
SET INDEX:C344([Inspections:27]InspID:2; True:C214)
// 3 DBrInspEngrIndexed Integer 0
SET INDEX:C344([Inspections:27]DBrInspEngr:3; True:C214)
// 4 TeamLeaderIndexed Integer 0
SET INDEX:C344([Inspections:27]TeamLeader:4; True:C214)
// 6 Insp TypeIndexed Alpha 3
SET INDEX:C344([Inspections:27]Insp Type:6; True:C214)
// 12 InspReviewedIndexed Integer 0
SET INDEX:C344([Inspections:27]InspReviewed:12; True:C214)
// 78 Insp DateIndexed Date 0
SET INDEX:C344([Inspections:27]Insp Date:78; True:C214)
// 134 Modified ByIndexed Alpha 40
SET INDEX:C344([Inspections:27]Modified By:134; True:C214)
// 167 InspApprovedIndexed Integer 0
SET INDEX:C344([Inspections:27]InspApproved:167; True:C214)

// Sequences
// 1 NameUnique Indexed Alpha 40
SET INDEX:C344([Sequences:28]Name:1; True:C214)

// ElementsSafety
// 1 ElementNoIndexed Integer 0
SET INDEX:C344([ElementsSafety:29]ElementNo:1; True:C214)
// 2 RatingIndexed Alpha 2
SET INDEX:C344([ElementsSafety:29]Rating:2; True:C214)
// 4 InspIDIndexed Long Integer 0
SET INDEX:C344([ElementsSafety:29]InspID:4; True:C214)
// 7 ElmSafetyIDUnique Indexed Long Integer 0
SET INDEX:C344([ElementsSafety:29]ElmSafetyID:7; True:C214)
// 8 SpecMemb FlagIndexed Boolean 0
SET INDEX:C344([ElementsSafety:29]SpecMemb Flag:8; True:C214)
// 9 CrackIndexed Boolean 0
SET INDEX:C344([ElementsSafety:29]Crack:9; True:C214)

// ElementDict
// 1 ElementNoUnique Indexed Integer 0
SET INDEX:C344([ElementDict:30]ElementNo:1; True:C214)
// 3 CategoryIndexed Alpha 3
SET INDEX:C344([ElementDict:30]Category:3; True:C214)
// 13 FullLabelIndexed Alpha 10
SET INDEX:C344([ElementDict:30]FullLabel:13; True:C214)
// 14 FullLabelArchIndexed Alpha 10
SET INDEX:C344([ElementDict:30]FullLabelArch:14; True:C214)

// Inspection Type
// 1 CodeUnique Indexed Alpha 3
SET INDEX:C344([Inspection Type:31]Code:1; True:C214)

// Element Cat
// 1 CodeUnique Indexed Alpha 3
SET INDEX:C344([Element Cat:32]Code:1; True:C214)

// Item 100

// Item 101

// Item 111

// Standard Photos
// 1 InspIDIndexed Long Integer 0
SET INDEX:C344([Standard Photos:36]InspID:1; True:C214)
// 5 PictTypeIndexed Alpha 2
SET INDEX:C344([Standard Photos:36]PictType:5; True:C214)
// 6 SeqNumIndexed Integer 0
SET INDEX:C344([Standard Photos:36]SeqNum:6; True:C214)
// 7 StdPhotoIDUnique Indexed Long Integer 0
SET INDEX:C344([Standard Photos:36]StdPhotoID:7; True:C214)

// RAILBridgeInfo
// 1 BINUnique Indexed Alpha 3
SET INDEX:C344([RAILBridgeInfo:37]BIN:1; True:C214)

// Foundation Type
// 1 CodeIndexed Alpha 2
SET INDEX:C344([Foundation Type:38]Code:1; True:C214)

// Bed Material

// Pontis_Metric_Data
// 1 PM_UNiqueKey_sIndexed Alpha 15
SET INDEX:C344([Pontis_Metric_Data:40]PM_UNiqueKey_s:1; True:C214)

// Pontis_Metrics
// 1 PM_RunKey_lIndexed Long Integer 0
SET INDEX:C344([Pontis_Metrics:41]PM_RunKey_l:1; True:C214)
// 2 PM_UniqueKey_sUnique Indexed Alpha 15
SET INDEX:C344([Pontis_Metrics:41]PM_UniqueKey_s:2; True:C214)
// 4 PM_ImportDate_dIndexed Date 0
SET INDEX:C344([Pontis_Metrics:41]PM_ImportDate_d:4; True:C214)

// Personnel
// 1 Person IDUnique Indexed Integer 0
SET INDEX:C344([Personnel:42]Person ID:1; True:C214)
// 3 First NameIndexed Alpha 20
SET INDEX:C344([Personnel:42]First Name:3; True:C214)
// 4 Middle NameIndexed Alpha 20
SET INDEX:C344([Personnel:42]Middle Name:4; True:C214)
// 5 Last NameIndexed Alpha 24
SET INDEX:C344([Personnel:42]Last Name:5; True:C214)
// 7 Division NoIndexed Alpha 4
SET INDEX:C344([Personnel:42]Division No:7; True:C214)
// 8 Job CodeIndexed Integer 0
SET INDEX:C344([Personnel:42]Job Code:8; True:C214)
// 9 EmployerIndexed Alpha 80
SET INDEX:C344([Personnel:42]Employer:9; True:C214)
// 10 DiveTeamIndexed Boolean 0
SET INDEX:C344([Personnel:42]DiveTeam:10; True:C214)
// 11 ActiveIndexed Boolean 0
SET INDEX:C344([Personnel:42]Active:11; True:C214)
// 12 UserID_4DIndexed Long Integer 0
SET INDEX:C344([Personnel:42]UserID_4D:12; True:C214)

// Field Trip
// 1 InspIDIndexed Long Integer 0
SET INDEX:C344([Field Trip:43]InspID:1; True:C214)
// 2 Person IDIndexed Integer 0
SET INDEX:C344([Field Trip:43]Person ID:2; True:C214)

// BMS Inspections
// 1 Inspection IDUnique Indexed Long Integer 0
SET INDEX:C344([BMS Inspections:44]Inspection ID:1; True:C214)
// 2 BINIndexed Alpha 3
SET INDEX:C344([BMS Inspections:44]BIN:2; True:C214)
// 4 Insp DateIndexed Date 0
SET INDEX:C344([BMS Inspections:44]Insp Date:4; True:C214)
// 5 DBrInspEngrIndexed Integer 0
SET INDEX:C344([BMS Inspections:44]DBrInspEngr:5; True:C214)
// 6 TeamLeaderIndexed Integer 0
SET INDEX:C344([BMS Inspections:44]TeamLeader:6; True:C214)

// Cond Units
// 1 Cond Unit IDUnique Indexed Long Integer 0
SET INDEX:C344([Cond Units:45]Cond Unit ID:1; True:C214)
// 2 Inspection IDIndexed Long Integer 0
SET INDEX:C344([Cond Units:45]Inspection ID:2; True:C214)
// 3 Element IDIndexed Integer 0
SET INDEX:C344([Cond Units:45]Element ID:3; True:C214)
// 4 EnvironmentIndexed Integer 0
SET INDEX:C344([Cond Units:45]Environment:4; True:C214)

// Cond State Insp
// 2 Cond Unit IDIndexed Long Integer 0
SET INDEX:C344([Cond State Insp:46]Cond Unit ID:2; True:C214)

// BMS Elements
// 1 Element IDUnique Indexed Integer 0
SET INDEX:C344([BMS Elements:47]Element ID:1; True:C214)
// 2 Element NoUnique Indexed Integer 0
SET INDEX:C344([BMS Elements:47]Element No:2; True:C214)
// 7 Common Note IDIndexed Integer 0
SET INDEX:C344([BMS Elements:47]Common Note ID:7; True:C214)
// 8 Category IDIndexed Integer 0
SET INDEX:C344([BMS Elements:47]Category ID:8; True:C214)

// Environments
// 1 Envir NoUnique Indexed Integer 0
SET INDEX:C344([Environments:48]Envir No:1; True:C214)

// BMS Categories
// 1 Category IDUnique Indexed Integer 0
SET INDEX:C344([BMS Categories:49]Category ID:1; True:C214)

// Element Costs
// 1 Element IDIndexed Integer 0
SET INDEX:C344([Element Costs:50]Element ID:1; True:C214)
// 3 Action NoIndexed Alpha 2
SET INDEX:C344([Element Costs:50]Action No:3; True:C214)
// 5 EnvironmentIndexed Integer 0
SET INDEX:C344([Element Costs:50]Environment:5; True:C214)

// Cond States
// 1 Cond State IDUnique Indexed Integer 0
SET INDEX:C344([Cond States:51]Cond State ID:1; True:C214)
// 2 Category IDIndexed Integer 0
SET INDEX:C344([Cond States:51]Category ID:2; True:C214)

// CS Actions
// 1 Cond State IDIndexed Integer 0
SET INDEX:C344([CS Actions:52]Cond State ID:1; True:C214)

// CS Notes
// 1 CS Note IDUnique Indexed Integer 0
SET INDEX:C344([CS Notes:53]CS Note ID:1; True:C214)

// Common Notes
// 1 Common Note IDUnique Indexed Integer 0
SET INDEX:C344([Common Notes:54]Common Note ID:1; True:C214)

// Cat CS Notes
// 1 Category IDIndexed Integer 0
SET INDEX:C344([Cat CS Notes:55]Category ID:1; True:C214)
// 2 CS Note IDIndexed Integer 0
SET INDEX:C344([Cat CS Notes:55]CS Note ID:2; True:C214)

// BMS Field Trip
// 1 Inspection IDIndexed Long Integer 0
SET INDEX:C344([BMS Field Trip:56]Inspection ID:1; True:C214)
// 2 Person IDIndexed Integer 0
SET INDEX:C344([BMS Field Trip:56]Person ID:2; True:C214)

// Preferences

// Error Codes

// Activity Log
// 1 DestinationIndexed Alpha 80
SET INDEX:C344([Activity Log:59]Destination:1; True:C214)
// 3 Activity TypeIndexed Alpha 3
SET INDEX:C344([Activity Log:59]Activity Type:3; True:C214)
// 9 StatusIndexed Long Integer 0
SET INDEX:C344([Activity Log:59]Status:9; True:C214)
// 14 Parent IDIndexed Alpha 20
SET INDEX:C344([Activity Log:59]Parent ID:14; True:C214)
// 15 Local IDIndexed Alpha 20
SET INDEX:C344([Activity Log:59]Local ID:15; True:C214)
// 22 FileID ParentIndexed Long Integer 0
SET INDEX:C344([Activity Log:59]FileID Parent:22; True:C214)
// 23 FieldID ParentIndexed Long Integer 0
SET INDEX:C344([Activity Log:59]FieldID Parent:23; True:C214)
// 24 FileID LocalIndexed Long Integer 0
SET INDEX:C344([Activity Log:59]FileID Local:24; True:C214)
// 28 RefIDUnique Indexed Long Integer 0
SET INDEX:C344([Activity Log:59]RefID:28; True:C214)

// FileIDRes Table
// 1 File NumberIndexed Long Integer 0
SET INDEX:C344([FileIDRes Table:60]File Number:1; True:C214)
// 2 Local IDIndexed Alpha 80
SET INDEX:C344([FileIDRes Table:60]Local ID:2; True:C214)
// 3 Destination IDIndexed Alpha 80
SET INDEX:C344([FileIDRes Table:60]Destination ID:3; True:C214)
// 4 DestinationIndexed Alpha 80
SET INDEX:C344([FileIDRes Table:60]Destination:4; True:C214)

// PostingStatus

// Owners of Data
// 1 RefIDIndexed Long Integer 0
SET INDEX:C344([Owners of Data:62]RefID:1; True:C214)
// 2 Owner NameIndexed Alpha 80
SET INDEX:C344([Owners of Data:62]Owner Name:2; True:C214)

// Conslt Rating
// 1 BINIndexed Alpha 3
SET INDEX:C344([Conslt Rating:63]BIN:1; True:C214)
// 42 ConsltRatingIDUnique Indexed Long Integer 0
SET INDEX:C344([Conslt Rating:63]ConsltRatingID:42; True:C214)

// Cons Inspection
// 1 BINIndexed Alpha 3
SET INDEX:C344([Cons Inspection:64]BIN:1; True:C214)
// 32 ConsInspectionIDUnique Indexed Long Integer 0
SET INDEX:C344([Cons Inspection:64]ConsInspectionID:32; True:C214)

// RatingReports
// 1 BINIndexed Alpha 3
SET INDEX:C344([RatingReports:65]BIN:1; True:C214)
// 21 RatingIDUnique Indexed Long Integer 0
SET INDEX:C344([RatingReports:65]RatingID:21; True:C214)

// RatingMember
// 1 RatingIDIndexed Long Integer 0
SET INDEX:C344([RatingMember:66]RatingID:1; True:C214)

// Rating Method

// zDialogs

// Status Report

// Out of Freq

// Integral Bridge

// RPCs

// TownLineInfo
// 1 BINIndexed Alpha 3
SET INDEX:C344([TownLineInfo:73]BIN:1; True:C214)

// Conslt Rating Cost
// 1 ConsltRatingIDIndexed Long Integer 0
SET INDEX:C344([Conslt Rating Cost:74]ConsltRatingID:1; True:C214)

// Bridge Design
// 1 BINIndexed Alpha 3
SET INDEX:C344([Bridge Design:75]BIN:1; True:C214)

// Cons Inspection Cost
// 1 ConsInspectionIDIndexed Long Integer 0
SET INDEX:C344([Cons Inspection Cost:76]ConsInspectionID:1; True:C214)

// Conslt Address
// 1 ConsltAddressIDUnique Indexed Long Integer 0
SET INDEX:C344([Conslt Address:77]ConsltAddressID:1; True:C214)
// 2 ConsltNameIndexed Alpha 80
SET INDEX:C344([Conslt Address:77]ConsltName:2; True:C214)
// 22 ConsultantNameID_lIndexed Long Integer 0
SET INDEX:C344([Conslt Address:77]ConsultantNameID_l:22; True:C214)

// Town Address
// 1 TownAddressIDUnique Indexed Long Integer 0
SET INDEX:C344([Town Address:78]TownAddressID:1; True:C214)
// 2 TownNameIndexed Alpha 50
SET INDEX:C344([Town Address:78]TownName:2; True:C214)

// Contracts
// 1 ContractNoUnique Indexed Alpha 20
SET INDEX:C344([Contracts:79]ContractNo:1; True:C214)
// 29 ContractIDUnique Indexed Long Integer 0
SET INDEX:C344([Contracts:79]ContractID:29; True:C214)

// Contract FundTransfer
// 1 ContractNoIndexed Alpha 20
SET INDEX:C344([Contract FundTransfer:80]ContractNo:1; True:C214)
// 2 TOF_IDUnique Indexed Long Integer 0
SET INDEX:C344([Contract FundTransfer:80]TOF_ID:2; True:C214)

// Contract ExtendTime
// 1 ContractNoIndexed Alpha 20
SET INDEX:C344([Contract ExtendTime:81]ContractNo:1; True:C214)
// 2 EOT_IDUnique Indexed Long Integer 0
SET INDEX:C344([Contract ExtendTime:81]EOT_ID:2; True:C214)

// Contract AddFund
// 1 ContractNoIndexed Alpha 20
SET INDEX:C344([Contract AddFund:82]ContractNo:1; True:C214)
// 2 AddFund_IDUnique Indexed Long Integer 0
SET INDEX:C344([Contract AddFund:82]AddFund_ID:2; True:C214)

// Contract Assignments
// 1 ContractNoIndexed Alpha 20
SET INDEX:C344([Contract Assignments:83]ContractNo:1; True:C214)
// 3 AssignIDUnique Indexed Long Integer 0
SET INDEX:C344([Contract Assignments:83]AssignID:3; True:C214)

// Contract Invoice
// 1 InvoiceIDUnique Indexed Long Integer 0
SET INDEX:C344([Contract Invoice:84]InvoiceID:1; True:C214)
// 3 ContractNoIndexed Alpha 20
SET INDEX:C344([Contract Invoice:84]ContractNo:3; True:C214)

// Contract Invoice AssignNo
// 1 InvoiceIDIndexed Long Integer 0
SET INDEX:C344([Contract Invoice AssignNo:85]InvoiceID:1; True:C214)

// Templates
// 1 TemplateIDUnique Indexed Long Integer 0
SET INDEX:C344([Templates:86]TemplateID:1; True:C214)
// 2 TemplateNameIndexed Alpha 80
SET INDEX:C344([Templates:86]TemplateName:2; True:C214)

// ServerProcesses

// ClientAccess
// 2 CA_MessageStart_sIndexed Alpha 12
SET INDEX:C344([ClientAccess:88]CA_MessageStart_s:2; True:C214)
// 3 CA_LimitAccess_sIndexed Alpha 12
SET INDEX:C344([ClientAccess:88]CA_LimitAccess_s:3; True:C214)

// SD_History
// 1 BinIndexed Alpha 3
SET INDEX:C344([SD_History:89]Bin:1; True:C214)
// 2 SD_YearIndexed Alpha 4
SET INDEX:C344([SD_History:89]SD_Year:2; True:C214)
// 3 SD_MonthIndexed Alpha 2
SET INDEX:C344([SD_History:89]SD_Month:3; True:C214)
// 16 SD_DefectAddRemoveStatus_sIndexed Alpha 2
SET INDEX:C344([SD_History:89]SD_DefectAddRemoveStatus_s:16; True:C214)
// 17 SD_Owner_sIndexed Alpha 3
SET INDEX:C344([SD_History:89]SD_Owner_s:17; True:C214)
// 18 SD_PostedAddRemoveStatus_sIndexed Alpha 2
SET INDEX:C344([SD_History:89]SD_PostedAddRemoveStatus_s:18; True:C214)
// 19 SD_PreviousOwner_sIndexed Alpha 3
SET INDEX:C344([SD_History:89]SD_PreviousOwner_s:19; True:C214)

// Combined Inspections
// 1 BINIndexed Alpha 3
SET INDEX:C344([Combined Inspections:90]BIN:1; True:C214)
// 2 NBISInspIDIndexed Long Integer 0
SET INDEX:C344([Combined Inspections:90]NBISInspID:2; True:C214)
// 3 BMSInspIDIndexed Long Integer 0
SET INDEX:C344([Combined Inspections:90]BMSInspID:3; True:C214)
// 4 InspDateIndexed Date 0
SET INDEX:C344([Combined Inspections:90]InspDate:4; True:C214)
// 5 InspTypeIndexed Alpha 3
SET INDEX:C344([Combined Inspections:90]InspType:5; True:C214)
// 6 IDUnique Indexed Long Integer 0
SET INDEX:C344([Combined Inspections:90]ID:6; True:C214)

// ACTMODLS
// 1 MOKEYIndexed Alpha 2
SET INDEX:C344([ACTMODLS:91]MOKEY:1; True:C214)
// 2 ELEMKEYIndexed Integer 0
SET INDEX:C344([ACTMODLS:91]ELEMKEY:2; True:C214)
// 3 SKEYIndexed Integer 0
SET INDEX:C344([ACTMODLS:91]SKEY:3; True:C214)
// 5 ENVKEYIndexed Integer 0
SET INDEX:C344([ACTMODLS:91]ENVKEY:5; True:C214)

// ELEMDEFS
// 1 ELEMKEYIndexed Integer 0
SET INDEX:C344([ELEMDEFS:92]ELEMKEY:1; True:C214)
// 3 ETYPKEYIndexed Alpha 2
SET INDEX:C344([ELEMDEFS:92]ETYPKEY:3; True:C214)
// 4 MATLKEYIndexed Alpha 2
SET INDEX:C344([ELEMDEFS:92]MATLKEY:4; True:C214)

// CONDUMDL
// 1 MOKEYIndexed Alpha 2
SET INDEX:C344([CONDUMDL:93]MOKEY:1; True:C214)
// 2 ELEMKEYIndexed Integer 0
SET INDEX:C344([CONDUMDL:93]ELEMKEY:2; True:C214)
// 3 ENVKEYIndexed Integer 0
SET INDEX:C344([CONDUMDL:93]ENVKEY:3; True:C214)

// Invoice_AssignNo_Maintenance
// 1 InvoiceIDIndexed Long Integer 0
SET INDEX:C344([Invoice_AssignNo_Maintenance:94]InvoiceID:1; True:C214)
// 6 IDUnique Indexed Long Integer 0
SET INDEX:C344([Invoice_AssignNo_Maintenance:94]ID:6; True:C214)

// Invoice_Maintenance
// 1 InvoiceIDUnique Indexed Long Integer 0
SET INDEX:C344([Invoice_Maintenance:95]InvoiceID:1; True:C214)
// 3 ContractNoIndexed Alpha 20
SET INDEX:C344([Invoice_Maintenance:95]ContractNo:3; True:C214)

// FundTransfer_Maintenance
// 1 ContractNoIndexed Alpha 20
SET INDEX:C344([FundTransfer_Maintenance:96]ContractNo:1; True:C214)
// 2 TOF_IDUnique Indexed Long Integer 0
SET INDEX:C344([FundTransfer_Maintenance:96]TOF_ID:2; True:C214)

// Contract_Maintenance
// 1 ContractNoUnique Indexed Alpha 20
SET INDEX:C344([Contract_Maintenance:97]ContractNo:1; True:C214)
// 2 ContractIDUnique Indexed Long Integer 0
SET INDEX:C344([Contract_Maintenance:97]ContractID:2; True:C214)

// ExtendTime_Maintenance
// 1 ContractNoIndexed Alpha 20
SET INDEX:C344([ExtendTime_Maintenance:98]ContractNo:1; True:C214)
// 2 EOT_IDUnique Indexed Long Integer 0
SET INDEX:C344([ExtendTime_Maintenance:98]EOT_ID:2; True:C214)

// AddFund_Maintenance
// 1 ContractNoIndexed Alpha 20
SET INDEX:C344([AddFund_Maintenance:99]ContractNo:1; True:C214)
// 2 AddFund_IDUnique Indexed Long Integer 0
SET INDEX:C344([AddFund_Maintenance:99]AddFund_ID:2; True:C214)

// Contract_Project_Maintenance
// 1 ProjectIDUnique Indexed Long Integer 0
SET INDEX:C344([Contract_Project_Maintenance:100]ProjectID:1; True:C214)
// 2 ContractNoIndexed Alpha 20
SET INDEX:C344([Contract_Project_Maintenance:100]ContractNo:2; True:C214)
// 5 BINIndexed Alpha 3
SET INDEX:C344([Contract_Project_Maintenance:100]BIN:5; True:C214)
// 9 AssignNoIndexed Integer 0
SET INDEX:C344([Contract_Project_Maintenance:100]AssignNo:9; True:C214)
// 13 AssignIDIndexed Long Integer 0
SET INDEX:C344([Contract_Project_Maintenance:100]AssignID:13; True:C214)

// Contract_Assignment_Maintenance
// 1 ContractNoIndexed Alpha 20
SET INDEX:C344([Contract_Assignment_Maintenance:101]ContractNo:1; True:C214)
// 2 AssignNoIndexed Integer 0
SET INDEX:C344([Contract_Assignment_Maintenance:101]AssignNo:2; True:C214)
// 3 AssignIDUnique Indexed Long Integer 0
SET INDEX:C344([Contract_Assignment_Maintenance:101]AssignID:3; True:C214)

// Addendum_Maintenance
// 1 AddendumIDUnique Indexed Long Integer 0
SET INDEX:C344([Addendum_Maintenance:102]AddendumID:1; True:C214)
// 2 AddendumNoIndexed Integer 0
SET INDEX:C344([Addendum_Maintenance:102]AddendumNo:2; True:C214)
// 3 AssignIDIndexed Long Integer 0
SET INDEX:C344([Addendum_Maintenance:102]AssignID:3; True:C214)
// 4 AssignNoIndexed Integer 0
SET INDEX:C344([Addendum_Maintenance:102]AssignNo:4; True:C214)

// Work_Estimate
// 1 WKIDUnique Indexed Long Integer 0
SET INDEX:C344([Work_Estimate:103]WKID:1; True:C214)
// 2 AssignIDIndexed Long Integer 0
SET INDEX:C344([Work_Estimate:103]AssignID:2; True:C214)

// WorkHour_Config
// 2 AssignTypeIndexed Alpha 80
SET INDEX:C344([WorkHour_Config:104]AssignType:2; True:C214)

// WorkHour_Summary
// 1 ProjTypeIndexed Alpha 40
SET INDEX:C344([WorkHour_Summary:105]ProjType:1; True:C214)
// 2 ItemIDIndexed Integer 0
SET INDEX:C344([WorkHour_Summary:105]ItemID:2; True:C214)

// zSpecialReports
// 1 PurposeIndexed Alpha 80
SET INDEX:C344([zSpecialReports:106]Purpose:1; True:C214)
// 7 Record_IDIndexed Long Integer 0
SET INDEX:C344([zSpecialReports:106]Record_ID:7; True:C214)

// Parameters
// 1 ParamCodeUnique Indexed Alpha 20
SET INDEX:C344([Parameters:107]ParamCode:1; True:C214)

// ScourPriorityRank
// 1 BINIndexed Alpha 3
SET INDEX:C344([ScourPriorityRank:108]BIN:1; True:C214)
// 4 LifeTimeRiskIndexed Real 0
SET INDEX:C344([ScourPriorityRank:108]LifeTimeRisk:4; True:C214)
// 5 CategoryIndexed Alpha 2
SET INDEX:C344([ScourPriorityRank:108]Category:5; True:C214)

// PERS_Groups
// 1 PERS_GroupID_IUnique Indexed Integer 0
SET INDEX:C344([PERS_Groups:109]PERS_GroupID_I:1; True:C214)
// 2 PERS_GroupName_sUnique Indexed Alpha 80
SET INDEX:C344([PERS_Groups:109]PERS_GroupName_s:2; True:C214)

// PERS_GroupMembers
// 1 GroupID_IIndexed Integer 0
SET INDEX:C344([PERS_GroupMembers:110]GroupID_I:1; True:C214)
// 2 PersonID_IIndexed Integer 0
SET INDEX:C344([PERS_GroupMembers:110]PersonID_I:2; True:C214)

// CM_ExtTimeFYAlloc
// 1 ExtTimeFYAllocID_LUnique Indexed Long Integer 0
SET INDEX:C344([CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1; True:C214)
// 2 EOT_ID_LIndexed Long Integer 0
SET INDEX:C344([CM_ExtTimeFYAlloc:111]EOT_ID_L:2; True:C214)

// InventoryPhotoInsp
// 1 InvPhotoInspID_LUnique Indexed Long Integer 0
SET INDEX:C344([InventoryPhotoInsp:112]InvPhotoInspID_L:1; True:C214)
// 2 BINIndexed Alpha 3
SET INDEX:C344([InventoryPhotoInsp:112]BIN:2; True:C214)

// InventoryPhotos
// 1 InvPhoto_IDUnique Indexed Long Integer 0
SET INDEX:C344([InventoryPhotos:113]InvPhoto_ID:1; True:C214)
// 2 InvPhotoInsp_IDIndexed Long Integer 0
SET INDEX:C344([InventoryPhotos:113]InvPhotoInsp_ID:2; True:C214)

// PRJ_Contractor
// 1 CTR_ContractorID_lUnique Indexed Long Integer 0
SET INDEX:C344([PRJ_Contractor:114]CTR_ContractorID_l:1; True:C214)

// PRJ_ProjectDetails
// 1 PRJ_ProjectID_lUnique Indexed Long Integer 0
SET INDEX:C344([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; True:C214)
// 2 CP_ConstructionProjectID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2; True:C214)
// 3 PF_FileID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ProjectDetails:115]PF_FileID_l:3; True:C214)
// 5 PRJ_BridgeNo_sIndexed Alpha 28
SET INDEX:C344([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; True:C214)
// 7 PRJ_NonBridge_sIndexed Alpha 80
SET INDEX:C344([PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; True:C214)
// 8 PRJ_CityOrTown_sIndexed Alpha 20
SET INDEX:C344([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; True:C214)
// 54 DC_DesignContractID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ProjectDetails:115]DC_DesignContractID_l:54; True:C214)

// PRJ_ConstructionProject
// 1 CP_ConstructionProjectID_lUnique Indexed Long Integer 0
SET INDEX:C344([PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1; True:C214)
// 2 CTR_ContractorID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ConstructionProject:116]CTR_ContractorID_l:2; True:C214)
// 5 CP_ConstructionContractNo_sIndexed Alpha 50
SET INDEX:C344([PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5; True:C214)
// 11 PF_FileID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ConstructionProject:116]PF_FileID_l:11; True:C214)

// PRJ_ProjectFile
// 1 PF_FileID_lUnique Indexed Long Integer 0
SET INDEX:C344([PRJ_ProjectFile:117]PF_FileID_l:1; True:C214)
// 3 PF_FileNumber_lUnique Indexed Long Integer 0
SET INDEX:C344([PRJ_ProjectFile:117]PF_FileNumber_l:3; True:C214)
// 17 PF_TypeCode_sIndexed Alpha 2
SET INDEX:C344([PRJ_ProjectFile:117]PF_TypeCode_s:17; True:C214)

// PRJ_ReportData
// 1 PRJ_ProjectID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ReportData:118]PRJ_ProjectID_l:1; True:C214)

// PRJ_StructuralReview
// 1 PRJ_ProjectID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_StructuralReview:119]PRJ_ProjectID_l:1; True:C214)
// 2 RV_ReviewID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_StructuralReview:119]RV_ReviewID_l:2; True:C214)

// PRJ_SketchPlans
// 1 PRJ_ProjectID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_SketchPlans:120]PRJ_ProjectID_l:1; True:C214)
// 2 RV_ReviewID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_SketchPlans:120]RV_ReviewID_l:2; True:C214)

// PRJ_TypeStudy
// 1 PRJ_ProjectID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_TypeStudy:121]PRJ_ProjectID_l:1; True:C214)
// 2 RV_ReviewID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_TypeStudy:121]RV_ReviewID_l:2; True:C214)

// PRJ_ProjectDetailsIncludedBINS
// 1 PRJ_ProjectID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; True:C214)
// 2 PDB_BIN_sIndexed Alpha 3
SET INDEX:C344([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; True:C214)

// PRJ_DesignContracts
// 1 DC_DesignContractID_lUnique Indexed Long Integer 0
SET INDEX:C344([PRJ_DesignContracts:123]DC_DesignContractID_l:1; True:C214)
// 2 ConsultantNameID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_DesignContracts:123]ConsultantNameID_l:2; True:C214)
// 17 DC_SQLContractID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_DesignContracts:123]DC_SQLContractID_l:17; True:C214)

// PRJ_ProjectTimeTracking
// 1 PT_TimeTrackingID_lUnique Indexed Long Integer 0
SET INDEX:C344([PRJ_ProjectTimeTracking:124]PT_TimeTrackingID_l:1; True:C214)
// 2 PRJ_ProjectID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ProjectTimeTracking:124]PRJ_ProjectID_l:2; True:C214)

// TableOfLists
// 1 ListName_sIndexed Alpha 31
SET INDEX:C344([TableOfLists:125]ListName_s:1; True:C214)
// 2 ListValue_sIndexed Alpha 80
SET INDEX:C344([TableOfLists:125]ListValue_s:2; True:C214)
// 4 ListKeyID_LIndexed Long Integer 0
SET INDEX:C344([TableOfLists:125]ListKeyID_L:4; True:C214)

// SQL_Connections

// Conslt_Name
// 1 ConsultantNameID_lUnique Indexed Long Integer 0
SET INDEX:C344([Conslt_Name:127]ConsultantNameID_l:1; True:C214)
// 3 SQL_VendorID_lIndexed Long Integer 0
SET INDEX:C344([Conslt_Name:127]SQL_VendorID_l:3; True:C214)

// PRJ_StrPrjManagerHistory
// 1 PRJ_ProjectID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_StrPrjManagerHistory:128]PRJ_ProjectID_l:1; True:C214)

// Scour Report
// 1 ReportDateIndexed Date 0
SET INDEX:C344([Scour Report:129]ReportDate:1; True:C214)

// PRJ_Attributes
// 1 ATTR_ID_lUnique Indexed Long Integer 0
SET INDEX:C344([PRJ_Attributes:130]ATTR_ID_l:1; True:C214)

// PRJ_ATTRFileNoXrefs
// 1 ATTR_ID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1; True:C214)
// 2 PF_FileNumber_lIndexed Long Integer 0
SET INDEX:C344([PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2; True:C214)

// ScourPOA
// 1 ScourPOAIDUnique Indexed Long Integer 0
SET INDEX:C344([ScourPOA:132]ScourPOAID:1; True:C214)
// 2 BINIndexed Alpha 3
SET INDEX:C344([ScourPOA:132]BIN:2; True:C214)

// ScourPOA_DetourBridge
// 1 DetourBridgeID_LUnique Indexed Long Integer 0
SET INDEX:C344([ScourPOA_DetourBridge:133]DetourBridgeID_L:1; True:C214)
// 2 ScourPOAIDIndexed Long Integer 0
SET INDEX:C344([ScourPOA_DetourBridge:133]ScourPOAID:2; True:C214)

// ScourPOA_Images
// 1 ScourPOAImgIDUnique Indexed Long Integer 0
SET INDEX:C344([ScourPOA_Images:134]ScourPOAImgID:1; True:C214)
// 2 ScourPOAIDIndexed Long Integer 0
SET INDEX:C344([ScourPOA_Images:134]ScourPOAID:2; True:C214)

// PRJ_DCPFJoin
// 1 DCPF_Contract_FileNo_sIndexed Alpha 23
SET INDEX:C344([PRJ_DCPFJoin:135]DCPF_Contract_FileNo_s:1; True:C214)
// 2 DC_DesignProjectID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_DCPFJoin:135]DC_DesignProjectID_l:2; True:C214)
// 3 PF_FileID_lIndexed Long Integer 0
SET INDEX:C344([PRJ_DCPFJoin:135]PF_FileID_l:3; True:C214)

// DCM_Contracts
// 1 ContractNoUnique Indexed Alpha 20
SET INDEX:C344([DCM_Contracts:136]ContractNo:1; True:C214)
// 2 ContractIDUnique Indexed Long Integer 0
SET INDEX:C344([DCM_Contracts:136]ContractID:2; True:C214)
// 3 ConsultantNameIndexed Alpha 80
SET INDEX:C344([DCM_Contracts:136]ConsultantName:3; True:C214)
// 7 ContractStatusIndexed Alpha 30
SET INDEX:C344([DCM_Contracts:136]ContractStatus:7; True:C214)

// DCM_WorkOrders
// 1 ContractNoIndexed Alpha 20
SET INDEX:C344([DCM_WorkOrders:137]ContractNo:1; True:C214)
// 2 AssignNoIndexed Integer 0
SET INDEX:C344([DCM_WorkOrders:137]AssignNo:2; True:C214)
// 3 AssignIDUnique Indexed Long Integer 0
SET INDEX:C344([DCM_WorkOrders:137]AssignID:3; True:C214)
// 4 ProjectISIndexed Alpha 30
SET INDEX:C344([DCM_WorkOrders:137]ProjectIS:4; True:C214)

// DCM_Project
// 1 ProjectIDUnique Indexed Long Integer 0
SET INDEX:C344([DCM_Project:138]ProjectID:1; True:C214)
// 2 ContractNoIndexed Alpha 20
SET INDEX:C344([DCM_Project:138]ContractNo:2; True:C214)
// 5 BINIndexed Alpha 3
SET INDEX:C344([DCM_Project:138]BIN:5; True:C214)
// 9 AssignNoIndexed Integer 0
SET INDEX:C344([DCM_Project:138]AssignNo:9; True:C214)
// 13 AssignIDIndexed Long Integer 0
SET INDEX:C344([DCM_Project:138]AssignID:13; True:C214)

// BridgeMHDNBISArchive
// 3 BINIndexed Alpha 3
SET INDEX:C344([BridgeMHDNBISArchive:139]BIN:3; True:C214)
// 173 FHWARecordIndexed Boolean 0
SET INDEX:C344([BridgeMHDNBISArchive:139]FHWARecord:173; True:C214)
// 223 ArchiveReason_sIndexed Alpha 80
SET INDEX:C344([BridgeMHDNBISArchive:139]ArchiveReason_s:223; True:C214)
// 224 ArchiveDate_dIndexed Date 0
SET INDEX:C344([BridgeMHDNBISArchive:139]ArchiveDate_d:224; True:C214)

// NBISSecondaryArchive
// 1 BINIndexed Alpha 3
SET INDEX:C344([NBISSecondaryArchive:140]BIN:1; True:C214)
// 39 ArchiveReason_sIndexed Alpha 80
SET INDEX:C344([NBISSecondaryArchive:140]ArchiveReason_s:39; True:C214)
// 40 ArchiveDate_dIndexed Date 0
SET INDEX:C344([NBISSecondaryArchive:140]ArchiveDate_d:40; True:C214)
// 41 NBISSecondaryKey_lIndexed Long Integer 0
SET INDEX:C344([NBISSecondaryArchive:140]NBISSecondaryKey_l:41; True:C214)

// PRJ_ProjectTypes
// 1 PRTP_TypeCode_sIndexed Alpha 2
SET INDEX:C344([PRJ_ProjectTypes:141]PRTP_TypeCode_s:1; True:C214)

// DCM_ProjDailyHrs
// 1 DailyIItemD_LIndexed Long Integer 0
SET INDEX:C344([DCM_ProjDailyHrs:142]DailyIItemD_L:1; True:C214)

// DCM_ProjDailys
// 1 ProjectIDIndexed Long Integer 0
SET INDEX:C344([DCM_ProjDailys:143]ProjectID:1; True:C214)
// 2 DailyID_LUnique Indexed Long Integer 0
SET INDEX:C344([DCM_ProjDailys:143]DailyID_L:2; True:C214)

// DCM_ProjDailyItems
// 1 DailyID_LIndexed Long Integer 0
SET INDEX:C344([DCM_ProjDailyItems:144]DailyID_L:1; True:C214)
// 2 DailyItemID_LUnique Indexed Long Integer 0
SET INDEX:C344([DCM_ProjDailyItems:144]DailyItemID_L:2; True:C214)
// 3 ItemNo_sIndexed Alpha 20
SET INDEX:C344([DCM_ProjDailyItems:144]ItemNo_s:3; True:C214)

// Preservation_Reviews
// 1 Review_IDUnique Indexed Long Integer 0
SET INDEX:C344([Preservation_Reviews:145]Review_ID:1; True:C214)
// 2 AssignIDIndexed Long Integer 0
SET INDEX:C344([Preservation_Reviews:145]AssignID:2; True:C214)
// 3 ReviewTYpe_sIndexed Alpha 80
SET INDEX:C344([Preservation_Reviews:145]ReviewTYpe_s:3; True:C214)

// ONSQLAuthenticationErrors

// LB_QueryTable
// 1 QueryName_sIndexed Alpha 20
SET INDEX:C344([LB_QueryTable:147]QueryName_s:1; True:C214)
// 6 UniqueKey_lIndexed Long Integer 0
SET INDEX:C344([LB_QueryTable:147]UniqueKey_l:6; True:C214)

// Preservation_Meetings
// 1 MeetingID_LUnique Indexed Long Integer 0
SET INDEX:C344([Preservation_Meetings:148]MeetingID_L:1; True:C214)
// 2 AssignIDIndexed Long Integer 0
SET INDEX:C344([Preservation_Meetings:148]AssignID:2; True:C214)

//End ut_setIndexes