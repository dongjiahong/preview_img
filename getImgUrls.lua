require "os"                                                                                           
local json = require "cjson"                                                                           

ngx.header['Access-Control-Allow-Origin'] = "*"                                                        
ngx.header['Content-Type'] = "application/json"                                                        

os.execute(" ls -lh /pdata1/tmp_picture | sort -nk5 | awk '{if(NF>=9){print $9}}' > res")                                                                                                                             

local res={ }                                                                                          
local file = io.open("res")                                                                            
local idx=0                                                                                            
for line in file:lines() do                                                                            
    if idx == 100 then                                                                                   
        break                                                                                          
    end                                                                                                
    table.insert(res, line)                                                                            
    idx = idx + 1                                                                                      
end                                                                                                    

ngx.print(json.encode(res))
