require "os"                                                                                           
local json = require "cjson"                                                                           

--ngx.header['Access-Control-Allow-Origin'] = "*"                                                        
ngx.header['Content-Type'] = "application/json"                                                        
math.randomseed(tostring(os.time()):reverse():sub(1, 7))

local args = ngx.req.get_uri_args()
local rand = args.rand or "0"

os.execute(" ls -lh /pdata1/tmp_picture | sort -nk5 | awk '{if(NF>=9){print $9}}' > res")                                                                                                                             

local res={ }                                                                                          
local file = io.open("res")                                                                            
local idx=0                                                                                            
if rand == "0" then
    for line in file:lines() do                                                                            
        if idx == 100 then                                                                                   
            break                                                                                          
        end                                                                                                
        table.insert(res, line)                                                                            
        idx = idx + 1                                                                                      
    end                                                                                                    
elseif rand == "1" then
    for line in file:lines() do                                                                            
        if idx == 100 then                                                                                   
            break                                                                                          
        end                                                                                                
        if math.random(1, 1000) then
            table.insert(res, line)                                                                            
            idx = idx + 1                                                                                      
        end
    end                                                                                                    
end

ngx.print(json.encode(res))
