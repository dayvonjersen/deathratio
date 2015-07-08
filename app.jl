#!/usr/bin/julia
using HttpCommon
using HttpServer
using HTTPClient
using HTTPClient.HTTPC
using JSON
using Mustache
using Morsel
using Meddle

function github_api(url::String)
    jsan = HTTPClient.get(string("https://api.github.com/",url),RequestOptions(headers=[("User-Agent","Web/4.0 [julia]")]))
#    return JSON.parse(takebuf_string(jsan.body))
    try
        plsrespond = takebuf_string(jsan.body)
        r = JSON.parse(plsrespond)
#        return string("full name: ", r["full_name"], "\ndescription: ", r["description"])
        return r
    catch
        return plsrespond
    end
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
        return view("test", Dict{String,Any}("invalid"=>true))
    end
#    github_api(string("repos/",req.state[:data]["repo"]))
    repos = github_api(string("repos/",req.state[:data]["repo"],"/stats/contributors"))
    # {"message": "Not Found"... 
    if typeof(repos) == Dict{AbstractString,Any} && haskey(repos,"message")
        return view("test", Dict{String,Any}("invalid"=>true))
    end

    res.headers["Content-Type"] = "text/plain"

    # {[{"author": /*1...*/},{"author": /*2...*/}]}
    words = ""
    if typeof(repos) == Array{Any,1}
        Σa = 0
        Σc = 0
        Σd = 0
        users = Dict{String,Int64}()
        for contrib in repos
            σa = 0
            σc = 0
            σd = 0
            for week in contrib["weeks"]
                σa += week["a"]
                σc += week["c"]
                σd += week["d"]
            end
            users[contrib["author"]["html_url"]] = σa + σc + σd
            Σa += σa
            Σc += σc
            Σd += σd
        end
        total = Σa + Σc + Σd
        for user in keys(users)
            words = string(words, user, ": ", users[user], " / ", total, " = ", users[user] / total * 100, "%\n")
        end
        return words
    end
    return "Something bad happened."    
end

# We get signal
start(app, 8000)
