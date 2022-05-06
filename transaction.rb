class Transaction
    def self.show_transaction(user_name)
        begin
             
            file = File.read('./user_data.json')
            user_data = JSON.parse(file)
            value = user_data.inject(:merge)
            acc_no = User.get_acc_no(user_name)
            user = value[user_name][acc_no.to_s]["transaction_history"]
            puts user
            user.each do |k|
               puts ( "\t #{k["trains_id"]} \t #{k["date"]}\t #{k["type"]}\t #{k["amount"]}")
           end
        rescue => e
            e.message
        end
    end

    def self.set_trans(user_name,trans_id,amount,type)
        puts "yaha"
        begin
        file = File.read('./user_data.json')
        user_data = JSON.parse(file)
        value = user_data.inject(:merge)
        date = Date.today
        acc_no =User.get_acc_no(user_name)
        user = value[user_name][acc_no.to_s]["transaction_history"]
         user<<({trains_id: trans_id, date: date, type: type, amount: amount})
        File.open("./user_data.json","w") do |f|
            f.write(user_data.to_json)   
        end
        rescue => e
            e.message
        end
    end
end