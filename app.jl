#!/usr/bin/julia
using HttpCommon
using HttpServer
using HTTPClient
using JSON
using Mustache
using Morsel
using Meddle

function github_api(url::String)
    jsan = HTTPClient.get(string("https://api.github.com/",url))
#    return JSON.parse(takebuf_string(jsan.body))
    takebuf_string(jsan.body)
end

function view(tpl::String, data::Dict)
    return Mustache.render(Mustache.template_from_file(string("./tpl/", tpl, ".tpl")), data)
end

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
    if !haskey(req.state[:data],"repo") || !ismatch(r"^\w+\/\w+$",req.state[:data]["repo"])
        return view("test", Dict({"invalid"=>true}))
    end
    res.headers["Content-Type"] = "text/plain"
    github_api(string("repos/",req.state[:data]["repo"]))
end

# We get signal
start(app, 8000)
