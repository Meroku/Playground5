global class scheduledDiscount implements Schedulable{
    
	global void execute(SchedulableContext sc) {
		BatchDiscount b = new BatchDiscount(); 
        database.executeBatch(b);
	}
}