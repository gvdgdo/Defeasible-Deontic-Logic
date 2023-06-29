records = File.open("Livio/asp20_30.asp","r")
output = File.new("Livio/ddl20_30.lp","w+")

records.each do |l|
    case l
    when /rexist_\d+\(ev_(\d+)_(\d+)\)/
        output << "fact(evaluate(c_#$1_#$2)).\n"
    when /rexist_\d+\(ea_(\d+)_(\d+)\)/
        output << "fact(authorise(c_#$1_#$2)).\n"
    when /rexist_\d+\(eg_(\d+)_(\d+)\)/
        output << "fact(license(c_#$1_#$2)).\n"
    when /rexist_\d+\(ec_(\d+)_(\d+)\)/
        output << "fact(commission(c_#$1_#$2)).\n"
    when /rexist_\d+\(epr_(\d+)_(\d+)\)/
        output << "fact(publish(c_#$1_#$2)).\n"
    when /rexist_\d+\(epc_(\d+)_(\d+)\)/
        output << "fact(remove(c_#$1_#$2)).\n"
    else
        output << "\n"   
    end        
end

output << "\n1 {\n"
for i in 0..20 do
    for j in 0..30 do 
        output << "caseId(c_#{i}_#{j});\n"
    end
end
output << "} 1 ."


