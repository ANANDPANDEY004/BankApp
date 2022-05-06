require_relative "./main.rb"
require_relative "./user.rb"
require_relative "./input.rb"
require_relative "./account.rb"
require_relative "./atm.rb"
require_relative "./transaction.rb"
require 'json'
require 'Date'

def trans(user_name,acc_no,trans_id,amount,type)
   file = File.read('./user_data.json')
   user_data = JSON.parse(file)
   value = user_data.inject(:merge)
   trans_id = trans_id
   date = Date.today
   type = type
   amount = amount
   user = value[user_name][acc_no.to_s]["transaction_history"]
    user.push({trains_id: trans_id, date: date, type: type, amount: amount})
    puts user
    File.open("./user_data.json","w") do |f|
     f.write(user_data.to_json)   
   end
 end
#  trans("ANand@45","658132308164","576347",600,"cr")
def tr(user_name)
      file = File.read('./user_data.json')
            user_data = JSON.parse(file)
            value = user_data.inject(:merge)
            acc_no = User.get_acc_no(user_name)
            user = value[user_name][acc_no.to_s]["transaction_history"]

            user.each do |k|
               puts ( "\t #{k["trains_id"]} \t #{k["date"]}\t #{k["type"]}\t #{k["amount"]}")
           end
           trans("Aand@45","669553837783","576347",600,"cr")
   end
   tr("Aand@45")




























   # def self.trans(user_name,acc_no,trans_id,amount,type)
   #    file = File.read('./user_data.json')
   #    user_data = JSON.parse(file)
   #    value = user_data.inject(:merge)
   #    trans_id = trans_id
   #    date = Date.today
   #    type = type
   #    amount = amount
   #    user = value[user_name][acc_no]["transaction_history"]
   #       user.push({trains_id: trans_id, date: date, type: type, amount: amount})
   #       File.open("./user_data.json","w") do |f|
   #       f.write(user_data.to_json)   
   #    end
   # end