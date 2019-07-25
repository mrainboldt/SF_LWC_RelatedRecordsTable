public class Column {
    @AuraEnabled
    public String label;

    @AuraEnabled
    public String name;

    @AuraEnabled
    public String fieldName;

    @AuraEnabled
    public String type;

    @AuraEnabled
    public boolean sortable;

    @AuraEnabled
    public boolean editable;

    @AuraEnabled
    public boolean required;

    public Column(){}

    public Column(Schema.FieldSetMember f) 
    {
        this.required = f.DBRequired;
        this.fieldName = f.fieldPath;
        this.label = f.label;
        this.required = f.required;
        this.type = '' + f.getType();
        this.sortable = true;
        this.editable = false;
    }

    /*@TestVisible
    private Column(SObjectField field)
    {
        Schema.DescribeFieldResult describe = field.getDescribe();
        this.required = false;
        this.fieldName = describe.getName();
        this.label = describe.getLabel();
        this.required = false;
        this.type = String.valueOf(describe.getType());        
        this.sortable = true;
        this.editable = false;
    }
    */
    public void setRequired(Boolean DBRequired) {
        this.required = DBRequired;
    }

}
