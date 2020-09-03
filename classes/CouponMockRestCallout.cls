public with sharing class CouponMockRestCallout extends RestCalloutBase {
    
    public class CouponMockRestCalloutRequest {
        public String couponNumber;
        //public String other property;
    }
    
    public CouponMockRestCallout(String customerId) {
        super('POST', 'alteration/coupon/access');
        this.request.setHeader('CustomerId', customerId);
    }

    public RestCalloutEntity.RestCalloutResponse send(CouponMockRestCalloutRequest couponRequest) {
        //System.debug(System.JSON.serialize(couponRequest));

        RestCalloutEntity.RestCalloutResponse couponResponse = new RestCalloutEntity.RestCalloutResponse();
        String body = JSON.serialize(couponRequest);//.replace('"CustomerPolicyNumber":', '"number":');
        response = super.send(body);
        if(response.getStatusCode()==200) {
            String responseBody = response.getBody();
            //responseBody = responseBody.replace('"number":', '"CustomerPolicyNumber":');
            couponResponse = (RestCalloutEntity.RestCalloutResponse)JSON.deserialize(responseBody, RestCalloutEntity.RestCalloutResponse.Class);
        }
       
        return couponResponse;
    }

}