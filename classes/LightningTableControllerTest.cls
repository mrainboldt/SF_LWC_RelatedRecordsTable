@isTest
private class LightningTableControllerTest {
    @isTest
    private static void general()
    {
        //ARRANGE
        User sourceRecord = [SELECT Id, ManagerId 
                                FROM User 
                                WHERE ManagerID != null 
                                LIMIT 1];
        String recordId = sourceRecord.ManagerId;
        String relatedObject = 'User';
        String relatedField = 'ManagerId';
        String fieldSet = 'TEST';
        String whereClause = '';

        //ACT
        Test.startTest();
        TableWrapper result = LightningTableController.initTable(recordId
                                                                , relatedField
                                                                , relatedObject
                                                                , fieldSet
                                                                , whereClause);
        Test.stopTest();

        //ASSERT
        System.assert(!result.records.isEmpty(), 'Records should not be empty.');
        System.assert(result.rowCount > 0, 'RowCount should be greater than 1.');
        System.assertNotEquals(null, result.columns);
    }

    @isTest
    private static void test_WhereClause()
    {
        //ARRANGE
        User sourceRecord = [SELECT Id, ManagerId, Name
                                FROM User 
                                WHERE ManagerID != null 
                                LIMIT 1];
        String recordId = sourceRecord.ManagerId;
        String relatedObject = 'User';
        String relatedField = 'ManagerId';
        String fieldSet = 'TEST';
        String whereClause = 'Name != \'' + sourceRecord.Name + '\'';

        //ACT
        Test.startTest();
        TableWrapper result = LightningTableController.initTable(recordId, relatedField, relatedObject, fieldSet, whereClause);
        Test.stopTest();

        //ASSERT
        System.assertEquals(0, result.rowCount);
        System.assertNotEquals(null, result.columns);
        System.assert(result.records.isEmpty());
    }
}