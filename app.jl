#!/usr/bin/julia
using HttpCommon
using HttpServer

function mainhandler(req::Request,res::Response)
    if ismatch(r"^/static/*",req.resource)
        res2 = FileResponse(string("/srv/deathratio",req.resource))
        res.status = res2.status
        res.headers = res2.headers
        res.data = res2.data
    else
        res.status = 404
        res.data = "Requested resource not found."
    end
    res
end

server = Server(mainhandler)
run(server,8000)
