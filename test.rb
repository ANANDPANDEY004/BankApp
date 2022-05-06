require "json"
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
trans("ANand@45","658132308164","576347",600,"cr")