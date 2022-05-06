class Account
  
  def self.deposite(user_name)
    begin
      amount = Input.input_amount
      file = File.read('./user_data.json')
      user_data = JSON.parse(file)
      value = user_data.inject(:merge)
      acc_no = User.get_acc_no(user_name)
      user = value[user_name][acc_no.to_s]
      balance = user["balance"]
      balance = balance.to_f + amount.to_f
      user["balance"] = balance
      File.open("./user_data.json","w") do |f|
        f.write(user_data.to_json)   
      end
    rescue => e
      puts e.message
    retry
    end
      puts "transaction successful"
  end
  def self.input_fetch_acc()
    begin
        puts "enter Second user Acc_no"
        acc = gets.chomp
        reg = /\A[+-]?\d+\z/
      if(acc =~ reg)
        puts "ok"
        
      else
        raise "Please use only Integer No"
      end
      
    rescue => exception
        puts(exception.message)
    end
    acc
  end
  
  def self.fetch_acc_no(user_name)
    begin
        acc = self.input_fetch_acc()
        file = File.read('./acc_data.json')
        user_data = JSON.parse(file)
        value = user_data.inject(:merge)
        value.each do |k,v| 
          if  v == acc.to_s
            puts v
            self.transfer(user_name)
            break
          end 
      break
      end
    rescue => e
      puts e.messag
    end
      acc

  end

  def self.transfer(user_name)
    begin
      acc_no=self.fetch_acc_no(user_name)
      login_user_balance =self.login_balance(user_name)
      user_balance=self.transfer_user_balance(acc_no)
      puts "How Much you want to send Amount"
      amount =gets.chomp
      login_user_balance = login_user_balance - amount.to_f
      user_balance = user_balance + amount.to_f
      self.set_login_user_balance(user_name,login_user_balance)
      self.set_transfer_user_balance(acc_no , user_balance)
      trans_id = rand(1000..9999)
      type = "Account to Account Transfer"
      puts "Transatcion scess"
      Transaction.set_trans(user_name,trans_id,amount,type)
    rescue => e
      puts e.message
    end
  end

  def self.login_balance(user_name)
    begin
    file = File.read('./user_data.json')
    user_data = JSON.parse(file)
    value = user_data.inject(:merge)
    user = value[user_name]
    acc_no = user.keys.last 
    user = value.dig(user_name,acc_no)
    balance = user["balance"]
    rescue => e
      puts e.message" yaha 4"
    end
    balance
  end

  def self.display_balance(user_name)
    begin
      file = File.read('./user_data.json')
      user_data = JSON.parse(file)
      value = user_data.inject(:merge)
      user = value[user_name]
      acc_no = user.keys.last 
      user = value.dig(user_name,acc_no)
      balance = user["balance"]
      puts "Total Balance in Your Account : #{balance}"
    rescue => e
      puts e.message "yaha 5"
      retry
    end
     balance
  end

  def self.set_login_user_balance(user_name,balance)
    begin
      file = File.read('./user_data.json')
      user_data = JSON.parse(file)
      value = user_data.inject(:merge)
      user = value[user_name]
      acc_no = user.keys.last 
      user = value.dig(user_name,acc_no)
      user["balance"]= balance 
      File.open("./user_data.json","w") do |f|
        f.write(user_data.to_json)   
      end
    rescue => e
    puts e.message "yaha2"
    end
  end

  def self.transfer_user_balance(acc_no)
    file = File.read('./user_data.json')
    user_data = JSON.parse(file)
    value = user_data.inject(:merge)
    balance =0
    value.each do |k,v|
      v.each do |j,b|
        if (j == acc_no)
          balance = b["balance"]  
        end
      end
    end
    balance 
  end

  def self.set_transfer_user_balance(acc_no, balance)
    begin
      file = File.read('./user_data.json')
      user_data = JSON.parse(file)
      value = user_data.inject(:merge)
      value.each do |k,v|
      v.each do |j,b|
          if (j == acc_no)
              b["balance"]= balance 
            
             end
      end
    end
    File.open("./user_data.json","w") do |f|
      f.write(user_data.to_json)   
    end
    rescue => e
      puts e.message " yaha3"
    end
  end

  def self.apply_for_atm(user_name)

       Atm.user_input_atm(user_name)
  end

  # def self.show_transaction(user_name)
end
