class Atm
  def self.show_atm(user_name)
    begin
      file = File.read('./user_data.json')
      user_data = JSON.parse(file)
      value = user_data.inject(:merge)
      user = value[user_name]
      acc_no = user.keys.last 
      user = value.dig(user_name,acc_no)
      user = value[user_name][acc_no]["atm"]
      puts    <<~_ 
                      ATM No         : #{user["atm_no"]}
                      cvv            : #{user["cvv"]}
                      ATM  Pin       : #{user["atm_pin"]}
                      EXPIRE Detail  : #{user["expire_date"]}

      _
    rescue => e
      puts e.message
      retry
    end
      puts  <<~_
                IF YOU WANT TO USE ATM  Then PRESS
                1.Fund Transfer
                2.Chek Balance
                3.Exit
                _
    case x = gets.chomp.to_i
    when 1
      self.atm_transfer(user_name)
    when 2
      Account.display_balance(user_name)
    when 3
      exit
    end
  end
  def self.input_user_atm_no
    begin
        puts "enter Second user no"
        atm = gets.chomp
        reg = /\A[+-]?\d+\z/
      if(atm =~ reg)
        puts "ok"
      else
        raise "Please use only Integer No"
      end
    rescue => exception
        puts(exception.message)
      retry
    end
    atm
  end
  def self.fetch_atm_no(user_name)
    atm = self.input_user_atm_no()
    file = File.read('./user_data.json')
    user_data = JSON.parse(file)
    value = user_data.inject(:merge)
    user = value[user_name]
    acc_no = user.keys.last 
    user = value.dig(user_name,acc_no)
    user = value[user_name][acc_no.to_s]["atm"]
      user.each do |k,v| 
        if  v.to_i == atm.to_i
          self.atm_fetch_atm_no(user_name)
        break
    end 
    end
  end
  def self.atm_transfer(user_name)
    begin
      atm_no=self.fetch_atm_no(user_name)
      login_user_balance =self.atm_login_balance(user_name)
      user_balance=self.atm_transfer_user_balance(atm_no)
      puts "How Much you want to send Amount"
      amount =gets.chomp
      trans_id =rand(10000..99999)
      type = "Atm Transfer"
      login_user_balance =  login_user_balance.to_f - amount.to_f
      user_balance = user_balance + amount.to_f
      self.atm_set_login_user_balance(user_name,login_user_balance)
      self.atm_set_transfer_user_balance(atm_no , user_balance)
      puts "Transatcion scessess"
      Transaction.set_trans(user_name,trans_id,amount,type)
        rescue => e
        puts e.message  
        end
  end
  
  def self.atm_login_balance(user_name)
    begin
    file = File.read('./user_data.json')
    user_data = JSON.parse(file)
    value = user_data.inject(:merge)
    user = value[user_name]
    acc_no = user.keys.last.to_s
    user = value.dig(user_name,acc_no)
    balance = user["balance"]
    rescue => e
      puts e.message
    end
    balance
  end
  
  def self.display_balance(user_name)
    begin
      file = File.read('./user_data.json')
      user_data = JSON.parse(file)
      value = user_data.inject(:merge)
      user = value[user_name]
      acc_no = user.keys.last.to_s
      user = value.dig(user_name,acc_no)
      balance = user["balance"]
      puts "Total Balance in Your Account : #{balance}"
    rescue => e
      puts e.message
      retry
    end
      balance
  end
  
  def self.atm_set_login_user_balance(user_name,balance)
    begin
      file = File.read('./user_data.json')
      user_data = JSON.parse(file)
      value = user_data.inject(:merge)
      user = value[user_name]
      acc_no = user.keys.last 
      user = value.dig(user_name,acc_no)
      user = value[user_name][acc_no.to_s]
      user["balance"]= balance 
      File.open("./user_data.json","w") do |f|
        f.write(user_data.to_json)   
      end
    rescue => e
    puts e.message "yaha2"
    end
  end
  
  def self.atm_transfer_user_balance(atm_no)
    file = File.read('./user_data.json')
    user_data = JSON.parse(file)
    value = user_data.inject(:merge)
    balance =0
    value.each do |k,v|
      v.each do |j,b| 

        if (b== atm_no)
              balance =b["balance"]
        end
      end
    end
    balance 
  end
  
  def self.atm_set_transfer_user_balance(atm_no, balance)
    begin
      file = File.read('./user_data.json')
      user_data = JSON.parse(file)
      value = user_data.inject(:merge)
      value.each do |k,v|
      v.each do |j,b|
          if (b == atm_no)
            b["balance"] = balance
          end 
      end
    end
    File.open("./user_data.json","w") do |f|
      f.write(user_data.to_json)   
    end
    rescue => e
      puts e.message
    end
  end


  def self.atm_pin_function
    begin  
      puts("Generate Your ATM pin No:")
      atm_pin = gets.chomp.to_s
      reg = /(\d{4}|\d{6})/
      if(atm_pin =~ reg)
        puts("Successfully Create")
      else
        raise "Please put only 4 digit of code"
      end
    rescue => exception
      puts(exception.message)
    retry
    end
      atm_pin
  end
  def  self.user_input_atm(user_name)
        file = File.read('./user_data.json')
        user_data = JSON.parse(file)
        value = user_data.inject(:merge)
        user = value[user_name]
        acc_no = user.keys.last 
        user = value.dig(user_name,acc_no)
        user = value[user_name][acc_no]["atm"]
        atm_no= rand(1000000000000000..1100000000000000)
        exp_date = DateTime.now.next_year(10)
        expire_dates =exp_date.strftime "%m/%Y"
        cvv = rand(100..999)
        user["atm_no"] = atm_no 
        user["cvv"]  =  cvv
        if user["atm_pin"] == 0
           user["atm_pin"] =atm_pin_function()
      else 
        puts "you alredy genrate"
      end
        user["expire_date"]    =  expire_dates
        File.open("./user_data.json","w") do |f|
          f.write(user_data.to_json)   
        end
        
    end 


end