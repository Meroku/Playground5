trigger NewAccount on User (before insert) {
	    List<Account> acs = new List<Account>();
	    for (User u: trigger.new){
	        Account c = new Account();
	        c.Name = u.Username;
	        acs.add(c);
            EmailManager.sendMail('maxim53shkrob@gmail.com', 'New User added', 
                    'His username is ' + u.Username + ' and email is ' + u.Email);
	    }
	    insert acs;
}