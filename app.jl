#!/usr/bin/julia
using HttpCommon
using HttpServer
using HTTPClient
using JSON
using Mustache
using Morsel
using Meddle

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

#server = Server(mainhandler)
#run(server,8000)

app = Morsel.app()

# Static assets handling
route(app, GET, "/static/<filename::String>") do req, res
    FileResponse(string("./static/",req.params[:filename]))
end

# Simple test
route(app, GET, "/") do req, res
    view("test", Dict())
end

route(app, POST, "/test") do req, res
    if !haskey(req.data,"repo") || !ismatch(r"^\w+\/\w+$",req.data["repo"])
        return view("test", Dict({"invalid"=>true}))
    end
    res.headers["Content-Type"] = "text/plain"
    github_api(string("repos/",req.data["repo"]))
end

# We get signal
start(app, 8000)
