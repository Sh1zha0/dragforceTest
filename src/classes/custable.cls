global with sharing class custable {

   public string recid{get;set;} // for account logic
   public string lStatus{get;set;} //for lead logic
   public string accType{get;set;}//query different acc

   public string row{ get; set;}
    
   public list<Account> Acclst{get;set;}
   Public Account A;

   public List<Contact> contacts {get; set;}
   Public Contact C;
       
   public List<Lead> leads {get; set;}
   public Lead L;
    
   public List<Opportunity> opportunities {get; set;}
   public Opportunity O;

   public custable(){
	
   Acclst = [select Id,Name from Account where Type =: accType];
   leads = [SELECT Id, Company, Status FROM lead WHERE Status like 'Open%'];
   opportunities = [SELECT Id, name,Description,StageName,CloseDate FROM Opportunity where IsClosed = false];
       
   system.debug(leads);
   contacts=null;
   }

   public pagereference deleteAccount()
   {
       account ac=[select id,name from account where id=:recid];
       delete ac;
    
    
       pagereference ref = new PageReference(ApexPages.currentPage().getUrl());
       ref.setredirect(true);
       return ref;
  }
    
    public void getLead(){
       	leads = [SELECT Id, Company, Status FROM lead WHERE Status like: lStatus];
    }

   public void setupContacts()
   {
     contacts=[select id, FirstName, LastName from Contact where AccountId=:recId];
   }
    
    @RemoteAction
    global static DfMonitor__c triggerMonitor(String name){
                                           
        System.debug('DfMonitor__c');
        DfMonitor__c newObject = new DfMonitor__c();
        
        //System.debug('accDate '+accDate);        
       
        newObject.Name = name;
        newObject.createDate__c = date.today();
        //newAcc.SLAExpirationDate__c = myDate;
                              
        insert newObject;
        return newObject;
    }
 }