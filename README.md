# Paytm_Web_Sample_Kit_Salesforce
Paytm Integration Development Kit using Salesforce

Use below method of class files to generate checksum and verify checksum.

Generate Checksum For Transaction Request:
public String genrateCheckSum(String Key, Map<String, String> paramap)
Generate Checksum For Refund Request:
public String genrateRefundCheckSum(String Key, Map<String, String> paramap)
Verify Checksum:
public boolean verifycheckSum(String masterKey, Map<String, String> paramap,String responseCheckSumString)
