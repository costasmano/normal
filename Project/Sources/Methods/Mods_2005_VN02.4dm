//%attributes = {"invisible":true}
//Mods_2005_VN02 
//24-August-2005

//Modified btnRetrieveCost Object method of [Contract Assignments]; "Assignments In"
// ` Changed the logic of how to retrieve Negotiated and Actual costs as follows:
// `  Negotiated Costs: 
// ` ` ` These costs get retrieved only if the assigned status of Consultant Inspection and 
// ` ` ` Consultant Rating are not Rescinded
// `  Actual Costs: 
// ` ` ` These costs get retrieved only if the assigned status of Consultant Inspection and 
// ` ` ` Consultant Rating are either Rescinded or Completed
