public with sharing class TMcVFPageBuilderCrtl {

	public ApexPage thePage { get; set; }
	public String theHTML { get; set; }
	public Boolean showHeader { get; set; }
	public Boolean sidebar { get; set; }

	public String headerTags { get; set; }
	public static Map<ID, ApexPage> vfPages { get; set; }

	public TMcVFPageBuilderCrtl() {
		thePage = new ApexPage();
	}

	public PageReference createPage() {
/*
		headerTags = '<apex:page showHeader="'+showHeader+'" sidebar="'+sidebar+'" >';

		thePage.Markup = headerTags + theHTML + '</apex:page>';
		//insert thePage;


		//byte[] ContentBytes;
		String Content = '<apex:page >//PageContent In Apex Code//</apex:page>';
		ApexCode = Content.getBytes('UTF-8');
		double version = 30.00;
		com.sforce.soap.metadata.ApexPage pag = new com.sforce.soap.metadata.ApexPage();
		pag.setFullName('Name');
		pag.setDescription('Description');
		pag.setLabel('Label');
		pag.setAvailableInTouch(true);
		pag.setApiVersion(version);
		pag.setContent(ApexCode);
		pag.setConfirmationTokenRequired(false);
		Metadataconnection.create(new Apexpage[]{pag});
*/

		return null;
	}

	@remoteAction
	public static Boolean doesPageExist(String pageName) {
		Boolean exists = false;
		List<ApexPage> testPages = [SELECT Name FROM ApexPage WHERE Name =: pageName];
		if ( testPages.isEmpty() ) {
			exists = false;
		}
		else {
			exists = true;
		}
		
		return exists;
	}

	@remoteAction
    public static String updatePage(String sessionId, String newContent, String pageName, Boolean showHeader, Boolean showSidebar) {
        //ApexPage myPage = [Select Id from ApexPage where Name = 'SSEPageMeta'];
        String result = '';

        String markup = '<apex:page showHeader="'+showHeader+'" sidebar="'+showSidebar+'" standardStylesheets="false"> \n'
        	+'<c:TMcVFPageBuilderIncludes /> \n' 
            + newContent + ' \n'
            +'</apex:page>';
        String name = pageName;
        String masterLabel = name;

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject(); 
        gen.writeStringField( 'Markup', markup );
        gen.writeStringField( 'Name', name );
        gen.writeStringField( 'MasterLabel', masterLabel );
        //gen.writeStringField( '', title );
        gen.writeEndObject();
        String jsonBody = gen.getAsString();

        System.debug('jsonBody req ===== '+jsonBody);


        Httprequest req = new HttpRequest();
        String instance = ''+System.URL.getSalesforceBaseUrl().getHost();
        instance = instance.replace('c.','');
        if(instance.contains('visual.force')){
            instance = instance.replace('visual.force','salesforce');
        }
        System.debug('Instance ======== '+instance);
        //req.setEndpoint('https://'+instance+'/services/data/v29.0/sobjects/ApexPage/'+pageId+'?_HttpMethod=PATCH');
        req.setEndpoint('https://'+instance+'/services/sobjects/ApexPages/');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'OAuth ' + sessionId);
        // req.setBody(newMarkup);
        req.setBody(jsonBody);
        req.setMethod('POST');

        System.debug('Request req ======== '+req);

        Http httpReq = new Http();
        try{
            HttpResponse res = httpReq.send(req); 
            result += 'Success : '+res.getBody();
        }
        catch(Exception e){
            result += 'Exception : '+e.getMessage();
        }

        jsonBody = JSON.serialize(jsonBody);
        System.debug('jsonBody req ===== '+jsonBody);

        return result;
    }
}