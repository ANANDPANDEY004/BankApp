class User
	def self.create
		name = Input.input_name()
		user_name = Input.input_user_name()  
		email = Input.input_email_id()
    puts "Enter your Address"
		address = gets.chomp
		password = Input.input_password()
		acc_no =  rand(100000000000..999999999999)
		ifsc = "PANDEY001"
		balance = 10000.00
		atm_no = 0
		atm_pin = 0
		cvv = 0
	  expire_date	 = 0
		transaction_history =  []

    
      self.collect( user_name,name,email,address,password,acc_no,ifsc,balance,atm_no,atm_pin,cvv,expire_date,transaction_history)
  end
  

  def self.collect( user_name,name,email,address,password,acc_no,ifsc,balance,atm_no,atm_pin,cvv,expire_date,transaction_history)
    begin
    user = {
      "#{user_name}": {
          name: name,
          email: email,
          address: address,
          password: password,
          
          "#{acc_no}": {
             ifsc: ifsc,
             balance: balance,
               atm: {
                    atm_no: atm_no,
                    atm_pin: atm_pin,
                    cvv: cvv,
                    expire_date: expire_date,
                  },
              transaction_history: transaction_history,
              }
        }
  } 
    arr = []
    file = File.read('./user_data.json')
      if(file.empty?())
        arr.push(user)
        user=File.open("./user_data.json","w") do |f|
        f.write(arr.to_json)
        end    
    
      else
        user_data = JSON.parse(file)
        user_data.each do |x|
        x.merge!(user)
        end
        File.open("./user_data.json","w") do |f|
        f.write(user_data.to_json)   
         end
      end
      self.set_atm(user_name,acc_no, "atm")
      self.set_acc_no(user_name,acc_no)
      self.user_menu(user_name)
      
    rescue => e
      puts e.message
    end  
  end
  
  def self.get_acc_no(user_name)
    begin
  
        file = File.read('./acc_data.json')
        user_data = JSON.parse(file)
        value = user_data.inject(:merge)
        return value[user_name]
    rescue => e
        e.message
    end
  end
  def self.set_acc_no(user_name,acc_no)
    user = {
      "#{user_name}": acc_no
          }
    arr = []
    file = File.read('./acc_data.json')
    if(file.empty?())
      arr.push(user)
      user=File.open("./acc_data.json","w") do |f|
      f.write(arr.to_json)
      end    
    else
      user_data = JSON.parse(file)
      user_data.each do |x|
      x.merge!(user)
      end
      File.open("./acc_data.json","w") do |f|
      f.write(user_data.to_json)   
       end
    end
    
  end

  def self.set_atm(user_name,acc_no,atm)
    user = {
      "#{user_name}":{
          "#{acc_no}": "atm" 
                     }
          }
    arr = []
    file = File.read('./atm_data.json')
    if(file.empty?())
      arr.push(user)
      user=File.open("./atm_data.json","w") do |f|
      f.write(arr.to_json)
      end    
  
    else
      user_data = JSON.parse(file)
      user_data.each do |x|
      x.merge!(user)
      end
      File.open("./atm_data.json","w") do |f|
      f.write(user_data.to_json)   
       end
    end
 
  end

   
  def self.login()
    begin
      puts "Enter user name"
      user_name = gets.chomp
      file = File.read('./user_data.json')
      user_data = JSON.parse(file)
      value = user_data.inject(:merge)
      value.each do |k,v|
        if k == user_name
          puts "Enter password"
          user_password =gets.chomp
          unless v["password"] == user_password 
            raise "You Don't Know Your id And Password"
          end
          self.user_menu(user_name)
        end
        
      end
      
    rescue => e
    puts e.message 
    retry
    end
   
  end

  def self.user_menu(user_name)
    begin
    i =0
    until i == 7
      puts <<~_
              1: Deposit Ammount 
              2: Transfer to Another Account 
              3: Cheack balance 
              4: Apply For Atm 
              5: Show Atm Detail
              6: tran
              7:Exit
              
              _
      x = gets.chomp.to_i
      case x
      when 1
       Account.deposite(user_name)
      when 2
        Account.transfer(user_name)
      when 3
        Account.display_balance(user_name)
      when 4
        Account.apply_for_atm(user_name)
      when 5
        Atm.show_atm(user_name)
      when 6
        Transaction.show_transaction(user_name)
      when 7
       exit
      
      else
        raise "Wrong entry try again.."
      end
    end
    rescue => e
      puts e.message
      retry
    end
  end
end

