public class TableWrapper {
    @AuraEnabled
    public List<SObject> records;

    @AuraEnabled
    public List<Column> columns;

    @AuraEnabled
    public Integer rowCount;

    @AuraEnabled
    public String fieldSOQL;

    @AuraEnabled
    public String whereClause;

    private String sObjectType;

    public TableWrapper(){}

    public TableWrapper(String recordId
                        , String relatedField
                        , String relatedObject
                        , String fieldSetName
                        , String whereClause)
    {
        this.sObjectType = relatedObject;
        this.columns = LightningController.getColumns(relatedObject
                                                        , fieldSetName);
        this.fieldSOQL = LightningController.getFieldSOQL(columns);
        this.whereClause = String.isBlank(whereClause) ? ' WHERE ' : ' WHERE ' + whereClause + ' AND '; 
        this.whereClause += relatedField + ' = \'' + recordId + '\'';
        this.records = this.refreshRecords();
        this.rowCount = this.records != null && !this.records.isEmpty() ? this.records.size() : 0;
    }

    public String getQuery()
    {
        String query = 'SELECT Id';
        query += fieldSOQL;
        query +=' FROM ' + this.sObjectType;
        query += whereClause;

        return query;
    }

    public List<SObject> refreshRecords()
    {
        return LightningController.querySObjects(this.getQuery());
    }
}
