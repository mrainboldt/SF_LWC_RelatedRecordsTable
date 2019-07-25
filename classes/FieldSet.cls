public class FieldSet {
	@AuraEnabled
	public String description {get; set;}

	@AuraEnabled
	public String label {get; set;}

	@AuraEnabled
	public String fieldName {get; set;}

	@AuraEnabled
	public String nameSpace {get; set;}

	@AuraEnabled
	public String type {get; set;}

	@AuraEnabled
	public List<Column> fields {get; set;}

	public FieldSet(Schema.FieldSet fs) {
		this.label = fs.getLabel();
		this.fieldName = fs.getName();
		this.description = fs.getDescription();
		this.nameSpace = fs.getNameSpace();
		this.type = fs.getSObjectType().getDescribe().getName();
		this.fields = new List<Column>();

		for (Schema.FieldSetMember f: fs.getFields()) {
            this.fields.add(new Column(f));
        }
	}

	@TestVisible
	private FieldSet(String label
				, String name
				, String description
				, String nameSpace
				, String sObjectType
				, List<Column> fields){
		this.label = label;
		this.fieldName = name;
		this.description = description;
		this.nameSpace = nameSpace;
		this.type = sObjectType;
		this.fields = fields;
	}

}