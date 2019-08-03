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

    public boolean isReferenceField;

    @AuraEnabled
    public TypeAttribute  typeAttributes;

    public Column(){}

    public Column(Schema.FieldSetMember f) 
    {
        this.required = f.DBRequired;
        this.fieldName = f.fieldPath;
        this.label = f.label;
        this.required = f.required;
        this.type = ('' + f.getType()).toLowerCase();
        this.sortable = true;
        this.editable = false;
        this.setType();
    }

    private void setType()
    {
        System.debug(LoggingLevel.INFO, 'Field: ' + this.fieldName + '; Type: ' + this.type);
        if(this.type == 'date')
        {
            this.type = 'date-local';
        }
        // else if(this.type == 'reference')
        // {
        //     this.isReferenceField = true;
        //     // String relatedField = this.fieldName.replace('__c', '__r') + '.Name';
        //     // relatedField = relatedField.replace('Id.', '.');
        //     // this.fieldName = relatedField;
        //     this.type = 'url';
        //     this.typeAttributes = new TypeAttribute().getUrl(this.fieldName);
        // }
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

    public class TypeAttribute{
        @AuraEnabled
        public String month;

        @AuraEnabled
        public String year;
        
        @AuraEnabled
        public String day;
        
        @AuraEnabled
        public String currencyCode;

        @AuraEnabled
        public String label;
        
        @AuraEnabled
        public String target;
        
        @AuraEnabled
        public String tooltip;

        public TypeAttribute(){}

        public TypeAttribute getUrl(String fieldName)
        {
            TypeAttribute attr = new TypeAttribute();
            attr.label = fieldName;
            attr.target = '_blank';
            attr.tooltip = fieldName;
            return attr;
        }
    }

}
