public with sharing class LightningController {

    @AuraEnabled
    public static SObject querySObject(String query){
        return Database.query(query);
    }

    @AuraEnabled
    public static List<SObject> querySObjects(String query){
        System.debug(query);
        return Database.query(query);
    }

    @AuraEnabled
    public static List<Column> getColumns(String sObjectName
                                        , String fieldSetString)
    {
        FieldSetMap fsMap = new FieldSetMap(sObjectName);
        List<Column> columns = new List<Column>();

        FieldSet fieldSet = fsMap.getFieldSet(fieldSetString);

        if(fieldSet == null) 
            throw new LightningException('Could not find fieldset \"' + fieldset + '\" on ' + sObjectName + '.');

        columns = fieldSet.fields;
        return columns;
    }

    @AuraEnabled
    public static String getFieldSOQL(List<Column> fields)
    {
        String fieldSOQL = '';
        for(Column fs: fields)
        {
            fieldSOQL += ', ' + fs.fieldName;
        }
        System.debug(fieldSOQL);

        return fieldSOQL;
    }

    public class LightningException extends Exception{}
}