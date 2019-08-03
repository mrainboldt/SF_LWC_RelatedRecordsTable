
# SF_LWC_RelatedRecordsTable
Allow admins to add related lists to any object and to filter on any criteria.
Out of the box related lists show all records based on a given relationship.  This component allows you to filter to see only a subset of records for a given related list.

# Known limitation
 - Does not display Name field has a lookup or as a link
 - Only displays Id for lookup fields
  

# How to use
1. Create a field set of the related object, whose records you are going to be showing. And place them in the order that you want to display them in.
2. Add component to record page and complete configuration
> - Related List Label - what will appear at the top of the table
> - Related Object API Name - the name of the object to be queried, if you want to show Contacts on an Account you would put "Contact"
> - Related Field - this is the field on the related object that should be equal to record context.  If you are showing Contacts on Account than it would be "AccountId"
> - Field Set - this is the api name of the field set that you created in step 1
> - WHERE clause - the component will automatically include "WHERE Id = :related_field AND..." what ever is completed in this field. If you only want to see Contacts that have a phone number you would type "Phone != null"
> - Icon - this is the slds icon you want to display next to the label of the table.  Use Icons [here](https://lightningdesignsystem.com/icons/).  To show the default Contact icon put in "standard:contact"
> - Sort By - Field API name that you want the records to be sorted by, by default
> - Sort Direction - indicates if you want to sort ASC or DESC
