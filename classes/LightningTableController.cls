public with sharing class LightningTableController {
    
    @AuraEnabled(cacheable=true)
    public static TableWrapper initTable(String recordId
                                        , String relatedField
                                        , String relatedObject
                                        , String fieldSetName
                                        , String whereClause
                                        )
    {
        TableWrapper table = new TableWrapper(recordId
                                            , relatedField
                                            , relatedObject
                                            , fieldSetName
                                            , whereClause);

        return table;
    }

    @AuraEnabled
    public static List<SObject> refreshRecords(TableWrapper table)
    {
        return table.refreshRecords();
    }
}