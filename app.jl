#!/usr/bin/julia
using HttpCommon
using HttpServer
using HTTPClient
using JSON
using Mustache

function github_api(url::String)
    return JSON.parse(takebuf_string(get(string("https://api.github.com/",url))))
end

function view(tpl::String, data::Dict)
    return Mustache.render(Mustache.template_from_file(string("./tpl/", tpl, ".tpl")), data)
end

function mainhandler(req::Request,res::Response)
    if ismatch(r"^/static/*",req.resource)
        res2        = FileResponse(string(".",req.resource))
        res.status  = res2.status
        res.headers = res2.headers
        res.data    = res2.data
    elseif ismatch(r"^/test/?", req.resource)
        res.status = 200
        res.data   = view("test", Dict({"something"=>"else"}))
    else
        res.status = 404
        res.data   = "Requested resource not found."
    end
    return res
end

server = Server(mainhandler)
run(server,8000)
