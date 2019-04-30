# Paytm_Web_Sample_Kit_Salesforce
Paytm Integration Development Kit using Salesforce

Use below method of Class Files to generate checksum and verify checksum.

  1. Generate Checksum For Transaction Request:  
    public String genrateCheckSum(String Key, Map<String, String> paramap)
  2. Generate Checksum For Refund Request:  
    public String genrateRefundCheckSum(String Key, Map<String, String> paramap)
  3. Verify Checksum:  
    public boolean verifycheckSum(String masterKey, Map<String, String>  paramap,String responseCheckSumString)
