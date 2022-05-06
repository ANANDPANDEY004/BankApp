class Main
  def menu
    begin
      puts    <<~_
      '----------------------------------- Welcome to *****PANDEY BANK***** Terminal ------------------------------'
              1: Create Account.
              2: Login Acc.
              3: Exit.
              _
      case x = gets.chomp.to_i
        when 1
          User.create
        when 2
          User.login
        when 3
          exit
      else 
        raise 'Plese Choose valid Input'
      end
    rescue => e
        puts e.message
        retry
    end
  end
end
