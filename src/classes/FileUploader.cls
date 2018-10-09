public class FileUploader 
{
    public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    String[] filelines = new String[]{};
        List<raw_material__c> accstoupload;
    
    /***This function reads the CSV file and inserts records into the Account object. ***/
    public Pagereference ReadFile()
    {
        try{
            //Convert the uploaded file which is in BLOB format into a string
            nameFile =blobToString( contentFile,'ISO-8859-1');
            
            //Now sepatate every row of the excel file
            filelines = nameFile.split('\n');
            
            //Iterate through every line and create a Account record for each row
            accstoupload = new List<raw_material__c>();
            
            ID stId;
            stId = ApexPages.currentPage().getparameters().get('id');
            
            for (Integer i=1;i<filelines.size();i++)
            {
                String[] inputvalues = new String[]{};
                    inputvalues = filelines[i].split(',');

                raw_material__c rm = new raw_material__c();
                rm.Name = inputvalues[0];
                rm.Name__c = inputvalues[1];
                rm.Amount__c = Double.valueOf(inputvalues[2]);
                rm.Receipt_date__c = date.parse(inputvalues[3]);
                rm.Made_in__c = inputvalues[4];
                rm.Number__c = Integer.valueOf(inputvalues[5]);
                rm.Quality__c = inputvalues[6];
                rm.Title__c = inputvalues[7];
                rm.Store__c = stId;
                accstoupload.add(rm);
            }
        }
        catch(Exception e){
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured reading the CSV file'+e.getMessage());
            ApexPages.addMessage(errormsg);
        }       
        //Finally, insert the collected records
        try{
            insert accstoupload;
        }
        catch (Exception e)
        {
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured inserting the records'+e.getMessage());
            ApexPages.addMessage(errormsg);
        }    
        return null;
    }
    
    /**** This function sends back to the visualforce page the list of account records that were inserted ****/ 
    public List<raw_material__c> getuploadedAccounts()
    {
        if (accstoupload!= NULL)
            if (accstoupload.size() > 0)
            return accstoupload;
        else
            return null;                    
        else
            return null;
    }  
    /**
This function convers the input CSV file in BLOB format into a string
@param input    Blob data representing correct string in @inCharset encoding
@param inCharset    encoding of the Blob data (for example 'ISO 8859-1')
*/
    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }         
}