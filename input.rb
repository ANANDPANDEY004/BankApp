class Input
  def self.input_name
    begin   
      puts("Enter your Name :")
      name = gets.chomp.to_s
      reg = /[a-zA-Z ]/
      if(name =~ reg)
          puts("Successfully Create")
      else
          raise "Invalid Name"
      end
    rescue => exception
      puts(exception.message)
      retry
    end
    name
  end
  def self.input_user_name
    begin    
      puts("Enter the user name :")
      username = gets.chomp.to_s
      reg = /[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$/
      if(username =~ reg)
          puts("Successfully Create")
      else
          raise "Invalid username"
      end
    rescue => exception
      puts(exception.message)
      retry
    end
     username
  end

  def self.input_email_id
    begin  
      puts("Enter your Email  :")
       email = gets.chomp.to_s
      reg = /(.+)@(.+)/
      if(email =~ reg)
          puts("Successfully Create")
      else
          raise "Invalid email "
      end
    rescue => exception
      puts(exception.message)
    retry
    end
    email
  end

  def self.input_password
    begin      
      puts("Enter the Password :")
      password = gets.chomp.to_s
      reg = /(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/
      if(password =~ reg)
        puts("Successfully Create")
      else
        raise "Invalid password"
      end
    rescue => exception
        puts(exception.message)
      retry
    end
    password
  end
  def self.input_amount
    begin
        puts "enter amount"
        amount = gets.chomp
        amount=Float(amount)
        if amount < 0
        raise "please Input Proper amount"
        end
        rescue => e
            puts e.message
        retry
        end
    amount
  end
end