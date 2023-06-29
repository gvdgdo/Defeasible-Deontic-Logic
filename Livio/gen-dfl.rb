records = File.open("Livio/SPINdle30_50.dfl","r")
output = File.new("Livio/facts30_50_stripped.dfl","w+")

records.each do |l|
    case l
    when /(>>.*)_\d+_\d+/
        output << "#$1\n"
    else
        output << "\n"
    end
end

# output << "\n1 {\n"
# for i in 0..20 do
#     for j in 0..30 do 
#         output << "caseId(c_#{i}_#{j});\n"
#     end
# end
# output << "} 1 ."


