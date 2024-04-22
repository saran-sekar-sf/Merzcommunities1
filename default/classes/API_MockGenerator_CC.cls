/*
* @Purpose:    			- This class is being used to create MOCK RESPONSE during test coverage
* @CreatedDate			- 22/Apr/2024
* @Author			    - Saravanan Sekar
**** Usage Instruction ****
* API_MockGenerator_CC 	- Constructor will receive StatusCode, StatusMessage and ResponseBody to create the generic wrapper
*/ 
@isTest
public class API_MockGenerator_CC implements HttpCalloutMock {
    protected Integer code;
    protected String status;
    protected String body;
   
    public API_MockGenerator_CC(Integer code, String status, String body) {
        this.code = code;
        this.status = status;
        this.body = body;
    }
    
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse resp = new HttpResponse();
        resp.setStatusCode(code);
        resp.setStatus(status);
        resp.setBody(body);
        
        return resp;
    }
    
}