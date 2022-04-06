public class BinListIntegration {
    public static void accountInfo(){
        String url ='https://lookup.binlist.net/';
        String errorMessage = '';
        String urlWithCardNumber = url +'45717360';
        Http htp = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse resp = new HttpResponse();
        req.setMethod('GET');
        req.setEndpoint(urlWithCardNumber);
        req.setHeader('Content-Type', 'application/JSON');
        try{
            resp = htp.send(req);
            if(resp.getStatusCode() == 200){
                String body = resp.getBody();
                System.debug('body----'+body);
            }else{
                System.debug('status '+resp.getStatus()+' response code '+ resp.getStatusCode());
            }
        }
        catch (system.Exception e){
            if (String.valueof(e.getMessage()).startsWith('Unauthorised endPoint')){
                errorMessage = 'check setting';
            }
        }
    }
}