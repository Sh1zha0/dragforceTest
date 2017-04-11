global with sharing class dfDefault {
	
    @RemoteAction
    global static Account insertAccount(String accName,String accType){
                                           
        System.debug('insertAccount');
        Account newAcc = new Account();
        
        //System.debug('accDate '+accDate);        
       
        newAcc.Name = accName;
        newAcc.Type = accType;
        //newAcc.SLAExpirationDate__c = myDate;
                              
        insert newAcc;
        return newAcc;
    }
    
    @RemoteAction
    global static Lead insertLead(String cName,String status, String lName){
                                           
        System.debug('Lead');
        Lead newLead = new Lead();
        
        //System.debug('accDate '+accDate);        
       
        newLead.Company = cName;
        newLead.Status  = status;
        newLead.LastName = lNAme;
        //newAcc.SLAExpirationDate__c = myDate;
                              
        insert newLead;
        return newLead;
    }
    
    @RemoteAction
    global static Case insertCase(String cSubject,String cStatus, String cOrigin){
                                           
        System.debug('Case');
        Case newCase = new Case();       
       
        newCase.Subject = cSubject;
        newCase.Status = cStatus;
        newCase.Origin = cOrigin;
                              
        insert newCase;
        return newCase;
    }
    
    @RemoteAction
    global static Opportunity insertOpportunity(String oppName,Date closeDate, String oppStage){
                                           
        System.debug('opportunity');
        Opportunity newOpp = new Opportunity();  
       
        newOpp.Name = oppName;
        newOpp.CloseDate = closeDate;
        newOpp.StageName = oppStage;
                              
        insert newOpp;
        return newOpp;
    }
    
 
    
}